Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48B4C5DF9D
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BkXJaaW+TN+H71o3YvS6+97ZT70d7rkvuIJkAMJWpDs=; b=yv9HppUnPEFSoHxCk2Zq66O0oS
	wthozzg3bBoPabUi0dKcep/NMm076PfAHufrH3kpWOwT5ILSiBKKwKRi0HU8/FJEu0aazg0JCzzIg
	xsO7DI2xv0yhGgdkT45smBg5P9Dpv7THqCY01TI2fk0zXaHJZKp2XL/3KRLVsEFT2WIgqXyf9YVcP
	6jncUOVwro7O/k6UEadbVcLEbzZyPSSdLtsn8BiER32abdoJRm0Va0+yWZTZ2feoaOomrwelnj5PH
	JSXzrjo1hiLOvce7lWFImsWzrycWnBZIJp0AwAreiB9Jf7qSBvtuS4k4k2ewLZdJQy0ZHFi3zLNcE
	zXTGe+Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyaxi-0000000HLDH-0bEy;
	Mon, 24 Aug 2026 20:08:06 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyaxe-0000000HLCw-48fF
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 20:08:04 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2d3b440b97aso4095ad.1
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787602082; x=1788206882; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BkXJaaW+TN+H71o3YvS6+97ZT70d7rkvuIJkAMJWpDs=;
        b=XPfvsSxm61XQ1QbKtI/GHIpmVuVW5s/atRGojgK9E5OwX8Ftsv4fgVlcGsjzC0Z73x
         CAF38QlP16uPkX59663V926EQh0FYYwbg92Fc2OkCZGahC+lt1E92iu3+/60Djhf7Oda
         6jsdjJQoAbXtmsNPEX3Q5RWje+y1p40ua0JFFnafc/4CQjFyu3ZHTNdKAZmX8x9E3q9p
         lUv88t8QOgRuateY5EWUatiSLLnGYNRlrFQHDCw3kOhquf0MHGV5PUa4FWDMaIgKpsN1
         ZaZ/ITLhcSoQrLZWPR82aC3V9cd3QGceUapoeYuMaZNrMChS4MGB/+U+LkTQvVGJcgj6
         2tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602082; x=1788206882;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkXJaaW+TN+H71o3YvS6+97ZT70d7rkvuIJkAMJWpDs=;
        b=a5qhjkCiltsfFKKhKUGoihukTKtQ7TgjgoWumm2rLm3EKfk+3BN1ifKSHhkSxB23KO
         vTka1vCNjU4n62K1DuSA0JawWNWT5a01B+nqHsldPVGNoAH2zzhj7oCNAZBg+ymtMTnz
         DF1RLlVSLq+EzD8qX0Si9gQYJiaR+mukszEif+qH0ibL5fJIHXRKy7YDRonYNaFQ2FAV
         OTsiFdckGCMB1NTjuFj3oa1LtzeP4Gw353TwmnfOEaPfMNRv9F/4AtR5RvDznCZtX/Mi
         blRr4BaKaI0P9iA/U5XGolsN2capX9rxpcEESoQexO047/muS0QN8VwJI8oQG+Lac1r9
         Um/Q==
X-Gm-Message-State: AFuF++n23Yfj58zeBbzZ96CtmuebZyYbrfsktShEHHJCZnAuKPawWuyq
	RbDBQkm+fClv225fV82AgAzBSLoP4HJVp6iXqZKj+6US0iELxbzmNvITgepsqlfdKQ==
X-Gm-Gg: AR+sD12ZSkVrpxx//IlGN6F3Fmzg/ajqzsZTYryXTCzVCPWU23L8hXW/ZS1HxTcLYsu
	C/8MoDv2l6zz20FLjiWCCylMv4pj9wD4FSDiNSRyMTf9T8xiIp+cshdhEXf0zpB3rNBO1dwwnYu
	hkxTpf9bJnzXLNDFz7b0oFKbubA65bp+M0Inwr0/HN5/TZigW50oqxW0/7/64HbfYEA1nv8BIgO
	3QPv1tbggBpkD/U5rQrtJ1tj2/9giGGtNTt/9Q3MlfjNSHQIhs+iDT1mkjGFQ/iOflRFRxxbTqk
	MV8idqVexrZ3/nL/FfVmbZp9P67ulyRoB8t+sAg8bumSQP5eKpwTreKKBgW9lTJod6O9LQnYUgX
	CA76ndB2SlZeh47iSHWJcNfrpU769Q9U9sGJG1swYNhIkF+XDm7TndpG4k6maqSeu7P5Z08jo2X
	sxK8wKbBaQlB9Msgwe/L5tjV65YEUVOEg51S0wJ0a5FD+V3alieFvsyzkMzzjB1x6A0hSfP/HjK
	HnhM9JTt+WmQFsI5Gb7PBDcwqCDC1rv88LVrYgMQ0xHVvXqNo2Nf6B7XwY=
X-Received: by 2002:a17:903:1a08:b0:2d1:1d3d:97c3 with SMTP id d9443c01a7336-2d6e088aba2mr1093055ad.13.1787602081412;
        Mon, 24 Aug 2026 13:08:01 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39642524ffesm371897a91.2.2026.08.24.13.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:08:00 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:07:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <aoykkgPM9UQue2qx@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-11-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-11-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_130803_030475_C32DCC74 
X-CRM114-Status: UNSURE (   9.94  )
X-CRM114-Notice: Please train this message.
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

On Tue, Jul 28, 2026 at 10:10:04PM +0000, David Matlack wrote:
>Freeze a device's outgoing preservation status (preserved or not
>preserved) during shutdown. This enables the PCI core and drivers to
>safely make decisions based on the device's preservation status during
>shutdown.
>
>Note that pci_liveupdate_freeze() is triggered by the PCI core rather
>than from drivers participating in Live Update so that all devices can
>have their status frozen (i.e. prevent non-preserved devices from
>getting preserved late).
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/liveupdate.c       | 16 ++++++++++++++++
> drivers/pci/liveupdate.h       |  4 ++++
> drivers/pci/pci-driver.c       |  2 ++
> include/linux/pci_liveupdate.h |  3 +++
> 4 files changed, 25 insertions(+)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

