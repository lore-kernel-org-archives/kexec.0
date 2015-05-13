Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsLlA-0007M1-O9
 for kexec@lists.infradead.org; Wed, 13 May 2015 01:46:57 +0000
Message-ID: <5552ACB9.5050309@hp.com>
Date: Wed, 13 May 2015 09:45:29 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v11 02/10] iommu/vt-d: Items required for kdump
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-3-git-send-email-zhen-hual@hp.com>
 <20150512081723.GC4561@localhost.localdomain>
In-Reply-To: <20150512081723.GC4561@localhost.localdomain>
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
To: Dave Young <dyoung@redhat.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

On 05/12/2015 04:17 PM, Dave Young wrote:
> On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
>> Add context entry functions needed for kdump.
>> +/*
>> + * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
>> + *
>> + * Fixes the crashdump kernel to deal with an active iommu and legacy
>> + * DMA from the (old) panicked kernel in a manner similar to how legacy
>> + * DMA is handled when no hardware iommu was in use by the old kernel --
>> + * allow the legacy DMA to continue into its current buffers.
>> + *
>> + * In the crashdump kernel, this code:
>> + * 1. skips disabling the IOMMU's translating.
>> + * 2. Do not re-enable IOMMU's translating.
>> + * 3. In kdump kernel, use the old root entry table.
>> + * 4. Allocate pages for new context entry, copy data from old context entries
>> + *    in the old kernel to the new ones.
>> + *
>> + * In other kinds of kernel, for example, a kernel started by kexec,
>> + * do the same thing as crashdump kernel.
>> + */
>> +
>> +
>
> Above comments should come along with the code changes instead of putting it
> in this patch.
>
> BTW, there's one more blank line at the end..
Code change is in 00/10, the cover letter.
And the blank does not matter, I checked the patch with 
scripts/checkpatch.pl,  no warnings, no errors.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
