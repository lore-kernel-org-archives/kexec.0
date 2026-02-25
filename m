Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058E6FD45F8
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yKxFO5jbcj0n3yx3uCDHTRhkwPsNZ/ADjqKpvoexazc=; b=EQWwu+4RtHcj8h8/2IRLDUx1QP
	/RvTYKczVB8UFPbcm44lzTjlonutgyDFShfBaW4/xIxLtKumLWL8fO5kedyZqE18ks47iIpi+Wjpp
	kpF/RTSPHIgbkrPMNSF3xD/c2e6lQo2koIkXfCAfyh+dW3SUro9HZ0B2as1OP+BKcOKB2umdjvLCY
	GrjwFm0N9UZJhek56onzVg9Qh1rnho7YGaqIkHip042D+lsYn6HLo441A/A7CLx1qY0lVqGyPfqES
	UE8mNZhRzDOQIEoihr9F90CMzs5zQUOUZH9F/W796e4tIKBF9HM+fYc/Qwi4zYdTxhCGIWkwRZN6c
	GFGBtngg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvN1d-00000004yJU-1sFs;
	Wed, 25 Feb 2026 22:06:33 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvN1a-00000004yJ9-2euG
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 22:06:32 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so30615ad.0
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 14:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772057189; x=1772661989; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKxFO5jbcj0n3yx3uCDHTRhkwPsNZ/ADjqKpvoexazc=;
        b=KI21p+u7GRMPeQEk1bR9kAImGsAYSw3zAhM79q7FbfN4591vKoaHDFW3Ux7A5kTiDs
         GmkDyD/fGgNWfUBps/Vtu71PDvnfDzPMIhAH/nC6BTAwcbKbdwtGtqtdqm+qMf923Yik
         V6kgydwO+OOuE7Nnp2mcTFGZGMshcKfwW/s9BGLdNLPysEdV0SovK9Wijj/BEMmkqlhl
         /HpEh7H7QILGlk4uTN2FlhiJ4O8Ab0FEGkkMar7vhdsmlsH250sPtQJ1LKkNpZtTljBn
         cWrn3K50wItXdaWNvw8v7XZL+Bri6k78XT99aIXy1aR5dL76VxBMMWhsu3fnY6EDDl1k
         I/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772057189; x=1772661989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKxFO5jbcj0n3yx3uCDHTRhkwPsNZ/ADjqKpvoexazc=;
        b=l8gnRWYGFOYzjwHN1WSdPsyBJ/xXdT2I2vpPjybUCOsy57x2TA2xLpDfD9l/7ev1E9
         QCc+XvfRACEccDRj6ZpA7Zpv/3nu89oTFY87e5BB4hFXm7bEe93KvKfufzWjTRgCEkRz
         YyVjrs9wS0M0yNvCkUrzpOBz69iNTZYUpRYwbPa57OGtRrXhMOtO+3qqH7HyVkzYWnZc
         YqDWK1JOkjpaDibIDiZKKBKwIk18C7ejsySwBhvxyIsoI2+Rujdzvk3EerFuCaN0D3E1
         XN4DvFVHSJbW7HmIAM03ORI72G4LYzfbJUDjbDgASu4TEx1fvx9+QVvRGFZiqkScoOGP
         nE7g==
X-Forwarded-Encrypted: i=1; AJvYcCXR3QvbtvpCXF3GN5du+l1ErnCY83HoYKrkAz4v34fO7K0drChzynEtCgPLg411VEln1bwwmQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzcau+7pjObzwG5AKEO151PrDslSslo+G37pxqweeF2fxQvGsbl
	xMVOFQ6hPIUuAlIeTrUmThJszoUV/P3YXl8n9/Ad9tsvjPS5Q6YqCpgB26ICDaTvFQ==
X-Gm-Gg: ATEYQzxqelSe9UVwYqvAOhv20GWT0NN4ce+YOf0eP/gZNiyl/J8dIEdfeQMKQNW2FRA
	RBHZhSUgiMTBIf9zWSd8mUEz1sD4kh/AGNESeXlhnWLyUppAvIxTWlZwgaUAxs0Lf2jJ3TA59rF
	bqWO7Z+5VeCqJsOI7R7uSqkwrGh+GqmaQYFJ14jll/IhZdjAnLFA17ADir6meh4W012qvMAO/XE
	J7u6+ZnpAwJmGByA22Z+Rvq96gN19R8W2CZ8lmTG0M/71NcTMdVrqKOM9MrPtAj/i/EVo4PES2Z
	z1H7I+uiz7KW/CpCxPxmaumbT/fjBxzTcj9SNtR+Y1jcw0zi4+AyHqWbdffhp8JdCht0wZPdFVV
	tfCpPukM14X9YHzMZEyDg2YSmPTxJoq7MwLPNAWqP4hASzJyXvRlbTZE8zXxoTAIIZbCaRRxBFz
	fvWk5pSo2YWJEeazNBQVRZKTJ8n7rd1ROgFH0z5YZyLEO1qrSb+LERSCSuvSqCGZQ+Hxg9UeA=
X-Received: by 2002:a17:903:2a86:b0:29e:27f4:bac0 with SMTP id d9443c01a7336-2adf77c692amr672495ad.16.1772057188344;
        Wed, 25 Feb 2026 14:06:28 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a05e831sm236247b3a.58.2026.02.25.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:06:27 -0800 (PST)
Date: Wed, 25 Feb 2026 22:06:18 +0000
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
Message-ID: <aZ9yWlcqs2b6FLxy@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225143328.35be89f6@shazbot.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_140630_735953_76A2CE6A 
X-CRM114-Status: GOOD (  25.98  )
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

On Wed, Feb 25, 2026 at 02:33:28PM -0700, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:51 +0000
> David Matlack <dmatlack@google.com> wrote:
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index 0c771064c0b8..19e88322af2c 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -258,6 +258,10 @@ static int __init vfio_pci_init(void)
> >  	int ret;
> >  	bool is_disable_vga = true;
> >  
> > +	ret = vfio_pci_liveupdate_init();
> > +	if (ret)
> > +		return ret;
> > +
> >  #ifdef CONFIG_VFIO_PCI_VGA
> >  	is_disable_vga = disable_vga;
> >  #endif
> > @@ -266,8 +270,10 @@ static int __init vfio_pci_init(void)
> >  
> >  	/* Register and scan for devices */
> >  	ret = pci_register_driver(&vfio_pci_driver);
> > -	if (ret)
> > +	if (ret) {
> > +		vfio_pci_liveupdate_cleanup();
> >  		return ret;
> > +	}
> >  
> >  	vfio_pci_fill_ids();
> >  
> > @@ -281,6 +287,7 @@ module_init(vfio_pci_init);
> >  static void __exit vfio_pci_cleanup(void)
> >  {
> >  	pci_unregister_driver(&vfio_pci_driver);
> > +	vfio_pci_liveupdate_cleanup();
> >  }
> >  module_exit(vfio_pci_cleanup);
> >  
> > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > new file mode 100644
> > index 000000000000..b84e63c0357b
> > --- /dev/null
> > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > @@ -0,0 +1,69 @@
> ...
> > +static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
> > +	.can_preserve = vfio_pci_liveupdate_can_preserve,
> > +	.preserve = vfio_pci_liveupdate_preserve,
> > +	.unpreserve = vfio_pci_liveupdate_unpreserve,
> > +	.retrieve = vfio_pci_liveupdate_retrieve,
> > +	.finish = vfio_pci_liveupdate_finish,
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
> > +	.ops = &vfio_pci_liveupdate_file_ops,
> > +	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
> > +};
> > +
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

Hmm... IIUC the concern here is about liveupdate policy if the user 
wants to unload a module which was previously marked for preservation?

AFAICT, In such a case, the user is expected to close the LUO session FD,
which "unpreserves" the FD. Finally, when rmmod is executed, the __exit 
(vfio_pci_cleanup) calls vfio_pci_liveupdate_cleanup() which ends up 
calling liveupdate_unregister_file_handler(), thereby dropping the ref
held by the liveupdate orchestrator which allows the module to be
unloaded.

I think we should document this policy somewhere or have a dev_warn to
scream at the users when they try unloading the module without closing
the session FD.

Thanks,
Praan

> 
> Alex
> 
> > +
> > +void vfio_pci_liveupdate_cleanup(void)
> > +{
> > +	if (!liveupdate_enabled())
> > +		return;
> > +
> > +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> > +}

