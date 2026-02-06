Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B8AEE6B6A
	for <kexec@archiver.kernel.org>; Fri,  6 Feb 2026 23:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xORO1Htmm6YxNYM1C9oAOOlxqgAaEPMiLYXG8QXy21k=; b=lDHCi2nOZHbE9zQ+gWumcHEyxI
	wN481dLmzhWjQ4HaLybkI1OlVSx3we99q0TRUAp0nIG6BRwCzhearlbpTQL27Xj8kX/akfWJ75RC7
	NSA4q/i1qH2oDB3dCjQJHINgD67AeqtoeaDZNFm2VcHb8ZEeaUuKTPOVOUJHEitHTO3/ixd52XJlj
	uiEJuF1fi7vzonkeGW3MTEboh2F7yaNc0rFl30SLsXzCRFfpBtgaDUG+W+ln4yFoCbtp3KMCWt7IT
	czq8rq7MCG/rpurHGsHbfp0kyq1KLlIvTnqJ+YpXL1LSU7d8h6uGo9Q1c61X+tjeIU0udHhUbTmm8
	7ZVM3s/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voV2P-0000000BuPJ-1ga9;
	Fri, 06 Feb 2026 23:14:57 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voV2M-0000000BuOx-2Wea
	for kexec@lists.infradead.org;
	Fri, 06 Feb 2026 23:14:55 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso933366a12.1
        for <kexec@lists.infradead.org>; Fri, 06 Feb 2026 15:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770419692; x=1771024492; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xORO1Htmm6YxNYM1C9oAOOlxqgAaEPMiLYXG8QXy21k=;
        b=XI5NK6Z9bkrV8iG9tqeHYsxQlj8PI3OmV9BRNazCwEV5UsvQnKRoTpTLcONsdcFwrm
         AeIZrCZcImWbbqVnMTQ3xplgghvULVdZg9snVIsdZGDcxr215NmuV+pjyW29SpqGkHiz
         0FKraU4LptYKgjLlgBTQXshcOpznTDVX/Ov6vGLca98jo5d/UjH0pTE+yeTOg2HHkuJ7
         3OL7z24agHaq5eXp8H/mbFo9BihRgm2t2R86uicET/Q4al8CUKGcFsCAvMzezdm8gY54
         3ZzZpHODAuAzZJ99fJyQOkUGLlDsQBvZ2NDxeyAqdwO9z5hBsrsjjyQhQuq6iY5NhqKS
         oJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770419692; x=1771024492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xORO1Htmm6YxNYM1C9oAOOlxqgAaEPMiLYXG8QXy21k=;
        b=pDzoSa15R99GhDeZolvItg7afJMGZZP7wYVpkrkRdeUjRpx4EWlyBsCnn+Odjm1LEL
         WsyY7CPSvjd224dGdTudiLvAsTv14VW22hCjWia6oRpyXmgkk8U5nCSqClwOlv/r9oN1
         eEVL8aEUc+d4h/gq42pWAT7mloGJQI4WLEEL7W2l5sdQtzg/wOAGGEbHVkN8Rn/+g5nN
         diBeG4FvF5Gcpxon4cMvx87IBbzA7FDV+e31dPcxB7FE7QgOBG7GFzPcetH2EvSVNlG/
         HU+4TfKV8nWubH9hJGPi6gv5hy9uMDDAq8jhEIae2W4zfFT/x0tVoVrL0AlQhAwDmR/7
         mf9g==
X-Forwarded-Encrypted: i=1; AJvYcCWlS4RJ4Lu574Q2z5sb94SURcqisBBlrt5Hc5n0RDmmaxCtgRYnKy1TIQKbZzIi39Ib83TBfQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yym9NHZM4JBa0fyGVO895eGHq6OFcEc8n9OxzWefUk6upsT0Y8S
	y4EvQw20ZZ8K+iZyaxmSA/Y0s1r/6Aqxd6wtDE5f/hZH+T1HGK3wQ6h9ic4ETzBp0A==
X-Gm-Gg: AZuq6aJHZZXkme2em+IPvEZHeZpc2L/7r26Q9L0+u4oHF08Ztb+vWe3GQag977qgcG0
	ScOBCKfZoUk2ruKT3OSWlb9JediUCCjquzOPV17+AtqAoG4WT6D4AECfer2/pdKS08/gl55l7Ct
	Vs9j/foxUhtlu/ujfXBSqDhekee3muk2y/nW/8aGztKsnzHmGNaBdrhXvDerluKvaNaDUDr0xdx
	XfBWHZMVFNHafr+QiLb40rCI8z6lBMrTR/mc7UzAJjF39fWTvIx7umL8orUnMEaiwxox/VyIbGg
	oCMBTCT0HgxuzHPoCEppX9DpXxaqkku6OKXz/wPSZV7SJFiDyg1ffBzmf8VsEx5JF1McrsrpzMH
	7r3GRbhUJZ6xmt3iE7Xi+aXHTjZ325K+jKQO/gE5Lx1WaL3btQ/xrR1qlUwQuHOc3zaKd31n35I
	kSp/rgFsRkaia+Fd8vGkKlkIftaB4sqjGH/KZZDW6XsaZbZbv5eg==
X-Received: by 2002:a17:903:3bcb:b0:2a0:c1ed:c8c2 with SMTP id d9443c01a7336-2a95191f76emr38694515ad.55.1770419692202;
        Fri, 06 Feb 2026 15:14:52 -0800 (PST)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521eb87fsm33865195ad.71.2026.02.06.15.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 15:14:51 -0800 (PST)
Date: Fri, 6 Feb 2026 23:14:46 +0000
From: David Matlack <dmatlack@google.com>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
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
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <aYZ15u120FEa8Qw2@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
 <6dc423bd-36e6-4f97-b2b2-c7030575a3a1@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dc423bd-36e6-4f97-b2b2-c7030575a3a1@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_151454_647424_F63CB933 
X-CRM114-Status: GOOD (  12.14  )
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

On 2026-02-06 02:37 PM, Yanjun.Zhu wrote:
> On 1/29/26 1:24 PM, David Matlack wrote:

> > +int __init vfio_pci_liveupdate_init(void)
> > +{
> > +	if (!liveupdate_enabled())
> > +		return 0;
> 813 int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> 814 {
> 815         struct liveupdate_file_handler *fh_iter;
> 816         int err;
> 817
> 818         if (!liveupdate_enabled())
> 
> 819                 return -EOPNOTSUPP;
> 
> In the function liveupdate_register_file_handler, liveupdate_enabled is also checked.
> as such, it is not necessary to check here?

Yeah that is a bit odd. I see that memfd_luo_init() just checks for
-EOPNOTSUPP. We can do the same thing here.

