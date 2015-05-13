Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsSG8-0001dN-FA
 for kexec@lists.infradead.org; Wed, 13 May 2015 08:43:21 +0000
Date: Wed, 13 May 2015 16:42:26 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v11 02/10] iommu/vt-d: Items required for kdump
Message-ID: <20150513084226.GO4561@localhost.localdomain>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-3-git-send-email-zhen-hual@hp.com>
 <20150512081723.GC4561@localhost.localdomain>
 <5552ACB9.5050309@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5552ACB9.5050309@hp.com>
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
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

On 05/13/15 at 09:45am, Li, ZhenHua wrote:
> On 05/12/2015 04:17 PM, Dave Young wrote:
> >On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> >>Add context entry functions needed for kdump.
> >>+/*
> >>+ * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
> >>+ *
> >>+ * Fixes the crashdump kernel to deal with an active iommu and legacy
> >>+ * DMA from the (old) panicked kernel in a manner similar to how legacy
> >>+ * DMA is handled when no hardware iommu was in use by the old kernel --
> >>+ * allow the legacy DMA to continue into its current buffers.
> >>+ *
> >>+ * In the crashdump kernel, this code:
> >>+ * 1. skips disabling the IOMMU's translating.
> >>+ * 2. Do not re-enable IOMMU's translating.
> >>+ * 3. In kdump kernel, use the old root entry table.
> >>+ * 4. Allocate pages for new context entry, copy data from old context entries
> >>+ *    in the old kernel to the new ones.
> >>+ *
> >>+ * In other kinds of kernel, for example, a kernel started by kexec,
> >>+ * do the same thing as crashdump kernel.
> >>+ */
> >>+
> >>+
> >
> >Above comments should come along with the code changes instead of putting it
> >in this patch.
> >
> >BTW, there's one more blank line at the end..
> Code change is in 00/10, the cover letter.

I means the real code, not the changelog.

> And the blank does not matter, I checked the patch with
> scripts/checkpatch.pl,  no warnings, no errors.

Why add two line breaks if one is enough? Adding such check in checkpatch.pl
make sense to me actually.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
