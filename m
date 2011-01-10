Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PcPt8-00072z-Tf
	for kexec@lists.infradead.org; Mon, 10 Jan 2011 22:06:55 +0000
Message-ID: <4D2B82E0.80204@zytor.com>
Date: Mon, 10 Jan 2011 14:06:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: kexec and relocatable kernels
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi guys,

I received a query last week regarding kexec's handling of relocatable
kernels.  In particular, it appears that kexec does not take advantage
of relocatable kernels -- except for kdump -- in avoiding low memory holes.

The system in question had an issue with a low memory hole in the
14-16 MiB range, which caused the kernel to crash on decompress.  They
have a hack in their bootloader to avoid that memory range (that's a
problem in itself and another issue, but the bottom line is that all
bootloaders, not just kexec, needs this awareness.)

Since bzImage 2.10, the kernel gives enough information that the
bootloader (including kexec) can reliably find a place for the kernel
away from memory holes, or fail if no acceptable memory exists.

On another subject, there has been an increasing tendency to put
utilities which are by their nature tightly coupled with the kernel into
the kernel source tree.  I'm kind of thinking that kexec might fit that
bill, what do you think?

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
