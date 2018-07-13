Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fe1ZE-0000nF-E7
 for kexec@lists.infradead.org; Fri, 13 Jul 2018 17:09:18 +0000
Date: Fri, 13 Jul 2018 19:08:57 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Message-ID: <20180713170857.GB17896@nazgul.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com>
 <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

On Mon, Jul 09, 2018 at 09:55:35PM +0800, lijiang wrote:
> About this issue, i want to use an example to describe it.
> /* drivers/iommu/amd_iommu_init.c */
> static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)

Those addresses come from the IVHD header which is an ACPI table. So the
dump kernel can find that out too.

> Obviously, the iommu mmio space is not encrypted, and the device
> mmio space is outside kdump kernel. We know that the old memory is
> encrypted, and the old memory is also outside kdump kernel. For the
> current case, e820__get_entry_type() and walk_iomem_res_desc() can't
> get the desired result, so we can't also decide whether encryption
> or not according to this result(rules). If we want to know whether
> encryption or not by deducing the address, we will need to read the
> content of memory and have a reference value for comparison, then
> what's a reference value? Sometimes we don't know that.

Again, if we don't know that how is the *caller* supposed to know
whether the memory is encrypted or not? Because

"we" == "caller"

in the kdump kernel.

And the more important question is, why are we dumping MMIO space of the
previous kernel *at* *all*? That doesn't make any sense to me.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
