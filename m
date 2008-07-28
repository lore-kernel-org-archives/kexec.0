Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KNLVb-0001wH-7B
	for kexec@lists.infradead.org; Mon, 28 Jul 2008 05:42:59 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20080728015117.GA12055@verge.net.au>
Date: Sun, 27 Jul 2008 22:39:30 -0700
In-Reply-To: <20080728015117.GA12055@verge.net.au> (Simon Horman's message of
	"Mon, 28 Jul 2008 11:51:19 +1000")
Message-ID: <m1tzeamust.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [patch] crashdump: fix undefined reference to `elfcorehdr_addr'
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
To: Simon Horman <horms@verge.net.au>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Chandru <chandru@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Terry Loftin <terry.loftin@hp.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

Simon Horman <horms@verge.net.au> writes:

>
> Hi,
>
> I started looking into a simple fix to change the name of
> the is_kdump_kernel() to kernel_has_vmcore(), which is what
> the code in its current incarnatation does.
>
> This also lead to cleaning the usage of elfcorehdr_addr,
> which is in the folloing messy state after recent changes.
>
> #ifdef CONFIG_PROC_VMCORE
> * Declared non-static include/linux/crash_dump.h
> * Initialised in fs/proc/vmcore.c
> #else
> * Declared and initialised as static in include/linux/crash_dump.h
> * Only used by is_kdump_kernel() which is a static function
>   also in include/linux/crash_dump.h
> #endif
>
>
> Howerver, in the course of doing this I came to thinking that actually
> this code won't solve the problem at hand in the case where
> CONFIG_CRASH_DUMP is defined but CONFIG_PROC_VMCORE is not.
> Or in other words, what happens if the calgary initialisation code
> runs in a kdump kernel that does not have CONFIG_PROC_VMCORE ?
>
> A similar problem appears to exist in
> arch/ia64/hp/common/sba_iommu.c:sba_init(), which currently doesn't
> compile if CONFIG_CRASH_DUMP is set but CONFIG_PROC_VMCORE is not.  The
> compilation issue could be solved by using kernel_has_vmcore() (as per
> the patch below) instead of checking elfcorehdr_addr directly, but does
> it actually lead to working code?
>
> There has long been a strong aversion to providing the second
> kernel with flags like im_in_kexec or im_in_kdump, as its felt
> that this kind of problem is better handled by making sure that the
> hardware is in a sensible state before leaving the first-kernel.
> But this is arguably more reasonable in the kexec case than the
> kdump case.

That and because we can generally solve the specific problem with
a general feature.  Something we can enable/disable on the
command line if needed.  Right now this is especially interesting
as on several architectures distros are not building special kdump
kernels but have a single kernel binary that works in both cases.

Skimming through your patches this is a case we really do need to
implement and handle cleanly.

Currently we leave DMA running in the kexec on panic case.  We avoid
problems by only running out of a reserved area of memory.

As as general strategy that is fine.  However we have not implemented that
strategy in the case of IOMMUs.  And we are having trouble with IOMMUs.

My hunch is that we should implement options to reserve a section of
the iommu and to tell to the iommu to use the previously reserved section.
Although turning iommus off altogether and simply using swiotlb
may be acceptable.  In which case we should just force usage of the swiotlb
on the command line in /sbin/kexec.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
