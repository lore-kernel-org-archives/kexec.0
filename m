Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE85606A32E
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DVaRAM3U;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IVOL8RGL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Rc92iNBDR3TpfE1Wb0FPlqB33KW4gheFc7Efbj9D4zA=; b=DVaRAM3UOYw2eF7274v7ORBOL/
	+6G8A9OXK/7j//319njYknnN+6eoVyOA/AFmsgaFPQWRo8XQhEZ/UTkYaAM43EWYDM1m0JtSzAgWW
	OWld49TvTKF5gpXhDIkjy6+TS/ppLsspSxopItIEA88d4MPHFQI6T+fGVl1y6oQA2qcaIQk6et2y0
	/9Z7NwdfnAp1wRnbCOoErHyz62VO76KisgddDGq9zdRKDRlLRsf1gqDyGu2MShBuwMc7VYFxH9WHT
	oDCrU230O91Kedjm0CwDCLTJERo9Ri/yN+Oy+DJZ/JrNIJnxsRY0CDyR5/zOBNSshLMEQ4cN/O+Fc
	UHZEOQ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQr6r-00000004rhO-2x52;
	Tue, 10 Nov 2026 19:02:21 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQr6o-00000004rgZ-3aDy
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 19:02:20 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2e9f6a16afcso5875ad.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 11:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794337338; x=1794942138; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rc92iNBDR3TpfE1Wb0FPlqB33KW4gheFc7Efbj9D4zA=;
        b=IVOL8RGLsJ0+TCP0tAk7dPHAE15K0DjISkQW4ZAMdwwUF3IeiQrnQskGC1OKCHspHG
         H7pUZLzArOaP1z//XnO7e0wV168oQqy5zK/wGurDBYOhJRRXjelUPEoe8FBszSmnad7J
         /1+vbfUnf0+KRT9N+CRaikN9NYxFIGq74wE/WfORTeFkCr3SuhSBPf3ssfJbSk40bGDq
         DsoyqyKidfakmNF6rHp1m2njPvl9uO682pd/yw1JyAkC9VSSAL/8/fU5mkjWEOpY21+c
         9UfRhGbmrY+CaTWW8gWwpDfc6O2ZwvtrdaT6oxwjYreNa7woP3xeOChDzpdS+XkK+ByR
         qgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337338; x=1794942138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rc92iNBDR3TpfE1Wb0FPlqB33KW4gheFc7Efbj9D4zA=;
        b=aQ25ehdAQ0rbI8LE/PukxPfjaeJGqeqJ9FxWhF5rUh/1H8CzbDxhuXP3M4c9eg+B9+
         0AxfntI04PDES/gnWv0Dx8TPqyt7SdiMW2gg1N1L9V3mhs4l9g8DRbk4l+X+UwXaj01b
         u0MHxh3SsMY1hfED0RzpoPLnEQzJx4jllA+LQgwnBqRSQ4s/bXVMGNmdZtFPuH61Fc4D
         miXrXTzsXKX/dU6gSWunbJYUaLeedLPdOG0XbLsmSzmzPtlJFIbVGtVrjjD1AXyRYzNc
         lgY4bgk8OANT09umpt0+Ewq3BhezYhrEpigceLG/RdFpTx63Vla3rvbIMHfM9uewE9Ig
         K4Yg==
X-Gm-Message-State: APuU4Z/8R/k+LsfY+pt2BzV22AwcYQi0ngsVWIP2Iz/ihfSixaHNHZRP
	k1fRMLz2HxC/QfwbioY9YgV8u3gnStgRWZg/RxmrdCl+cjgTn/XWHr9NBAo5SbyqvA==
X-Gm-Gg: AYBFou1PcQQvl2MhYmPg31c9Cq4tmRI3cU8JwNRrRp2YyvxqLctYFIPCMtKaasHMMcG
	6t5HIrEq1RsZ+op62yaQeaYcnbIpkcqZSYHCTyl0zpKo8M8zFgsf+XI5/1YeeNxdjER1oWg4daQ
	vxb9NREJo8hfUqkyBgWgxwT1fKvnHNK9BFRbnUJjuoQEueDMJDeslehDg+i8O6HU3d+rnpLWUWJ
	+5oZEzuQNq9U8etmpMqBFX2+4ERkPNneMZZWSDQyh7bGkQVCsqjKJmYO9qT/B1QG1icCc4KmZ5h
	wsQCTq6z03gjBFexNxCx9iLPQ8p2W26w18pcr4Vzqci5O2BOaJPGFLVCb8D9mWEJ573hhyXm9Ij
	8ZmZ6fj/nsnNwdfAMgwsSrc2f37U0086ye977xx854vwqGBTjDO/BzSrYjOeEvF2eVlz8itdj64
	EOaSx4WOa++MfVYdPUDPn54sMD3RwQGAQQVkBAuJEQ381Qjweh5MmEz4mrKdFr2kO4xHStkN2Ti
	rg3Zwx8nbrrXaoLYz8SgiZiNVWYMtt1GtvlT/4l8VUUwtfbnKxg7xmhR/pGrTzSr49A32IEtiJc
	DF8mEbrrZpsIxI9jLNscwApkAtLq6agArzvgKGm9YCbmPplTK+0+BmJYzO1hQQuE
X-Received: by 2002:a17:903:1b44:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2edba3e2a10mr5113665ad.15.1794337336971;
        Tue, 10 Nov 2026 11:02:16 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db31cafsm914394a91.3.2026.11.10.11.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:02:15 -0800 (PST)
Date: Tue, 10 Nov 2026 11:02:11 -0800
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 04/27] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <20261110185305.GC519525.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-5-vipinsh@google.com>
 <au5T7qouVfxJSDmr@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au5T7qouVfxJSDmr@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_110218_907679_350B780E 
X-CRM114-Status: GOOD (  25.49  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 10:29:06PM +0000, Samiullah Khawaja wrote:
> On Mon, Nov 02, 2026 at 07:36:33AM -0800, Vipin Sharma wrote:
> > Register a live update file handler for vfio-pci device files. Add stub
> > implementations of all required callbacks so that registration does not
> > fail. Register it with both live update framework and PCI subsystem.
> > 
> > This file handler will be extended in subsequent commits to enable a
> > device bound to vfio-pci to run without interruption while the host is
> > going through a kexec Live Update.
> > 
> > Put this support behind a new Kconfig VFIO_PCI_LIVEUPDATE. Initial
> > support is added for no-iommu model vfio-pci devices.
> > 
> > Co-developed-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> > MAINTAINERS                            |  1 +
> > drivers/vfio/pci/Kconfig               | 11 ++++
> > drivers/vfio/pci/Makefile              |  1 +
> > drivers/vfio/pci/vfio_pci.c            | 11 +++-
> > drivers/vfio/pci/vfio_pci_liveupdate.c | 75 ++++++++++++++++++++++++++
> > drivers/vfio/pci/vfio_pci_priv.h       | 14 +++++
> > include/linux/kho/abi/vfio_pci.h       | 28 ++++++++++
> > 7 files changed, 140 insertions(+), 1 deletion(-)
> > create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
> > create mode 100644 include/linux/kho/abi/vfio_pci.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5d1b58271989..167aa9d66ce8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -28662,6 +28662,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
> > F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
> > F:	Documentation/driver-api/vfio.rst
> > F:	drivers/vfio/
> > +F:	include/linux/kho/abi/vfio_pci.h
> > F:	include/linux/vfio.h
> > F:	include/linux/vfio_pci_core.h
> > F:	include/uapi/linux/vfio.h
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index 296bf01e185e..e8285ad93a69 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -42,6 +42,17 @@ config VFIO_PCI_IGD
> > 	  and LPC bridge config space.
> > 
> > 	  To enable Intel IGD assignment through vfio-pci, say Y.
> > +
> > +config VFIO_PCI_LIVEUPDATE
> > +	bool "VFIO PCI support for Live Update in no-iommu mode"
> > +	depends on PCI_LIVEUPDATE && VFIO_NOIOMMU
> 
> Can we handle this dependency in code instead of doing through
> configs? Are there any build dependencies on noiommu?

I can remove it but then by itself VFIO series will enable LIVEUPDATE
irrespective of VFIO_NOIOMMU and it will just fail when someone tries to
enable it. So, kconfig looks cleaner to me.

Can your series modify this kconfig and add (VFIO_NOIOMMU ||
IOMMU_LIVEUPDATE)? Will that work for you?

