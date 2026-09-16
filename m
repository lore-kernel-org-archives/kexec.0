Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253DCC88E7F
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 03:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IwkSYifMbosbsUEedZ7gLy2vWvhS8YTHhJAZCDXKYtg=; b=BzIx8yOBe9HRmZGdPbqliOUzKe
	69HgcR60mWpN3/N95sa1xLZapBgf/nXa+RFE9GW8yuh03usjBiIllV8E1lUEb3U1fppFZF5h285W2
	iY1IGwy5o4tqULgvqqePNCbOs+FzKXI/4382eoqyYHiiwmSCMln42H1CndzR3zbjec0cMsJAjzUdv
	8PISc3TDxEWvk25yskS9mxAOZrh96hKc/2tGV/ONfZgo7pt7DdR16loocdTPNR/163W7VLMuWLdWJ
	ca3SWAMJb+GuudKWq1E7faRodAr4rHC8IvdLLXvUtvLPx/v9o2K5NzfybDuMpkJAYF8k1/uknpigC
	mYwVIphA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6g2a-00000008EE0-4BGL;
	Wed, 16 Sep 2026 03:10:33 +0000
Received: from out-2.mta0.migadu.com ([2001:41d0:1004:224b::2] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6g2Y-00000008EDc-0Klg
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 03:10:31 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=csEbIBxX3sc1gWBbMon8k+eE2iLJ+8zMXKxOOcicrLc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789528226; v=1; x=1790133026;
 b=cPwbaGEyr9AEIxHIOKCgX2cg+wl6YWHVg/fUnjYX5SCVjVqREAA566s5fjb/VfStMlFKguN1
 4E+9WrsO+hJQh5Xm/xt9z16yB+5afOmI1glNhHY0GEaSZe1EWo3PWShYSA1ZQkfnrWMbKgi+o7W
 qxyP6RZN8xd7w18A3z94uB94=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id bddbdcc5f2aab402;
	Wed, 16 Sep 2026 03:10:15 +0000
X-Mizu-Trace-ID: bddbdcc5f2aab402
X-Migadu-Flow: FLOW_OUT
Message-ID: <9211b2b6-9fca-4ef7-a141-84636d56e67e@linux.dev>
Date: Tue, 15 Sep 2026 20:10:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
To: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pranjal Shrivastava <praan@google.com>, Pratyush Yadav
 <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>,
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-3-dmatlack@google.com>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260728221007.2098560-3-dmatlack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_201030_407376_0B77859A 
X-CRM114-Status: GOOD (  43.71  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

在 2026/7/28 15:09, David Matlack 写道:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
> 
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).

Hi David,

I have a question about the pci_liveupdate_preserve() and 
pci_liveupdate_unpreserve() APIs.

Is it supported to call these APIs multiple times for the same PCI 
device? For example, a driver could do:

pci_liveupdate_preserve(pdev) -- > pci_liveupdate_unpreserve(pdev) -- > 
perform some operations -- > pci_liveupdate_preserve(pdev) again, before 
the actual Live Update starts.

 From the implementation, it looks like an unpreserved pci_dev_ser entry 
can be reused, so I wanted to confirm whether this preserve -- > 
unpreserve -- > preserve sequence is an intended and supported usage.

Thanks!

Yanjun.Zhu

> 
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so the list of
> preserved devices can be handed off to the next kernel.
> 
> For now, the API only supports preserving non-VF devices on a root bus
> (not behind an PCI-to-PCI bridges).
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>   drivers/pci/liveupdate.c       | 210 +++++++++++++++++++++++++++++++++
>   drivers/pci/liveupdate.h       |  21 ++++
>   drivers/pci/probe.c            |   2 +
>   include/linux/pci.h            |   3 +
>   include/linux/pci_liveupdate.h |  21 ++++
>   5 files changed, 257 insertions(+)
>   create mode 100644 drivers/pci/liveupdate.h
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index fffb41a66ca7..b003b7069cdb 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -36,6 +36,27 @@
>    *
>    *  * ``pci_liveupdate_register_flb(driver_file_handler)``
>    *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
> + *
> + * Device Tracking
> + * ===============
> + *
> + * Drivers must notify the PCI core when specific devices are preserved or
> + * unpreserved with the following APIs:
> + *
> + *  * ``pci_liveupdate_preserve(pci_dev)``
> + *  * ``pci_liveupdate_unpreserve(pci_dev)``
> + *
> + * This allows the PCI core to keep its FLB data (struct pci_ser) up to date
> + * with the list of **outgoing** preserved devices for the next kernel.
> + *
> + * Restrictions
> + * ============
> + *
> + * The PCI core enforces the following restrictions on which devices can be
> + * preserved. These may be relaxed in the future:
> + *
> + *  * The device cannot be a Virtual Function (VF).
> + *  * The device cannot be behind a PCI-to-PCI bridge.
>    */
>   
>   #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -50,6 +71,21 @@
>   #include <linux/pci.h>
>   #include <linux/slab.h>
>   
> +#include "liveupdate.h"
> +
> +/**
> + * struct pci_liveupdate_global - Global state for PCI Live Update support
> + * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
> + *         FLBs, and the references to them in struct pci_dev.
> + */
> +struct pci_liveupdate_global {
> +	struct rw_semaphore rwsem;
> +};
> +
> +static struct pci_liveupdate_global pci_liveupdate = {
> +	.rwsem = __RWSEM_INITIALIZER(pci_liveupdate.rwsem),
> +};
> +
>   /**
>    * struct pci_flb_outgoing - Outgoing PCI FLB object
>    * @ser: Pointer to the preserved struct pci_ser.
> @@ -128,6 +164,180 @@ static struct liveupdate_flb pci_liveupdate_flb = {
>   	.compatible = PCI_LUO_FLB_COMPATIBLE,
>   };
>   
> +static void pci_liveupdate_flb_put_outgoing(void)
> +{
> +	liveupdate_flb_put_outgoing(&pci_liveupdate_flb);
> +}
> +
> +static struct pci_flb_outgoing *pci_liveupdate_flb_get_outgoing(void)
> +{
> +	struct pci_flb_outgoing *outgoing = NULL;
> +	int ret;
> +
> +	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outgoing);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (!outgoing)
> +		return ERR_PTR(-ENOENT);
> +
> +	return outgoing;
> +}
> +
> +static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoing)
> +{
> +	struct pci_dev_ser *dev_ser;
> +	struct kho_block_set_it it;
> +	u64 count = 0;
> +	int err;
> +
> +	kho_block_set_it_init(&it, &outgoing->block_set);
> +
> +	/* Try to find an existing, previously unpreserved, entry. */
> +	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
> +		if (!dev_ser->refcount)
> +			return dev_ser;
> +
> +		count++;
> +	}
> +
> +	/* Otherwise grow the block set and reserve a new entry. */
> +	err = kho_block_set_grow(&outgoing->block_set, count + 1);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	if (!count)
> +		kho_block_set_it_init(&it, &outgoing->block_set);
> +
> +	/* This should always succeed since kho_block_set_grow() succeeded. */
> +	dev_ser = kho_block_set_it_reserve_entry(&it);
> +	if (WARN_ON_ONCE(!dev_ser))
> +		return ERR_PTR(-ENOSPC);
> +
> +	return dev_ser;
> +}
> +
> +static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
> +					     struct pci_dev *dev)
> +{
> +	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
> +
> +	if (!dev_ser) {
> +		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> +		return;
> +	}
> +
> +	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
> +	outgoing->ser->nr_devices--;
> +	memset(dev_ser, 0, sizeof(*dev_ser));
> +	dev->liveupdate.outgoing = NULL;
> +}
> +
> +static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
> +					  struct pci_dev *dev)
> +{
> +	struct pci_dev_ser *dev_ser;
> +
> +	if (dev->is_virtfn) {
> +		pci_warn(dev, "Cannot preserve Virtual Functions\n");
> +		return -EINVAL;
> +	}
> +
> +	if (dev->liveupdate.outgoing) {
> +		pci_warn(dev, "Device is already preserved\n");
> +		return -EBUSY;
> +	}
> +
> +	if (!pci_is_root_bus(dev->bus)) {
> +		pci_warn(dev, "Cannot preserve devices behind bridges\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_ser = pci_flb_alloc_dev_ser(outgoing);
> +	if (IS_ERR(dev_ser))
> +		return PTR_ERR(dev_ser);
> +
> +	pci_info(dev, "Device will be preserved across next Live Update\n");
> +	outgoing->ser->nr_devices++;
> +	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
> +
> +	dev_ser->domain = pci_domain_nr(dev->bus);
> +	dev_ser->bdf = pci_dev_id(dev);
> +	dev_ser->refcount = 1;
> +
> +	dev->liveupdate.outgoing = dev_ser;
> +	return 0;
> +}
> +
> +/**
> + * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
> + * @dev: The PCI device to preserve.
> + *
> + * pci_liveupdate_preserve() notifies the PCI core that a PCI device should be
> + * preserved across the next Live Update. Drivers are expected to call
> + * pci_liveupdate_preserve() from their struct liveupdate_file_handler
> + * preserve() callback to ensure the outgoing struct pci_ser is already set up.
> + *
> + * Returns: 0 on success, <0 on failure.
> + */
> +int pci_liveupdate_preserve(struct pci_dev *dev)
> +{
> +	struct pci_flb_outgoing *outgoing = NULL;
> +	int ret;
> +
> +	guard(rwsem_write)(&pci_liveupdate.rwsem);
> +
> +	outgoing = pci_liveupdate_flb_get_outgoing();
> +	if (IS_ERR(outgoing))
> +		return PTR_ERR(outgoing);
> +
> +	ret = pci_liveupdate_preserve_device(outgoing, dev);
> +
> +	pci_liveupdate_flb_put_outgoing();
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
> +
> +/**
> + * pci_liveupdate_unpreserve() - Cancel preservation of a PCI device
> + * @dev: The PCI device to unpreserve.
> + *
> + * pci_liveupdate_unpreserve() notifies the PCI core that a PCI device should no
> + * longer be preserved across the next Live Update. Drivers are expected to call
> + * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
> + * unpreserve() callback to ensure the outgoing struct pci_ser is already set
> + * up.
> + */
> +void pci_liveupdate_unpreserve(struct pci_dev *dev)
> +{
> +	struct pci_flb_outgoing *outgoing = NULL;
> +
> +	guard(rwsem_write)(&pci_liveupdate.rwsem);
> +
> +	outgoing = pci_liveupdate_flb_get_outgoing();
> +	if (IS_ERR(outgoing)) {
> +		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
> +		return;
> +	}
> +
> +	pci_liveupdate_unpreserve_device(outgoing, dev);
> +	pci_liveupdate_flb_put_outgoing();
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> +
> +void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> +{
> +	/*
> +	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
> +	 * since there should no longer be any references to @dev on the system.
> +	 *
> +	 * This should never happen in practice. Drivers should block removal
> +	 * while a device is preserved.
> +	 */
> +	if (READ_ONCE(dev->liveupdate.outgoing))
> +		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
> +}
> +
>   /**
>    * pci_liveupdate_register_flb() - Register a file handler with the PCI core
>    * @fh: The file handler to register.
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> new file mode 100644
> index 000000000000..b2335581f8d0
> --- /dev/null
> +++ b/drivers/pci/liveupdate.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCI Live Update support (core API)
> + *
> + * Copyright (c) 2026, Google LLC.
> + * David Matlack <dmatlack@google.com>
> + */
> +#ifndef DRIVERS_PCI_LIVEUPDATE_H
> +#define DRIVERS_PCI_LIVEUPDATE_H
> +
> +#include <linux/pci.h>
> +
> +#ifdef CONFIG_PCI_LIVEUPDATE
> +void pci_liveupdate_cleanup_device(struct pci_dev *dev);
> +#else
> +static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> +{
> +}
> +#endif
> +
> +#endif /* DRIVERS_PCI_LIVEUPDATE_H */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..14b66acbdb15 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -24,6 +24,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/bitfield.h>
>   #include <trace/events/pci.h>
> +#include "liveupdate.h"
>   #include "pci.h"
>   
>   static struct resource busn_resource = {
> @@ -2485,6 +2486,7 @@ static void pci_release_dev(struct device *dev)
>   
>   	pci_dev = to_pci_dev(dev);
>   	pci_release_capabilities(pci_dev);
> +	pci_liveupdate_cleanup_device(pci_dev);
>   	pci_release_of_node(pci_dev);
>   	pcibios_release_device(pci_dev);
>   	pci_bus_put(pci_dev->bus);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index da58aa101e4c..b41dd572a2d6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -593,6 +593,9 @@ struct pci_dev {
>   	u8		tph_mode;	/* TPH mode */
>   	u8		tph_req_type;	/* TPH requester type */
>   #endif
> +#ifdef CONFIG_PCI_LIVEUPDATE
> +	struct pci_liveupdate liveupdate;
> +#endif
>   };
>   
>   static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
> index 8ec98beefcb4..894052ad6961 100644
> --- a/include/linux/pci_liveupdate.h
> +++ b/include/linux/pci_liveupdate.h
> @@ -8,14 +8,26 @@
>   #ifndef LINUX_PCI_LIVEUPDATE_H
>   #define LINUX_PCI_LIVEUPDATE_H
>   
> +#include <linux/kho/abi/pci.h>
>   #include <linux/liveupdate.h>
> +#include <linux/spinlock_types.h>
>   #include <linux/types.h>
>   
> +/**
> + * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
> + * @outgoing: State preserved for the next kernel.
> + */
> +struct pci_liveupdate {
> +	struct pci_dev_ser *outgoing;
> +};
> +
>   struct pci_dev;
>   
>   #ifdef CONFIG_PCI_LIVEUPDATE
>   int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
>   void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
> +int pci_liveupdate_preserve(struct pci_dev *dev);
> +void pci_liveupdate_unpreserve(struct pci_dev *dev);
>   #else
>   static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
>   {
> @@ -25,6 +37,15 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
>   static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
>   {
>   }
> +
> +static inline int pci_liveupdate_preserve(struct pci_dev *dev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
> +{
> +}
>   #endif
>   
>   #endif /* LINUX_PCI_LIVEUPDATE_H */


