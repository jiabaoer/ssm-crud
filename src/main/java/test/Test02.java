package test;

import javax.swing.JFrame;

import org.bytedeco.javacpp.Loader;
import org.bytedeco.javacpp.avcodec;
import org.bytedeco.javacpp.opencv_core.IplImage;
import org.bytedeco.javacpp.opencv_objdetect;
import org.bytedeco.javacv.CanvasFrame;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.FrameGrabber;
import org.bytedeco.javacv.FrameRecorder;
import org.bytedeco.javacv.FrameGrabber.Exception;
import org.bytedeco.javacv.OpenCVFrameConverter;

public class Test02 {

	public static void main(String[] args) throws Exception, org.bytedeco.javacv.FrameRecorder.Exception, InterruptedException {
		recordCamera("output.mp4", 25);
	}

	public static void recordCamera(String outputFile, double frameRate)
			throws Exception, org.bytedeco.javacv.FrameRecorder.Exception, InterruptedException {
		Loader.load(opencv_objdetect.class);
		// 本机摄像头默认为0，这里使用javaCV的抓取器
		// 至于使用的是ffmpeg还是opencv，请自行查看源码
		FrameGrabber grabber = FrameGrabber.createDefault(0);
		// 开启抓取器
		grabber.start();
		// 转换器
		OpenCVFrameConverter.ToIplImage converter = new OpenCVFrameConverter.ToIplImage();
		// 抓取一帧视频并将其转换为图像，至于用这个图像用来做什么？加水印，人脸识别等等自行添加
		IplImage gIplImage = converter.convert(grabber.grab());
		int width = gIplImage.width();
		int height = gIplImage.height();
		FrameRecorder recorder = FrameRecorder.createDefault(outputFile, width, height);
		// avcodec.AV_CODEC_ID_H264 编码
		recorder.setVideoCodec(avcodec.AV_CODEC_ID_H264);
		// 封装格式，如果是推送到rtemp就必须是flv封装格式
		recorder.setFormat("flv");
		recorder.setFrameRate(frameRate);

		// 开启录制
		recorder.start();
		long statTime = 0;
		long vodeoTS = 0;
		CanvasFrame frame = new CanvasFrame("视频录制", CanvasFrame.getDefaultGamma() / grabber.getGamma());
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setAlwaysOnTop(true);
		// 不知道为什么这里不做转换就不能推到rtmp
		Frame rotatedFrame = converter.convert(gIplImage);
		while (frame.isValid() && (gIplImage = converter.convert(grabber.grab())) != null) {
			rotatedFrame = converter.convert(gIplImage);
			frame.showImage(rotatedFrame);
			if (statTime == 0) {
				statTime = System.currentTimeMillis();
			}
			vodeoTS = 1000 * (System.currentTimeMillis() - statTime);
			recorder.setTimestamp(vodeoTS);
			recorder.record(rotatedFrame);
			Thread.sleep(40);
		}
		frame.dispose();
		recorder.stop();
		recorder.release();
		grabber.stop();
	}
}
