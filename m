Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCE0CD8CB9
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 15:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UyfvIUyYOvTVt/UpRIulwDCiz4s89QiTYmiwF1UuTbs=; b=M3wW6Tt/fwegL8YefQPeI0Lj+8
	1WpudIP1T9z0MrpZvedYHzV3e7EMQF5RND1IJQnj7sa19r9EdJ6hsAIZ1hNrptmp7qA+nJvI77h0k
	+Qbj6yzGe0Ni+NGBdBarTN+J9v18eO49QRZXymgevLZPJp8gMZw/NbUkRaPc9Q2HRP5MvuV3ZdgAF
	8spVIb/osPCxKm3ukqGspEzSthbAKULstCHn4yzwvoTu8zz3ZdgJjmzWM2DwZvzXxxMjpZ5Dnxk6q
	m6d3LdhUA5ax4MZi5voPXHCKe2XjLYPmsEmgioe+qSA+mJAoSy374J+fWB2bB83PZyIVD3qk/rCPD
	sAdEwQJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWyTs-00000005w5J-48Cm;
	Tue, 09 Jun 2026 15:35:09 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWyTr-00000005w4v-0FUj
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 15:35:08 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2bf2911f93cso448885ad.1
        for <kexec@lists.infradead.org>; Tue, 09 Jun 2026 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019306; x=1781624106; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyfvIUyYOvTVt/UpRIulwDCiz4s89QiTYmiwF1UuTbs=;
        b=gE7Yd+IYT+kW6T9EdNfwCTawFwLZrIEzk1BpuYfTtOR3qmqwBHmT1Qq0hqkF0+1TAb
         0303LmauFeNWfo0D3yZyLKTZbwhB73Iipn5I2LyHQh8GyWaCFl9WqheSBWeu8gehf3im
         2UNHuDyBylE4WGAIdTqNNCYM5KYuN6A/xv2GAQeqvaOoIyM9Yr9l9rlTD3tQoLLMmBrt
         4FRZLS9r2mXUeJOnj//9BJ0fxBPQrKrYxu48Z/EC06/t4i8CVAvSxcL60HQVdDLYNnxO
         QX2SqhN8+Fc02tUriGItaHaL/TuxUL+j4fXVaWgl2YGTnar74dEbivaLY/zmkQ7Yf43d
         LpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019306; x=1781624106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyfvIUyYOvTVt/UpRIulwDCiz4s89QiTYmiwF1UuTbs=;
        b=Lr2s5VExMsuj/C+8j8TYyDf+bZaWzcukFQxNO6f5vmYidf9lPDXridN/W/ZoppCGOL
         dHLw4U/IizhxVrEqTo+cNOUVrysmZKVI+wtEg3l5sWO9zT9SGUufBA7mWMJK1Agzp8iS
         gHEx0EEezA389qfm8f5eJe9AOSK0EgHgBfsllgBYDK7f7n+fEns1WhMLfb69u2wlWJf9
         sveB8ir0o/Flav/c5weMszpiYuGv06Gfcb3o6qjjxRwH5pO+m7xDQN1x1BaDLvQ0Sv2S
         8vufmRD/XhhPNLEKXmJnXaqGlXbC+8ev+GDvJguTH9+xBPc1ca2fNfbbOk5jnn/JcgHI
         i1Hg==
X-Forwarded-Encrypted: i=1; AFNElJ+gWwzJfcku0XJHFixQPxvxqxFvfKkfg9lESzt6uqIot2JQuyqBS+fedxkywzbuyVIh4E2CUg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDxN2zkX3VNqcWmviJb5PCkDyX0c4XD1xAUCeYWh/Guky5cY7I
	VzvAu9JCBxUb3COO3NPocsTj3xWUoGBkYd7sjhRjEHpLFuEg4aFrt2u2dayGJ/Uc5A==
X-Gm-Gg: Acq92OExhCDm+EgsoluX0Xw92SBcICx+5TEFalZeIX77lze51NfDu7Xk4miEDkqURys
	yHGe1Sm2KWZJMRb78OvxSXDHm3tpymg6T+zYRDsRWFuNMoewYyt4I8RBVCn2F/fi4WEAk7J3JR+
	JT+dEoHK4POdwDenchsWTJVgtAP+peW4P05OmCjRaZ7X8iGHWWP1GhwsPoISOR3TkHZd/XYYNHQ
	h8JR02q96ZjgUfxmsG62ZcVVilbSHVe5MuNoP1TOWxAAPQLnUYxcM+1FNToH43PzBBav4aob1CL
	ZrlWW7q7udTAYpIVxK1arNoqHsVZPC/1nj9oMeZTHqVKwwgT2rdZZr4zxlDAaB0M6T0+OmBD2r/
	kM3cOj8ymlGQYvsVVZ7dMD2DDBqJeu/Biz5xQIdQwJRHxrHWyvVKYqO6RBVHRitqg/OBezcvr0c
	dEpcvh4ruY4BHLFNzf6Z/WFZ+wPozI1XM+wOzGowTB7o95Itfs5Cm4U1ltrjqAZh8NffGjHX/wB
	EHAIFcMhg==
X-Received: by 2002:a17:902:e885:b0:2bd:7e8e:ad56 with SMTP id d9443c01a7336-2c1eafba702mr7653595ad.6.1781019305283;
        Tue, 09 Jun 2026 08:35:05 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm24737580a91.1.2026.06.09.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:35:04 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:34:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <aigyn66-xQ_9JBW6@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aiaeOVomxQZhoM3K@google.com>
 <20260608181640.GO1962447@nvidia.com>
 <aigtS3UDdhUGp3m0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aigtS3UDdhUGp3m0@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_083507_176248_728CAE3D 
X-CRM114-Status: GOOD (  20.13  )
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

On Tue, Jun 09, 2026 at 03:12:11PM +0000, Pranjal Shrivastava wrote:
> On Mon, Jun 08, 2026 at 03:16:40PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 08, 2026 at 10:49:29AM +0000, Pranjal Shrivastava wrote:
> > 
> > > My point was that a FW exploit can meddle with the bitfields of the
> > > ACS_CTRL to spoof and mis-report the ACS flags.
> > 
> > Devices can also ignore the ACS flags. I don't think this is an area
> > where we should be worrying about devices being actively hostile.
> 
> I'm wondering what happens if we preserve IOMMU groups across a kexec,
> but a switch's ACS capability is dropped or the ACS_RR bit gets cleared?
> The incoming kernel assumes that it's the same ACS cap from the old one
> 
> Now, the incoming kernel restores the groups assuming they're still 
> isolated, but the hardware no longer enforces it, silently allowing DMAs
> & breaking isolation? 

Again, to clarify, I'm aware that we aren't preserving IOMMU groups,
the incoming kernel has to rebuild the groups. My concern is that if the 
ACS_RR bit is cleared during the kexec window, the produced grouping would
be different than the old kernel. What happens if two devices on the
same bridge were assigned to 2 different VMs?

Thanks,
Praan

