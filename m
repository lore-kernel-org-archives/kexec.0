Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f177.google.com ([209.85.211.177])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Mp1WC-0005Yv-M4
	for kexec@lists.infradead.org; Sat, 19 Sep 2009 15:06:37 +0000
Received: by ywh7 with SMTP id 7so2496456ywh.24
	for <kexec@lists.infradead.org>; Sat, 19 Sep 2009 08:06:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E99B4DCB8B5A0241832DBF4FCB7C813A7D05A5@zch01exm27.fsl.freescale.net>
References: <E99B4DCB8B5A0241832DBF4FCB7C813A7D0280@zch01exm27.fsl.freescale.net>
	<20090916035131.GO24467@verge.net.au>
	<E99B4DCB8B5A0241832DBF4FCB7C813A7D05A5@zch01exm27.fsl.freescale.net>
Date: Sat, 19 Sep 2009 23:06:30 +0800
Message-ID: <e997b7420909190806l28baba26y9f6b4e4679248092@mail.gmail.com>
Subject: Re: The failure of the KEXEC on ARM1136
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
To: Lai Weilin-B04597 <B04597@freescale.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

2009/9/18 Lai Weilin-B04597 <B04597@freescale.com>:
> Hi Simon,
> I am trying to get kexec working on an ARM1136 using the 2.0.1 version of=
 the KEXEC.
>
> The loading seems to work ok. On "kexec -e", I see:
>
> Starting new kernel
> Uncompressing Linux......................................................=
.............................................
>
> crc error
>
> =A0-- System halted
>

It seemed that your second kernel has collapsed.

I don't know why there is a "Uncompressing Linux" print here , as far
as I know, the second kernel is in the form of vmlinux, not uImage or
others.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
