Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F08AFD45F1
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aEWfuL1WgCP/eH/o3qO74sPfk+Pg3+xsCKw2mq2gLYE=; b=D4yxGylV2SN1xkGqmF5oSuWRaK
	rkz95qcMxa4SPr4ZZy+AcfIHHrrpAMMnKQHF65SkU92swfTE2H2ofzwFzVrhe4AZcdkwVR9L9cacE
	zajSytHNKtefcS0jS9kEE88GnqVR9nLxE7oJPkmUN5LvXH9ramGx6oaOAvUwrVk7lcNEL+VK4ftUs
	E9JwrgwGKFM/dnH38wdPq0i8W4uoq30RCfjkF2N49OklZOt2a0kJ0zXtX9nHkQ9Xr5kfQ0C1yBQX/
	15pXmLkWP1/ooyBprTY1EnWBJBgdP23zgs+1pTMj2mMPRV5pB/dt3VRRdygFtoxErE5kbyGrb6Xte
	YnyPLsyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvOB4-000000053s9-0RG8;
	Wed, 25 Feb 2026 23:20:22 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvOAz-000000053r3-3Nxf
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 23:20:19 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-81df6a302b1so327285b3a.2
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 15:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772061617; x=1772666417; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEWfuL1WgCP/eH/o3qO74sPfk+Pg3+xsCKw2mq2gLYE=;
        b=u7TDajfC+DQPx742BBfKfypE+OxLaKqnopbX05Pn4PhZrB0dLIcLUXK9kUmpskpuNA
         Fuhq0CKU8drAVcoEc+V2knCZD1eX/LpxGCX2jwkpKsAtk0FeJCy7zI5YNHYT/aycnUUg
         kev1pMn+DgXlaG0OHrFh+mHjHg8cQpy0AxvoZodBQFYUAQTwUDHWRRh7UpThRVcWhHxn
         ORLYdMbxTH1+J5bds28JYspiRg0F1oQFOFc8sT3/rFkpluEs0F0kVgeTsGxJBp6BY3aE
         ytYIFi5cvJILjcjBQqJ6koqVE5EDa8jt44ulbG2EDjnJivUeglgPs5Zbax+ZSXd4iYOn
         AbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772061617; x=1772666417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEWfuL1WgCP/eH/o3qO74sPfk+Pg3+xsCKw2mq2gLYE=;
        b=bPTR9OtEoYVLDMKbu3QVxW2mQDRS08MY5RZS+YoufMSbXaR62bp+hCg9zz2UqueQZy
         fZBFSALuDtkmFk/R0aLmzspF+EIoWED4X8ZkWQtqx2yUykLH/ECLcgtDIusQF8rUpKK9
         nBYZf380pyFJlTVhzhy4EKkfGiHBLuZgcIw7Dl6EW8F+nbXe2U9Z5QBbgN8pw3MFpKp0
         oLrKEe22n8S13h3UA+OWlZOm1rtyNrMTVRI6TwXB5D8LoRz8SjG7ssFZXIXQW+UH3T+d
         IgQKrBuImSZk/36L5019ooKltXo8LU0EDkItMoMDEBheaJfc1sS4ppPpobVam3Iu5LmU
         H9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp+GayEnqw322ccennY7xydSlQ4M7afvy10evm4Ok1WhDy0GyLeWmWNFLZ5wIRlNJ84Xd3gw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1M5IZMQfdt8OB7c1PYCwMgeK62wtMp5/TCh7qdEa8ZxY9DrdP
	jidgXpErUwE9HQQvfiq5R0TlQE4EQ2TuXVorD383uFY8qNLv+FHZ4ROpfpxm/64/hw==
X-Gm-Gg: ATEYQzxdc6tHs+FzKP8tHSk0tT5XXiUrFwosS1ovxhEOs9jqSpL2MrUUYfzjA6pPLGS
	EzKl++Ubdzg3vqHsEzimFPbslK7vBDj2EBp6betujAl7GshF+UnOSZjQLrerZYN9cXQhGx30vf7
	dgbCa6Yu23YwGLkoNOGYdjP0/sLzjjkmU2MjMS14tcsMsL8DuuATJ8Y1c5BASySo6CNno1eRUSz
	teJRaRNdWBc2QP4kZprwmZFVjPFh46zprGhNAw1hTGY1kzFyacXPPynfs8UDZRF8xlOiPf+2hJO
	yzeMxfEfr+MrYkIebxVyAtjVOqU8ow1rSDu8VxP0A+Ra8b2nq+nocWkbwbnH7GVZDQaOvHt5Erm
	loluTju8qjZqyOAaIe7S88u7FkzksD3o7fS2Yfb1eCWthmoVdVBeqMZR3Af+/LB2JexZBC+ffH8
	akjOBocRo3Jbv2YzqlwLyOZcB7bclHfcANu2+hPu29uS0Np+Bz3qVMQzwjbQJVKg==
X-Received: by 2002:a05:6a00:18a7:b0:81f:852b:a91c with SMTP id d2e1a72fcca58-8273390dcc3mr1547131b3a.64.1772061616376;
        Wed, 25 Feb 2026 15:20:16 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff37f1sm347240b3a.40.2026.02.25.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:20:14 -0800 (PST)
Date: Wed, 25 Feb 2026 23:20:10 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
Message-ID: <aZ-Dqi782aafiE_-@google.com>
References: <20260129212510.967611-4-dmatlack@google.com>
 <20260225224746.GA3714478@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225224746.GA3714478@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_152018_221632_2F8CE59F 
X-CRM114-Status: GOOD (  14.59  )
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

On 2026-02-25 04:47 PM, Bjorn Helgaas wrote:
> On Thu, Jan 29, 2026 at 09:24:50PM +0000, David Matlack wrote:
> > Inherit bus numbers from the previous kernel during a Live Update when
> > one or more PCI devices are being preserved. This is necessary so that
> > preserved devices can DMA through the IOMMU during a Live Update
> > (changing bus numbers would break IOMMU translation).
> 
> I think changing bus numbers would break DMA regardless of whether an
> IOMMU is involved.  Completions carrying the data for DMA reads are
> routed back to the Requester ID of the read.

Ahh, makes sense. I'll clarify the commit message in the next version.

