Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NkH9p-0006wC-Qe
	for kexec@lists.infradead.org; Wed, 24 Feb 2010 13:20:10 +0000
Received: by ewy23 with SMTP id 23so915590ewy.4
	for <kexec@lists.infradead.org>; Wed, 24 Feb 2010 05:20:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d1b08f941002240448s30863e7cg751e6f9cd1f875c5@mail.gmail.com>
References: <36E4692623C5974BA6661C0B18EE8EDF0173493B@MAILSERV.hcrest.com>
	<d1b08f941002240448s30863e7cg751e6f9cd1f875c5@mail.gmail.com>
Date: Wed, 24 Feb 2010 14:20:00 +0100
Message-ID: <d1b08f941002240520g799d5b0di4be827be095e94b2@mail.gmail.com>
Subject: Re: Kexec on ARM?
From: Andrea Adami <andrea.adami@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

> =A0Kexec seems to be able to load the kernel, but just hangs after
> decompression=85. My terminal output looks like:

> root@10.9.5.34:~# kexec -l uImage
> root@10.9.5.34:~# kexec -e
> Starting new kernel
> Bye!
> Uncompressing Linux... done, booting the kernel.

> After this, it just sits there=85.

 I suspect it could be a misconfigured kernel or a kernel problem.
 I can successfully kexec armv5te 2.6.2x/2.6.3x kernels.

 Regards

 Andrea

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
