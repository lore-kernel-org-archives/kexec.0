Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD27C982DE
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7fnbLCpb26KXPMnHq1G3sv+CyiTND7rvG+kHXBaTg0g=; b=TJYoHpgZTEJB3Up0VOwmgo4JZu
	zp3csZRwIgiTogaiiq5EBk9a2CfEf2s/mxAIp5jGFkKxpWp9CvyyFhlAZNDQih2KqsgoFRRK8KvaQ
	d1YCNX/8SdOMzHIztdTC1fVrH7KyUvQopJe1+Scab3Bk6CMRQF4VHLOEkK98hK5E6PhW0gnRQ9w0T
	Eb2G0LC3TfC9nJ2Hilu+PC9JnYJi0l0U8Yj8LRRqhuxF833nbbCPuUyTyKvmAIHJH1fCjR9/olfLJ
	DR6sbGHZn4qLHQb3iU7Lu2z9raxwih3Q2aNv682bUvYioEv3RQuW088U5ac3vTnpr4EnG1X4gAtii
	ocyeNoiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Ll6-0000000Cvi2-1p2i;
	Thu, 17 Sep 2026 23:43:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Lgm-0000000CqhQ-0gfc
	for kexec@bombadil.infradead.org;
	Thu, 17 Sep 2026 23:38:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7fnbLCpb26KXPMnHq1G3sv+CyiTND7rvG+kHXBaTg0g=; b=UD97LvUr4gKeo6FqvjLitcz3uu
	a5FwI8qtcAGak9BrFJ4lDkdVPqap0JDTe3P0Bw20SB7JnjCKM2hFXmfTIT3zGrO7kpDAbDpXGlyw+
	iMlJPpI3CN1Obae9qzTsvea4FhOD2GTIeKmnsExk9JNC2r6tKssI2uZAbSL3rx0f2NTPW1pXmxK8m
	GnrPpIxusV8NythMyVbJp7YFj8ldmIc9cdMr7aUzGmoVPQ1uvju5VEDFha2rM1y8ZP5U/Q4fHcGpo
	hk2PZTvvaLxHibk/GeD6MybUv+Q2HPUtGKEFJD/5z3Q9GOhVtCqQ6UT1xRe3qhuA0dQBhbkS8N1yb
	iQkXDOqw==;
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7Lgg-00000009NBs-0ESf
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 23:38:46 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d8fdc579daso1742675ad.1
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 16:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789688317; x=1790293117; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7fnbLCpb26KXPMnHq1G3sv+CyiTND7rvG+kHXBaTg0g=;
        b=a4NmmWDfmGbZ+fCrV3MtVy+Q8EFhAV073y/kMbtGBt2SKbbW8NPIE2XwFNFneRgSfm
         e8J5mR4zXdJJt5g/jJjo9+Wb5wGLVsOB6/r+kGvi/osoLV2GJ4P6PBVY4uS1QldVGXaZ
         mNBhyRQ9oxK/2zMQ0AkB5behflKmwdnVkii8CxZr9a8iv4gcYCwKb+y5Rd9xhhY8EozQ
         0IxTen5jh9/Dc2UYzzTFXK2nUcDT4fzQRlKlL7ua5u8+PokhXh/6qFv5GF3aqNEfaRwi
         kSsxUmOO2yacAS3h66hikWz6GFvik8XocbHrsIcel1aAjWff7u35L4nSLIgzQXQRtCTd
         hWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789688317; x=1790293117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fnbLCpb26KXPMnHq1G3sv+CyiTND7rvG+kHXBaTg0g=;
        b=o9Z/11ziPeaAPHNQG/0J4V/M8W71K0mJ8xiMwv/9800hI7U9tsWOQtJ5A91yC+OOGP
         hUaDB6qfxN2EDBpcqge9MiGLl7jBbURXmloT8WjbkhIWS/wfx3s7gjYd4eQHd5a0MuNz
         IYg691EqmWqPKsq4FrXy/VCPttFIITEJfO/EioAUTlkUjZ58bfI/Yg1tPO+DsXs74iLO
         1spcT9LR46B+zsEMlUX6RS4BN8BqA4dcemBiIcrA5ggJMNwugfh6ZpOw2T5+xj5Cd2Ax
         unQSjk6ycssXpj2tFVY7VlQ9mTYYv3XVczi/LCLfA8kZ8NguduQwDOXn1lYTPa+xvFoq
         wFNA==
X-Gm-Message-State: AFuF++nY0Ek7SxKR1IDg4oubSDyLs1t55bQ1pL29Ni5KOPG9zUJaUwll
	1RdXXQ+S3J4AwA7CClAOleTiZhZCFVY6EmBqAid05yZstunJ+zL6tsoIMPxagcN+tVxsScqt8He
	FYOZG8w==
X-Gm-Gg: AYBFou0QPYs8vXTqGMgDr4P1cjNPoNZTWacuYwaN1dTE/2qmv7XjKqYYBbYqfXfCCqy
	gv5lZ/FjGkAM7XCIEWjTROLrU0qhes0+7YWF6E4BjlgU1KytYPFD1xQDN/avUHbbQtSa7Yn0AMU
	E+ivRfDlmynGvR1eQSK3ExrwhviHj8N35HXWBFctI+Xd33ISaHssl64AFxILW/aXLnyJfwhYBjj
	zV7FoUy9z3JEQ1o9iFEC6babKF1AcHlgLgulYvAvKHmiFQHFOwKZIALT9cdg82ZjgIPT8CaxKcg
	6nGMka6dET8PRf/HeqxYaVoky9oI9Z7V94F1SykJjvizqA0hmF1YT3CpOdM5q3iT0687yiIJDmn
	zGMlacD8Mu0lpAuI1Ts4cTW/cej5ENZu3vnH3fUgwCjoSbL1Mch1guP3ySxh3YahJ2IOcRynRJN
	eGrxn7smCVuJ6l2v3xH1Muduuf9RSNn0z89vUIdgphtX4rUCJSOEJ/MnSRODw18tktiNoz2jSbj
	dB7xxA7UOXrprE2b8qFa+xgdh8aMYH8UNzJk35Mx6WSaGyEoY8=
X-Received: by 2002:a17:902:c944:b0:2d6:ffa1:429b with SMTP id d9443c01a7336-2ddb1adf381mr15539635ad.7.1789688316616;
        Thu, 17 Sep 2026 16:38:36 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89e96cccsm32897375ad.22.2026.09.17.16.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:38:35 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:38:32 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <aqx5-KH_GcSvsvqs@google.com>
References: <20260728221007.2098560-11-dmatlack@google.com>
 <20260917201737.GA1047708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917201737.GA1047708@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_003842_264456_49BBB2A7 
X-CRM114-Status: GOOD (  27.23  )
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

On 2026-09-17 03:17 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:10:04PM +0000, David Matlack wrote:
> > Freeze a device's outgoing preservation status (preserved or not
> > preserved) during shutdown. This enables the PCI core and drivers to
> > safely make decisions based on the device's preservation status during
> > shutdown.
> > 
> > Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> > than from drivers participating in Live Update so that all devices can
> > have their status frozen (i.e. prevent non-preserved devices from
> > getting preserved late).
> 
> This calls pci_liveupdate_freeze() from pci_device_shutdown(), the
> pci_bus_type .shutdown() method, which I think is only called from
> device_shutdown() in the kexec or restart paths.
> 
> Since there's no error exit after we get as far as device_shutdown(),
> and this applies to all devices and dev->liveupdate.frozen is never
> set to false (at least at this point in the series), is there benefit
> to tracking this per-device?

I think this could be global. But I don't see any obvious place to add
that hook and keeping it per device is one less global variable to
worry about.

> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: David Matlack <dmatlack@google.com>
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > ---
> >  drivers/pci/liveupdate.c       | 16 ++++++++++++++++
> >  drivers/pci/liveupdate.h       |  4 ++++
> >  drivers/pci/pci-driver.c       |  2 ++
> >  include/linux/pci_liveupdate.h |  3 +++
> >  4 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 744513ee11ed..65bcecb1b64e 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -394,6 +394,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
> >  {
> >  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
> >  
> > +	if (dev->liveupdate.frozen) {
> > +		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (!dev_ser) {
> >  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> >  		return -EINVAL;
> > @@ -447,6 +452,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (dev->liveupdate.frozen) {
> > +		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (dev->liveupdate.outgoing) {
> >  		if (!dev->liveupdate.outgoing->refcount) {
> >  			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> > @@ -718,6 +728,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> >  		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
> >  }
> >  
> > +void pci_liveupdate_freeze(struct pci_dev *dev)
> > +{
> > +	guard(rwsem_write)(&pci_liveupdate.rwsem);
> > +	dev->liveupdate.frozen = 1;
> 
> Nit, the series assigns "true" to other booleans
> (preserve_bus_numbers, was_preserved).

Ack, will fix.

