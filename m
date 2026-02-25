Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC30EFD45F6
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 22:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EvlpF/Rbdy5yVGOyUM/AWdTkLEwWYWZDygf5cNk3LN8=; b=fT8uSDh59QJw9Fg+fMLV9v/XX0
	nAekw2CMcJC+JlnFJR0doyVmDqYHAF+jqtzRaAeTZDK5ufaTpwerRxJ2vzOqnAQRH7ng9l8zJR4+4
	vcB5GDbYw2r3NkVvYdFFiKt/07hKO+CnA3P5w2cEcP7NK6XxroX32x5P5syq5xvzl2UfR0toIGUdn
	MdxMVpREebg1PSJuSxPEfIbH+5KzuPwnb6ZHcbAmpVsjES8gXBLMD8pJAmJ4lM+NUqu18EpQ9p8Kc
	XFjCJpvZ4g5mACcbqJ6T2UdnPsBPn9lyQLl0Hb5y9eVi+KgOWX+8hADKTZjQPlr9uJzan8kIPixMc
	enszHafQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvNOF-000000050dr-0kAM;
	Wed, 25 Feb 2026 22:29:55 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvNOC-000000050dU-2COJ
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 22:29:53 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2a964077671so29535ad.0
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 14:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772058591; x=1772663391; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvlpF/Rbdy5yVGOyUM/AWdTkLEwWYWZDygf5cNk3LN8=;
        b=VdXcW0L0O8qFnBnmlaODfOY3rUgHpOTbFdX+tErgUOrrTge6Vv0WvDbUer9I8XM+fM
         eVig+Mw1Cd/lxQaB2GmMxC06H/wWoFaKbYVn4GbMWlQFBMeG8ZOuW5N+O3h2knGzXuAR
         8YfaGpjJnsXKQ0FP2c0KeS72mOBRbvliOvMj6qg94t5FvR0w6RyJ0v5Qx6sKeeZpmlm8
         hvdG+GbiI5JhEl7Y8MhnCBFADQaQY3BtiHrsZYryoo1UrjkKd8nFXiJJ8pJFqfXGb7Ep
         UxfgWg5HsWGd7U02L7AVfnkZz/IJnJkFb5HOUOo651JQ802g0FIdnciljkc+x3ga2CD0
         dhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058591; x=1772663391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvlpF/Rbdy5yVGOyUM/AWdTkLEwWYWZDygf5cNk3LN8=;
        b=KAnwkuEQHAxQMOI+xXGTM7LyW8I2ZJpnnAxre0zTrduufOJ+iGwpSJHwvy8xTL/X2j
         CHXuE/MpiKoKoBClJxMK8SWPXA9ikmWpS/16tMV22CHRxe4rzjBCoTh+tZdx83B2C46Y
         DPt2zaArnOFqeNXtMD2HCqgdntd9YZnUvtXQj1mu+MjLo724L5e/Wm0QNfZGSmwInQdb
         X/rkCaIsllQz6kcD4NfSd6DS252sHev6ASFIq9IvVa8abo59QR9qKpR8kmPEBXpfo67s
         VRCb5F7NpnXmQ4DSgtLQOrQpjb88HqflQD1vOvYLveGrbNUXjwIV8uayc15zTMM250G+
         kZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNnozkvLnAXXBlxtbMx/xU8TBKLJYZenkK4OxjRiQWWpuGLk/ZqcZS/O++9vRrpW2LjqSYLA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxjH4lCMQlTgkZBZYGV5jMMKPEvU0+B3JEX1zjY7lG8REn8mfQW
	TXirNgH73qjby/Xwl4QVmuGJkhlaiPYXrEbuKPuta0W+3IuVgj06/tjDDiWbO5pMPQ==
X-Gm-Gg: ATEYQzxN3vPh+uwhGACBwc+VkL2yGziF13yILNdMf5TRa/CmmIumFWtyW5eMAJCwTur
	Lg580ZGSHsdlURzHzhRGyh5K1qAg+jUd9KgSICmpd8qI1t1keRhl2yOnPs7BXH1lR80YL6QU0lj
	PqwKyqsTr0mVe+a2EpkezWSUOWVTyxH1GcQz/1RDDZJeDHI6/9WlscfqEqyS7yMHuOEF+glww6k
	OrQjgw6j5Q83Q0CSwPRAOQl3DnFVQKcI970Q7L+ypCR8leZqsGE36AvhTAQf4YsD8UvX9Wk4f6F
	T5dlPj7/TA1Rz3+HeKEnm8Y42keCMBZu436M0NFV0Y0/Ao5Az3CVS4s2pTZupSc452GYeDFaZSO
	bDinXmzfbRnUrW/R+rU2RR96IBHgPw5FhkPWmaomX3maWyYEahghIhHyCu3I9g66nCHG3tHBRNt
	ba//Yt73K9n+U8ti+/hx5z5mNdRXxiK1ml+6X13q6uh/I7ftaxVs19XGcqge/Mbxi9n8S2L+Q=
X-Received: by 2002:a17:903:15ce:b0:2a3:cd98:f07 with SMTP id d9443c01a7336-2adfefd95b6mr300155ad.3.1772058591084;
        Wed, 25 Feb 2026 14:29:51 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b2309sm2774685ad.19.2026.02.25.14.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:29:50 -0800 (PST)
Date: Wed, 25 Feb 2026 22:29:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>,
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
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <aZ931bYILhhkhW-Y@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org>
 <aZ9yWlcqs2b6FLxy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ9yWlcqs2b6FLxy@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_142952_570486_6E27C8E0 
X-CRM114-Status: GOOD (  31.89  )
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

On Wed, Feb 25, 2026 at 10:06:18PM +0000, Pranjal Shrivastava wrote:
> On Wed, Feb 25, 2026 at 02:33:28PM -0700, Alex Williamson wrote:
> > On Thu, 29 Jan 2026 21:24:51 +0000
> > David Matlack <dmatlack@google.com> wrote:
> > > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > > index 0c771064c0b8..19e88322af2c 100644
> > > --- a/drivers/vfio/pci/vfio_pci.c
> > > +++ b/drivers/vfio/pci/vfio_pci.c
> > > @@ -258,6 +258,10 @@ static int __init vfio_pci_init(void)
> > >  	int ret;
> > >  	bool is_disable_vga = true;
> > >  
> > > +	ret = vfio_pci_liveupdate_init();
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  #ifdef CONFIG_VFIO_PCI_VGA
> > >  	is_disable_vga = disable_vga;
> > >  #endif
> > > @@ -266,8 +270,10 @@ static int __init vfio_pci_init(void)
> > >  
> > >  	/* Register and scan for devices */
> > >  	ret = pci_register_driver(&vfio_pci_driver);
> > > -	if (ret)
> > > +	if (ret) {
> > > +		vfio_pci_liveupdate_cleanup();
> > >  		return ret;
> > > +	}
> > >  
> > >  	vfio_pci_fill_ids();
> > >  
> > > @@ -281,6 +287,7 @@ module_init(vfio_pci_init);
> > >  static void __exit vfio_pci_cleanup(void)
> > >  {
> > >  	pci_unregister_driver(&vfio_pci_driver);
> > > +	vfio_pci_liveupdate_cleanup();
> > >  }
> > >  module_exit(vfio_pci_cleanup);
> > >  
> > > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > > new file mode 100644
> > > index 000000000000..b84e63c0357b
> > > --- /dev/null
> > > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > > @@ -0,0 +1,69 @@
> > ...
> > > +static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
> > > +	.can_preserve = vfio_pci_liveupdate_can_preserve,
> > > +	.preserve = vfio_pci_liveupdate_preserve,
> > > +	.unpreserve = vfio_pci_liveupdate_unpreserve,
> > > +	.retrieve = vfio_pci_liveupdate_retrieve,
> > > +	.finish = vfio_pci_liveupdate_finish,
> > > +	.owner = THIS_MODULE,
> > > +};
> > > +
> > > +static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
> > > +	.ops = &vfio_pci_liveupdate_file_ops,
> > > +	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
> > > +};
> > > +
> > > +int __init vfio_pci_liveupdate_init(void)
> > > +{
> > > +	if (!liveupdate_enabled())
> > > +		return 0;
> > > +
> > > +	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > > +}
> > 
> > liveupdate_register_file_handler() "pins" vfio-pci with a
> > try_module_get().  Since this is done in our module_init function and
> > unregister occurs in our module_exit function, rather than relative
> > to any actual device binding or usage, this means vfio-pci CANNOT be
> > unloaded.  That seems bad.  Thanks,
> 
> Hmm... IIUC the concern here is about liveupdate policy if the user 
> wants to unload a module which was previously marked for preservation?
> 
> AFAICT, In such a case, the user is expected to close the LUO session FD,
> which "unpreserves" the FD. Finally, when rmmod is executed, the __exit 
> (vfio_pci_cleanup) calls vfio_pci_liveupdate_cleanup() which ends up 
> calling liveupdate_unregister_file_handler(), thereby dropping the ref
> held by the liveupdate orchestrator which allows the module to be
> unloaded.
> 

Ohh wait, You're right, Alex. I just realized the __exit won't even be 
reached because of the internal pin. The current implementation creates
a catch-22 where the module pins itself during init and can't reach the
unregister call in exit. I believe we should drop the ref when the user
closes the session FD? Additionally, should we move try_module_get out of
the global liveupdate_register_file_handler() and instead take the ref
only when a file is actually marked for preservation?

Thanks,
Praan

> I think we should document this policy somewhere or have a dev_warn to
> scream at the users when they try unloading the module without closing
> the session FD.
> 
> Thanks,
> Praan
> 
> > 
> > Alex
> > 
> > > +
> > > +void vfio_pci_liveupdate_cleanup(void)
> > > +{
> > > +	if (!liveupdate_enabled())
> > > +		return;
> > > +
> > > +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> > > +}

