Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B999C982D0
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 20:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=rAg/Yg/DqWx7Pxj9VVqEz4+jt8Yppr1YHw8Z6DY3rWg=; b=p4HOgdeg92LbQR
	uPmsQ35xAAFsKt96jnytDV7AReI6Pmr/VU+J3ISyoKMIIxqSG6MiZW2roXLJJLIOyuuHMwPbO5NyH
	6fcagXORfAye/6qEPwVeVG62/ClBQrUqFRMNnjqM3/DpQe32q9OIy1IXbpLl1CTPo5TyW50o59VTM
	969VQ/Ll76ZmpKiXhH1zAWdSmHf9ncWTzbXQAxys7EWV6cw0ni/luW8eGcGRgs+ncC1WeyXQMAEY1
	SkHIyMtfGMa7vTit18QbQQrg8ft5AoV8zTbwYAlSNNTZkj8GN3NCNqBumqJnSZZ2+HA1RqB7+wvaS
	xjwZlBkF4dSnVPib+HGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7IY9-0000000CPc8-3WOT;
	Thu, 17 Sep 2026 20:17:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7IY7-0000000CPbt-3MmG
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 20:17:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D94E3601EF;
	Thu, 17 Sep 2026 20:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BD01F000FF;
	Thu, 17 Sep 2026 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789676258;
	bh=rAg/Yg/DqWx7Pxj9VVqEz4+jt8Yppr1YHw8Z6DY3rWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Cifno/seyID/kYnwEs9+FDv8lDl1iWkhIbTZOCPYv/Zl3U125NOEahqqxlcPptx84
	 Lp+WwS5UwXz/cE4pxyhTPmDq18IuA97tb6+2/EXTfb40xf7gXew560HWki//BNg5Md
	 H7BSt20m8+K0EtOHWRWg13d3vTanCYcfD/ZnAmCnqUvBVdF93rIQGxmXbUx+PpnZDU
	 crxNVg/ZxechdqZsl3il8cA/fsemgpg3ig+1w7IAHO7YmVWbOnOqiGbOl8yoGm3Ihh
	 Tqqfwyso+aUaiAND0Smu6s+0pb3Z1KrGeXCrJ14Q2T0e5PjzzsNNugJznZbfYTAcPi
	 Mpe8P3u+jQcjQ==
Date: Thu, 17 Sep 2026 15:17:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <20260917201737.GA1047708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-11-dmatlack@google.com>
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

On Tue, Jul 28, 2026 at 10:10:04PM +0000, David Matlack wrote:
> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
> 
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).

This calls pci_liveupdate_freeze() from pci_device_shutdown(), the
pci_bus_type .shutdown() method, which I think is only called from
device_shutdown() in the kexec or restart paths.

Since there's no error exit after we get as far as device_shutdown(),
and this applies to all devices and dev->liveupdate.frozen is never
set to false (at least at this point in the series), is there benefit
to tracking this per-device?

> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/liveupdate.c       | 16 ++++++++++++++++
>  drivers/pci/liveupdate.h       |  4 ++++
>  drivers/pci/pci-driver.c       |  2 ++
>  include/linux/pci_liveupdate.h |  3 +++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 744513ee11ed..65bcecb1b64e 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -394,6 +394,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
>  {
>  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
>  
> +	if (dev->liveupdate.frozen) {
> +		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
> +		return -EINVAL;
> +	}
> +
>  	if (!dev_ser) {
>  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
>  		return -EINVAL;
> @@ -447,6 +452,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
>  		return -EINVAL;
>  	}
>  
> +	if (dev->liveupdate.frozen) {
> +		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
> +		return -EINVAL;
> +	}
> +
>  	if (dev->liveupdate.outgoing) {
>  		if (!dev->liveupdate.outgoing->refcount) {
>  			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> @@ -718,6 +728,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
>  		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
>  }
>  
> +void pci_liveupdate_freeze(struct pci_dev *dev)
> +{
> +	guard(rwsem_write)(&pci_liveupdate.rwsem);
> +	dev->liveupdate.frozen = 1;

Nit, the series assigns "true" to other booleans
(preserve_bus_numbers, was_preserved).

> +}
> +
>  static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
>  {
>  	if (!dev->liveupdate.incoming) {
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index ccc23031e99d..49d07fd02132 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -13,6 +13,7 @@
>  #ifdef CONFIG_PCI_LIVEUPDATE
>  void pci_liveupdate_setup_device(struct pci_dev *dev);
>  void pci_liveupdate_cleanup_device(struct pci_dev *dev);
> +void pci_liveupdate_freeze(struct pci_dev *dev);
>  bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
>  					 struct pci_dev *dev);
>  void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
> @@ -28,6 +29,9 @@ static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
>  {
>  }
>  
> +static inline void pci_liveupdate_freeze(struct pci_dev *dev)
> +{
> +}
>  static inline bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus,
>  						       struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f36778e62ac1..51616e4327d3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -21,6 +21,7 @@
>  #include <linux/acpi.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/iommu.h>
> +#include "liveupdate.h"
>  #include "pci.h"
>  #include "pcie/portdrv.h"
>  
> @@ -536,6 +537,7 @@ static void pci_device_shutdown(struct device *dev)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct pci_driver *drv = pci_dev->driver;
>  
> +	pci_liveupdate_freeze(pci_dev);
>  	pm_runtime_resume(dev);
>  
>  	if (drv && drv->shutdown)
> diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
> index 04a2b2a3102a..31898685a406 100644
> --- a/include/linux/pci_liveupdate.h
> +++ b/include/linux/pci_liveupdate.h
> @@ -24,6 +24,8 @@
>   * @was_preserved: True if this struct pci_dev was preserved by the previous
>   *                 kernel. Unlike @incoming, this field is not cleared after
>   *                 the device is finished participating in Live Update.
> + * @frozen: True if the outgoing preservation status of this device is frozen
> + *          and thus cannot be changed.
>   */
>  struct pci_liveupdate {
>  	struct pci_dev_ser *outgoing;
> @@ -31,6 +33,7 @@ struct pci_liveupdate {
>  	u16 acs_ctrl;
>  	bool preserve_bus_numbers;
>  	bool was_preserved;
> +	bool frozen;
>  };
>  
>  struct pci_dev;
> -- 
> 2.55.0.487.gaf234c4eb3-goog
> 

