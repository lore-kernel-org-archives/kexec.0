Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from 8bytes.org ([85.214.48.195] helo=mail.8bytes.org)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WKqom-00073r-7m
 for kexec@lists.infradead.org; Tue, 04 Mar 2014 14:59:40 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 3321F12B223
 for <kexec@lists.infradead.org>; Tue,  4 Mar 2014 15:59:18 +0100 (CET)
Date: Tue, 4 Mar 2014 15:59:15 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv3 3/6] Crashdump-Accepting-Active-IOMMU-Domain-Interfaces
Message-ID: <20140304145911.GD2799@8bytes.org>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
 <1389391652-52422-4-git-send-email-bill.sumner@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389391652-52422-4-git-send-email-bill.sumner@hp.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Bill Sumner <bill.sumner@hp.com>
Cc: indou.takao@jp.fujitsu.com, bhe@redhat.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, zhenhua@hp.com, dwmw2@infradead.org

On Fri, Jan 10, 2014 at 03:07:29PM -0700, Bill Sumner wrote:
> +context_get_entry(struct context_entry *context_addr,
> +			struct intel_iommu *iommu, u32 bus, int devfn)
> +{
> +	unsigned long long q;		/* quadword scratch */
> +	struct root_entry *root_phys;	/* Phys adr (root table entry) */
> +	struct root_entry  root_temp;	/* Local copy of root_entry */
> +	struct context_entry *context_phys;	/* Phys adr */
> +
> +	if (pr_dbg.domain_get)
> +		pr_debug("ENTER %s B:D:F=%2.2x:%2.2x:%1.1x &context_entry:0x%llx &intel_iommu:0x%llx\n",
> +			__func__, bus, devfn>>3, devfn&7,
> +			(u64)context_addr, (u64)iommu);
> +
> +	if (bus > 255)				/* Sanity check */
> +		return -5;
> +	if (devfn > 255 || devfn < 0)		/* Sanity check */
> +		return -6;
> +
> +	q = readq(iommu->reg + DMAR_RTADDR_REG);
> +	pr_debug("IOMMU %d: DMAR_RTADDR_REG:0x%16.16llx\n", iommu->seq_id, q);
> +	if (!q)
> +		return -1;
> +
> +	root_phys = (struct root_entry *) q;	/* Adr(base of vector) */
> +	root_phys += bus;			/* Adr(entry we want) */
> +
> +	oldcopy(&root_temp, root_phys, sizeof(root_temp));
> +
> +	pr_debug("root_temp.val:0x%llx .rsvd1:0x%llx root_phys:0x%llx\n",
> +		root_temp.val, root_temp.rsvd1, (u64)root_phys);
> +
> +	if (!root_present(&root_temp))
> +		return -2;
> +
> +	pr_debug("B:D:F=%2.2x:%2.2x:%1.1x root_temp.val: %llx .rsvd1: %llx\n",
> +		bus, devfn >> 3, devfn & 7, root_temp.val, root_temp.rsvd1);
> +
> +	if (root_temp.rsvd1)			/* If (root_entry is bad) */
> +		return -3;
> +
> +	context_phys = get_context_phys_from_root(&root_temp);
> +	if (!context_phys)
> +		return -4;

What do all these magic return values mean? 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
