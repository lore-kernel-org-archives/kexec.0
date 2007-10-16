Return-path: <kexec-bounces@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IhfMn-0001Wp-14
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 06:53:25 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9G5ntpk012554
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 01:49:55 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9G5nt9n565586
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 01:49:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9G5njoH005263
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 01:49:45 -0400
Date: Tue, 16 Oct 2007 11:19:56 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 0/2] Protect crashkernel against BSS overlap
Message-ID: <20071016054956.GA4659@in.ibm.com>
References: <20071015115042.391348549@strauss.suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071015115042.391348549@strauss.suse.de>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de

On Mon, Oct 15, 2007 at 01:50:42PM +0200, Bernhard Walle wrote:
> I observed the problem that even when you choose the default 16M as
> crashkernel base address and the kernel is very big, the reserved area may
> overlap with the kernel BSS. Currently, this is not checked at runtime, so the
> kernel just crashes when you load the panic kernel in the sys_kexec call.
> 
> This two patches check this at runtime. The patches are against current git,
> but with the patches
> 
>     extended-crashkernel-command-line.patch
>     extended-crashkernel-command-line-update.patch
>     extended-crashkernel-command-line-comment-fix.patch
>     extended-crashkernel-command-line-improve-error-handling-in-parse_crashkernel_mem.patch
>     use-extended-crashkernel-command-line-on-i386.patch
>     use-extended-crashkernel-command-line-on-i386-update.patch
>     use-extended-crashkernel-command-line-on-x86_64.patch
>     use-extended-crashkernel-command-line-on-x86_64-update.patch
>     use-extended-crashkernel-command-line-on-ia64.patch
>     use-extended-crashkernel-command-line-on-ia64-fix.patch
>     use-extended-crashkernel-command-line-on-ia64-update.patch
>     use-extended-crashkernel-command-line-on-ppc64.patch
>     use-extended-crashkernel-command-line-on-ppc64-update.patch
>     use-extended-crashkernel-command-line-on-sh.patch
>     use-extended-crashkernel-command-line-on-sh-update.patch
> 
> from -mm tree applied since they are marked to be merged in 2.6.24.
> 
> I know that the implementation of both patches is only x86 (i386 and x86-64),
> but if you agree that it's the way to go, I can add the BSS resource
> and the check for all other architectures that apply.
> 

Hi Bernhard,

Shouldn't bootmem allocator have the functionality to flag an error if
we try to reserve a memory which is already reserved? I see that bootmem
allocator is currently printing a warning under CONFIG_DEBUG_BOOTMEM.

Wouldn't it be better if we reserve the code, data and bss memory also
using bootmem allocator and when somebody tries to reserve craskernel memory
and if there is an overlap, boot memory allocator should scream?

In second patch, you are checking for crash kernel reserved memory being
beyond _end. That will make sure that there is no overlap with kernel
text, data or bss. I am wondering then why do we need first patch and
why should we register bss memory in the resources list. Second patch 
would make sure that there is no overlap with crash kernel memory and kexec
will not place any segment outside crashkernel memory.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
