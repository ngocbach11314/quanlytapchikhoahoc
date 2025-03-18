USE master;
GO
-- Xóa database nếu đã tồn tại
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'QuanLyTapChiKhoaHoc')
    DROP DATABASE QuanLyTapChiKhoaHoc;
GO
-- Tạo database mới
CREATE DATABASE QuanLyTapChiKhoaHoc;
USE QuanLyTapChiKhoaHoc;


CREATE TABLE TapChi (
    MaTapChi VARCHAR(20) PRIMARY KEY,
    TenTapChi NVARCHAR(255) NOT NULL,
    ISSN VARCHAR(20) UNIQUE,
    NhaXuatBan NVARCHAR(255),
    KyXuatBan NVARCHAR(50) CHECK (KyXuatBan IN (N'Hàng tháng', N'Hàng quý', N'Nửa năm', N'Hàng năm'))
);
CREATE TABLE SoBao (
    MaSoBao VARCHAR(20) PRIMARY KEY,
    MaTapChi VARCHAR(20),
    SoPhatHanh INT NOT NULL,
    NgayPhatHanh DATE,
    FOREIGN KEY (MaTapChi) REFERENCES TapChi(MaTapChi) ON DELETE CASCADE
);

CREATE TABLE TacGia (
    MaTacGia VARCHAR(20) PRIMARY KEY,
    HoTen NVARCHAR(255) NOT NULL,
    CoQuanCongTac NVARCHAR(255),
    Email VARCHAR(100) UNIQUE,
    ORCID VARCHAR(50) UNIQUE
);

CREATE TABLE LinhVuc (
    MaLinhVuc VARCHAR(20) PRIMARY KEY,
    TenLinhVuc NVARCHAR(255) NOT NULL
);

CREATE TABLE BaiBao (
    MaBaiBao VARCHAR(20) PRIMARY KEY,
    TieuDe NVARCHAR(255) NOT NULL,
    TomTat TEXT,
    TuKhoa NVARCHAR(255),
    MaSoBao VARCHAR(20),
	MaLinhVuc VARCHAR(20), -- Cột MaLinhVuc để liên kết với bảng LinhVuc
    FOREIGN KEY (MaSoBao) REFERENCES SoBao(MaSoBao) ON DELETE CASCADE,
    FOREIGN KEY (MaLinhVuc) REFERENCES LinhVuc(MaLinhVuc) ON DELETE SET NULL -- Ràng buộc khóa ngoại với LinhVuc
);



CREATE TABLE TacGia_BaiBao (
    MaTacGia VARCHAR(20),
    MaBaiBao VARCHAR(20),
    VaiTro NVARCHAR(50) CHECK (VaiTro IN (N'Tác giả chính', N'Đồng tác giả', N'Tác giả liên hệ')),
    PRIMARY KEY (MaTacGia, MaBaiBao),
    FOREIGN KEY (MaTacGia) REFERENCES TacGia(MaTacGia) ON DELETE CASCADE,
    FOREIGN KEY (MaBaiBao) REFERENCES BaiBao(MaBaiBao) ON DELETE CASCADE
);

CREATE TABLE PhanBien (
    MaPhanBien VARCHAR(20) PRIMARY KEY,
    MaBaiBao VARCHAR(20),
    HoTenPhanBien NVARCHAR(255) NOT NULL,
    KetQua NVARCHAR(50) CHECK (KetQua IN (N'Chấp nhận', N'Sửa đổi', N'Từ chối')),
    NhanXet TEXT,
    FOREIGN KEY (MaBaiBao) REFERENCES BaiBao(MaBaiBao) ON DELETE CASCADE
);
-- Chen du lieu vao bang TapChi
INSERT INTO TapChi (MaTapChi, TenTapChi, ISSN, NhaXuatBan, KyXuatBan)
VALUES
    ('TC001', 'Tap chi Cong Nghe Thong Tin', '1234-5678', 'Nha xuat ban Dai hoc Bach Khoa', N'Hàng tháng'),
    ('TC002', 'Tap chi Khoa Hoc va Cong Nghe', '2345-6789', 'Nha xuat ban Khoa Hoc', N'Hàng quý'),
    ('TC003', 'Tap chi Sinh Hoc', '3456-7890', 'Nha xuat ban Y Duoc', N'Nửa năm'),
    ('TC004', 'Tap chi Vat Ly', '4567-8901', 'Nha xuat ban Tu Nhien', N'Hàng năm'),
    ('TC005', 'Tap chi Toan Hoc', '5678-9012', 'Nha xuat ban Giao Duc', N'Hàng tháng'),
    ('TC006', 'Tap chi Hoa Hoc', '6789-0123', 'Nha xuat ban Dai hoc Quoc gia', N'Hàng quý'),
    ('TC007', 'Tap chi Khoa Hoc Xa Hoi', '7890-1234', 'Nha xuat ban Chinh tri', N'Nửa năm'),
    ('TC008', 'Tap chi Lich Su', '8901-2345', 'Nha xuat ban Van Hoa', N'Hàng năm'),
    ('TC009', 'Tap chi Nghe Thuat', '9012-3456', 'Nha xuat ban My Thuat', N'Hàng tháng'),
    ('TC010', 'Tap chi Kinh Te', '0123-4567', 'Nha xuat ban Tai Chinh', N'Hàng quý'),
    ('TC011', 'Tap chi Co Khi', '1234-6789', 'Nha xuat ban Co Khi', N'Nửa năm'),
    ('TC012', 'Tap chi Nong Nghiep', '2345-7890', 'Nha xuat ban Nong Lam', N'Hàng năm'),
    ('TC013', 'Tap chi Giao Duc', '3456-8901', 'Nha xuat ban Giao Duc Quoc Gia', N'Hàng tháng'),
    ('TC014', 'Tap chi Xa Hoi Hoc', '4567-9012', 'Nha xuat ban Xa Hoi', N'Hàng quý'),
    ('TC015', 'Tap chi Du Lich', '5678-0123', 'Nha xuat ban Du Lich', N'Nửa năm');

-- Chen du lieu vao bang SoBao
INSERT INTO SoBao (MaSoBao, MaTapChi, SoPhatHanh, NgayPhatHanh)
VALUES
    ('SB001', 'TC001', 1, '2025-01-01'),
    ('SB002', 'TC002', 5, '2025-02-01'),
    ('SB003', 'TC003', 3, '2025-03-01'),
    ('SB004', 'TC004', 8, '2025-04-01'),
    ('SB005', 'TC005', 4, '2025-05-01'),
    ('SB006', 'TC006', 2, '2025-06-01'),
    ('SB007', 'TC007', 10, '2025-07-01'),
    ('SB008', 'TC008', 6, '2025-08-01'),
    ('SB009', 'TC009', 7, '2025-09-01'),
    ('SB010', 'TC010', 9, '2025-10-01'),
    ('SB011', 'TC011', 11, '2025-11-01'),
    ('SB012', 'TC012', 12, '2025-12-01'),
    ('SB013', 'TC013', 13, '2025-01-01'),
    ('SB014', 'TC014', 14, '2025-02-01'),
    ('SB015', 'TC015', 15, '2025-03-01');

-- Chen du lieu vao bang TacGia
INSERT INTO TacGia (MaTacGia, HoTen, CoQuanCongTac, Email, ORCID)
VALUES
    ('TG001', 'Nguyen Van A', 'Dai hoc Bach Khoa', 'nguyenvana@example.com', '0000-0001-2345-6789'),
    ('TG002', 'Tran Thi B', 'Vien Khoa Hoc', 'tranthib@example.com', '0000-0001-2345-6790'),
    ('TG003', 'Pham Minh C', 'Dai hoc Quoc gia', 'phamminhc@example.com', '0000-0001-2345-6791'),
    ('TG004', 'Le Thi D', 'Vien Vat Ly', 'lethid@example.com', '0000-0001-2345-6792'),
    ('TG005', 'Hoang Van E', 'Truong Dai hoc Kinh te', 'hoangvane@example.com', '0000-0001-2345-6793'),
    ('TG006', 'Nguyen Thi F', 'Dai hoc Y Duoc', 'nguyenf@example.com', '0000-0001-2345-6794'),
    ('TG007', 'Bui Minh G', 'Vien Khoa hoc Xa hoi', 'buimingh@example.com', '0000-0001-2345-6795'),
    ('TG008', 'Dang Thanh H', 'Truong Dai hoc Su pham', 'dangthanhh@example.com', '0000-0001-2345-6796'),
    ('TG009', 'Phan Hoang I', 'Truong Dai hoc Van hoa', 'phanhoangi@example.com', '0000-0001-2345-6797'),
    ('TG010', 'Vu Thi J', 'Truong Dai hoc Nong Lam', 'vuthij@example.com', '0000-0001-2345-6798'),
    ('TG011', 'Ly Hong K', 'Truong Dai hoc My thuat', 'lyhongk@example.com', '0000-0001-2345-6799'),
    ('TG012', 'Doan Minh L', 'Vien Khoa hoc Ky thuat', 'doanminhl@example.com', '0000-0001-2345-6800'),
    ('TG013', 'Nguyen Quang M', 'Truong Dai hoc Co khi', 'nguyenquangm@example.com', '0000-0001-2345-6801'),
    ('TG014', 'Le Thi N', 'Vien Sinh hoc', 'lethinh@example.com', '0000-0001-2345-6802'),
    ('TG015', 'Tran Minh O', 'Truong Dai hoc Khoa hoc', 'tranminho@example.com', '0000-0001-2345-6803');

-- Chen du lieu vao bang BaiBao
INSERT INTO BaiBao (MaBaiBao, TieuDe, TomTat, TuKhoa, MaSoBao)
VALUES
    ('BB001', 'Nghien cuu ve Cong Nghe Thong Tin', 'Bai bao nay nghien cuu ve cac cong nghe moi trong nganh IT.', 'Cong nghe, IT', 'SB001'),
    ('BB002', 'Phan tich cac phuong phap hoc may', 'Bai bao nay de cap den cac phuong phap hoc may tien tien.', 'Hoc may, AI', 'SB002'),
    ('BB003', 'Vat ly luong tu va ung dung', 'Bai bao gioi thieu cac nghien cuu moi ve vat ly luong tu.', 'Vat ly, Luong tu', 'SB003'),
    ('BB004', 'Sinh hoc phan tu trong y hoc', 'Bai bao nay nghien cuu ve ung dung cua sinh hoc phan tu trong y hoc.', 'Sinh hoc, Y hoc', 'SB004'),
    ('BB005', 'Kinh te hoc va su phat trien ben vung', 'Bai bao nay nghien cuu ve moi quan he giua kinh te hoc va phat trien ben vung.', 'Kinh te, Phat trien ben vung', 'SB005'),
    ('BB006', 'Chinh tri hoc va su thay doi xa hoi', 'Bai bao nay nghien cuu tac dong cua chinh tri doi voi su thay doi xa hoi.', 'Chinh tri, Xa hoi', 'SB006'),
    ('BB007', 'Doi moi sang tao trong giao duc', 'Bai bao nay thao luan ve cac phuong phap doi moi trong giao duc.', 'Giao duc, Doi moi', 'SB007'),
    ('BB008', 'Nong nghiep thong minh va cong nghe cao', 'Bai bao nay nghien cuu ve ung dung cong nghe trong nong nghiep.', 'Nong nghiep, Cong nghe', 'SB008'),
    ('BB009', 'Phat trien nghe thuat duong dai', 'Bai bao nay thao luan ve su phat trien cua nghe thuat duong dai trong xa hoi hien nay.', 'Nghe thuat, Duong dai', 'SB009'),
    ('BB010', 'Ung dung tri tue nhan tao trong y te', 'Bai bao nay nghien cuu ve ung dung AI trong nganh y te.', 'Tri tue nhan tao, Y te', 'SB010'),
    ('BB011', 'Tinh toan va mo phong trong co khi', 'Bai bao nay nghien cuu ve cac ky thuat tinh toan trong co khi.', 'Co khi, Mo phong', 'SB011'),
    ('BB012', 'Quan ly tai chinh trong doanh nghiep', 'Bai bao nay phan tich cac phuong phap quan ly tai chinh hieu qua trong doanh nghiep.', 'Tai chinh, Doanh nghiep', 'SB012'),
    ('BB013', 'Phat trien van hoa va truyen thong dan toc', 'Bai bao nay nghien cuu ve van hoa va truyen thong dan toc Viet Nam.', 'Van hoa, Dan toc', 'SB013'),
    ('BB014', 'Nghien cuu khoa hoc trong moi truong bien doi', 'Bai bao nay nghien cuu anh huong cua moi truong bien doi doi voi khoa hoc.', 'Khoa hoc, Moi truong', 'SB014'),
    ('BB015', 'Kham pha cac phuong phap giao duc sang tao', 'Bai bao nay phan tich cac phuong phap giao duc sang tao trong the gioi hien dai.', 'Giao duc, Sang tao', 'SB015');

-- Chen du lieu vao bang LinhVuc
INSERT INTO LinhVuc (MaLinhVuc, TenLinhVuc)
VALUES
    ('LV001', 'Cong Nghe Thong Tin'),
    ('LV002', 'Vat Ly'),
    ('LV003', 'Sinh Hoc'),
    ('LV004', 'Kinh Te'),
    ('LV005', 'Chinh Tri'),
    ('LV006', 'Xa Hoi'),
    ('LV007', 'Giao Duc'),
    ('LV008', 'Nong Nghiep'),
    ('LV009', 'Nghe Thuat'),
    ('LV010', 'Y Hoc'),
    ('LV011', 'Co Khi'),
    ('LV012', 'Moi Truong'),
    ('LV013', 'Van Hoa'),
    ('LV014', 'Tai Chinh'),
    ('LV015', 'Doi Moi Sang Tao');


-- Chen du lieu vao bang TacGia_BaiBao
INSERT INTO TacGia_BaiBao (MaTacGia, MaBaiBao, VaiTro)
VALUES
    ('TG001', 'BB001', N'Tác giả chính'),
    ('TG002', 'BB002', N'Đồng tác giả'),
    ('TG003', 'BB003', N'Tác giả liên hệ'),
    ('TG004', 'BB004', N'Tác giả chính'),
    ('TG005', 'BB005', N'Đồng tác giả'),
    ('TG006', 'BB006', N'Tác giả liên hệ'),
    ('TG007', 'BB007', N'Tác giả chính'),
    ('TG008', 'BB008', N'Đồng tác giả'),
    ('TG009', 'BB009', N'Tác giả liên hệ'),
    ('TG010', 'BB010', N'Tác giả chính'),
    ('TG011', 'BB011', N'Đồng tác giả'),
    ('TG012', 'BB012', N'Tác giả liên hệ'),
    ('TG013', 'BB013', N'Tác giả chính'),
    ('TG014', 'BB014', N'Đồng tác giả'),
    ('TG015', 'BB015', N'Tác giả liên hệ');


-- Chen du lieu vao bang PhanBien
INSERT INTO PhanBien (MaPhanBien, MaBaiBao, HoTenPhanBien, KetQua, NhanXet)
VALUES
    ('PB001', 'BB001', 'Nguyen Thi A', N'Chấp nhận', 'Bai bao co nghien cuu chinh xac, phu hop voi muc tieu nghien cuu.'),
    ('PB002', 'BB002', 'Tran Thi B', N'Sửa đổi', 'Bai bao can duoc bo sung them cac chi tiet ve phuong phap thu nghiem.'),
    ('PB003', 'BB003', 'Pham Thi C', N'Từ chối', 'Bai bao chua du thong tin can thiet, can dieu chinh lai.'),
    ('PB004', 'BB004', 'Le Thi D', N'Chấp nhận', 'Bai bao co gia tri thuc tien cao, cung cap giai phap moi.'),
    ('PB005', 'BB005', 'Nguyen Thi E', N'Sửa đổi', 'Cau hoi ve cach thuc thuc hien can duoc lam ro.'),
    ('PB006', 'BB006', 'Hoang Thi F', N'Từ chối', 'Bai bao chua duoc kiem tra thong tin, can phai co tai lieu tham khao.'),
    ('PB007', 'BB007', 'Pham Thi G', N'Chấp nhận', 'Bai bao duoc viet ro rang, thong tin phong phu, su chinh xac trong cac so lieu tham kha.'),
    ('PB008', 'BB008', 'Dang Thanh O', N'Chấp nhận', 'Bai bao dung dan, du lieu phong phu.'),
    ('PB009', 'BB009', 'Phan Hoang P', N'Sửa đổi', 'Can bo sung them chi tiet ve qua trinh phat trien nghe thuat.'),
    ('PB010', 'BB010', 'Vu Thi Q', N'Chấp nhận', 'Bai bao co tinh thuc tien cao, co gia tri trong nghanh y te.'),
    ('PB011', 'BB011', 'Ly Hong R', N'Từ chối', 'Bai bao chua xac dinh duoc phuong phap tinh toan mo phong co hieu qua.'),
    ('PB012', 'BB012', 'Doan Minh S', N'Chấp nhận', 'Bai bao co gia tri cao trong quan ly tai chinh doanh nghiep.'),
    ('PB013', 'BB013', 'Nguyen Quang T', N'Sửa đổi', 'Can lam ro ve khung noi dung cua bai bao.'),
    ('PB014', 'BB014', 'Le Thi U', N'Chấp nhận', 'Bai bao rat huu ich, cho cong dong nghien cuu.'),
    ('PB015', 'BB015', 'Tran Minh V', N'Sửa đổi', 'Can lam ro mot so dong bo ve phuong phap giao duc.');

SELECT * FROM TapChi
SELECT * FROM SoBao
SELECT * FROM TacGia
SELECT * FROM BaiBao
SELECT * FROM LinhVuc
SELECT * FROM TacGia_BaiBao
SELECT * FROM PhanBien

--Chương 4 Tạo view
--1.View Tổng hợp thông tin về bài báo và tác giả
--Tạo view
CREATE VIEW V_TongHopBaiBaoTacGia AS
SELECT 
    B.MaBaiBao, 
    B.TieuDe, 
    TG.HoTen AS TacGia, 
    TGB.VaiTro
FROM 
    BaiBao B
JOIN 
    TacGia_BaiBao TGB ON B.MaBaiBao = TGB.MaBaiBao
JOIN 
    TacGia TG ON TGB.MaTacGia = TG.MaTacGia;
--Hiển thị kết quả
SELECT BaiBao.TieuDe, TacGia.HoTen
FROM BaiBao
JOIN TacGia_BaiBao ON BaiBao.MaBaiBao = TacGia_BaiBao.MaBaiBao
JOIN TacGia ON TacGia_BaiBao.MaTacGia = TacGia.MaTacGia
WHERE TacGia_BaiBao.VaiTro = N'Tác giả chính';

--2.View Danh sách các bài báo có kết quả phản biện là "Chấp nhận"
--Tạo view
CREATE VIEW V_BaiBaoChapNhan AS
SELECT 
    B.MaBaiBao, 
    B.TieuDe, 
    PB.HoTenPhanBien, 
    PB.NhanXet
FROM 
    BaiBao B
JOIN 
    PhanBien PB ON B.MaBaiBao = PB.MaBaiBao
WHERE 
    PB.KetQua = N'Chấp nhận';
--Hiển thị kết quả
SELECT TenTapChi, COUNT(*) AS SoLanXuatBan
FROM TapChi
JOIN SoBao ON TapChi.MaTapChi = SoBao.MaTapChi
WHERE SoBao.NgayPhatHanh LIKE '2025-01%' 
GROUP BY TenTapChi;
--3.View Danh sách tạp chí với số bài báo xuất bản theo năm
--Tạo view
CREATE VIEW V_TapChiTheoNam AS
SELECT 
    T.MaTapChi, 
    T.TenTapChi, 
    COUNT(B.MaBaiBao) AS SoBaiBao
FROM 
    TapChi T
JOIN 
    SoBao S ON T.MaTapChi = S.MaTapChi
JOIN 
    BaiBao B ON S.MaSoBao = B.MaSoBao
GROUP BY 
    T.MaTapChi, T.TenTapChi, YEAR(S.NgayPhatHanh);
--Hiển thị kết quả
SELECT HoTen, CoQuanCongTac
FROM TacGia;
--4.View Danh sách bài báo của tác giả liên hệ
--
CREATE VIEW V_BaiBaoTacGiaLienHe AS
SELECT 
    B.MaBaiBao, 
    B.TieuDe, 
    TG.HoTen, 
    TGB.VaiTro
FROM 
    BaiBao B
JOIN 
    TacGia_BaiBao TGB ON B.MaBaiBao = TGB.MaBaiBao
JOIN 
    TacGia TG ON TGB.MaTacGia = TG.MaTacGia
WHERE 
    TGB.VaiTro = N'Tác giả liên hệ';
--
SELECT BaiBao.TieuDe, PhanBien.KetQua
FROM BaiBao
JOIN PhanBien ON BaiBao.MaBaiBao = PhanBien.MaBaiBao;
--5.View Tác giả có số lượng bài báo nhiều nhất
--
CREATE VIEW V_TacGiaCoSoLuongBaiBaoNhieuNhat AS
SELECT 
    TG.MaTacGia, 
    TG.HoTen, 
    COUNT(TGB.MaBaiBao) AS SoLuongBaiBao
FROM 
    TacGia TG
JOIN 
    TacGia_BaiBao TGB ON TG.MaTacGia = TGB.MaTacGia
GROUP BY 
    TG.MaTacGia, TG.HoTen
HAVING 
    COUNT(TGB.MaBaiBao) = (SELECT MAX(SoLuongBaiBao) FROM 
                            (SELECT COUNT(MaBaiBao) AS SoLuongBaiBao 
                             FROM TacGia_BaiBao 
                             GROUP BY MaTacGia) AS Temp);
--
SELECT TenTapChi, COUNT(MaBaiBao) AS SoBaiBao
FROM TapChi
JOIN SoBao ON TapChi.MaTapChi = SoBao.MaTapChi
JOIN BaiBao ON SoBao.MaSoBao = BaiBao.MaSoBao
GROUP BY TenTapChi;
--6.View Tổng hợp các bài báo theo lĩnh vực###
--
CREATE VIEW V_BaiBaoTheoLinhVuc AS
SELECT 
    B.MaBaiBao, 
    B.TieuDe, 
    L.TenLinhVuc
FROM 
    BaiBao B
JOIN 
    LinhVuc L ON B.TuKhoa LIKE '%' + L.TenLinhVuc + '%';
--
SELECT BaiBao.TieuDe
FROM BaiBao
JOIN SoBao ON BaiBao.MaSoBao = SoBao.MaSoBao
JOIN TapChi ON SoBao.MaTapChi = TapChi.MaTapChi
WHERE TapChi.TenTapChi = 'Tap chi Cong Nghe Thong Tin';
--7.View Tạp chí có số lượng bài báo tối đa
--
CREATE VIEW V_TapChiCoSoLuongBaiBaoToiDa AS
SELECT 
    T.MaTapChi, 
    T.TenTapChi, 
    COUNT(B.MaBaiBao) AS SoLuongBaiBao
FROM 
    TapChi T
JOIN 
    SoBao S ON T.MaTapChi = S.MaTapChi
JOIN 
    BaiBao B ON S.MaSoBao = B.MaSoBao
GROUP BY 
    T.MaTapChi, T.TenTapChi
HAVING 
    COUNT(B.MaBaiBao) = (SELECT MAX(SoLuongBaiBao) FROM 
                         (SELECT COUNT(MaBaiBao) AS SoLuongBaiBao FROM BaiBao 
                          JOIN SoBao ON BaiBao.MaSoBao = SoBao.MaSoBao 
                          GROUP BY SoBao.MaTapChi) AS Temp);

--
SELECT HoTen, TieuDe
FROM TacGia
JOIN TacGia_BaiBao ON TacGia.MaTacGia = TacGia_BaiBao.MaTacGia
JOIN BaiBao ON TacGia_BaiBao.MaBaiBao = BaiBao.MaBaiBao
WHERE TacGia_BaiBao.VaiTro = N'Tác giả chính';
--8.View Danh sách các bài báo đã được phản biện
--
CREATE VIEW V_BaiBaoDaPhanBien AS
SELECT 
    B.MaBaiBao, 
    B.TieuDe, 
    PB.HoTenPhanBien, 
    PB.KetQua
FROM 
    BaiBao B
JOIN 
    PhanBien PB ON B.MaBaiBao = PB.MaBaiBao;
--
SELECT TenTapChi, ISSN
FROM TapChi
WHERE KyXuatBan = N'Hàng tháng';
--9.View Danh sách các bài báo theo Tạp chí
--
CREATE VIEW V_DanhSachBaiBaoTheoTapChi AS
SELECT 
    T.MaTapChi, 
    T.TenTapChi, 
    B.MaBaiBao, 
    B.TieuDe, 
    B.TomTat
FROM 
    TapChi T
JOIN 
    SoBao S ON T.MaTapChi = S.MaTapChi
JOIN 
    BaiBao B ON S.MaSoBao = B.MaSoBao;
--
SELECT TenTapChi, KyXuatBan
FROM TapChi;
--10.View liệt kê các bài báo với thông tin tác giả và vai trò của họ trong bài báo
--
CREATE VIEW V_BaiBaoTacGiaVaiTro AS
SELECT BaiBao.TieuDe, TacGia.HoTen, TacGia_BaiBao.VaiTro
FROM BaiBao
JOIN TacGia_BaiBao ON BaiBao.MaBaiBao = TacGia_BaiBao.MaBaiBao
JOIN TacGia ON TacGia_BaiBao.MaTacGia = TacGia.MaTacGia;
--
SELECT * FROM V_BaiBaoTacGiaVaiTro;

--Chương 5 Xây dựng các procedure
--1.Thêm một tạp chí mới
--
CREATE PROCEDURE sp_ThemTapChi
    @MaTapChi VARCHAR(20),
    @TenTapChi NVARCHAR(255),
    @ISSN VARCHAR(20),
    @NhaXuatBan NVARCHAR(255),
    @KyXuatBan NVARCHAR(50)
AS
BEGIN
    INSERT INTO TapChi (MaTapChi, TenTapChi, ISSN, NhaXuatBan, KyXuatBan)
    VALUES (@MaTapChi, @TenTapChi, @ISSN, @NhaXuatBan, @KyXuatBan);
END;
--
EXEC sp_ThemTapChi 'TC016', 'Tap chi Cong Nghe AI', '6789-9999', 'NXB Cong Nghe', N'Hàng tháng';
SELECT * FROM TapChi WHERE MaTapChi = 'TC016';

--2.Cập nhật thông tin của một tạp chí
--
CREATE PROCEDURE sp_CapNhatTapChi
    @MaTapChi VARCHAR(20),
    @TenTapChi NVARCHAR(255),
    @ISSN VARCHAR(20),
    @NhaXuatBan NVARCHAR(255),
    @KyXuatBan NVARCHAR(50)
AS
BEGIN
    UPDATE TapChi
    SET TenTapChi = @TenTapChi,
        ISSN = @ISSN,
        NhaXuatBan = @NhaXuatBan,
        KyXuatBan = @KyXuatBan
    WHERE MaTapChi = @MaTapChi;
END;
--
EXEC sp_CapNhatTapChi 'TC016', 'Tap chi Cong AI Cap Nhat', '6789-9999', 'NXB Cong Nghe Moi', N'Hàng quý';
SELECT * FROM TapChi WHERE MaTapChi = 'TC016';
--3.Xóa một tạp chí theo mã
--
CREATE PROCEDURE sp_XoaTapChi
    @MaTapChi VARCHAR(20)
AS
BEGIN
    DELETE FROM TapChi WHERE MaTapChi = @MaTapChi;
END;
--
EXEC sp_XoaTapChi 'TC016';
SELECT * FROM TapChi WHERE MaTapChi = 'TC016';
--4.Lấy danh sách bài báo theo mã số báo
--
CREATE PROCEDURE sp_LayBaiBaoTheoSoBao
    @MaSoBao VARCHAR(20)
AS
BEGIN
    SELECT * FROM BaiBao WHERE MaSoBao = @MaSoBao;
END;
--
EXEC sp_LayBaiBaoTheoSoBao 'SB001';
--5.Lấy danh sách tác giả của một bài báo#####
--
CREATE PROCEDURE sp_LayTacGiaTheoBaiBao
    @MaBaiBao VARCHAR(20)
AS
BEGIN
    SELECT TG.HoTen, TG.Email, TGBB.VaiTro
    FROM TacGia_BaiBao TGBB
    JOIN TacGia TG ON TGBB.MaTacGia = TG.MaTacGia
    WHERE TGBB.MaBaiBao = @MaBaiBao;
END;
--
EXEC sp_LayTacGiaTheoBaiBao 'BB001';
--6.Thêm một bài báo mới####
CREATE PROCEDURE sp_ThemBaiBao
    @MaBaiBao VARCHAR(20),
    @TieuDe NVARCHAR(255),
    @TomTat TEXT,
    @TuKhoa NVARCHAR(255),
    @MaSoBao VARCHAR(20)
AS
BEGIN
    -- Kiểm tra xem MaBaiBao đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM BaiBao WHERE MaBaiBao = @MaBaiBao)
    BEGIN
        PRINT N'Bài báo đã tồn tại';
        RETURN;
    END

    -- Kiểm tra xem MaSoBao có tồn tại trong bảng SoBao không
    IF NOT EXISTS (SELECT 1 FROM SoBao WHERE MaSoBao = @MaSoBao)
    BEGIN
        PRINT N'Số báo không tồn tại';
        RETURN;
    END

    -- Thực hiện chèn bài báo vào bảng BaiBao
    INSERT INTO BaiBao (MaBaiBao, TieuDe, TomTat, TuKhoa, MaSoBao)
    VALUES (@MaBaiBao, @TieuDe, @TomTat, @TuKhoa, @MaSoBao);
    
    PRINT N'Bài báo đã được thêm thành công';
END;
EXEC sp_ThemBaiBao 'BB016', N'Ứng dụng AI trong y tế', N'Bài báo nghiên cứu về AI trong y tế', N'AI, Y tế', 'SB002';
SELECT * FROM BaiBao WHERE MaBaiBao = 'BB016';

--7.
--
CREATE PROCEDURE sp_XoaBaiBao
    @MaBaiBao VARCHAR(20)
AS
BEGIN
    -- Kiểm tra xem bài báo có tồn tại trong bảng BaiBao không
    IF NOT EXISTS (SELECT 1 FROM BaiBao WHERE MaBaiBao = @MaBaiBao)
    BEGIN
        PRINT N'Bài báo không tồn tại';
        RETURN;
    END

    -- Kiểm tra xem bài báo có bản ghi liên quan trong bảng PhanBien không
    IF EXISTS (SELECT 1 FROM PhanBien WHERE MaBaiBao = @MaBaiBao)
    BEGIN
        PRINT N'Bài báo này có phản biện, không thể xóa';
        RETURN;
    END

    -- Kiểm tra xem bài báo có bản ghi liên quan trong bảng TacGia_BaiBao không
    IF EXISTS (SELECT 1 FROM TacGia_BaiBao WHERE MaBaiBao = @MaBaiBao)
    BEGIN
        PRINT N'Bài báo này có tác giả liên quan, không thể xóa';
        RETURN;
    END

    -- Thực hiện xóa bài báo từ bảng BaiBao
    DELETE FROM BaiBao WHERE MaBaiBao = @MaBaiBao;
    
    PRINT N'Bài báo đã được xóa thành công';
END;
--
EXEC sp_XoaBaiBao 'BB016';

--8.Lấy danh sách tất cả tạp chí với số lượng bài báo
--
CREATE PROCEDURE sp_ThongKeBaiBaoTheoTapChi
AS
BEGIN
    SELECT TC.MaTapChi, TC.TenTapChi, COUNT(BB.MaBaiBao) AS SoLuongBaiBao
    FROM TapChi TC
    LEFT JOIN SoBao SB ON TC.MaTapChi = SB.MaTapChi
    LEFT JOIN BaiBao BB ON SB.MaSoBao = BB.MaSoBao
    GROUP BY TC.MaTapChi, TC.TenTapChi;
END;
--
EXEC sp_ThongKeBaiBaoTheoTapChi;
--9.Thống kê số lượng bài báo theo từng lĩnh vực#####
--
CREATE PROCEDURE sp_ThongKeBaiBaoTheoLinhVuc
AS
BEGIN
    SELECT LV.TenLinhVuc, COUNT(BB.MaBaiBao) AS SoLuongBaiBao
    FROM LinhVuc LV
    LEFT JOIN BaiBao BB ON LV.MaLinhVuc = BB.MaSoBao
    GROUP BY LV.TenLinhVuc;
END;
--
EXEC sp_ThongKeBaiBaoTheoLinhVuc;
--10.Lấy danh sách các bài báo được chấp nhận qua phản biện
CREATE PROCEDURE sp_LayBaiBaoChapNhan
AS
BEGIN
    SELECT BB.*
    FROM BaiBao BB
    JOIN PhanBien PB ON BB.MaBaiBao = PB.MaBaiBao
    WHERE PB.KetQua = N'Chấp nhận';
END;
--
EXEC sp_LayBaiBaoChapNhan;

--Chương 6: Trigger
--1.Không cho phép xóa tạp chí nếu có số báo tồn tại
CREATE TRIGGER trg_KhongXoaTapChiNeuCoSoBao
ON TapChi
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM deleted d
        JOIN SoBao sb ON d.MaTapChi = sb.MaTapChi
    )
    BEGIN
        RAISERROR (N'Không thể xóa tạp chí vì có số báo liên quan!', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM TapChi WHERE MaTapChi IN (SELECT MaTapChi FROM deleted);
    END
END;
--
DELETE FROM TapChi WHERE MaTapChi = 'TC001';

--2.Xóa bài báo thì tự động xóa phản biện liên quan
CREATE TRIGGER trg_XoaPhanBienKhiXoaBaiBao
ON BaiBao
AFTER DELETE
AS
BEGIN
    DELETE FROM PhanBien WHERE MaBaiBao IN (SELECT MaBaiBao FROM deleted);
END;

DELETE FROM BaiBao WHERE MaBaiBao = 'BB018';
SELECT * FROM PhanBien WHERE MaBaiBao = 'BB018';

--3.Không cho phép xóa tác giả nếu có bài báo liên quan
CREATE TRIGGER trg_KhongXoaTacGiaNeuCoBaiBao
ON TacGia
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM deleted d
        JOIN TacGia_BaiBao tgbb ON d.MaTacGia = tgbb.MaTacGia
    )
    BEGIN
        RAISERROR (N'Không thể xóa tác giả vì có bài báo liên quan!', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM TacGia WHERE MaTacGia IN (SELECT MaTacGia FROM deleted);
    END
END;
--
DELETE FROM TacGia WHERE MaTacGia = 'TG001';
--4. Tự động cập nhật số lượng bài báo của một số báo khi có bài báo mới được thêm vào
CREATE TRIGGER trg_UpdateSoLuongBaiBao
ON BaiBao
AFTER INSERT, DELETE
AS
BEGIN
    UPDATE SoBao
    SET SoPhatHanh = (SELECT COUNT(*) FROM BaiBao WHERE MaSoBao = SoBao.MaSoBao)
    WHERE MaSoBao IN (SELECT MaSoBao FROM inserted UNION SELECT MaSoBao FROM deleted);
END;
--Thêm bài báo mới vào số báo SB001
INSERT INTO BaiBao (MaBaiBao, TieuDe, MaSoBao) 
VALUES ('BB100', N'Nghiên cứu AI', 'SB001');
--Kết quả mong đợi: Số lượng bài báo trong SB001 tăng thêm 1.
SELECT MaSoBao, SoPhatHanh FROM SoBao WHERE MaSoBao = 'SB001';
--5.Ngăn chặn việc thêm bản ghi vào bảng
CREATE TRIGGER trg_ThemTapChi
ON TapChi
AFTER INSERT
AS
BEGIN
    DECLARE @ISSN VARCHAR(20)
    
    SELECT @ISSN = ISSN FROM inserted
    
    IF @ISSN IS NULL
    BEGIN
        RAISERROR(N'ISSN không thể rỗng', 16, 1)
        ROLLBACK TRANSACTION
    END
END
--
INSERT INTO TapChi (MaTapChi, TenTapChi, ISSN)
VALUES (1, N'Tạp chí Công nghệ', NULL);
--6.Tạo trigger cập nhật nhà xuất bản khi tạp chí bị thay đổi
CREATE TRIGGER update_nhaxuatban
ON TapChi
FOR UPDATE
AS
BEGIN
    DECLARE @maTapChi VARCHAR(20);
    DECLARE @nhaXuatBanMoi NVARCHAR(255);
    
    SELECT @maTapChi = MaTapChi, @nhaXuatBanMoi = NhaXuatBan FROM INSERTED;
    
    -- Cập nhật nhà xuất bản nếu cần
    UPDATE TapChi
    SET NhaXuatBan = @nhaXuatBanMoi
    WHERE MaTapChi = @maTapChi;
    
    PRINT N'Đã cập nhật nhà xuất bản cho tạp chí ' + @maTapChi;
END;
-- Cập nhật thông tin nhà xuất bản của tạp chí
UPDATE TapChi
SET NhaXuatBan = 'Nha Xuat Ban Moi'
WHERE MaTapChi = 'TC001';
--7.Trigger tự động ghi lại lịch sử thay đổi thông tin bảng
-- Tạo bảng lịch sử
CREATE TABLE SoBao_LichSu (
    MaSoBao VARCHAR(20),
    NgayThayDoi DATETIME,
    ThaoTac NVARCHAR(50),
    SoPhatHanh INT,
    NgayPhatHanh DATE
);
GO
-- Tạo trigger ghi lại lịch sử thay đổi
CREATE TRIGGER log_soBao_changes
ON SoBao
FOR UPDATE
AS
BEGIN
    DECLARE @maSoBao VARCHAR(20), @soPhatHanh INT, @ngayPhatHanh DATE;
    DECLARE @thaoTac NVARCHAR(50);
    
    SELECT @maSoBao = MaSoBao, @soPhatHanh = SoPhatHanh, @ngayPhatHanh = NgayPhatHanh FROM INSERTED;
    
    -- Xác định loại thao tác (update)
    SET @thaoTac = 'UPDATE';
    
    -- Ghi lại thay đổi vào bảng lịch sử
    INSERT INTO SoBao_LichSu (MaSoBao, NgayThayDoi, ThaoTac, SoPhatHanh, NgayPhatHanh)
    VALUES (@maSoBao, GETDATE(), @thaoTac, @soPhatHanh, @ngayPhatHanh);
    
    PRINT N'Đã ghi lại lịch sử thay đổi của số báo ' + @maSoBao;
END;
-- Cập nhật thông tin số báo
UPDATE SoBao
SET SoPhatHanh = 2, NgayPhatHanh = '2025-03-10'
WHERE MaSoBao = 'SB001';
--Kiểm tra bảng SoBao_LichSu để xem các bản ghi lịch sử:
SELECT * FROM SoBao_LichSu;
--8.Tạo trigger tự động xóa bài báo khi số báo bị xóa
CREATE TRIGGER delete_baibao_on_delete_soBao
ON SoBao
FOR DELETE
AS
BEGIN
    DECLARE @maSoBao VARCHAR(20);
    
    -- Lấy mã số báo từ bản ghi bị xóa
    SELECT @maSoBao = MaSoBao FROM DELETED;
    
    -- Xóa tất cả các bài báo có mã số báo đó
    DELETE FROM BaiBao
    WHERE MaSoBao = @maSoBao;
    
    PRINT N'Tất cả bài báo của số báo ' + @maSoBao + N' đã bị xóa.';
END;
GO
-- Xóa số báo
DELETE FROM SoBao
WHERE MaSoBao = 'BB001';
-- Kiểm tra bảng BaiBao để xem các bài báo có bị xóa không:
SELECT * FROM BaiBao WHERE MaSoBao = 'BB001';
--9.Trigger tự động tính toán và cập nhật trạng thái đơn hàng
-- Tạo bảng HoaDon
CREATE TABLE HoaDon (
    MaHoaDon VARCHAR(20),
    TongTien DECIMAL(18,2),
    SoTienThanhToan DECIMAL(18,2),
    TrangThai NVARCHAR(50)
);
GO
-- Chèn dữ liệu vào bảng HoaDon
INSERT INTO HoaDon (MaHoaDon, TongTien, SoTienThanhToan, TrangThai)
VALUES ('HD001', 5000, 0, 'Chưa thanh toán');

-- Tạo trigger tự động cập nhật trạng thái đơn hàng khi thanh toán
CREATE TRIGGER update_trangthai_hoadon
ON HoaDon
FOR UPDATE
AS
BEGIN
    DECLARE @maHoaDon VARCHAR(20);
    DECLARE @tongTien DECIMAL(18,2);
    DECLARE @soTienThanhToan DECIMAL(18,2);
    DECLARE @trangThai NVARCHAR(50);
    
    -- Lấy thông tin hóa đơn từ bản ghi được cập nhật
    SELECT @maHoaDon = MaHoaDon, @tongTien = TongTien, @soTienThanhToan = SoTienThanhToan FROM INSERTED;
    
    -- Kiểm tra xem số tiền thanh toán có bằng tổng tiền hay không
    IF @soTienThanhToan = @tongTien
    BEGIN
        SET @trangThai = 'Đã thanh toán';
    END
    ELSE
    BEGIN
        SET @trangThai = 'Chưa thanh toán';
    END
    
    -- Cập nhật trạng thái của hóa đơn
    UPDATE HoaDon
    SET TrangThai = @trangThai
    WHERE MaHoaDon = @maHoaDon;
    
    PRINT N'Trạng thái của hóa đơn ' + @maHoaDon + N' đã được cập nhật.';
END;
GO
-- Cập nhật số tiền thanh toán của hóa đơn
UPDATE HoaDon
SET SoTienThanhToan = 5000
WHERE MaHoaDon = 'HD001';
GO
-- Kiểm tra lại bảng HoaDon
SELECT * FROM HoaDon WHERE MaHoaDon = 'HD001';
--10.Trigger tự động cập nhật thời gian sửa đổi khi cập nhật bản ghi trong bảng khác
-- Tạo bảng Cha và Bảng Con
CREATE TABLE QuanLyBaiBao (
    MaBaiBao VARCHAR(20),
    TenBaiBao NVARCHAR(100),
    ThoiGianSua DATETIME
);
GO
-- Chèn dữ liệu vào bảng QuanLyBaiBao (Bảng Cha)
INSERT INTO QuanLyBaiBao (MaBaiBao, TenBaiBao, ThoiGianSua)
VALUES
('BB001', N'Nghiên cứu về SQL Server', GETDATE()),
('BB002', N'Hướng dẫn sử dụng Trigger trong SQL', GETDATE());

CREATE TABLE ChiTietBaiBao (
    MaChiTietBaiBao VARCHAR(20),
    MaBaiBao VARCHAR(20),
    NoiDung NVARCHAR(500)
);
GO
-- Chèn dữ liệu vào bảng ChiTietBaiBao (Bảng Con)
INSERT INTO ChiTietBaiBao (MaChiTietBaiBao, MaBaiBao, NoiDung)
VALUES
('CT001', 'BB001', N'Chi tiết về SQL Server - phần 1'),
('CT002', 'BB001', N'Chi tiết về SQL Server - phần 2'),
('CT003', 'BB002', N'Hướng dẫn chi tiết về Trigger trong SQL');

-- Tạo trigger tự động cập nhật thời gian sửa đổi khi bảng con được cập nhật
CREATE TRIGGER update_thoigiansua_baibao
ON ChiTietBaiBao
FOR UPDATE
AS
BEGIN
    DECLARE @maBaiBao VARCHAR(20);
    
    -- Lấy MaBaiBao từ bản ghi cập nhật
    SELECT @maBaiBao = MaBaiBao FROM INSERTED;
    
    -- Cập nhật ThoiGianSua trong bảng Cha
    UPDATE QuanLyBaiBao
    SET ThoiGianSua = GETDATE()
    WHERE MaBaiBao = @maBaiBao;
    
    PRINT N'Thời gian sửa đổi của bài báo ' + @maBaiBao + N' đã được cập nhật.';
END;
-- Cập nhật một chi tiết bài báo
UPDATE ChiTietBaiBao
SET NoiDung = 'Nội dung mới'
WHERE MaChiTietBaiBao = 'CT001';
SELECT * FROM QuanLyBaiBao WHERE MaBaiBao = 'BB001';
GO

SELECT name, type_desc, create_date, modify_date 
FROM sys.triggers;
DROP TRIGGER ;

--Chương 7: Phân quyền và bảo vệ cơ sở dữ liệu
-- Tạo vai trò Quản lý (Admin)
CREATE ROLE Admin;

-- Tạo vai trò Nhân viên (Staff)
CREATE ROLE Staff;

-- Tạo vai trò Khách hàng (Customer)
CREATE ROLE Customer;

-- Cấp quyền SELECT, INSERT, UPDATE cho Staff đối với tất cả bảng, không có quyền DELETE và ALTER
GRANT SELECT, INSERT, UPDATE ON DATABASE::QuanLyTapChiKhoaHoc TO Staff;

-- Cấp quyền SELECT, INSERT, UPDATE cho Staff đối với tất cả bảng, không có quyền DELETE và ALTER
GRANT SELECT, INSERT, UPDATE ON DATABASE::QuanLyTapChiKhoaHoc TO Staff;

-- Cấp quyền SELECT cho Customer đối với tất cả bảng
GRANT SELECT ON DATABASE::QuanLyTapChiKhoaHoc TO Customer;

-- Tạo người dùng cho quản lý và gán vai trò Admin
CREATE LOGIN quanly WITH PASSWORD = 'password123';  -- Tạo login trước
CREATE USER quanly FOR LOGIN quanly;  -- Tạo user từ login
EXEC sp_addrolemember 'Admin', 'quanly';  -- Gán vai trò Admin

-- Tạo người dùng cho nhân viên và gán vai trò Staff
CREATE LOGIN nhanvien WITH PASSWORD = 'password456';  -- Tạo login cho nhân viên
CREATE USER nhanvien FOR LOGIN nhanvien;  -- Tạo user từ login
EXEC sp_addrolemember 'Staff', 'nhanvien';  -- Gán vai trò Staff

-- Tạo người dùng cho khách hàng và gán vai trò Customer
CREATE LOGIN khachhang WITH PASSWORD = 'password789';  -- Tạo login cho khách hàng
CREATE USER khachhang FOR LOGIN khachhang;  -- Tạo user từ login
EXEC sp_addrolemember 'Customer', 'khachhang';  -- Gán vai trò Customer

-- Kiểm tra quyền của một người dùng cụ thể
EXEC sp_helprole 'Admin';
EXEC sp_helprole 'Staff';
EXEC sp_helprole 'Customer';

-- Từ chối quyền DELETE cho vai trò Staff
REVOKE DELETE ON DATABASE::QuanLyTapChiKhoaHoc FROM Staff;
-- Kiểm tra các vai trò đã gán
EXEC sp_helprole;
--Kiểm tra danh sách User trong Database
SELECT name FROM sys.database_principals WHERE type IN ('S', 'U', 'G') AND name = 'quanly';
--Kiểm tra User có liên kết với Login không
SELECT dp.name AS DatabaseUser, sp.name AS LoginName
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp ON dp.sid = sp.sid
WHERE dp.name = 'quanly';

-- Xóa User trong Database
EXEC sp_droprolemember 'Customer', 'khachhang';
DROP USER khachhang;
DROP LOGIN khachhang;
