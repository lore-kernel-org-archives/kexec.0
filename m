Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g6t1526.atlanta.hp.com ([15.193.200.69])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YAwbz-0000PR-O9
 for kexec@lists.infradead.org; Tue, 13 Jan 2015 08:14:04 +0000
Message-ID: <54B4D36D.8030204@hp.com>
Date: Tue, 13 Jan 2015 16:12:29 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 02/10] iommu/vt-d: Items required for kdump
References: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
 <1421046388-27925-3-git-send-email-zhen-hual@hp.com>
 <20150112152207.GC6343@8bytes.org>
In-Reply-To: <20150112152207.GC6343@8bytes.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

On 01/12/2015 11:22 PM, Joerg Roedel wrote:
> On Mon, Jan 12, 2015 at 03:06:20PM +0800, Li, Zhen-Hua wrote:
>> +
>> +#ifdef CONFIG_CRASH_DUMP
>> +
>> +/*
>> + * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
>> + *
>> + * Fixes the crashdump kernel to deal with an active iommu and legacy
>> + * DMA from the (old) panicked kernel in a manner similar to how legacy
>> + * DMA is handled when no hardware iommu was in use by the old kernel --
>> + * allow the legacy DMA to continue into its current buffers.
>> + *
>> + * In the crashdump kernel, this code:
>> + * 1. skips disabling the IOMMU's translating of IO Virtual Addresses (IOVA).
>> + * 2. Do not re-enable IOMMU's translating.
>> + * 3. In kdump kernel, use the old root entry table.
>> + * 4. Leaves the current translations in-place so that legacy DMA will
>> + *    continue to use its current buffers.
>> + * 5. Allocates to the device drivers in the crashdump kernel
>> + *    portions of the iova address ranges that are different
>> + *    from the iova address ranges that were being used by the old kernel
>> + *    at the time of the panic.
>> + *
>> + */
>
> It looks like you are still copying the io-page-tables from the old
> kernel into the kdump kernel, is that right? With the approach that was
> proposed you only need to copy over the context entries 1-1. They are
> still pointing to the page-tables in the old kernels memory (which is
> just fine).
>
> The root-entry of the old kernel is also re-used, and when the kdump
> kernel starts to use a device, its context entry is updated to point to
> a newly allocated page-table.
>

Current status:
1. Use old root entry table,
2. Copy old context entry tables.
3. Copy old page tables.
4. Allocate new page table when device driver is loading.

I remember the progress we discussed was this. Checking the old mails,
founding we did not clearly discuss about the old page tables, only
agrred with allocating new page tables when device driver is loading.

To me, both of these two options are fine, copying old page tables, or
re-use the old ones. My debugging shows both of them works fine.

If we use the old page tables, the patchset will use less code.
Functions copy_page_addr, copy_page_table are no longer needed, and
functions copy_context_entry and copy_context_entry_table will be
reduced to several lines. The patchset will be much simpler.

Zhenhua



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
