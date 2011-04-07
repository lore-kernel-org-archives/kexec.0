Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from www.linutronix.de ([62.245.132.108] helo=linutronix.de)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q7kUa-0005Ij-V2
	for kexec@lists.infradead.org; Thu, 07 Apr 2011 08:23:05 +0000
Message-ID: <4D9D7465.8030102@linutronix.de>
Date: Thu, 07 Apr 2011 10:23:01 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
Subject: Re: Question regarding the kexec support for FSL Book E
References: <4D9D5F17.2040208@in.ibm.com>
In-Reply-To: <4D9D5F17.2040208@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: kexec@lists.infradead.org

Suzuki Poulose wrote:
> Hi Sebastian,
Hi,

> I am working on the Kexec support for PPC44x based boards. I was going 
> through
> the patchset that you have posted for FSL Book E. I was not able to 
> understand
> some parts of the setup code. If you have some time, could you please 
> help me by
> answering the questions below :
> 
> Here is what I understood from the code walk through :
> 
> In relocate_kernel :, we try to setup a 1:1 mapping for 0-2GB of memory 
> so that
> the code could run with the MMU switched on. We leave a temparory 
> mapping in
> place and create the mapping for 0-2GiB.
> 
> Q1: Does the temparory mapping cover the code which sets up the mapping 
> ? i.e,
> the code in fsl_booke_entry_mapping.S ?

Yes, it does. Please keep in mind that relocate_new_kernel is kmalloc()
into a separate page while running. This is not just the case for
FSL-BookE but for all arches.

> Q2: Does the relocate kernel also get loaded within the 0-2GB memory ? 

Yes. We don't have a mapping >2GiB.

> If so,
> won't we have multiple mappings for the code we are executing, unless we 
> were
> mapped 1:1 by the primary kernel ?

The primary kernel maps 0-2GiB 1:1. We jump to relocate_new_kernel() which
is somewhere within 0..2GiB and not part of the original kernel image.
This code has a page list of the new kernel. It copies the new kernel to
its final position and overwrites the old kernel. This is not a problem as
you remember relocate_new_kernel() is no longer part of the old image.

Once the image is copied, we jump to purgatory and then to the new kernel.

> Thanks
> Suzuki Poulose
> Linux Technology Center
> IBM India

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
