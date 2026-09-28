Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1ADCA5FA1
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DWEY4l/bIKaUQ0LkmUfe65oGxH2cGGoTK+zPHQ0IPQM=; b=kzjs2QaUN5xoku6bHHCVP415aq
	FExigVmOHUEixdUVxB22Dm+GoJL91JWi+PMLm7peX1+Kw+SIvfQXVDTtJ36vDFCHpxyQBxM3r/YSd
	vcqulHatK5pZ/yRmCREcnPMr0hyzpS/EQyAJTDxTt9Ot4WOazTlTPXd1mhn2GKm58M34CIOINKyck
	CzxKscabbD1sg2WXYMg0/kyfxXtgvSfWpjWvKmer5Xf0VOBOS05hYmHu0ARUe9xIlKg3L+jzs/Re0
	cEceof0gQnmIZPVyLlGy4vUGaIoap/qCWEPk2mkjoh20uKoiJka3z9E+SL+pE1W5T4WP1vIDUp2kz
	hNWp9JKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF19-000000018db-1oq3;
	Mon, 28 Sep 2026 17:19:55 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF15-000000018bm-44FK
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:19:54 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2d3b445a84fso3085ad.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790615991; x=1791220791; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DWEY4l/bIKaUQ0LkmUfe65oGxH2cGGoTK+zPHQ0IPQM=;
        b=OtgYB2mbuMwskOFjs1+9QqsrzB3twtUcwOrjraOYfC5NmkLhKs6iQPtRWbR8bp2Bcn
         +974yL+eNAOW0f8mT9aiZj9VNA+vE1iAi0OYTQKfcl2WaqFGu+rLvgePy6gg7d9CiILq
         htQCu5gVHaiXH8E14YJ8XrohmdC1elBu1TuyThv5BW0wFb0Mgi0RwRkoR+KNhm5nSbeY
         96qM4GDE9fK0Cpd2INLWf3MKdhjqM0/1m3up4DIl7JTwc7UerRvmQY6dDrgNI17HXH4N
         H3jd4pQxAoh4MkkpcL3DQSF57fAKtYOneQQC6lX2vUbA2svNiHZcmg/wkm2O8n3Ozdx7
         9Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615991; x=1791220791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWEY4l/bIKaUQ0LkmUfe65oGxH2cGGoTK+zPHQ0IPQM=;
        b=l3rVDVCJIxWkEPP341oGZFvaCUwEiE0SQkIm2qRTYWTArBMJVXeGtwOcHrUVkXwLSJ
         WRJdYr5cA6G2Q2aqfKcPHr2oyQNDNvCLSkyGEBiI0Xrd2kMWUmLpLuZPCuMoey56pst9
         Se7x82M1Q4aiCg9s8cQVKhGsnTN2GzyTDarRm2JIAxZblKH/9kaESpnnRAsZ9p2nn5Yn
         OBEuX1ARLIxmbj6x5Hpx96hMB1GcMC7wgVWkep1nY6/QnCnnQ7mJJR5JSnz5pDL5zX7A
         sq5fSJoltBbXvWQAlRUKJDrZZY8vthr+ucUijEVvrM/lERX0mljId3MG5xAidT18k1az
         BFDw==
X-Gm-Message-State: AFq9FYKDDUw1gvE7Enbop9MlJadLPcrYeGCpVWOnNfVPg1ZS1uCDJGf3
	j2zu7PQptNHmRlBT3lUc/SGAKxZcbEiBWFc0kSceqq+iESZ9ay4u6bJsq/F0WHB89w==
X-Gm-Gg: AYBFou2O74fffmgQzFsnHOnBwvBOniQwO2bFpe3xrAJooaGtzeaZKIsRSuM1pjqZ+zG
	lVAhp9O445MLefhnLBBlx7u5UPX9qDcVLWC5ZW9Ce5bVBojGgQS4FEmke0ghQT5syVsruuEqk+A
	Yr+Gi2BQAfcuoeZS9SdvquiCtoXU4iazthpA2Tfbn9H01x8pEdQDZprUqxb1idc9Zc/5RQkKVMx
	KwFFazPShj9kJXsvEVvJTbSEyxM1QO730kbkUnGSbC06S7WlsvGRSw3tCX6gT8rG+AQAevXxihi
	apOQfvHTdOOM7Cq3XosFf4800zez6O9Uj0PYT+yTyLSy1bATyftl44AXT2AxmjdTb91vH2VyHLV
	w5DjNMD/7DeQar6wS/Q4O0AHOIUKCWDL4AS9vv6pTzeuWE/X53+sJSSQBL4ydBCbAreDzTXBBea
	Mzen0MYNjoS6NBVbtu8EB47AzhtHYroFJDzc3tdcyE+X7o7XEHSC5R7zTlSadKh6gm9aHvjNbFT
	Doq8QnkksEeOS7NBTcgwT7I+v/n8LXZhMw1
X-Received: by 2002:a17:902:f54b:b0:2c6:99be:9dd with SMTP id d9443c01a7336-2dfa6248695mr7310435ad.12.1790615990264;
        Mon, 28 Sep 2026 10:19:50 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858c123sm538411a91.3.2026.09.28.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:19:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:19:41 +0000
From: Pranjal Shrivastava <praan@google.com>
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
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 09/13] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
Message-ID: <arqhrVi0YfFNwKuS@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-10-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200640.887030-10-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_101952_019090_6C5AB603 
X-CRM114-Status: GOOD (  14.94  )
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

On Fri, Sep 18, 2026 at 08:06:35PM +0000, David Matlack wrote:
> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change during or
> after Live Update.
> 
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> automatically reapplied by pci_restore_state() if the device is reset.
> If that save buffer could not be allocated there is nowhere to record
> the adopted controls, and they would be silently lost by the first
> reset. Program ACS from scratch in that case, which is a better outcome
> than leaving ACS disabled.
> 
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

