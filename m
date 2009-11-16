Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f204.google.com ([209.85.211.204])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NA1m1-0006Jq-JA
	for kexec@lists.infradead.org; Mon, 16 Nov 2009 13:37:46 +0000
Received: by ywh42 with SMTP id 42so5017643ywh.28
	for <kexec@lists.infradead.org>; Mon, 16 Nov 2009 05:37:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200911160053.10339.florian@openwrt.org>
References: <200911160053.10339.florian@openwrt.org>
Date: Mon, 16 Nov 2009 21:37:38 +0800
Message-ID: <e997b7420911160537p3b8aaa97p83cc19fca0c35804@mail.gmail.com>
Subject: Re: [PATCH] add support for loading lzma compressed kernels
From: "wilbur.chan" <wilbur512@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Florian Fainelli <florian@openwrt.org>
Cc: kexec@lists.infradead.org

2009/11/16 Florian Fainelli <florian@openwrt.org>
>
> Hi Eric,
>
> This patch allows one to load a lzma compressed kernel using kexec -l.
> As I wanted the lzma code to be very similar to the existing
> zlib slurp_decompress I took lzread and associated routines
> from the cpio lzma support. Tested on my x86 laptop using the
> following commands:
>
> lzma e bzImage bzImage.lzma
> kexec -l bzImage.lzma
>
> Having lzma support is particularly useful on some embedded
> systems on which we have the kernel already lzma compressed
> and available on a mtd partition.


Good.

btw, is there any solution to uImage format=A0=A0 ?=A0 :D

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
