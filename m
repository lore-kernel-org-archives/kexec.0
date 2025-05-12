Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7D6C3ABBC
	for <kexec@archiver.kernel.org>; Mon, 12 May 2025 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g/ZnFTuVYued68oe7XL8RDnKQ+ZMKy0qE+LfBacqvSc=; b=ZGzufstkqxjVwZTp0yqfXlFQfS
	UyX9i3pyN4CCgP01kZ3AC5AD2r+Ik6fpq/xltnmroGuGU0cGBaBPePQ7KMSj2gVOyhFrgT3senhI3
	Gw0zmnv21BWypLB+IU/vsWWcb2mexbrGtJIsdPME9NfY/9IFiHKNx6Oec7RHEnOM16rbbP9SMoDM9
	3myn3KVihVt21T3tejLPWZGhnbTsRtMSAkgl4OS5cKK8H84QX+Eu8Zz4UFxhMYPy/wIOafvJtNcnG
	1ABsKqnC8Y15kMULOpc59COvS/FW9IWhC+SByNMbxTJPpwJ8f/IcpyNLJ5t2x5IGs3aDQGzoaD6jE
	K9J58HGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEO6y-00000008gZH-2Hf9;
	Mon, 12 May 2025 08:02:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEO6t-00000008gYh-1dZr
	for kexec@bombadil.infradead.org;
	Mon, 12 May 2025 08:02:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=g/ZnFTuVYued68oe7XL8RDnKQ+ZMKy0qE+LfBacqvSc=; b=ZSm3IaLMVncD3AXlqYbq38UrJi
	32nydCwZFQsdzXDgGNhFauOPzJBk74lDI4Lpl8GTRlrEhp0eXynImvmjP7jFd4S5KQ/4So7hDp51y
	nzZs1uU+QFPlUZf5FT723lxGK+Oyes1fHTGFx3bhevtny7HCTKxTLZ1EjUB3IVijepc9ZJIGPMAHb
	SQzweh6iuKpLPk0iDYfULmM8JlNmnJV/boedSCTPqV/UzNeUiJifEzRe0wEuLzkSV23kdFtFKE+B4
	b6PYKV8ANkfXMhmzfB7DxlTx7MIgOSvLr/HhvpRdStKKVrnx1Ob2yRuRhruhQy8ztxYCkLBFXj2Ne
	QVSq50Pw==;
Received: from mail.ventrixio.pl ([57.129.137.141])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uEO6o-0000000GjNK-3y7S
	for kexec@lists.infradead.org;
	Mon, 12 May 2025 08:02:02 +0000
Authentication-Results: ventrixio.pl; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; d=ventrixio.pl; s=default; a=rsa-sha256; cv=none; t=1747036907;
	b=FBnDnc3cRda/IJGSB8oXMchirGvXCwqjFficV2ZQSb4EQqTgIi3WAc6X/twS2bbnRZHw
	 ZNFbT1jdOWepFUs/89+KYstAOOIx5rO6fCDlx20CC3jroWHBXbKkZKzgZIGsaiPwRJPUV
	 IquVUgVP1q/7dgKb/IXCT+EwlYwJNDdb+y640Zhdf21Vtbw/Fs4pSFH/HQbNTRZDbpi9I
	 hfVMk/DlK3okgdD22JdzerEzDR1n1cTveuyzRpFsQgyOrm7XfO09LTPELMCOYc66GJC44
	 6RemFr+/ZQj+5+S2SdxnZf29JJlgqcdhquw/vHR3Z2E+aDdIWiHjBk+rj4ERRAZxnVg==
ARC-Message-Signature: i=1; d=ventrixio.pl; s=default; a=rsa-sha256;
	c=relaxed/simple; t=1747036907;
	h=Message-ID:Date:From:Subject:From;
	bh=g/ZnFTuVYued68oe7XL8RDnKQ+ZMKy0qE+LfBacqvSc=;
	b=d6prtI9x4ojsx0zc2+2tb5L9EvuW9HbBmJRIs4De5Yt6PvqEWTEA9/WhxqxjEDx4iooO
	 Dsk7uy+Ly1ld1D0ilYkPSa+On0YpD8vQergVrTVLT6I7+DZgXLslGu13VX995Tec6Xdi0
	 n7nSyvI2i/B2N8u3dk0G+pwbdhnZhCs8JgL0bKwX5oVdqsTdwGcsEF0aO/nTfCFSJjWMH
	 gwBCXUlhOLXKL3Ob02wmIV2T7j/Wi7zJEtY3JVrJVPXSmY1C5YBMHqgO3aiubmgA/3QXC
	 dANTJs72lJOCZjadrCE3n7R4VLVMd3Q1K5JSnHej7BB1ZZkk6FtJgBc4d+Qz0xMAR2w==
ARC-Authentication-Results: i=1; ventrixio.pl; arc=none smtp.remote-ip=127.0.0.1
Received: by mail.ventrixio.pl (Postfix, from userid 1002)
	id A9FE524317; Mon, 12 May 2025 08:01:40 +0000 (UTC)
Received: by mail.ventrixio.pl for <kexec@lists.infradead.org>; Mon, 12 May 2025 08:01:21 GMT
Message-ID: <20250512064500-0.1.26.lxpw.0.k6dbozilct@ventrixio.pl>
Date: Mon, 12 May 2025 08:01:21 GMT
From: "Karol Bednaszewski" <karol.bednaszewski@ventrixio.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Mniejsze_wydatki_na_samoch=C3=B3d?=
X-Mailer: mail.ventrixio.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_090159_577758_3D25D581 
X-CRM114-Status: UNSURE (   1.06  )
X-CRM114-Notice: Please train this message.
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Dzie=C5=84 dobry!

Czy m=C3=B3g=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re umo=C5=
=BCliwia monitoring ka=C5=BCdego auta w czasie rzeczywistym w tym jego po=
zycj=C4=99, zu=C5=BCycie paliwa i przebieg?

Dodatkowo nasze narz=C4=99dzie minimalizuje koszty utrzymania samochod=C3=
=B3w, skraca czas przejazd=C3=B3w, a tak=C5=BCe umo=C5=BCliwia tworzenie =
planu tras czy dostaw.

Z naszej wiedzy i do=C5=9Bwiadczenia korzysta ju=C5=BC ponad 49 tys. Klie=
nt=C3=B3w. Monitorujemy 809 000 pojazd=C3=B3w na ca=C5=82ym =C5=9Bwiecie,=
 co jest nasz=C4=85 najlepsz=C4=85 wizyt=C3=B3wk=C4=85.

Bardzo prosz=C4=99 o e-maila zwrotnego, je=C5=9Bli mogliby=C5=9Bmy wsp=C3=
=B3lnie om=C3=B3wi=C4=87 potencja=C5=82 wykorzystania takiego rozwi=C4=85=
zania w Pa=C5=84stwa firmie.


Pozdrawiam
Karol Bednaszewski

