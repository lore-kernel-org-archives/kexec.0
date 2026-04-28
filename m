Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDABFF886D
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MaR4AuPDQzq9MeZ+Bqr1j2DtvJljfw3TYQa7ZG83Cs8=; b=4ueSfkphvDqdYMXhCAL//Y8SNo
	PkfR3Yp+mgX/A6MgUFw7g3bGCMOSfyfa+OoMipxuuIVoW+r8mfLCsHPcUruSVZwCUaBeXM60u9ans
	udNdfMKSixNP9ls4t8YQIqDsWww2AGXyGAb5VkJQzHNsT/dmyk6oA/+8fAGmWgH99VH20LM4i4/Wc
	z78/yMvf1GLSNP2GN8gCTu1nMjJugcUWFIrAkoFwy79UMcFvaSq2K2TYo+5vHUFgO4O5W2F9gZLMo
	dbmk9BQEFEqs65zH8ZZHKzS39O/DAw6llQ/7O2667waISCRYfHvfyyMu46uUCbEbYoVNeBm34WBj8
	2IRso+kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHov4-00000002RKG-2fZg;
	Tue, 28 Apr 2026 20:20:34 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHov1-00000002RJa-44uJ
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 20:20:33 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso14915ad.0
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777407631; x=1778012431; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaR4AuPDQzq9MeZ+Bqr1j2DtvJljfw3TYQa7ZG83Cs8=;
        b=uRZhUagkxXOXGsT/4+h6A+EDtpINMg24/c4JRFyaDohF9H64ca7EgsrtlZc+pXlKE+
         ic8hIUqXT55FXchcofeSlmBOxgrsIWCktEj65Q1o1AqzczeR7WPJJMi4VRvP84GkSntF
         VCGUsUqGFMJr14QMk0VAA3IxcDEGz21h5TuPYxww9vwaBCDsA5I8tBwPglnnnCs1mINb
         0jsju2DnYYMeyq6UoBpliCDMh7rKx3PpoMPSemCQRm1YOdR/GPZ1JSugGyjKdNWSQoaP
         4wtuHNRgP6nW9Tf2VE2a2UayEvXHefX0WDuYKZOJE72f1hqMh6NxtMgSUh7KvgfWPwHE
         1+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777407631; x=1778012431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaR4AuPDQzq9MeZ+Bqr1j2DtvJljfw3TYQa7ZG83Cs8=;
        b=BuKExO4uMdm6yKqhRX7PgUkccSET6JvuY4XsqjTzG+LWvjCyfZLVH24LkhS7hiRivF
         RAAEoK+AjUHVmwOKvJpJpf7iKKy/9JKhsWCEzCvamgs0RkKWRU/UKhGF3oFJAPVbCmft
         zSkZOdG5IWfshE8Ws5El+Sww+mrb5GUx5Mut6k4ZD8sx2Km/ugIqQ9j5F0pkRHeLO25b
         D+B+FevaWxnGpGeehstiGNUXfyANz6jnqZpDe+reGgmLMwRP9p0IcnH5HHNiASdlIO1q
         TGrn2oqI2gYDxDqGWtkBtw8pUBwd1Dj97+9FW+RlKrGxhAhBWwGkJmTGcsr07egeJ5uW
         gPsg==
X-Forwarded-Encrypted: i=1; AFNElJ/CeKtHKHKMk/TsrsDjtdfdHk2/HoKXlMGYXb7QJFfgCEqDiPp3V7nhhq+wV9OK+wMWb5xUtg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmFmgTJSZWg2GYlAWeUfHYi7ZhJkqizHe9aYEuDU/Akx+cEllY
	ExDffrCzXQCb7qbji6ikiK+zBS3amEc6LVtpVnVasURhrxHSoTeq8Zi5Gwneuxi/pQ==
X-Gm-Gg: AeBDieshEDQ0rJTDT+d6JWOjSwjB6S2koNnFw2Lus5GyzhrSn06FJTZ8CPYCaVCk5Ei
	SgRIMgCHFVC7iTc55JSlRSrW4WuKawlDuTFz6PTRdabz4tbOoQ1E19GHeEMDge7qccc/vHMXhFx
	EEwt41Vr2sz2yV5KkWgWk/pR6D7oCysjseLepTpnJ8wV6Orl2QjpPhfeC0WL+/OOZ3e/jps+Moh
	2qqafcVBSfqgjnk7xD5n3rVYzYGLbCW7m/VvY6SkDUhNYLyZhbiLNOV6DyNDFqXF2FPHvObEsDe
	+fZ+vVh9I93f0xYXmaS72MUyGI+j9PfBEHLcksgCp784/Oy8TuBmgkT8U1GE4s6+CWAeWCN8rxl
	bCiYEzUnfoddCZVjrLTtQ2R/SPAaa2U3L1RHUTnSZeVMFrOtcGWQfVk855JqjypZn4gicFHsmoc
	K9D8UCVAeg8w41bhQHVr7VPUXZR6KMplEAJdWok7V+2Ljwl5Z5NxplnXwDPgh/H5A4efHVEA0ao
	I0z1+g=
X-Received: by 2002:a17:902:db0e:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2b988e32430mr88155ad.13.1777407630352;
        Tue, 28 Apr 2026 13:20:30 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae00d13sm3520508b3a.8.2026.04.28.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:20:29 -0700 (PDT)
Date: Tue, 28 Apr 2026 13:20:25 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260428201231.GA3885809.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-3-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_132032_034700_CEB5E710 
X-CRM114-Status: GOOD (  22.50  )
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

On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> +int pci_liveupdate_preserve(struct pci_dev *dev)
> +{
> +	struct pci_ser *ser;
> +	int i, ret;
> +
> +	guard(mutex)(&pci_flb_outgoing_lock);
> +
> +	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
> +	if (ret)
> +		return ret;
> +
> +	if (!ser)
> +		return -ENOENT;
> +
> +	if (dev->is_virtfn)
> +		return -EINVAL;
> +
> +	if (dev->liveupdate_outgoing)
> +		return -EBUSY;
> +
> +	if (ser->nr_devices == ser->max_nr_devices)
> +		return -ENOSPC;
> +
> +	for (i = 0; i < ser->max_nr_devices; i++) {
> +		/*
> +		 * Start searching at index ser->nr_devices. This should result
> +		 * in a constant time search under expected conditions (devices
> +		 * are not getting unpreserved).
> +		 */
> +		int index = (ser->nr_devices + i) % ser->max_nr_devices;
> +		struct pci_dev_ser *dev_ser = &ser->devices[index];
> +
> +		if (dev_ser->refcount)
> +			continue;
> +
> +		pci_info(dev, "Device will be preserved across next Live Update\n");
> +		ser->nr_devices++;
> +
> +		dev_ser->domain = pci_domain_nr(dev->bus);
> +		dev_ser->bdf = pci_dev_id(dev);
> +		dev_ser->refcount = 1;
> +
> +		dev->liveupdate_outgoing = dev_ser;
> +		return 0;
> +	}
> +
> +	return -ENOSPC;

Since it is executing under a mutex, and we already failed
'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
here and return -ENOSPC?

> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> index 5c0e92588c00..5b4c8d9e462c 100644
> --- a/include/linux/kho/abi/pci.h
> +++ b/include/linux/kho/abi/pci.h
> @@ -23,19 +23,20 @@
>   * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
>   */
>  
> -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"

Just curious, why did we change the version here? It's not like just
previous patch is working enough to perform a live update. As the config
is experimental, can't we just keep it PCI-v1 for the whole series?

> 

