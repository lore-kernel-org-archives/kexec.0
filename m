Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6287FEFD204
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 07:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sT2VtKh2V5oEus0jIgTdEjDE+//UyVLRT7BohuHzzWw=; b=BwdATjNEWE17SHHnkmOWrpg/P9
	2qU6PpShY8g8RM/7hhehiwgduliTtTHSAU06ssxEuJWcZbu1KHlikuT6UkKXq6vyuPVHVmWWbNc8S
	NPCbCxQhuzVmvNDT6eDmSlgZA62MzXk1JldsCp5WEFAakfwoWpldCs6ZsWKwuwI2VfFp7HCLkUidX
	iMNGepskd5q7JpDRDy7mjQMzoJXa1EaydGePff++qDEwHDd3oGyx7D46ILU/SOwzw0F3Nc2YHuLXj
	IYhYY/cbFyl6DSl1Q/Pay4ZLvdy21SOOufIRS3PaOmaw5sZHrDjkM32XNr+rR14wo+5DmvZEV8Jy5
	c6VHkQxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv9kg-00000003SUU-2AYL;
	Wed, 25 Feb 2026 07:56:10 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv9kZ-00000003SU5-2ddl
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 07:56:09 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2aad8123335so58235ad.1
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 23:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772006163; x=1772610963; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sT2VtKh2V5oEus0jIgTdEjDE+//UyVLRT7BohuHzzWw=;
        b=Del11oeGqStVmmbUoB8L/viNSmU3vWAIClfWDLTt3Lo63i8B2y1R0EmRS+zPktVYb0
         n9lXS6BCK9XY7RFRoVxKnEU8Y7Ng7fL+CPr+2dzuR/y2J6c0xccn/ml3M3QKPr/Xzvrs
         vChv3z4BPuJvFNtrvWlt3xHtWseXhVEs/bgnwWGU9kdgc+RgAvDux4T1IpZL8L7DoZy6
         /1I80tKPjes7Ro7r1YlM38OzH+FmAWdQ3lpcwPFvQbeX7wxiEulwTPUR8f6iZJYLuOJZ
         ilNeb4wQNdFdhUVY2VysNGk5+mMgx5s9kbdkapbIWHrheKE1fRsK578ju+GG3iPLc7On
         vqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772006163; x=1772610963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT2VtKh2V5oEus0jIgTdEjDE+//UyVLRT7BohuHzzWw=;
        b=myNxMLS9Zz8Y5W1irECr/s0xFyShSuFrduI0VjBCdkQXYH0cd2vyDivqZxx18uyVDQ
         i9YQhYB+UAobK1VvEJwPJtr9S9+6LUUCI3DH+047h/GRAXJwj/it8Vw5065qHcJBHUV4
         PWiq1qmGJ98cIRfxMzxtYBYZWuvjN65rK25cPoNptFRV0gCkTqtpac776l4ejyBpVHJI
         V7GtpBzfjdaQYOjXPE/xjIAYbsPa8QKidzNBK5/yOGRSGoK8WeUdmA3cpUDtnBkTsSGB
         0iyJb8CI3RCBAv/r6WnGfDiuz+2qCFetQiwzppjUIIL7P7N+aIcjLOOPeYej1CG3yHan
         lrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrhV9h2CGADQHrmBO2H+el2cFtE4PIIqgu/0rVJXexsZV9FDwaiTmP2OtltA1PQw/O0lnBug==@lists.infradead.org
X-Gm-Message-State: AOJu0YxsPwPGcRVMSMaNF2zWCa5NAVzPCtDYoRKcn1kBdZlGlPN909by
	EuPMfFS8kAllRInyxMNUfHZi/UorlpkBaPDLDet9jM1Y1jWAgQIA99SXQThce+3upw==
X-Gm-Gg: ATEYQzxCN7xWY+9thHLS6kcdVQgeKE/Ok0DDUsQXvIGlJImSRuOxu6UwbZXXvd9sOGg
	4HrPJA9iu/8YO+dbRbeeaqPLsGaL6ODlDHK0UahgLOhTNAv/l20HlU/ne4vwkSc97UntHQjw+Gq
	ICXwO7IPq1MMEcB246CkblcStRQRdkjPnOqwcByE1gqeVfXwjDUPdR45BtVo4Rf66JtNp6q4jtL
	wcmzEudD6RCNGiDl4zhqjnKNaXhJ+pZRpXsO4NmhUG08Wp5mTY5+2b8Dtx0t8BOms2U0uO4xJI6
	P8qEBhH9sH+Yy/HzJF3JunDcXcLBAaufRGNqhQDEp28xxb/S7usbkmEc7p4KfPadQRi+OgvnbG2
	GB0CXX+uljkPkUmmh1dWhnPXsVAX7Z1RaoGcv9IDj64lVFf0DNvsL4qkFe1/OUSrJ9u44sePOw4
	MenmFPXEYmXpLqGyNnMlaqDvkKO+IHwcl7bnW8AfUP6PJ12OfCbdSdrMET85xt
X-Received: by 2002:a17:902:d592:b0:2a7:6c4e:5924 with SMTP id d9443c01a7336-2adca6e950fmr1322615ad.12.1772006162194;
        Tue, 24 Feb 2026 23:56:02 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e2b2sm124024035ad.52.2026.02.24.23.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:56:01 -0800 (PST)
Date: Wed, 25 Feb 2026 07:55:51 +0000
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
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
Message-ID: <aZ6rB-zmpaR3RLB_@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-8-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-8-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_235606_588485_33BD8812 
X-CRM114-Status: GOOD (  27.03  )
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

On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:
> Notify the PCI subsystem about devices vfio-pci is preserving across
> Live Update by registering the vfio-pci liveupdate file handler with the
> PCI subsystem's FLB handler.
> 
> Notably this will ensure that devices preserved through vfio-pci will
> have their PCI bus numbers preserved across Live Update, allowing VFIO
> to use BDF as a key to identify the device across the Live Update and
> (in the future) allow the device to continue DMA operations across
> the Live Update.
> 
> This also enables VFIO to detect that a device was preserved before
> userspace first retrieves the file from it, which will be used in
> subsequent commits.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index 7f4117181fd0..ad915352303f 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -53,6 +53,8 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  	if (IS_ERR(ser))
>  		return PTR_ERR(ser);
>  
> +	pci_liveupdate_outgoing_preserve(pdev);
> +
>  	ser->bdf = pci_dev_id(pdev);
>  	ser->domain = pci_domain_nr(pdev->bus);
>  
> @@ -62,6 +64,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>  
>  static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
>  {
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +
> +	pci_liveupdate_outgoing_unpreserve(to_pci_dev(device->dev));
>  	kho_unpreserve_free(phys_to_virt(args->serialized_data));
>  }
>  
> @@ -171,6 +176,9 @@ static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
>  
>  static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
>  {
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +
> +	pci_liveupdate_incoming_finish(to_pci_dev(device->dev));
>  	kho_restore_free(phys_to_virt(args->serialized_data));
>  }
>  
> @@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
>  
>  int __init vfio_pci_liveupdate_init(void)
>  {
> +	int ret;
> +
>  	if (!liveupdate_enabled())
>  		return 0;
> 
> -	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		return ret;

Nit: We might need to handle the retval here if we remove the
liveupdate_enabled() check above (as discussed in patch 2).

> +
> +	ret = pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> +	return ret;
>  }
>  
>  void vfio_pci_liveupdate_cleanup(void)
> @@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
>  	if (!liveupdate_enabled())
>  		return;
>  
> +	WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh));

same here.

>  	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
>  }

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Thanks,
Praan

