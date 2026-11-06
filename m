Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F438606A326
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GAvJvXeo;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ew/7EXqo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=i6wtLwteYwyUZUWdoRocIhX8iiQGzMdlm5waC4g0QLs=; b=GAvJvXeoyrGbo0Byc+JEjqZ9cx
	eCGIyTQOzqqGLopcQISY3ga+Rg3twwALVp5S3YKansy/ikrMsPIwFML8EUI8cgfxJn8RQLOHwVauM
	h2BGn0cNTBgYmZ23s/YGWm4PiC++imB3vMFJPvQdg0AbMdrQTZ5BFBl/iJAiQKL/FPSYJSqFKwr4a
	8N6x96ouwZbgv35LMwMVmszdM58rMGCeo1Y98B4b3BCWByqnAnQp8il+VZeY3oFli/y/fQAYuAayM
	ZxFxYVBfdBU/GMHWWxAbUg2EBpbASh/h4sq0SVNE/aL9CVrFaawfdMuIH92bco/92WiWXmGWO3yFl
	BbIpcALw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPSQt-0000000Dmq3-03ra;
	Fri, 06 Nov 2026 22:29:15 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPSQr-0000000Dmpa-0s3B
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 22:29:14 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ed3f563739so11695ad.0
        for <kexec@lists.infradead.org>; Fri, 06 Nov 2026 14:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794004151; x=1794608951; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6wtLwteYwyUZUWdoRocIhX8iiQGzMdlm5waC4g0QLs=;
        b=ew/7EXqoWjaXwkpHQJzr5aU33PbrJkh52Ac3Q7cgoeTojuEH98Y1Q2YNJjevFPGefs
         8wR3b37YXyj3xR088aBQ1+wVXI8hYXTvvuheIMHhyBvLXCmJgpWBj31GNNQVlMThYyCo
         k874fUgfLn6I9/JxQ2/UEjE8optRrfqwDRXIY774WA8JzwDUjoYuQaxQrSDgiUcyjCN6
         NSwSDds7LjtcEnkg94kUZvgATPr1gD1ptJ0GJ8fIdweUwctjUKa4QStflz4gyqJPPYVy
         zd1TrKIq2sW3qeO7OSPHoN5SKkzy08XLwuLEoxxvxZAbCTXWW5DdftOPpV9zBkjEmM46
         qGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794004151; x=1794608951;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6wtLwteYwyUZUWdoRocIhX8iiQGzMdlm5waC4g0QLs=;
        b=KgDRQcVsaTHRIdUCeaAmsmNUIpwOJV+uTbwieZCVfxjHkH8HKNCkq3GqkaPdchMt8c
         ax22jzMtGR6ncUmadNdX7TVwLPZRC/2Dyqa6n+KRIMA/ocwVGYlnzSbXm6FashlPgqqP
         0fx9UCKdy8hBGI/kEnkeU+wffTf7MTmBV+2ZdeW1CpwjhB2EHdU155Lnjox6/qevSGfL
         56lf1mpY+Gr4zaUBWJDGx4HY/oYzLiElJynF5rTSimlpeBAo4TDfxuXFmiefj109onBH
         Kkk1sI4n4KBT1fDU7pNtZa87JEMWTSbu3E4YPCKwVjQuxLPjQyq+WpdZsXOnkfRYd79I
         1N4Q==
X-Gm-Message-State: APuU4Z8h2ku+L2F7DDT6eti/saLcxYMV9btyn7GXLw35F60o+jj/tSy6
	/2eVKYBE7t2dnnwjRK/Amt4piS1KE/fohKii9XbRDOtb7UcaoGrpm8nBjmTf/Dk6bQ==
X-Gm-Gg: AYBFou2rueygmbk/YoiT1iFOwAsCurLOu96c80X0tkeGNwe5AKS2vLNivBBoa0IfEA3
	J1KXT+wfOlzVd9M7rELgK8nBM1KOF2ixpcayd7Pe6xVPWnAyVIJsaDpmr33dtoIKCMsavz5+35/
	CbfToGgxo1CdXtxyUv6mAUn4G7DQKtdTRc14NG99ktOhMECtKRk7jR+mcdXJL7IGcipvvKbM+fb
	PulzzHfpvFl4SUD6tJYNs1BI+J25pT6tBnkgJBR1NDZDANu8KxLcIz1zxy8IZ08P6Orl3Erso1m
	9tpWfx6i12NpBijLnTvxyrIS8ZlJfjdkk/bOnKjXkqk1Gzmr1tYhofjIaaZWhTDlywuml+1WLeG
	3UMe8BKQQwiEwQwdAWblv4Mu9lUs5IIcOStG190AX/li8m/4XesAvnbdWNMpLhyYJHMdRo9xx7Q
	Wne8K7MLk18aqrsWX1NGP6G79Wj5X1xSwFHglUgDJ41QNmun3OBQzqRzUnzL8tLHJl7f0xMmgIP
	Oi3MgCV8F+pOPqOeSyeNai4Xd8VCaqwSDeWhNEjgjYNmSo7SmzGUvUXZIYd1mqCDLSpdWtUdww8
	4BqbvbaCG5krEfBjsNW0LLkIXNkrm12ljact30DiGNKxUvd5N35mdbHHrwGl/lRnj4xZESuOnX+
	TGnT9Frw6DodeFFObLsUV7+PrNi+YC29Heyx/QBa0Ug4=
X-Received: by 2002:a17:902:ef11:b0:2eb:188a:1c06 with SMTP id d9443c01a7336-2ed6a865b76mr263955ad.9.1794004150728;
        Fri, 06 Nov 2026 14:29:10 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc27e829sm775868a91.0.2026.11.06.14.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:29:09 -0800 (PST)
Date: Fri, 6 Nov 2026 22:29:06 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
Message-ID: <au5T7qouVfxJSDmr@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-5-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-5-vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_142913_253133_1B7C5AF8 
X-CRM114-Status: GOOD (  15.50  )
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 07:36:33AM -0800, Vipin Sharma wrote:
>Register a live update file handler for vfio-pci device files. Add stub
>implementations of all required callbacks so that registration does not
>fail. Register it with both live update framework and PCI subsystem.
>
>This file handler will be extended in subsequent commits to enable a
>device bound to vfio-pci to run without interruption while the host is
>going through a kexec Live Update.
>
>Put this support behind a new Kconfig VFIO_PCI_LIVEUPDATE. Initial
>support is added for no-iommu model vfio-pci devices.
>
>Co-developed-by: David Matlack <dmatlack@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>---
> MAINTAINERS                            |  1 +
> drivers/vfio/pci/Kconfig               | 11 ++++
> drivers/vfio/pci/Makefile              |  1 +
> drivers/vfio/pci/vfio_pci.c            | 11 +++-
> drivers/vfio/pci/vfio_pci_liveupdate.c | 75 ++++++++++++++++++++++++++
> drivers/vfio/pci/vfio_pci_priv.h       | 14 +++++
> include/linux/kho/abi/vfio_pci.h       | 28 ++++++++++
> 7 files changed, 140 insertions(+), 1 deletion(-)
> create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
> create mode 100644 include/linux/kho/abi/vfio_pci.h
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 5d1b58271989..167aa9d66ce8 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -28662,6 +28662,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
> F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
> F:	Documentation/driver-api/vfio.rst
> F:	drivers/vfio/
>+F:	include/linux/kho/abi/vfio_pci.h
> F:	include/linux/vfio.h
> F:	include/linux/vfio_pci_core.h
> F:	include/uapi/linux/vfio.h
>diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>index 296bf01e185e..e8285ad93a69 100644
>--- a/drivers/vfio/pci/Kconfig
>+++ b/drivers/vfio/pci/Kconfig
>@@ -42,6 +42,17 @@ config VFIO_PCI_IGD
> 	  and LPC bridge config space.
>
> 	  To enable Intel IGD assignment through vfio-pci, say Y.
>+
>+config VFIO_PCI_LIVEUPDATE
>+	bool "VFIO PCI support for Live Update in no-iommu mode"
>+	depends on PCI_LIVEUPDATE && VFIO_NOIOMMU

Can we handle this dependency in code instead of doing through
configs? Are there any build dependencies on noiommu?
>+	help
>+	  Support for preserving devices bound to vfio-pci in no-iommu mode
>+	  across a Live Update. It enables a device to continue working (DMA)
>+	  while host kernel is going through a kexec live update.
>+
>+	  If you don't know what to do here, say N.
>+
> endif
>

Thanks,
Sami

