Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([2a01:238:4383:600:38bc:a715:4b6d:a889]
 helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YAgp4-0000nR-6E
 for kexec@lists.infradead.org; Mon, 12 Jan 2015 15:22:30 +0000
Date: Mon, 12 Jan 2015 16:22:08 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v8 02/10] iommu/vt-d: Items required for kdump
Message-ID: <20150112152207.GC6343@8bytes.org>
References: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
 <1421046388-27925-3-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1421046388-27925-3-git-send-email-zhen-hual@hp.com>
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
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

On Mon, Jan 12, 2015 at 03:06:20PM +0800, Li, Zhen-Hua wrote:
> +
> +#ifdef CONFIG_CRASH_DUMP
> +
> +/*
> + * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
> + *
> + * Fixes the crashdump kernel to deal with an active iommu and legacy
> + * DMA from the (old) panicked kernel in a manner similar to how legacy
> + * DMA is handled when no hardware iommu was in use by the old kernel --
> + * allow the legacy DMA to continue into its current buffers.
> + *
> + * In the crashdump kernel, this code:
> + * 1. skips disabling the IOMMU's translating of IO Virtual Addresses (IOVA).
> + * 2. Do not re-enable IOMMU's translating.
> + * 3. In kdump kernel, use the old root entry table.
> + * 4. Leaves the current translations in-place so that legacy DMA will
> + *    continue to use its current buffers.
> + * 5. Allocates to the device drivers in the crashdump kernel
> + *    portions of the iova address ranges that are different
> + *    from the iova address ranges that were being used by the old kernel
> + *    at the time of the panic.
> + *
> + */

It looks like you are still copying the io-page-tables from the old
kernel into the kdump kernel, is that right? With the approach that was
proposed you only need to copy over the context entries 1-1. They are
still pointing to the page-tables in the old kernels memory (which is
just fine).

The root-entry of the old kernel is also re-used, and when the kdump
kernel starts to use a device, its context entry is updated to point to
a newly allocated page-table.


	Joerg


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
