Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51573F53D6D
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bdY0MHpBaQytGDjrwl6No73PmmhiNXL6flXFjxFT7cE=; b=RuFal3qddLoSv7QqpokBrCNlxP
	w8QIXxT1DO5wnY4VG5jysI0WFksD5Tl8iV2g819PScKSRNOikLpkAzzBqM/EdNwFCBmOX5atT5Mcu
	yjcck3Pz3qHXASNXqY7aL0dwBqZEM/nefXkQAt9ZdW4SKCuw0gFWwUkUgg3sRJbkURRKcAy7K9/q/
	ZsdZyMiHZeob06cNP4bzjBcFHg6BeWlqIuBsDnpD8aF/w7fQ+8OJfKyJtAcoDLgG/OPrc5TTttWLC
	95u1wIJboYZqF0czUWSeuAhqHitgO+jbJVZu40fCRDB/Jj4DMq3ESKbx4ur61Lp4On44hUDOedw/D
	38sjWQhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Ao3-00000004SIg-48m2;
	Mon, 16 Mar 2026 16:28:39 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Ao2-00000004SIH-0bnz
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 16:28:39 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b052ec7176so96845ad.1
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773678517; x=1774283317; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bdY0MHpBaQytGDjrwl6No73PmmhiNXL6flXFjxFT7cE=;
        b=KRazCbEhMRqf+zU6VdKLWRkgsWm9fy1EiyRlxpRF3y+FdNV0OI6PFep+qp+JkQP0+A
         WIoAAWMfnYEvKypgQw1WJmUL998lIc2a/sAC7wD33uzI7sz8mmM57lzCV57M72Xbpusr
         5nUjrT13DsF3gTm8m84kbVDgK1IYsrsthApo2sXb4VngFJ1dAYh1/W2kesTDOFD+lu+9
         7al4RBoM2gRJT+tSLhG6hsgDGW4Np1MO7p7gqeKKW7CkwxUVGxV4WR44W5qbAenFFM0R
         yTZc8sMMZoIWKBaLWXmiOC12t4w2aH46N+m3s9sMe1d2E/EmS8cOVdF7G6uCAfPLjIxk
         pBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678517; x=1774283317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdY0MHpBaQytGDjrwl6No73PmmhiNXL6flXFjxFT7cE=;
        b=FI80zC+lvYark8k4EtmE3+BQDihVdAOGCC3SpvJmsR5yDVRSy1mb/LwGeAoNQFBfmk
         YSfqLqGQvA51HtNjqLghEhTiJuXlH/XlGlFdOsDPFIpB81kYeoWCJnhF7RjUGd416OnU
         vxSBrBpquiwDX7nR6B0A7/HvVjgWBtQ8NBi+swUSyW+lJRD1kRq7KAo+sSFxx6baE7WB
         k3nMY17bQoYcGBmG6is8+ySpf3A/8svdZTbmzVeRsd/9IgTxhrQv0ypwj8bC3VofD0Ag
         pqVHoHf4MfgNyuXVlCrg1UcuR9Y4ZG+WYkaeTn7yWCjsLskPhXPPglFTj3zj410rivY+
         Vlrg==
X-Forwarded-Encrypted: i=1; AJvYcCW7TCzpyvGG8fQx1VxNzb4EwJSzVCEKhmoPSFv+I+AjyPj3Z4u9hEw+5MgbBgm0IO/ArrCDgw==@lists.infradead.org
X-Gm-Message-State: AOJu0YypOrCbbhX5rkpTuQcDcKlmQkZPawGQHJnzbJMBdFLY4X8fElHo
	TsFvhIRufuwKc9QXQjrWpyEOPvXbDnAO05nvsSWTnBTw5zBqimKTsAkRtGMBEWdMZQ==
X-Gm-Gg: ATEYQzw+9jxYNt4Mt8375nkQTivJPp6On4ueOcSx5mlgUPq7G+mKRNlG57aHolcy+PN
	MAzejma277s2y7GlHihD/x1bnKCmtuiYwLV/ktq2F7BnVMnPGi4mxPxuBrYh6tbjrvWJ4NexxZP
	jmgIXy/0ZVQq8yPbaznRvDtf6QlNMyXfxOj9RmknGhtiXgurxuuLrBaZdCrBD1ADK2D55WYqo2f
	X3BIDvUHy4S6JaBJ5FDdkMRLEePRemFkWIs8E3xT/RilFkBuzlOfJmZnD2MDF601z9dDp13agJ0
	7cbnGRN+3Zzi9CeeR5GCmvEZ2m5RFaw6RV9pmW6RxwD8Ext/lfc5rE1QOKjHt5TmlF0OWIUnOt5
	wStriZA0kCMS5HB+7WSqBCIrg1cQ2V0UxmKnot2aT3Ni8Lh4Px7U/GZvEM9qWwRS5Bx9QakIkip
	QpxRX+a7y0Rm+o8mvAP6qZHwOrdSoBLMtVlej+JzatVnlq6Tl0wb+YYRM/t06cIOgku0ze
X-Received: by 2002:a17:902:d48b:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2b042d512d2mr5465485ad.11.1773678516811;
        Mon, 16 Mar 2026 09:28:36 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada5c760sm115860a91.5.2026.03.16.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:28:36 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:28:32 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260316162518.GB1767448.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com>
 <20260313083918.00005731@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313083918.00005731@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_092838_211589_D3C33826 
X-CRM114-Status: GOOD (  15.35  )
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

On Fri, Mar 13, 2026 at 08:39:18AM -0700, Jacob Pan wrote:
> Hi David,
> 
> > +config VFIO_PCI_LIVEUPDATE
> > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > +       depends on LIVEUPDATE && VFIO_PCI
> > +       help
> > +         Support for preserving devices bound to vfio-pci across a
> > Live
> > +         Update. The eventual goal is that preserved devices can run
> > +         uninterrupted during a Live Update, including DMA to
> > preserved
> > +         memory buffers and P2P. However there are many steps still
> > needed to
> > +         achieve this, including:
> > +
> > +          - Preservation of iommufd files
> > +          - Preservation of IOMMU driver state
> In the interim, what do you think about moving forward with noiommu
> mode without preserving IOMMU driver state? I’ve tested your
> vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works as
> expected.
> 

Just curious, are you using qemu VM without iommu device for noiommu
work or do you have actual system without iommu hardware for testing?

