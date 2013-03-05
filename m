Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCgs2-0005V6-Kl
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 01:40:47 +0000
Date: Tue, 5 Mar 2013 10:40:44 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc: Fix kernel program entry point while changing
 the load addr
Message-ID: <20130305014043.GD16128@verge.net.au>
References: <20130303073540.12040.16854.stgit@suzukikp>
 <20130304014152.GB9007@verge.net.au> <51343788.7070503@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51343788.7070503@in.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: Matthew McClintock <msm@freescale.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

On Mon, Mar 04, 2013 at 11:26:24AM +0530, Suzuki K. Poulose wrote:
> On 03/04/2013 07:11 AM, Simon Horman wrote:
> >[ Cc: linuxppc-dev@lists.ozlabs.org ]
> >
> >On Sun, Mar 03, 2013 at 01:06:00PM +0530, Suzuki K. Poulose wrote:
> >>From: Suzuki K. Poulose <suzuki@in.ibm.com>
> >>
> >>uImage probe fills the entry point (ep) based on the load_addr
> >>from the uImage headers. If we change the load_addr, we should
> >>accordingly update the entry point.
> >>
> >>For ELF, calculate the offset of e_entry from the virtual start
> >>address and add it to the physical start address to find the
> >>physical address of kernel entry.
> >>
> >>i.e,
> >>   pa (e_entry) = pa(phdr[0].p_vaddr) + (e_entry - phdr[0].p_vaddr)
> >>                = kernel_addr + (e_entry - phdr[0].p_vaddr)
> >
> >Would it be possible for someone to provide a review of this change?
> To make it bit more clear :
> 
> The entry point of the kernel is usually at 0 offset from the first
> PT_LOAD section. The current code makes this assumption and uses the
> pa(phdr[0].p_vaddr) as the kernel entry.
> 
> But this *may* not be true always, in such a case the kexec would fail.
> While I fixed the uImage case, I thought it would be better to
> handle the same case in ELF.
> 
> Btw, this calculation is not specific to ppc32.

Thanks, I have applied the patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
