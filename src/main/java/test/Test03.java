package test;

import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.Scalar;

public class Test03 {
	public static void main(String[] args) {
		Mat mat=new Mat(3, 2, CvType.CV_8UC3);
		System.out.println(mat.dump());
	}

	public void test() {
		int flags;
		int dims;// 矩阵的维数，取值应该大于或等于2
		int rows, cols;// 矩阵的行列数
		char data;// 指向数据的指针
		int refcount;// 指向引用计数的指针，如果数据由用户分配则为null
		Mat mat = new Mat();// 无参数构造方法
		// 创建行数为rows，列数为cols，类型为type的图像
		Mat mat2 = new Mat(3, 3, CvType.CV_8UC1);
		// 创建大小为size，类型为type的图像
		Scalar s=new Scalar(3, 2, 56, 123);
		
	}
}
