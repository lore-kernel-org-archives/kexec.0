Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7971FD45FA
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 23:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+aqTMCmmaBlC6BgaLKDJu82UvyrNA1bTtUP5fONJU9U=; b=ru4ktNU/us4NcLVZiZFx2jIn/k
	oxMimxqaySG93QtTK+u29RE146KLr5n2jVg7FOXK51At+bsFUsQM2efDuhFm+MINVKNPbZj5Ku5kS
	9fztTSO47KxKkvPKjgdHGPR8NeCgP19Uxwy97D9VbZrOhN6vSIIdgRdLlXXnu+gack27A0W7+tptF
	5E90agpLJ3g6z5x/jC6xsQlZVMeaWcU7ZWRIUvL47Gw/E3+C6VLTt95ENdg3Ayn4n09Y9v3zrjvzI
	FoG++FYArLiqnhUdWDEnxaxSBvng4/QBoW4hCXpghwwKIdcH2bTQBWPyDOMb4OSPdE739/hYIes/5
	iAnIZ3uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvO6i-000000053OM-3jWp;
	Wed, 25 Feb 2026 23:15:52 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvO6g-000000053Nq-3yem
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 23:15:52 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-827307b12dfso114355b3a.1
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 15:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772061349; x=1772666149; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aqTMCmmaBlC6BgaLKDJu82UvyrNA1bTtUP5fONJU9U=;
        b=pGZzSuvlDCTeyDaYNWJ2xtCNXwg8KA23CEB8YdRQsSycuYGqozGxMIp5EZKwsHFypG
         hW5sk2xvc326eUNfF3ydFKBtARxhKP0y3WBug4YS44rKUN8dY9i8/AkqfPFmA/gilucR
         yYYj+KYYojDE3zESIRuzaPgj3pAUQmFlX7IhtxCb3N0QJrIOcVyWruW9oVFtnZGl6+hj
         iniw0l0QYwhyFAzWGuOZG1AgZtMZAlJfLvTffeWIGdVEiJKl1qJWqXHUUq1QGB7oKtNB
         Vo+B8okEnVOKERWmMG2F6HVFTqGpoTZ1DgRQeLr/9mtrtj8kTHx999H5gUKR06jEwbed
         YY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772061349; x=1772666149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aqTMCmmaBlC6BgaLKDJu82UvyrNA1bTtUP5fONJU9U=;
        b=KYzJ71AzOlSFZ8uSPxpmgIkYmLBTcNU29HXsv6rPYftP4GMt0K3n70nMdfZQZOJNnk
         UXRb20uNV604jmrw+gm+8uNLBr8mKTHYPHnTfiMD2Kytkn+gM6xjRQgE41LNMPtbRGH2
         TIi9dyOYp5ZmwPdm7RmXb8UP4ljdyTOZMJKlRYKI88ZmRZaoKgWh1zhwYfGbB3mF/gN7
         6kJP+RkGNUcgJcxc2xEd8iUfna6d3mo6g4vbMTV1WnyQBgDMZV5sC5YF8h0D6A4p2qPn
         J+AcX6M3ZxQVhKS+qjN6amjuODgtnz0Jv8qazigiifJvx3Nc/Yrq+g5S7riVejOirf5G
         frjg==
X-Forwarded-Encrypted: i=1; AJvYcCVEN74IJZYsVfGZ7vaDduJuVpeG3AqIab4dHmUASmctvGQdZh2WZB/OiWXmsf8lQTr/57CdAQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywc2iNj6UyGVGUUyfCLLBCAQYnJkkcivnNGKkaUlIxwdzbiuPR2
	WyL69dutzm+gyqrkY5qsaDCSduOcQNVmzC+jCUgHbFdnAxcLNoRjxfwNf4S95Bnr+Q==
X-Gm-Gg: ATEYQzwH+ekAs2ROcNjHmzY6MQhPK3+dS0XUrRPk5wcD5OmcGB/7r/yqThLZqw7V4gV
	/NRL1QG4hrBPqKyrj1Q74xlW//mLPud9exTaGed04iAZnZnRA3l1kHgdY9GfEHI9g3qwZNIhwBC
	oaMvzOv0xmDEHIRg0syXYlPeVqvV/GFmpitEorqedEVdSTFM0eGKfYbS6N3qZHe2daib/hpgpoO
	76nplhvKFbl1ylZ7xsHDCCRlHf0jF6mN3WkgrvCeMwQtcPBlrmExbl8D+Gjb1OpTJ6N04Xbdigc
	lrNIKuC221HyExq3GScMJPIrYTAjGALuMSN3RYFSObBwcc1Wm+djNeRg4XEpx3rJu5ZTO+afUcE
	GbKPNc00KIkl3+6h6rvbXOpx52emGk/v3HevgQQxtD+8zpAmGP9l7LHij3vPni6yO7+7q4YHblX
	gT3Ho0KHKUizez0jXD3u95tRRTNM+UOiZlZRf3+S45GW1xz7A11ppmHgIKea6ZVw==
X-Received: by 2002:a05:6a21:7e0c:b0:395:46aa:4467 with SMTP id adf61e73a8af0-395b1d39ecdmr623014637.14.1772061348571;
        Wed, 25 Feb 2026 15:15:48 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8479aasm89953a12.31.2026.02.25.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:15:47 -0800 (PST)
Date: Wed, 25 Feb 2026 23:15:43 +0000
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
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <aZ-CnywNgMnr6f1k@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225143328.35be89f6@shazbot.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_151550_985879_EC39B51E 
X-CRM114-Status: GOOD (  14.18  )
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

On 2026-02-25 02:33 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:51 +0000
> David Matlack <dmatlack@google.com> wrote:

> > +int __init vfio_pci_liveupdate_init(void)
> > +{
> > +	if (!liveupdate_enabled())
> > +		return 0;
> > +
> > +	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > +}
> 
> liveupdate_register_file_handler() "pins" vfio-pci with a
> try_module_get().  Since this is done in our module_init function and
> unregister occurs in our module_exit function, rather than relative
> to any actual device binding or usage, this means vfio-pci CANNOT be
> unloaded.  That seems bad.  Thanks,

Good point. So a better approach that would allow vfio-pci to be
unloaded would be to register the file handler when the number of
devices bound to vfio-pci goes from 0->1 and then unregister on 1->0.

