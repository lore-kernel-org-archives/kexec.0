Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F786CD8C9F
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50OC+dN1N2saKp65EvIeh5RVBrO21QC8rtRPxTXYSBs=; b=gst5PtnPDe49bvxR5Acqrv1LK3
	KHRbvs9pD71n5shYa46C8ZnBMvyW4N+orDPzjqACR2PR6iNqHVfyCLZMXXwvhX2p5QokaEZbqkMci
	NFK1DZKqCT4WoPwAFNxPp20JLDYui2T3ZM56aG567AdhbYo54c1RWpajNMx3FrGG7oHVG3gOSezkJ
	IGlswD/QqwB1CKC/a9PmdzQLmTrcHWey5dOriuIivbNbY3QtZmd2z5EL1n0XqWx2L1bV0wa4vy+BR
	slcgMXoak84gKgKYrnC+2pKJdRowkw25qWCzjAiKmlEJYTpyz1eI2sZDu0onHo6AXY2nOsQb+bD7V
	BKVRL4Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYSY-00000003ST4-1rXN;
	Mon, 08 Jun 2026 11:48:02 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYSV-00000003SSj-2qGa
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 11:48:00 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2bf2d865383so301335ad.1
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 04:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780919279; x=1781524079; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50OC+dN1N2saKp65EvIeh5RVBrO21QC8rtRPxTXYSBs=;
        b=BBfFG3ic0Gdp1zfp/uiaA8CEo5+eDMYJ1e3BN+6CQVGu2wucnv9PNa9pM1s5vEPEnQ
         s0MI/0oBDy808KOz5Eko+hMILbSVZzq+rcA2HTrmv+W3nPxgcc5pO83hwdNNES3nhO+R
         6TuVjzP4pOcSswh8EH19F4PwA8FuGc1xYll5pANDRdLzCmu9iu8rlEMV72TpmtA3p0L/
         wmOwXikGO0pnZWTzQ8VZmutXt4AnRCflDAEoBX6DnW/Te35gLsLuWaRRbJX76UGgQESO
         a9iZ5gVDpcvTOfgpUi1Ht6tRKl0TVvdtH6FmY+nmOa3+E7XMRtXvT2f4RjOHqnQHzWYR
         gKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919279; x=1781524079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50OC+dN1N2saKp65EvIeh5RVBrO21QC8rtRPxTXYSBs=;
        b=QesxR+UoalnzKgZVHPv2XOZgORkmXT4Lwgde05sa30riM0582DfR6Y7Edsjlo/Xpy7
         e/Ro4qrvureJfRMJ/YTuORlqv36BJAH8ERy/AgDTUNbkvbKBPAAWeIX0nKN5KJCqwGoP
         j34GIq0ogfHakOTG04g+HUXJqJdHFQ+7SX+fUPe+IguARVX3UmoYFB1oFi57UhQaSgMk
         s0O7MsB3fNJRmkiuhK1ZKoHU6guPsMWOmgtQYOy30dBt20gXmL3+sknzVUhJYN7eb9yJ
         Ty1hdl/lVTkOGT78p2yRxUx6y7nAfX0Ze/pZfBcU5p1bIugddeA/0Dre5E01R1GLJNMP
         ymWQ==
X-Gm-Message-State: AOJu0YwlRd3VEY0m/Xz7tReQWzCBEU/GcSQQl2QvdDEUEI22R5N0Ste4
	2eIW0JzHATPhjYf+CVEbdBkU1EP/Jh/f2gFZQfHWR6+vvS9QT+dLEjxbC6QsE8eWmQ==
X-Gm-Gg: Acq92OGERZvJKdzkB52tx+ZavL49bivktFi1b1l0USIzcoiyzM1/A5war1dAsiCY3SB
	iQ6qTP+7pUi3DYUrPcZaHU6LohQ7n7eieAUZG1Z9sY41+fhRyf2ifLetmatHRMlV6DEiCx11W6S
	3iZ2FIonVN2+l1umkYYfFdi3tnN3+h25OypLymscuL46vqUaV/COJoUXtyhG7ThoEOb/FDFodUR
	O7BJXnCEMGxzGLXdaw/zbCM4Ayz09ydd+1G/GoM5kIASxdv0owRgYlGT2AwhM7cla2B/gM+zxi9
	g2Ge6TbageQi7bx5O+u2qWvAt3K76vgxxWX9NUNHDEkc7s7fx2hT1SobEQntovuqWEagC1jIr9v
	GsoD+GiBklE5EY3/kl/sFAdWB2QGAv/WdBUEbd/x3/UzC/yHzYIW6QJjWbcBw3opbKCDkSACF6g
	m9LWZlJQ7tq8C7RCzayLR54alo6oT6hudb1OEmgc1ugmFf6BYUUj1Cv4UaDgG5fRdkUz54ZGs=
X-Received: by 2002:a17:903:2349:b0:2bd:3c1b:3073 with SMTP id d9443c01a7336-2c1ebea9c71mr4332535ad.16.1780919278196;
        Mon, 08 Jun 2026 04:47:58 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm19158424a91.1.2026.06.08.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:47:57 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:47:48 +0000
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
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <aiar5MyWymrLjQjA@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-11-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-11-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_044759_716169_6F754924 
X-CRM114-Status: GOOD (  10.37  )
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

On Fri, May 22, 2026 at 08:24:08PM +0000, David Matlack wrote:
> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
> 
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

