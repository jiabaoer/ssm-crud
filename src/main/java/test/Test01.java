package test;

import javax.swing.JFrame;

import org.bytedeco.javacv.CanvasFrame;
import org.bytedeco.javacv.OpenCVFrameGrabber;

public class Test01 {

	public static void main(String[] args) throws Exception, InterruptedException {
		OpenCVFrameGrabber grabber=new OpenCVFrameGrabber(0);
		//开始获取摄像头数据
		grabber.start();
		//新建一个窗口
		CanvasFrame canvas=new CanvasFrame("视频窗口");
		canvas.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		canvas.setAlwaysOnTop(true);
		while (true) {
			//窗口是否关闭
			if (!canvas.isDisplayable()) {
				//停止抓取
				grabber.stop();
				//退出
				System.exit(2);
			}
			//获取摄像头图像并放到窗口上显示
			//这里的Frame frame=grabber.grab();frame是一帧视频图像
			canvas.showImage(grabber.grab());
			//20毫秒刷新一次图像
			Thread.sleep(20);
		}
	}
}
