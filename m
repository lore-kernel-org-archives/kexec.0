Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5780CFD9E1E
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UQ19nP7LWyVtbwlYCJ4KZaeb2FLacueUWULaQoURJXE=; b=1bYFxK+m1EUFCx3VJkLlAG8jxw
	gxkbrNaDToWKe1QVx7/v/AQFyqKaOTnALRAKYeiraB2gMMjB1daP4fNEVmjBeigSN9mdzJw3T+j9l
	dLC7S6NBg9bsPsz4sKCMVjVGwwfjYrLlXAvgC0FymdiLiO9k6toRaK5iAC5HNykL0vVz0YMip3BzM
	LejCfAJFE0Uwzwjf14KQ9bXluhUc/YcnS5zx+N6bvNgbxvkE6fNbDDymrSbX+l8h2PqGvGsIBOHBY
	eR98nDSQ43DMRR9zx3xywBGpp/X4fUpTWO4acsU9BbrykVVZ/jGEEl0gaVXFG4gIVAe1OZL5+r/8q
	IT9DAbEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvkpj-00000007Nqx-1P6b;
	Thu, 26 Feb 2026 23:31:51 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvkph-00000007Nqc-0dBM
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 23:31:50 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2aaed195901so7132495ad.0
        for <kexec@lists.infradead.org>; Thu, 26 Feb 2026 15:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772148708; x=1772753508; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ19nP7LWyVtbwlYCJ4KZaeb2FLacueUWULaQoURJXE=;
        b=J4CLUGm93u7vWQbnBnuEwNrnIqNcLWCmMlO1jOxq2exvVbiC6RcYHPQ3FYwe4MgQhJ
         shGTEkdM6XawLRV11f6vFvf5oZ/1EsoHPmBSXA56dzvcf+YsYyXFybnIN7Gesqe5OXVk
         jtIO3HwaMl5/VpmpB+1NLDTyg2ej04Qz98OSRVyEYGS57ii7nEr25Aw/9fzt8ZAOENsQ
         MGR8zvP6Bp9KB32zGh6/gEEm1A0km6dXlh9qQPWMd5LvWafZLNml/uBy/JrXLSEpwNGn
         xj1UIymhn1T1lYUh4ul+gdyuoY90wypqo0tStExzz+8Xvf5hNbbnMBbeZg4PMDFXm6qz
         mSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772148708; x=1772753508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ19nP7LWyVtbwlYCJ4KZaeb2FLacueUWULaQoURJXE=;
        b=r/qftMwnuF8A2a1Q4NO4HzcurfGhlBnWFfVkRI1O/Xd6qFlz0gbcia371y+w0WCe39
         MwkNbc55jgZi5wgLbpI8j7JGm7UOMB9gZSjZ7v0+vahxrsYWArWsIvBPgjlDw4KISfyf
         xnfv8KIpUW8Bc4EnS8VNu3qDjRP++9YWLivACjpoK1JYeYH58PaV9swpARw3hY2IGd11
         /YaIt+ulV1WlukfJrCajU3ZQ5aQtYXdMMdnysH5L70dgA7DfR5A3KUElNEqq46tzsGjD
         XAG8JQA4CU6NTnEBZOespL4WeQDunoY+BOCYhU20QE+PS0LcfAp6ugv+/kPcuzuKEhMy
         DptA==
X-Forwarded-Encrypted: i=1; AJvYcCW/3XDOTek/ckMU+vzlM0uRaNq4dtpV0E1IB7H5SmKjm2CZ/9MKkzIxyO4wwKyttTeuhDhibQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxaZJD7Y2vyuBbPC7QLqDFjSTwZQCGrtLw2PRLfT1odld6fAtX5
	6kY7iOmSIhue1gw3+uqIwnKRjNiIeo7ugzDKRVdrAsT7TgQKh4mgftlRwDZ39tHgHA==
X-Gm-Gg: ATEYQzyur/TR7wT82PxRP8nT1DGkVWy2T94A516ydPiKYzSY7pSm9nigXk058PZVdLt
	G3UO69pV+TM9b2XSHouNR0lTbQG5unqMyOVmLF7eey4TRpnsvhAjSN9gn/gF58QJoNJUMclms7+
	CmuFXzCOsKSoO3yZKZ34Y5Gs1BlIoAK45lXGi5WJdGSHWXOgdoprvd3S0GItDlX34cZzl7NaxOU
	6bdrWQqC5nPTGY3ZqqIlMTiH5CWVcl4oDUCJwUXSYXIUcctu4NWZf+wtvoE/LFXD4hv91vKfZyz
	+rYZsrPRvNUmvleBmvQtWKE2RNIBzbROhJeweAxh/6VYQ0SgRDwI7zwwgC9Uf+t3aYbl5FygklD
	Ec9HsckUcpRw0McMKCycBM+rMFT1mB2jRaxBWeXOGBFBcI2+Te5Ttz+JWRdDBAJI2sJEFEnZw0b
	DzNbVJs7LeYSQqNBt6vjuLRHbePDB4y3+wgkZ7+Ne4Q1FFxJByU5CCYIJ5A6yiTA==
X-Received: by 2002:a17:902:dacb:b0:2a7:919c:34c6 with SMTP id d9443c01a7336-2ae2e4cd74bmr5371545ad.38.1772148707814;
        Thu, 26 Feb 2026 15:31:47 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a0432sm53850525ad.52.2026.02.26.15.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:31:46 -0800 (PST)
Date: Thu, 26 Feb 2026 23:31:43 +0000
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
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
Message-ID: <aaDX34yT_3dwUi4I@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-8-dmatlack@google.com>
 <20260226160353.6f3371bc@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226160353.6f3371bc@shazbot.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_153149_188640_6351C597 
X-CRM114-Status: GOOD (  14.88  )
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

On 2026-02-26 04:03 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:54 +0000 David Matlack <dmatlack@google.com> wrote:

> > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > index 7f4117181fd0..ad915352303f 100644
> > --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > @@ -53,6 +53,8 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
> >  	if (IS_ERR(ser))
> >  		return PTR_ERR(ser);
> >  
> > +	pci_liveupdate_outgoing_preserve(pdev);
> 
> Why do we get to ignore the return value here?

Ugh, we do not. This is a bug, thanks for catching.

> > @@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
> >  	if (!liveupdate_enabled())
> >  		return;
> >  
> > +	WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh));
> 
> This is propagation of a poor API choice in liveupdate, the unregister
> should return void, it shouldn't be allowed to fail, IMO.  Thanks,

Ack. I'll make pci_liveupdate_unregister_fh() unable to fail and follow
up with the maintainers of LUO about liveupdate_unregister_flb().

