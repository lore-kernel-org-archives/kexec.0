Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89793FD9E23
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dweZEP9P9syIIaIBNbJewu0YbCAV1KvejPrlkY4pDLk=; b=SU/QkIwXjJ8FKO6mD/OKpByiH7
	YISUDMKmEGZb2HiCl0Rzc9qL3jxnry+yk/h843hPVOa52R74lxW8Y8y/2q1UZRxNjg9HxSgqQPvsR
	h8ujWfCj0T0VQmFUqDUl31oGwW+qPu9TEZwYEiFiRcnFUH35WTKnquiD1YT+a3D1hpe9VFZm0kbIH
	fqdT5MeD3je/LLbvwn4Yu8DqAoBDwj69BaSMPcVzDWmvTcGt1Ne4IFoA5uWf5CkggXEvr2dOLh+G0
	Iu6qTzT2/larcfkGCbr7Zg78W50PkocgVEr5vFsnQpTXgy/8gmwuTjP+9YLyB6ZGr0QVhjKkor5v3
	96EpQdbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvkyQ-00000007OJE-2JSk;
	Thu, 26 Feb 2026 23:40:50 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvkyO-00000007OIu-0pyx
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 23:40:49 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c70378ddaafso926288a12.3
        for <kexec@lists.infradead.org>; Thu, 26 Feb 2026 15:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772149247; x=1772754047; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dweZEP9P9syIIaIBNbJewu0YbCAV1KvejPrlkY4pDLk=;
        b=sWZd/fQiJ98/M6MDsf4tR3mHZz907JuaZx4ipRbvE8ZwsmyvqQ4+oy4SFi69i34tpW
         IkmTqPmbUUsDTCfuzASIzQcNhcVyTvWDQto6jLiDt+lrR3jwPbfjsCi+qYN2uyuTjCRW
         xV/WwNLaKXkGTMN6bKeVGXfVJDuBxvgkusRAlyEvPgdbvwnLFct5c4lRtcPaU8TAj3jf
         nYVPZtZ/oUlECasL2sS8oW275/m2PSQ6TPkT8RFaC1Rvlqi5GrJLtXkiDLROSu9+ngfi
         5SYIJ+78qNhLZ2kFLqizimoyroZaaBGNeoNMfMJfDPftJu3pESKVPtCzSWudLhMR4TM+
         QDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149247; x=1772754047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dweZEP9P9syIIaIBNbJewu0YbCAV1KvejPrlkY4pDLk=;
        b=my1Bi+bP0sxbZGz42qHVlDltsMnLkCiZtL/2Ar9+ErswslysVTZrtAiQ5048fAEcY4
         e1NkMtyOUTkz0UzNbhU8o7LWamnwmXreebbpDP2/XscpKOqzD0Heuvz/R8mTzE/POHjB
         2bWOutZh1HZo604ZVsgcaYbTloJ9C1EDFzv2v/bRVA9RuKbJxBdL0AHMJzsf/w3fvn18
         vgrx+qU514g5f0yZocZwC21VYtDjP2gVknsDWWScxw1eS88YFsJWnLte91ZRf1QzNer+
         N8xJDEkPDcyEoq4VWaUPAkJQdjIuYbcV6geP5VuskccICIDvpFPfcwgFHUk4v9apKQi2
         gjpA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Sc4iv8lpnVT+Zz7y86m5SahWyvkLwAZLtt0WylTknF9ablJIvCeli0AYQpci1e08EkCLVw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwQeer359nsflkISCWdWbRqbLbUIBqjUz+vQE6JHzX1Kk16ZetM
	Gxzb9is44BNj4S/LKNVk6MEROiGhorimtistvq1hPHh9otQBzJaMHBUU4DdjHG4mUg==
X-Gm-Gg: ATEYQzzZNSVvareVEXPGY4RppKdonrH+ZkQ2rxqIIYeKyzv37jblv5WxlZvx6WL7NpY
	yA7DXKHYzy6isBEzmBqkaKlJYJnG1+VzvAKuXh/T9GYNTGxR1N1jxpGMpkxWwcyEtfGiHlpFwQd
	06Lk9QciTw8+kpHL6gAoI2Krh8I28diDyZM7wKK7NM3FoCwkX7BZFatA7s256fKrEwF+upuYQQi
	gJv1ESb/t8cfJZjjfKFbKN3T1W0s6O8In4t8ZupTDXvf3ZWlp6ZvTqFyCBYJAkoHasm4bCZsvk1
	9nP7KAeRyEmodOIaUZS4idQAY32LaCY9aewhDcsb7zsij+6ClYQERXEHNomhOlLJmyAtXsXL5u1
	g1eJdJKuXQlWPQmwJDzSX4SDK1scba4bURYCdyOKPJX/xNlojlKAlV8bjDrdBe29zGy3tIhY36c
	2cC9aG8cQJvzCiz0Ubvel8pzCsEPd4EEYOvwfZRjnZoUX7nwlzQj72Z03vKusH8w==
X-Received: by 2002:a17:903:22c9:b0:2ad:cede:3a18 with SMTP id d9443c01a7336-2ae2e46bd8emr6748745ad.33.1772149246778;
        Thu, 26 Feb 2026 15:40:46 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b257esm36167495ad.4.2026.02.26.15.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:40:45 -0800 (PST)
Date: Thu, 26 Feb 2026 23:40:41 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
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
	Pranjal Shrivastava <praan@google.com>,
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
Subject: Re: [PATCH v2 06/22] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <aaDZ-ffs4kiUo3GY@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-7-dmatlack@google.com>
 <20260226155222.5452a741@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226155222.5452a741@shazbot.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_154048_277055_D88EFB9F 
X-CRM114-Status: GOOD (  21.38  )
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

On 2026-02-26 03:52 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:53 +0000 David Matlack <dmatlack@google.com> wrote:

> > diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> > index 8ceca24ac136..935f84a35875 100644
> > --- a/drivers/vfio/device_cdev.c
> > +++ b/drivers/vfio/device_cdev.c
> > @@ -52,6 +46,19 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
> >  	vfio_device_put_registration(device);
> >  	return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(__vfio_device_fops_cdev_open);
> 
> I really dislike that we're exporting the underscore variant, which
> implies it's an internal function that the caller should understand the
> constraints, without outlining any constraints.
> 
> I'm not sure what a good alternative is.  We can drop fops since this
> isn't called from file_operations.  Maybe vfio_device_cdev_open_file().

Ack. Due to the bug you pointed out below, I think the changes in this
file will look fairly different in the next version. But no matter what
I'll avoid exporting a underscore variant without outlining the
constraints.

> > +	/*
> > +	 * Simulate opening the character device using an anonymous inode. The
> > +	 * returned file has the same properties as a cdev file (e.g. operations
> > +	 * are blocked until BIND_IOMMUFD is called).
> > +	 */
> > +	file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
> > +					&vfio_device_fops, NULL,
> > +					O_RDWR, FMODE_PREAD | FMODE_PWRITE);
> > +	if (IS_ERR(file)) {
> > +		ret = PTR_ERR(file);
> > +		goto out;
> > +	}
> > +
> > +	ret = __vfio_device_fops_cdev_open(device, file);
> > +	if (ret) {
> > +		fput(file);
> 
> Don't we end up calling vfio_device_fops.release with NULL
> file->private_data here with inevitable segfaults?  Thanks,

Yes indeed. In that case I think we need to call
vfio_device_try_get_registration() and vfio_allocate_device_file()
before anon_inode_getfile_fmode(). We could play games with file->fops
to avoid it calling vfio_device_fops.release here instead, but that
feels hacky.

