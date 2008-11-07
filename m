Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KyRhU-0005od-MQ
	for kexec@lists.infradead.org; Fri, 07 Nov 2008 13:48:36 +0000
In-Reply-To: <18687.62202.333736.269891@drongo.ozlabs.ibm.com>
References: <f90d4d7306443a720ca31adf513faf25@bga.com> <kexec-kern-2@bga.com>
	<18687.61506.924500.411952@drongo.ozlabs.ibm.com>
	<18687.62202.333736.269891@drongo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <b02389c29116c38699a129dfc66be127@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/3] powerpc/ppc64/kdump: better flag for running
	relocatable
Date: Fri, 7 Nov 2008 07:52:31 -0600
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
To: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, Ben Herrenschmidt <benh@kernel.crashing.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linuxppc-dev@ozlabs.org

On Oct 22, 2008, at 10:43 PM, Paul Mackerras wrote:
> Paul Mackerras writes:
>> Milton Miller writes:
>>> Move the flag to 0x5c, 1 word before the secondary cpu entry point at
>>> 0x60.  Use the copy at address 0 not the one in the base kernel 
>>> image to
>>> make it easier on kexec-tools.
>>
>> Why is it easier on kexec-tools?  Doesn't kexec-tools know where it
>> put the kernel?

The archictecture code calls cross-platform code to identify what is
loaded.   It isn't specified if this is a shared mmap or a read into
a buffer.

>>
>> I'd much rather keep the flag inside the kdump kernel image, rather
>> than having kexec/kdump start using random fixed locations outside the
>> new kernel image.
>
> In fact the cliching argument is that when the kernel is loaded by OF
> or yaboot, we have no way to tell what will be at location 0x5c,
> whereas we know that the word at offset 0x5c in the kernel image will
> have been initialized to 0.  So we had better put the flag inside the
> kernel image.

Well, prom_init will copy the 256 bytes to 0 before the code checks
that location.

However, there is an arguement for using the same code from an epapr
or book-e relocatable, and that would need it at 0.   And today
the kexec tool does not do a shared mmap.  Since the change has
been made, I will make a new patch for kexec-tools.

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
