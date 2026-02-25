Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EADEEFD207
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 08:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=euz76pxATmJYev+UEaMjSj8YYGXQ5aYbA3uegrgN/Es=; b=LzF2uN4myMO6y2MaiV4CsJZNmV
	bsgsWUBu75qziJA6rpZEnxSKrNuJEvpLwneR9FsjabJTCwfYrH292VBC6kwaJq0b8YMpmML5d7sqM
	uHdUI1dQZ8G3xzFq0KJycbn/ahfj3PVXsgDMf2ZLv5OSs+cE0rbDhuIqXDm8DnZimnlxurPU5PzXO
	Sk6bqQ1dbf2FXZaPaUhldIomlJP26bifZev+DQSeeXESG8BMMXHGaxG9HEwxR6JbjrMF3Icra6ut8
	fU5mK1m25/1g2i3tvPm61z37FDCcHQKnI9NsW/LCjwnH5aiEbEr3aQhgB5WeHSRIa2lTX/LsgPqli
	ZrelPwdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvAPU-00000003Zlw-3aSY;
	Wed, 25 Feb 2026 08:38:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvAPS-00000003ZlP-3u7g
	for kexec@bombadil.infradead.org;
	Wed, 25 Feb 2026 08:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=euz76pxATmJYev+UEaMjSj8YYGXQ5aYbA3uegrgN/Es=; b=EayGN6WHK9TADeileMaNjss8bu
	OMpWak3nwpxLf2EqGBNy/J8aEsSVs7kpDB5DVAe+9wG5X+b/+SJ5odlNooHcIgqXdQgD/2Y1D9oRe
	lzKjpUmlJAVotMM5ADpaNWhF3VoRKueARpLEKPBEieaBfJ0IpvBJTd7VaUbHki5IylWq7fqixBoar
	uaYP5sSRLMKBwvHHqLHPE9mCjzD/1J67GrkYQx9E+STX7tnXaaalI4y/UKDbHY9JyxSNd2ligSu7h
	P8Ch2AWZpbk506zZtP0PMIASh3VEQjumiWfqyZZozSzbYBFHur3D16lXB+7h1+4AbgdGktTtfmCu5
	pLTKEvXQ==;
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvAPP-00000008aF4-2vAb
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 08:38:17 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2aad8123335so61775ad.1
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 00:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772008693; x=1772613493; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euz76pxATmJYev+UEaMjSj8YYGXQ5aYbA3uegrgN/Es=;
        b=U0ygp57nWxEN0gmh22TFEu2IMrwalCpx+H2k0J7LaaSt5PdFO7nUQ5T2Z4QUMYfb3i
         eXRhISIoznO5ILFZ0U8VSAYjvFs+rPvHh6AjJOYxVx4L+SSLojN0zQgyFvZCr4sVze+H
         JSWvJmgUuRFuFmeSVWOQab5axDKfNnIvdYPNTXQiL9mO/zc8WG0pssuncyHL5XSencu0
         ssiYW77wk1p6UoHpXRnURoG8wEGWr2EQh+HMROHK6rZ/L7o871iPakPFMMS0cT6vrrxe
         vAe3V4u09IDIu6TwEZmwzrNKMFoA9SxasPKKpm5ecaizhNMh8VwFq8JxBV9hk8E3aErz
         D06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772008693; x=1772613493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euz76pxATmJYev+UEaMjSj8YYGXQ5aYbA3uegrgN/Es=;
        b=EstdE4uIGcGRq6P+Z1KKH48aazDxf9OSlEWLL9dqdPmtLDkVkqVFLJ//1+EYy5WqLo
         UnZpwy+MWJ7QKku3yBkipk9DfdJ4ArtK+fr7StWhKh1MvYNh/KPVncbMwea20OG/Yrg9
         4c6Sva9db6H4Oqjuyp9asMATcgZGXJx/c78wHY2Ui4lK6d+XHDwbaFwW/X3BtB5tiIRr
         +wyvxW2FhltokJRa8aBfbRB3FOdYe24TcJQ1OaiAyn+Ms+ert1C2XyRJYizWacPmv5rS
         Vy5+Xf8D0BLQLxk/2Ak/Yx9GmXz8sH2ap9X03zTKQ7ZVOMNnL8OsUaETy4WHkfB69NEc
         8tfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgyST9HImQk8YVt0paEzNJOJAtpkgU9C9hqpHI1CvB0qfWUXgz2XJAtTX+01GF3tQZIwdofw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yypnxw/sCspyHZ7Q0eBhdeWjqRMjEiJidR4soSenws9Trt6LtjI
	ZSLQ29ZrCKGmJx72bw/XFYpjKRiPsnOd2EbdmsYCpo4AuNBKgyJC0/vUXNwsViZKUw==
X-Gm-Gg: ATEYQzxQhBgmmRkP1HYWHRoS2xmNChz+M8yAv0k2AmCau6NsE3mSf9Vns4o5QFsikhH
	lUqtOjzHzBPA6x9aKxHlfB7yUmnTUqJQzfmc7wQnDy4vrtTHyOkye9EMHiEGbha4neZ6pJ5zoyI
	/7xpDbd9r12DGVo0snG0ngCLGk9TiDQt2nrgApwtcxrXKnDK6HMOKv1vSuWpTKYdlaMKqJf+Rau
	njbaH/D9zlAKTAVp+9JDIK04ZTpRT5gx54DnQYd4q7MZcbNo/nuHU3FHtqNQfA3dNmTEXIYACK0
	JHkMKgv/4zL9GsSUE4SUfpMl4YQLRFyhJLU9VS/Ix+cV7EanmqzDkrSq1dYl+LfLXNoyyQ45ddB
	9U7+OMC3YZzlmvtQucYiQ9kuMVi9G3FyeeulHylWXhNoMMp+ZbQ+kPus+F1olKxgd2L2xzCJzlJ
	IBtLGGEOb+Gt7MDJisTB9VRZVZj8op3hJ8ub+UpKoa9O9ZO/MKi51MW46jeb79
X-Received: by 2002:a17:902:ea02:b0:291:6858:ee60 with SMTP id d9443c01a7336-2adca6c8a9fmr1402215ad.4.1772008693092;
        Wed, 25 Feb 2026 00:38:13 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd6c30dfsm13034861b3a.27.2026.02.25.00.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 00:38:12 -0800 (PST)
Date: Wed, 25 Feb 2026 08:38:02 +0000
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
Subject: Re: [PATCH v2 09/22] vfio/pci: Store incoming Live Update state in
 struct vfio_pci_core_device
Message-ID: <aZ606sDJxtfNF6qW@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-10-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-10-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_083815_941347_BBB0C518 
X-CRM114-Status: GOOD (  26.06  )
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

On Thu, Jan 29, 2026 at 09:24:56PM +0000, David Matlack wrote:
> Stash a pointer to a device's incoming Live Updated state in struct
> vfio_pci_core_device. This will enable subsequent commits to use the
> preserved state when initializing the device.
> 
> To enable VFIO to safely access this pointer during device enablement,
> require that the device is fully enabled before returning true from
> can_finish(). This is synchronized by vfio_pci_core.c setting
> vdev->liveupdate_incoming_state to NULL under dev_set lock once it's
> done using it.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c       |  2 +-
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 17 ++++++++++++++++-
>  include/linux/vfio_pci_core.h          |  1 +
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3a11e6f450f7..b01b94d81e28 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -569,7 +569,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>  		vdev->has_vga = true;
>  
> -
> +	vdev->liveupdate_incoming_state = NULL;
>  	return 0;
>  
>  out_free_zdev:
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> index ad915352303f..1ad7379c70c4 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -131,6 +131,7 @@ static int match_device(struct device *dev, const void *arg)
>  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
>  {
>  	struct vfio_pci_core_device_ser *ser;
> +	struct vfio_pci_core_device *vdev;
>  	struct vfio_device *device;
>  	struct file *file;
>  	int ret;
> @@ -160,6 +161,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
>  		goto out;
>  	}
>  
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	vdev->liveupdate_incoming_state = ser;
> +
>  	args->file = file;
>  
>  out:
> @@ -171,7 +175,18 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
>  
>  static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
>  {
> -	return args->retrieved;
> +	struct vfio_pci_core_device *vdev;
> +	struct vfio_device *device;
> +
> +	if (!args->retrieved)
> +		return false;
> +
> +	device = vfio_device_from_file(args->file);
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +
> +	/* Check that vdev->liveupdate_incoming_state is no longer in use. */
> +	guard(mutex)(&device->dev_set->lock);
> +	return !vdev->liveupdate_incoming_state;

Since we set this to NULL in the success path of vfio_pci_core_enable()
I'm wondering if a failure in vfio_pci_core_enable could cause a
resource leak? Because vfio_pci_liveupdate_can_finish() returns false
as long as that pointer is valid, a single device failure will 
perpetually block the LIVEUPDATE_SESSION_FINISH IOCTL for the entire 
session preventing the LUO from reclaiming KHO memory.

Shall we also set vdev->liveupdate_incoming_state = NULL on the error
paths of vfio_pci_core_enable() ?

Thanks,
Praan

