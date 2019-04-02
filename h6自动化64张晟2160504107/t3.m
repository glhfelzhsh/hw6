img=255*im2double(imread('lena.bmp'));
F = fftshift(fft2(img));
[W,H]=size(F);
a=-0.1;b=-0.1;T=1;
for u=1:W
    for v=1:H
        FF(u,v)=T/(pi*(u*a+v*b))*sin(pi*(u*a+v*b))*exp(-sqrt(-1)*pi*(u*a+v*b));
        G(u,v)=(FF(u,v))*F(u,v);
    end
end
G=ifftshift(G);
g=ifft2(G);
g=255*g/max(max(g));
g=real(g);
img1=uint8(g);


H=fspecial('motion',30,45);
img1=imfilter(img,H,'circular','conv');
img1=img1/255;
imwrite(img1,'运动模糊.jpg')
img2=imnoise(img1,'gaussian',0,10/size(img,1)/size(img,2));
imwrite(img2,'运动模糊+高斯噪声.jpg')
img3=deconvwnr(img2,H,0.0003);
imwrite(img3,'维纳滤波.jpg')
img3=deconvreg(img2,H,0.00003*numel(img));
imwrite(img3,'约束最小二乘滤波.jpg')

