Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ksqx1-0000tf-T7
	for kexec@lists.infradead.org; Thu, 23 Oct 2008 03:33:32 +0000
MIME-Version: 1.0
Message-ID: <18687.61506.924500.411952@drongo.ozlabs.ibm.com>
Date: Thu, 23 Oct 2008 14:32:18 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/3] powerpc/ppc64/kdump: better flag for running
	relocatable
In-Reply-To: <kexec-kern-2@bga.com>
References: <f90d4d7306443a720ca31adf513faf25@bga.com> <kexec-kern-2@bga.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Milton Miller <miltonm@bga.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, Ben Herrenschmidt <benh@kernel.crashing.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linuxppc-dev@ozlabs.org

Milton Miller writes:

> Move the flag to 0x5c, 1 word before the secondary cpu entry point at
> 0x60.  Use the copy at address 0 not the one in the base kernel image to
> make it easier on kexec-tools.

Why is it easier on kexec-tools?  Doesn't kexec-tools know where it
put the kernel?

I'd much rather keep the flag inside the kdump kernel image, rather
than having kexec/kdump start using random fixed locations outside the
new kernel image.

Paul.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
