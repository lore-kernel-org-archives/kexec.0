Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D33EFB81B
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 09:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TF+mm2Z4a0QE/AlRHLl01HM4EQQQQy3Q0r3NjkNuBjE=; b=IdEAoV5bAGOXEDInhNzXtRw4ee
	kkEP8aEAjJmRLlJginzPRGTsfHUpLNzhLnIIXVPtQyH3B1L9xDO1Q/e5/AGcXzy6D0qnL5OzEiziD
	SnHCsWCe+E2hV55MMKpfBtMAbDJOyZGliYclAz6h7WMtoDBHjaWOHluR/xXm6bTNNU5E0PfUYI4Hk
	po8gS4+RByHCYb3j+6IoVzUj8OW51aGoTVV0NR6AQcqySjj1xDQReF6nA/KHNgLV67avtNk89D/U/
	oL3t9n2VKljx4o3Q+h+DHjbBmzX7l+HYDGshyMFDzmdUSR4xXcrLCuRPsaJv1Hku/IcrJI2RJPZnU
	2emlGQrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuoYP-00000001ipB-2zxz;
	Tue, 24 Feb 2026 09:18:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuoYP-00000001ip2-0OBt
	for kexec@bombadil.infradead.org;
	Tue, 24 Feb 2026 09:18:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TF+mm2Z4a0QE/AlRHLl01HM4EQQQQy3Q0r3NjkNuBjE=; b=oGyfPS0AsoCvAzhKYbMYq9LJzk
	qPOeGVz5SUAHIVvjdQrxJJGNaL8NPfWYC6BYYNCdbsW76jYtmbLv1IuIVFUVpNtGWSTuSXLjql/s4
	mNwct78pxbP4RWzz5M9ZyQisOZxES212GbNeKNiLZXH7xKcn0Uq2DqPjAVLtsjCIuN0Jor1Nq7WsG
	j3IuOPrYhnuxEsyYt+xC8nSNxcC60qBzDvTg5PK29wmYz9YMExJ/Z1Clzn+CSBd/Kwo9MUDUCqeCW
	I+HpSDbYvV4y7hS6cboeULZqXzQ+ifFWVHUpUL6IJa2cBy+5NoA6t1AXIumvC8wOu024+RCP4z4wl
	owIHlNRA==;
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuoYM-00000006l7r-0xMk
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 09:18:04 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2aad8123335so56895ad.1
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771924679; x=1772529479; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TF+mm2Z4a0QE/AlRHLl01HM4EQQQQy3Q0r3NjkNuBjE=;
        b=Joa7LphhJo+fbx9koRqtw8E02s8DzdBLXQJVX9N1IMHCHOaSgMIdnVYLQC5gu4T3o9
         INlkohbZ9Smnq3cHecjwLt+rs8bJFteKUA7n6j4GLEdRRrAlCJUPSmQRzEVIzfSaNeVL
         79gEha63tq+VPCAW2y2FWa0FH9C6/TglP8gDRrDLPKdkTMVKQGHsjqewXY3OFhUbXqc+
         WYm931nDiieHYxVsgLmOzdEOpcOUsktHTqTGIHTylz0V/Ha6l2T/gTW1KcDJA18JDKvQ
         sYxSAlronNRzhyFFb7z5xqQbGF+f+tVq7hO6xF8FWncnLaR2ZT22DteAPFNgiazFCA1v
         pUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771924679; x=1772529479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF+mm2Z4a0QE/AlRHLl01HM4EQQQQy3Q0r3NjkNuBjE=;
        b=oI7pWrte1KH7BQ2N7HmzHCJtt9dMsmBqWhsClIgaZVA+xUrtJ16ZB/Or1cnnp/kuZz
         qZs7CUdtW04vjjAzyGJtLxmep2fH1gdIfUN63m9DQT6qF1SjzgCG/uNP6Bu0K1pSlPtg
         zS7t1oWPoo248EiENCC8Xu9H2bWX0fEU5Fgo7ji5qdkUr36/kfYuzxsq5f7aanLh43QP
         u9xcjXfv8S+yxSmaCHmnHeo1Tyn0svlJIkHer3zTQ0QnMZdLOpuJqv1NNuMrPGhhTEyb
         APOmXa/ssRP340sXm5luG78c8vWsPyZzZnCSyjz9wNF3Y6fzSx6eyJTzTMariIDi/BzZ
         YiSw==
X-Forwarded-Encrypted: i=1; AJvYcCUNio80mvReIK7RKTIhsT+SzcuvO8JIllEpyjmjFHUbnUkff8ugm4MsBwe9HRMZkjGEke3nTA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyrXozbhRLV7d+03cPakxecaVZkUJBnZWSgTuUEJRA8fhN5GCMA
	e7HSREKCSgPnL3YL6FLO4jb/91/AxhdO9QYYM2D4Kq61N/KyR8pWOtHEHpiTyqK+Vw==
X-Gm-Gg: ATEYQzzCaf6C5Y3BHGshsy3P+YAF0S42SIOkm8rarFEZ129rMYyBNnlovNls+mpxi/Q
	XZpQSu3cNpnyH/pAoT7UBi5RKhFTSHbY1K6+ng0RDQOtSiYzJzNxAn5dfI72AFqjcXOuJOnBJwI
	yqlyCXqatsEhVqm5mh5CJBharIpXW48O3z1sxgLY/O2Zvq/TqtAxDcOt1MOevn7iwRrXeZJ6Mtu
	sd9aTxgRP4endOLcDpi4LoK55zs+DzcMEnlhKmzsXrIC2Nq3u2T/e/taKJBgErB8Y1y5IDpCOV6
	OYv7tObyxiENSpKi8GnY7Xgr9cZWrrir6JpcV5+ODIN53zn9+7oIZHKkrkeSGHFVO66Wz/3hc2K
	Jb0UJ6DqjM+XEqlp1kt33wwuoFUwrk54+Gyu114rHHdMGlIDLPYAxTISrMrNTVRTCb7yYTvgaD3
	RxCRw/3PMj2+vuTEHpUuExE/YXBS9BSrXFgA70m8n/pJFy45tERNYEzEh6GJn+
X-Received: by 2002:a17:903:944:b0:29d:7b9e:6df8 with SMTP id d9443c01a7336-2ad993a4aafmr1605825ad.2.1771924678903;
        Tue, 24 Feb 2026 01:17:58 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f764a6sm95101785ad.40.2026.02.24.01.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:17:58 -0800 (PST)
Date: Tue, 24 Feb 2026 09:17:48 +0000
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
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <aZ1svGur9IxQ7Td2@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-3-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-3-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091802_431966_FFA9DCF9 
X-CRM114-Status: GOOD (  44.19  )
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

On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:
> Add an API to enable the PCI subsystem to track all devices that are
> preserved across a Live Update, including both incoming devices (passed
> from the previous kernel) and outgoing devices (passed to the next
> kernel).
> 
> Use PCI segment number and BDF to keep track of devices across Live
> Update. This means the kernel must keep both identifiers constant across
> a Live Update for any preserved device. VFs are not supported for now,
> since that requires preserving SR-IOV state on the device to ensure the
> same number of VFs appear after kexec and with the same BDFs.
> 
> Drivers that preserve devices across Live Update can now register their
> struct liveupdate_file_handler with the PCI subsystem so that the PCI
> subsystem can allocate and manage File-Lifecycle-Bound (FLB) global data
> to track the list of incoming and outgoing preserved devices.
> 
>   pci_liveupdate_register_fh(driver_fh)
>   pci_liveupdate_unregister_fh(driver_fh)
> 
> Drivers can notify the PCI subsystem whenever a device is preserved and
> unpreserved with the following APIs:
> 
>   pci_liveupdate_outgoing_preserve(pci_dev)
>   pci_liveupdate_outgoing_unpreserve(pci_dev)
> 
> After a Live Update, the PCI subsystem fetches its FLB global data
> from the previous kernel from the Live Update Orchestrator (LUO) during
> device initialization to determine which devices were preserved.
> 
> Drivers can check if a device was preserved before userspace retrieves
> the file for it via pci_dev->liveupdate_incoming.
> 
> Once a driver has finished restoring an incoming preserved device, it
> can notify the PCI subsystem with the following call, which clears
> pci_dev->liveupdate_incoming.
> 
>   pci_liveupdate_incoming_finish(pci_dev)
> 
> This API will be used in subsequent commits by the vfio-pci driver to
> preserve VFIO devices across Live Update and by the PCI subsystem.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/Makefile        |   1 +
>  drivers/pci/liveupdate.c    | 212 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c         |   2 +
>  include/linux/kho/abi/pci.h |  55 ++++++++++
>  include/linux/pci.h         |  47 ++++++++
>  5 files changed, 317 insertions(+)
>  create mode 100644 drivers/pci/liveupdate.c
>  create mode 100644 include/linux/kho/abi/pci.h
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 8c259a9a8796..a32f7658b9e5 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_PROC_FS)		+= proc.o
>  obj-$(CONFIG_SYSFS)		+= pci-sysfs.o slot.o
>  obj-$(CONFIG_ACPI)		+= pci-acpi.o
>  obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
> +obj-$(CONFIG_LIVEUPDATE)	+= liveupdate.o
>  endif
>  
>  obj-$(CONFIG_OF)		+= of.o
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> index 000000000000..182cfc793b80
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2025, Google LLC.

Nit: Should these be 2026 now?

> + * David Matlack <dmatlack@google.com>
> + */
> +
> +#include <linux/bsearch.h>
> +#include <linux/io.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/pci.h>
> +#include <linux/liveupdate.h>
> +#include <linux/mutex.h>
> +#include <linux/mm.h>
> +#include <linux/pci.h>
> +#include <linux/sort.h>
> +
> +static DEFINE_MUTEX(pci_flb_outgoing_lock);
> +
> +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> +{
> +	struct pci_dev *dev = NULL;
> +	int max_nr_devices = 0;
> +	struct pci_ser *ser;
> +	unsigned long size;
> +
> +	for_each_pci_dev(dev)
> +		max_nr_devices++;
> +
> +	size = struct_size_t(struct pci_ser, devices, max_nr_devices);
> +
> +	ser = kho_alloc_preserve(size);
> +	if (IS_ERR(ser))
> +		return PTR_ERR(ser);
> +
> +	ser->max_nr_devices = max_nr_devices;
> +
> +	args->obj = ser;
> +	args->data = virt_to_phys(ser);
> +	return 0;
> +}
> +
> +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> +{
> +	struct pci_ser *ser = args->obj;
> +
> +	WARN_ON_ONCE(ser->nr_devices);
> +	kho_unpreserve_free(ser);
> +}
> +
> +static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
> +{
> +	args->obj = phys_to_virt(args->data);
> +	return 0;
> +}
> +
> +static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> +{
> +	kho_restore_free(args->obj);
> +}
> +
> +static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
> +	.preserve = pci_flb_preserve,
> +	.unpreserve = pci_flb_unpreserve,
> +	.retrieve = pci_flb_retrieve,
> +	.finish = pci_flb_finish,
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct liveupdate_flb pci_liveupdate_flb = {
> +	.ops = &pci_liveupdate_flb_ops,
> +	.compatible = PCI_LUO_FLB_COMPATIBLE,
> +};
> +
> +#define INIT_PCI_DEV_SER(_dev) {		\
> +	.domain = pci_domain_nr((_dev)->bus),	\
> +	.bdf = pci_dev_id(_dev),		\
> +}
> +
> +static int pci_dev_ser_cmp(const void *__a, const void *__b)
> +{
> +	const struct pci_dev_ser *a = __a, *b = __b;
> +
> +	return cmp_int(a->domain << 16 | a->bdf, b->domain << 16 | b->bdf);
> +}
> +
> +static struct pci_dev_ser *pci_ser_find(struct pci_ser *ser,
> +					struct pci_dev *dev)
> +{
> +	const struct pci_dev_ser key = INIT_PCI_DEV_SER(dev);
> +
> +	return bsearch(&key, ser->devices, ser->nr_devices,
> +		       sizeof(key), pci_dev_ser_cmp);
> +}
> +
> +static int pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
> +{
> +	struct pci_dev_ser *dev_ser;
> +	int i;
> +
> +	dev_ser = pci_ser_find(ser, dev);
> +	if (!dev_ser)
> +		return -ENOENT;
> +
> +	for (i = dev_ser - ser->devices; i < ser->nr_devices - 1; i++)
> +		ser->devices[i] = ser->devices[i + 1];
> +
> +	ser->nr_devices--;
> +	return 0;
> +}
> +
> +int pci_liveupdate_outgoing_preserve(struct pci_dev *dev)
> +{
> +	struct pci_dev_ser new = INIT_PCI_DEV_SER(dev);
> +	struct pci_ser *ser;
> +	int i, ret;
> +
> +	/* Preserving VFs is not supported yet. */
> +	if (dev->is_virtfn)
> +		return -EINVAL;
> +
> +	guard(mutex)(&pci_flb_outgoing_lock);
> +
> +	if (dev->liveupdate_outgoing)
> +		return -EBUSY;
> +
> +	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
> +	if (ret)
> +		return ret;
> +
> +	if (ser->nr_devices == ser->max_nr_devices)
> +		return -E2BIG;

I'm wondering how (or if) this handles hot-plugged devices?
max_nr_devices is calculated based on for_each_pci_dev at the time of
the first preservation.. what happens if a device is hotplugged after
the first device is preserved but before the second one is, does
max_nr_devices become stale? Since ser->max_nr_devices will not reflect
the actual possible device count, potentially leading to an unnecessary
-E2BIG failure?

> +
> +	for (i = ser->nr_devices; i > 0; i--) {
> +		struct pci_dev_ser *prev = &ser->devices[i - 1];
> +		int cmp = pci_dev_ser_cmp(&new, prev);
> +
> +		if (WARN_ON_ONCE(!cmp))
> +			return -EBUSY;
> +
> +		if (cmp > 0)
> +			break;
> +
> +		ser->devices[i] = *prev;
> +	}
> +
> +	ser->devices[i] = new;
> +	ser->nr_devices++;
> +	dev->liveupdate_outgoing = true;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_outgoing_preserve);
> +
> +void pci_liveupdate_outgoing_unpreserve(struct pci_dev *dev)
> +{
> +	struct pci_ser *ser;
> +	int ret;
> +
> +	guard(mutex)(&pci_flb_outgoing_lock);
> +
> +	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
> +	if (WARN_ON_ONCE(ret))
> +		return;
> +
> +	WARN_ON_ONCE(pci_ser_delete(ser, dev));
> +	dev->liveupdate_outgoing = false;
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_outgoing_unpreserve);
> +
> +u32 pci_liveupdate_incoming_nr_devices(void)
> +{
> +	struct pci_ser *ser;
> +	int ret;
> +
> +	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
> +	if (ret)
> +		return 0;

Masking this error looks troubled, in the following patch, I see that
the retval 0 is treated as a fresh boot, but the IOMMU mappings for that
BDF might still be preserved? Which could lead to DMA aliasing issues,
without a hint of what happened since we don't even log anything.

Maybe we could have something like the following:

int pci_liveupdate_incoming_nr_devices(void)
{
	struct pci_ser *ser;
	int ret;

	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
	if (ret) {
		if (ret != -ENOENT)
			pr_warn("PCI: Failed to retrieve preservation list: %d\n", ret);
		return ret;
	}

	return ser->nr_devices;
}


> +
> +	return ser->nr_devices;
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_incoming_nr_devices);
> +
> +void pci_liveupdate_setup_device(struct pci_dev *dev)
> +{
> +	struct pci_ser *ser;
> +	int ret;
> +
> +	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
> +	if (ret)
> +		return;

We should log something here either at info / debug level since the
error isn't bubbled up and the luo_core doesn't scream about it either.

> +
> +	dev->liveupdate_incoming = !!pci_ser_find(ser, dev);

This feels a little hacky, shall we go for something like:

dev->liveupdate_incoming = (pci_ser_find(ser, dev) != NULL); ?

> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_setup_device);
> +
> +void pci_liveupdate_incoming_finish(struct pci_dev *dev)
> +{
> +	dev->liveupdate_incoming = false;
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_incoming_finish);
> +
> +int pci_liveupdate_register_fh(struct liveupdate_file_handler *fh)
> +{
> +	return liveupdate_register_flb(fh, &pci_liveupdate_flb);
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_register_fh);
> +
> +int pci_liveupdate_unregister_fh(struct liveupdate_file_handler *fh)
> +{
> +	return liveupdate_unregister_flb(fh, &pci_liveupdate_flb);
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_unregister_fh);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 37329095e5fe..af6356c5a156 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2060,6 +2060,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	if (pci_early_dump)
>  		early_dump_pci_device(dev);
>  
> +	pci_liveupdate_setup_device(dev);
> +
>  	/* Need to have dev->class ready */
>  	dev->cfg_size = pci_cfg_space_size(dev);
>  
> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> new file mode 100644
> index 000000000000..6577767f8da6
> --- /dev/null
> +++ b/include/linux/kho/abi/pci.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * David Matlack <dmatlack@google.com>
> + */
> +
> +#ifndef _LINUX_KHO_ABI_PCI_H
> +#define _LINUX_KHO_ABI_PCI_H
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
> +/**
> + * DOC: PCI File-Lifecycle Bound (FLB) Live Update ABI
> + *
> + * This header defines the ABI for preserving core PCI state across kexec using
> + * Live Update File-Lifecycle Bound (FLB) data.
> + *
> + * This interface is a contract. Any modification to any of the serialization
> + * structs defined here constitutes a breaking change. Such changes require
> + * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
> + */
> +
> +#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> +
> +/**
> + * struct pci_dev_ser - Serialized state about a single PCI device.
> + *
> + * @domain: The device's PCI domain number (segment).
> + * @bdf: The device's PCI bus, device, and function number.
> + */
> +struct pci_dev_ser {
> +	u16 domain;
> +	u16 bdf;
> +} __packed;
> +
> +/**
> + * struct pci_ser - PCI Subsystem Live Update State
> + *
> + * This struct tracks state about all devices that are being preserved across
> + * a Live Update for the next kernel.
> + *
> + * @max_nr_devices: The length of the devices[] flexible array.
> + * @nr_devices: The number of devices that were preserved.
> + * @devices: Flexible array of pci_dev_ser structs for each device. Guaranteed
> + *           to be sorted ascending by domain and bdf.
> + */
> +struct pci_ser {
> +	u64 max_nr_devices;
> +	u64 nr_devices;
> +	struct pci_dev_ser devices[];
> +} __packed;
> +
> +#endif /* _LINUX_KHO_ABI_PCI_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7e36936bb37a..9ead6d84aef6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -40,6 +40,7 @@
>  #include <linux/resource_ext.h>
>  #include <linux/msi_api.h>
>  #include <uapi/linux/pci.h>
> +#include <linux/liveupdate.h>
>  
>  #include <linux/pci_ids.h>
>  
> @@ -582,6 +583,10 @@ struct pci_dev {
>  	u8		tph_mode;	/* TPH mode */
>  	u8		tph_req_type;	/* TPH requester type */
>  #endif
> +#ifdef CONFIG_LIVEUPDATE
> +	unsigned int	liveupdate_incoming:1;	/* Preserved by previous kernel */
> +	unsigned int	liveupdate_outgoing:1;	/* Preserved for next kernel */
> +#endif
>  };

This would start another anon bitfield container, should we move this
above within the existing bitfield? If we've run pahole and found this
to be better, then this should be fine.

>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> @@ -2854,4 +2859,46 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  	WARN_ONCE(condition, "%s %s: " fmt, \
>  		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
> 

[ ---->8------]

> +#endif /* !CONFIG_LIVEUPDATE */
> +
>  #endif /* LINUX_PCI_H */

Thanks,
Praan


