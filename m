Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09900F4BB6F
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXKJ6/hKtL2Tqg7iZ1FrnbB55AHiiDCgqCoKiJbuxWs=; b=RAgd2ICkVhxC8IG9Uop0ABxlHG
	7XND36C3ybFs7e8egnMaN5CQbsStRGi8qzfhQKmSMMYE23+ZXaoc8wn1NMX9TdjVP7/tMOh53MTrb
	ff4NyM7rCjskcXpeWDulvNEuIpF1klhmcECvNtruoyjE7OvJRtY+SD+hj1dL0AxsAeMPLyPFvHNzy
	jsu9aFt90Tx7IUREFMSPENTYJulbnWeJeTwV8dcJq9lI+22+Maw/sx00elf3oiLUkxiWO3YD8EbzA
	5Weruuq5XT2GDs0k0v5nvKkjkAS4dl5XpAIH3bGc2QgJUf/djhXStvOv0AQl9G0yaJueqWOF142Rx
	2vmGIFSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxIS-00000002eCC-49nl;
	Tue, 24 Feb 2026 18:38:12 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxIQ-00000002eBr-1p4r
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 18:38:11 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so8685ad.0
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771958289; x=1772563089; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXKJ6/hKtL2Tqg7iZ1FrnbB55AHiiDCgqCoKiJbuxWs=;
        b=M6NapVAOZ9iFdcQ7VswK20MS5D4DEqpTMjCApM0BPwloQoDlticMMrVyxEycHPLNFT
         8uVfNeuXnGDz8dQw1OPuH8qs2l+nYaLJJ2F63cL8qdiE4eD3lUsszjL5dSgUBcPpZZgX
         MzqrfkGZO7GBv48FqyFlCwMuf154OwbuLEfnbtsFZ0ZdYIqVPSjgrgHHSS6uPPzuUHJK
         A1RS0RUMBauL0/xuC9WD/GULhGZ7IuwYNHLVZ7DBcIkxiMD0ZDQaqsqrCtQBiY5nN1Te
         xJ4l8mvecr78IIHIDFqJH7wRMuY3FwA6n1QNqVVoorzhmfGQhpphVwl6GUmU34CsjTyy
         X+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958289; x=1772563089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXKJ6/hKtL2Tqg7iZ1FrnbB55AHiiDCgqCoKiJbuxWs=;
        b=esJypF1CCMPW9fpQjrBeTSJ4q+fhqxt+u50+avQqAXZn6WjcR1bKNwGriQ1LJBFnwD
         dvnV9Eng7E89NALNDG66MQzFoliPGnk7zXVdiEWhyAWQt1iPRjvuBV32YR7xoDJl3Jow
         oqlIBzPspjsH/dOcQ+j2CJUPh/Y4MHSWBlfv5NHmulK7v1v5f7EIOAs4xWZ4vWV41Aku
         OKhnWilI4laed3ycEnINNU2QZD5ArrhppaA4FBYiCVon2aaUs7uNzNvIj76fPy+3WhNf
         /vSAyj9Kkpiq2P0EXpx6pFjarwjLBSZ9DEwK1+vnLJUaNC77hpGp/54mDERIZ3uU1gno
         lu4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2cx6b+oU2aNr2kC5zON9cWAykD28Y+xPJ9g26Q4la5M7Z5oGuLsqFMgoGCEoNf8NGvl3alg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw4r6C6CZiOODEGOLgWW+G3e/ISIz0bzwMGGa7QK/plJt38xFlt
	Tpdgk6L/mGbWFDbhV7dQfl1ShK/BGHs4Ryr7bwtKUeCANtMWBP9GU00haNFRq0oucg==
X-Gm-Gg: ATEYQzwNq29Pu03q1zykm91FyGFaLN/9iS2u9W2a10qdxeLonLUrJgs01Ow0jWNTITZ
	f2TkQnZUuNqnkZgQso8gtHw3zhJ9sm/d8AQRZGX1NolAfUmo8tDkWHapn6q3oBN7lzzqrtdiK2T
	q9f7LTuKkT/xwjyFxN23R683s3fKGrZiljCeb5VMArahO5yy5yc702xhJbpULvPGhgbsYZ9moKl
	GL/tmv1CP7I9nPgrH6Pa1XtHji3SzfLvB4XzRykUhbu+mYnQR5+C0llZK0g3Zi3nTjLd4qdelUe
	HMQcxe8qXF6PLegWOXmnceKfmTJg/res+LcKq4vX9KIKK7G4DE9x4uLvYyMMG9sw8+cVbNRv+HP
	w/sR3DoW/7PYduMFT6VVlGhvx7u8IMrwdMkPKml6Esr+iX9fnIZDhDNFxvuDs3cyRq35b2PDf8v
	Pn4K4D9vsqR5hKmc/PhtOitAkp5TJy3UpPIA34n+igQcHPOwHzNfw46DG0TN6N
X-Received: by 2002:a17:903:2f8b:b0:2ad:6f9b:7818 with SMTP id d9443c01a7336-2adca88478dmr70235ad.23.1771958288771;
        Tue, 24 Feb 2026 10:38:08 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5db00sm156866805ad.23.2026.02.24.10.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:38:07 -0800 (PST)
Date: Tue, 24 Feb 2026 18:37:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 05/22] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <aZ3wBpYSF7mQv_GZ@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-6-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-6-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_103810_514028_65F079B7 
X-CRM114-Status: GOOD (  45.96  )
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

On Thu, Jan 29, 2026 at 09:24:52PM +0000, David Matlack wrote:
> From: Vipin Sharma <vipinsh@google.com>
> 
> Implement the live update file handler callbacks to preserve a vfio-pci
> device across a Live Update. Subsequent commits will enable userspace to
> then retrieve this file after the Live Update.
> 
> Live Update support is scoped only to cdev files (i.e. not
> VFIO_GROUP_GET_DEVICE_FD files).
> 
> State about each device is serialized into a new ABI struct
> vfio_pci_core_device_ser. The contents of this struct are preserved
> across the Live Update to the next kernel using a combination of
> Kexec-Handover (KHO) to preserve the page(s) holding the struct and the
> Live Update Orchestrator (LUO) to preserve the physical address of the
> struct.
> 
> For now the only contents of struct vfio_pci_core_device_ser the
> device's PCI segment number and BDF, so that the device can be uniquely
> identified after the Live Update.
> 
> Require that userspace disables interrupts on the device prior to
> freeze() so that the device does not send any interrupts until new
> interrupt handlers have been set up by the next kernel.
> 
> Reset the device and restore its state in the freeze() callback. This
> ensures the device can be received by the next kernel in a consistent
> state. Eventually this will be dropped and the device can be preserved
> across in a running state, but that requires further work in VFIO and
> the core PCI layer.
> 
> Note that LUO holds a reference to this file when it is preserved. So
> VFIO is guaranteed that vfio_df_device_last_close() will not be called
> on this device no matter what userspace does.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Co-developed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/pci/vfio_pci.c            |  2 +-
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 84 +++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h       |  2 +
>  drivers/vfio/vfio.h                    | 13 ----
>  drivers/vfio/vfio_main.c               | 10 +--
>  include/linux/kho/abi/vfio_pci.h       | 15 +++++
>  include/linux/vfio.h                   | 28 +++++++++
>  7 files changed, 129 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 19e88322af2c..0260afb9492d 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
>  	return 0;
>  }
>  
> -static const struct vfio_device_ops vfio_pci_ops = {
> +const struct vfio_device_ops vfio_pci_ops = {
>  	.name		= "vfio-pci",
>  	.init		= vfio_pci_core_init_dev,
>  	.release	= vfio_pci_core_release_dev,
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index b84e63c0357b..f01de98f1b75 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -8,25 +8,104 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/kexec_handover.h>
>  #include <linux/kho/abi/vfio_pci.h>
>  #include <linux/liveupdate.h>
>  #include <linux/errno.h>
> +#include <linux/vfio.h>
>  
>  #include "vfio_pci_priv.h"
>  
>  static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
>  					     struct file *file)
>  {
> -	return false;
> +	struct vfio_device_file *df = to_vfio_device_file(file);
> +
> +	if (!df)
> +		return false;
> +
> +	/* Live Update support is limited to cdev files. */
> +	if (df->group)
> +		return false;
> +
> +	return df->device->ops == &vfio_pci_ops;
>  }
>  
>  static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  {
> -	return -EOPNOTSUPP;
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +	struct vfio_pci_core_device_ser *ser;
> +	struct vfio_pci_core_device *vdev;
> +	struct pci_dev *pdev;
> +
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	pdev = vdev->pdev;
> +
> +	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
> +		return -EINVAL;
> +
> +	if (vfio_pci_is_intel_display(pdev))
> +		return -EINVAL;
> +
> +	ser = kho_alloc_preserve(sizeof(*ser));
> +	if (IS_ERR(ser))
> +		return PTR_ERR(ser);
> +
> +	ser->bdf = pci_dev_id(pdev);
> +	ser->domain = pci_domain_nr(pdev->bus);
> +
> +	args->serialized_data = virt_to_phys(ser);
> +	return 0;
>  }
>  
>  static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>  {
> +	kho_unpreserve_free(phys_to_virt(args->serialized_data));
> +}
> +
> +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
> +{
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +	struct vfio_pci_core_device *vdev;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	pdev = vdev->pdev;
> +
> +	guard(mutex)(&device->dev_set->lock);
> +
> +	/*
> +	 * Userspace must disable interrupts on the device prior to freeze so
> +	 * that the device does not send any interrupts until new interrupt
> +	 * handlers have been established by the next kernel.
> +	 */
> +	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
> +		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
> +		return -EINVAL;
> +	}
> +
> +	pci_dev_lock(pdev);
> +
> +	ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * Reset the device and restore it back to its original state before
> +	 * handing it to the next kernel.
> +	 *
> +	 * Eventually both of these should be dropped and the device should be
> +	 * kept running with its current state across the Live Update.
> +	 */
> +	if (vdev->reset_works)
> +		ret = __pci_reset_function_locked(pdev);

I see the 'Eventually both of these should be dropped' comment,
which acknowledges that a reset is a v1 crutch. However, I wanted to
clarify the fallback strategy here.

If vdev->reset_works is false, we skip the reset but still jump into the
new kernel. For devices that don't support FLR, are we comfortable jumping
with the device potentially still hot? 

> +
> +	pci_restore_state(pdev);
> +
> +out:
> +	pci_dev_unlock(pdev);
> +	return ret;
>  }
>  
>  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
> @@ -42,6 +121,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
>  	.can_preserve = vfio_pci_liveupdate_can_preserve,
>  	.preserve = vfio_pci_liveupdate_preserve,
>  	.unpreserve = vfio_pci_liveupdate_unpreserve,
> +	.freeze = vfio_pci_liveupdate_freeze,
>  	.retrieve = vfio_pci_liveupdate_retrieve,
>  	.finish = vfio_pci_liveupdate_finish,
>  	.owner = THIS_MODULE,
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 68966ec64e51..d3da79b7b03c 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -11,6 +11,8 @@
>  /* Cap maximum number of ioeventfds per device (arbitrary) */
>  #define VFIO_PCI_IOEVENTFD_MAX		1000
>  
> +extern const struct vfio_device_ops vfio_pci_ops;
> +
>  struct vfio_pci_ioeventfd {
>  	struct list_head	next;
>  	struct vfio_pci_core_device	*vdev;
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 50128da18bca..6b89edbbf174 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -16,17 +16,6 @@ struct iommufd_ctx;
>  struct iommu_group;
>  struct vfio_container;
>  
> -struct vfio_device_file {
> -	struct vfio_device *device;
> -	struct vfio_group *group;
> -
> -	u8 access_granted;
> -	u32 devid; /* only valid when iommufd is valid */
> -	spinlock_t kvm_ref_lock; /* protect kvm field */
> -	struct kvm *kvm;
> -	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
> -};
> -
>  void vfio_device_put_registration(struct vfio_device *device);
>  bool vfio_device_try_get_registration(struct vfio_device *device);
>  int vfio_df_open(struct vfio_device_file *df);
> @@ -34,8 +23,6 @@ void vfio_df_close(struct vfio_device_file *df);
>  struct vfio_device_file *
>  vfio_allocate_device_file(struct vfio_device *device);
>  
> -extern const struct file_operations vfio_device_fops;
> -
>  #ifdef CONFIG_VFIO_NOIOMMU
>  extern bool vfio_noiommu __read_mostly;
>  #else
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index f7df90c423b4..276f615f0c28 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1436,15 +1436,7 @@ const struct file_operations vfio_device_fops = {
>  	.show_fdinfo	= vfio_device_show_fdinfo,
>  #endif
>  };
> -
> -static struct vfio_device *vfio_device_from_file(struct file *file)
> -{
> -	struct vfio_device_file *df = file->private_data;
> -
> -	if (file->f_op != &vfio_device_fops)
> -		return NULL;
> -	return df->device;
> -}
> +EXPORT_SYMBOL_GPL(vfio_device_fops);
>  
>  /**
>   * vfio_file_is_valid - True if the file is valid vfio file
> diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
> index 37a845eed972..9bf58a2f3820 100644
> --- a/include/linux/kho/abi/vfio_pci.h
> +++ b/include/linux/kho/abi/vfio_pci.h
> @@ -9,6 +9,9 @@
>  #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
>  #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
>  
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
>  /**
>   * DOC: VFIO PCI Live Update ABI
>   *
> @@ -25,4 +28,16 @@
>  
>  #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
>  
> +/**
> + * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
> + * device.
> + *
> + * @bdf: The device's PCI bus, device, and function number.
> + * @domain: The device's PCI domain number (segment).
> + */
> +struct vfio_pci_core_device_ser {
> +	u16 bdf;
> +	u16 domain;
> +} __packed;
> +
>  #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index e90859956514..9aa1587fea19 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -81,6 +81,34 @@ struct vfio_device {
>  #endif
>  };
>  
> +struct vfio_device_file {
> +	struct vfio_device *device;
> +	struct vfio_group *group;
> +
> +	u8 access_granted;
> +	u32 devid; /* only valid when iommufd is valid */
> +	spinlock_t kvm_ref_lock; /* protect kvm field */
> +	struct kvm *kvm;
> +	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
> +};
> +
> +extern const struct file_operations vfio_device_fops;
> +

There seem to be two extern declarations for vfio_device_fops in both
vfio_pci_priv.h and include/linux/vfio.h. Could we consolidate these?

> +static inline struct vfio_device_file *to_vfio_device_file(struct file *file)
> +{
> +	if (file->f_op != &vfio_device_fops)
> +		return NULL;
> +
> +	return file->private_data;
> +}
> +
> +static inline struct vfio_device *vfio_device_from_file(struct file *file)
> +{
> +	struct vfio_device_file *df = to_vfio_device_file(file);
> +
> +	return df ? df->device : NULL;
> +}
> +

I'm a little uncomfortable with this part. Why is it necessary to expose
the internal vfio_device_file structure to drivers? If this is only to 
support vfio_device_from_file(), could we not keep the structure private
and just export the helper function instead? 

Exposing internal state into the public API introduces some maintenance
constraints for e.g. if vfio_main.c ever changes how it tracks 
file-to-device mappings or its internal security state (like 
access_granted), it now has to worry about breaking external drivers.

I believe we expose the struct just to power these static inline helper
(mainly vfio_device_from_file) ? Instead, could we treat
`vfio_device_file` as an opaque type in the public header (like struct 
iommu_group) and move the implementation of vfio_device_from_file() into
vfio_main.c as an exported symbol? This gives drivers the vfio_device 
pointer they need without leaking the core's private internals. Maybe
something like the following (untested):

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index f7df90c423b4..71e3dda53187 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1446,6 +1446,18 @@ static struct vfio_device *vfio_device_from_file(struct file *file)
        return df->device;
 }

+struct vfio_device *vfio_device_from_file(struct file *file)
+{
+       struct vfio_device_file *df;
+
+       if (file->f_op != &vfio_device_fops)
+               return NULL;
+
+       df = file->private_data;
+       return df->device;
+}
+EXPORT_SYMBOL_GPL(vfio_device_from_file);
+
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
  * @file: VFIO group file or VFIO device file
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e90859956514..182f192c5641 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -81,6 +81,15 @@ struct vfio_device {
 #endif
 };

+
+struct vfio_device_file;
+
+extern const struct file_operations vfio_device_fops;
+
+/* Public API for drivers */
+struct vfio_device *vfio_device_from_file(struct file *file);
+ [...]
+

>  /**
>   * struct vfio_device_ops - VFIO bus driver device callbacks
>   *
> -- 
> 2.53.0.rc1.225.gd81095ad13-goog
> 

Thanks,
Praan

