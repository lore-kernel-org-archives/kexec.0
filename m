Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from 8bytes.org ([85.214.48.195] helo=mail.8bytes.org)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOSTv-0007Fp-EC
 for kexec@lists.infradead.org; Tue, 24 Sep 2013 13:16:50 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 42C3712B018
 for <kexec@lists.infradead.org>; Tue, 24 Sep 2013 15:16:25 +0200 (CEST)
Date: Tue, 24 Sep 2013 15:16:23 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] intel-iommu: Quiesce devices before disabling IOMMU
Message-ID: <20130924131621.GC5150@8bytes.org>
References: <1379484541-4496-1-git-send-email-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379484541-4496-1-git-send-email-indou.takao@jp.fujitsu.com>
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: bhe@redhat.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, dwmw2@infradead.org

On Wed, Sep 18, 2013 at 03:09:01PM +0900, Takao Indoh wrote:
> +	/*
> +	 *  In the case of kdump, ioremap is needed because root-entry table
> +	 *  exists in first kernel's memory area which is not mapped in second
> +	 *  kernel
> +	 */
> +	root = (struct root_entry *)ioremap(addr, PAGE_SIZE);
> +	if (!root)
> +		return;
> +
> +	for (bus = 0; bus < ROOT_ENTRY_NR; bus++) {
> +		if (!root_present(&root[bus]))
> +			continue;
> +
> +		context = (struct context_entry *)ioremap(
> +			root[bus].val & VTD_PAGE_MASK, PAGE_SIZE);
> +		if (!context)
> +			continue;
> +
> +		for (devfn = 0; devfn < CONTEXT_ENTRY_NR; devfn++) {
> +			if (!context_present(&context[devfn]))
> +				continue;
> +
> +			dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
> +			if (!dev)
> +				continue;
> +
> +			if (!pci_reset_bus(dev->bus)) /* go to next bus */
> +				break;
> +			else /* Try per-function reset */
> +				pci_reset_function(dev);
> +
> +		}
> +		iounmap(context);
> +	}
> +	iounmap(root);

I am not convinced that this is the right approach. If a device wasn't
translated by VT-d in the old kernel doesn't mean it will not be
translated in the new kernel. How about unconditionally resetting all
PCI busses and/or functions here before IOMMU initialization proceeds?


	Joerg



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
