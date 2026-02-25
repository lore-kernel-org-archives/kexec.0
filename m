Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D30EFD206
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sCJxVjDFn9Nx1ZVu0w3V3L8nPN74ZP9DglkzEBV+/BI=; b=ZGIF4OhDMuQAe6hi4iVI+rnSwc
	sYYUkaWtryb3JEOSGvhOW116+b7oGNRMY7Pa/oVNhUFjbtVALe0cliktfALaa5ogZv6UYTmmpXnxT
	xUS397jemu/hwRPNSRkEIe9+n20eMExSftKf3Q4G2rRVl5RoFReULXBIepZvA/MhJLVlnV0MRq7lS
	QB7rGYx7fpve5Yrf0Em7ycicLmHmSUVM7d5mervGayYFh/jvQ90JYxS+uPrinMlYW0Mbig0pA8JAf
	mwVvg2mYio+nDYZ6n+YfAJfpCAL5dmKE/sUfiYFjK+GMib/H1sTWq9NfbInNS0Nh3MTDpuRW5KDQz
	kU6y3eLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv9rp-00000003StH-2IJU;
	Wed, 25 Feb 2026 08:03:33 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv9rm-00000003Ssw-3OpN
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 08:03:31 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ada9e4ea32so55925ad.1
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 00:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772006610; x=1772611410; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCJxVjDFn9Nx1ZVu0w3V3L8nPN74ZP9DglkzEBV+/BI=;
        b=e1ZYrwCB7nX8vd8WsCW3yUWlnPJklQgbEd82MtplHfsdKCOPBcKdP4QDKY4MU3DnVU
         tyhqnJ4xdq18mnfF7Jo+/1QZlAKjZu6eb4KbBNT5GNrrGJRNppNPSAkaiWPhWww8SlbW
         2l5SdUgdf2LMRt1op7J5stZeaSyrD9SqReU6DcSGX+/64JRubY296VTnFMHoMPENTcmw
         A9fhJutjVs3JeWWHG+B+FUMbybxo7pRzlut7vDO9b1j/C8dl5Cc1cJ+IBFRRKxjFwoZ/
         qNK8lmvYFexLbyvdDOSBjz6MgyqmYPJJSLYDb9bJV8yB872UBixxUQmPyN5DAVznI2vw
         45PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772006610; x=1772611410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCJxVjDFn9Nx1ZVu0w3V3L8nPN74ZP9DglkzEBV+/BI=;
        b=jEUbxnFHycbNgapXJ/5LdtEE0hg1vXdLyNRiAv1MhZfWt+q8Jqojrk/WVbDIGNMMaK
         LZ9QSXr/7nGQwQ5GxCIGIwAJc2gZPKT2Ie4oSYzT2zRJoyqyRIR88vKLUxpcJNHxRP2F
         awVpVFDop8Cvc2/WvQx1BOhU3EbubITIPmR5gD1zmTVqYMxhkVFguxkQD69mQjE3ABVr
         zWkXUeWmpiHEuzzniSddEzPGmXt1srsPRtqHdzW2AEbdTGqtsPU1c/8bPouBqgM/oLz4
         nQAjrSIUpfmRByJkX6mDSsiMrHYCktmXvdlAVb8v4QX7DBLc7D8ev9boqleAjEcuC3XW
         zvqA==
X-Forwarded-Encrypted: i=1; AJvYcCXEUeM1lSSB5f+dhBtVDYAFvpQJ3gyNcUnb2czQzntKrp2fVDvmjM+c85TrSxdB4mZhHBI6WA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2XVY3jZ+L/pT6ESHzqH1bCzpYpOPBBAYqEizBaVVwcwnicyH3
	2Knkud7QfvpdXYeHN2kzh7IuEIvJAQJ/n1JbP9+JZxGtA2X3XUdKbchi7v44yTDMxw==
X-Gm-Gg: ATEYQzxyKS69jEY096mG54rtqRVRC/VniNfq/wwlY6syo/nYE1/97ZD2NjEXSf586Du
	8nnrQ6qZ9YspU3P9fWqX7CunxOaJC09B6zIucd0AwqjJ4KMSUK1PvA2ZMMDKjfrhFK7icCqfsfs
	7zXh87qGRlJxPVsQPYmqKTHDgI3NjhIbVur/SrxTLawtJ9MU3GObsI0EnhVKwUJr/YCod3RfdL0
	rSu7kZsDmke5rjlIRJutKQFOWwoQ5irHE6EAbjlBmpVVVJ2UkOfn0YIILshhnnYyDwWfKBD6x1A
	+1H99uflW48WcoC+8FdHHyeBfv/1e3TK+wIYJ/O0YCaADJpciJudan0P59fi+6UoY5+Y7A4P9Jr
	uHQiOiuyJ4YTtfQRBlTflFo/HUc5TyIaOnB7QzyLVXr9yGFeWrefwPPbUTbNjYIilDZTB9CAV0f
	6WH/OELLz6fIwrfHozadBZnKNLYrQQ+7KS3cK1LZmBnavFnvgUohYL0xlUjTzP
X-Received: by 2002:a17:902:ecc2:b0:2a7:7f07:340e with SMTP id d9443c01a7336-2adca6c9d85mr1313215ad.4.1772006609152;
        Wed, 25 Feb 2026 00:03:29 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3591342f19fsm421683a91.10.2026.02.25.00.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 00:03:28 -0800 (PST)
Date: Wed, 25 Feb 2026 08:03:18 +0000
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
Subject: Re: [PATCH v2 08/22] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Message-ID: <aZ6sxhNeHqy-hqhK@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-9-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-9-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_000330_855001_8D4AB12D 
X-CRM114-Status: GOOD (  14.41  )
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

On Thu, Jan 29, 2026 at 09:24:55PM +0000, David Matlack wrote:
> Enforce that files for incoming (preserved by previous kernel) VFIO
> devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
> opening the corresponding VFIO character device or via
> VFIO_GROUP_GET_DEVICE_FD.
> 
> Both of these methods would result in VFIO initializing the device
> without access to the preserved state of the device passed by the
> previous kernel.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/device_cdev.c |  4 ++++
>  drivers/vfio/group.c       |  9 +++++++++
>  include/linux/vfio.h       | 18 ++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

