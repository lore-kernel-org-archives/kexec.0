Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E029606A325
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VioE0wKR;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VbKC6XJg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j6HenvetdiqKK5Mv1KKa157Ln9/E8xXqIQ72cYSu+2Y=; b=VioE0wKR0UFvjqvDt9SKJkrpOw
	YrMoCL5NhoY0gsKefd8I8n/HnT/q/yBIESAKEWmIc6KOE+vUI6bAgLj1yPbU2KeejMcpkUyoKdmfV
	qKk0KY8vHVbD76bTfOvPVZY/HhOQK2tCC8AOLIzn7Pvv/Y39q7cMUx62/tq2I+bbsKjvCC6poAELu
	fIm2cJgQD+6cjoS5Wb9Fu6IPL/CsVE6TJ13+/xOk5C+nOOjNbldfKo3osYMWxr8EqyqBIcL/hisZM
	d88p9XZWRNEJ699BIAoz+pPwuFFwuer48w6z/RgsquYJk8yoZZyazKCdqcU0dFhjknd46jP5Kp2fZ
	BoWOSjvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQqqk-00000004pQM-2Xvq;
	Tue, 10 Nov 2026 18:45:42 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQqqh-00000004pPc-37tv
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 18:45:41 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so4865ad.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 10:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794336338; x=1794941138; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j6HenvetdiqKK5Mv1KKa157Ln9/E8xXqIQ72cYSu+2Y=;
        b=VbKC6XJgcte3HeYRY46YzTnPsObSF/iLcAD+mKz6dGEGNZlHYnQu/W3oYnX90+JX/M
         oU0I6eZ/m2m9+4DhDtCxmulger4ByJ3QpbBYV1jiBsVUxVIdKQ47ere7c1ypETjjDbL9
         pvm3E75PGqsruTnUaBSLnDvwWS43fs2vKdvGEy+vj/FectMue8ueyvhtLuKTukBcGfBz
         ZTRSdku0fbvIwlD3fQfdMHK6A3olWmOxrslL3Zf7vgv80QngD4rgn836R8jKeWGzWyO8
         Eqkwt/ku6GXCaSYg19qmhgBlLIjBvsoWhHzUAH81nzj3bR68FvyPKL+4+InUjATQGAWy
         sWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794336338; x=1794941138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6HenvetdiqKK5Mv1KKa157Ln9/E8xXqIQ72cYSu+2Y=;
        b=kt7iJDduxs6SeUrIaiP+iCWdh/noazObWJYky556yiFVUHAoi1lL0ibD3WtQkLVFNI
         Oc43tkq2gl6Lr3NT14KmUN6Q60uL6b7+Fl0afP3oXG3ER5iNDLIeesjJfa7kC1uHqkip
         VPwyRisAFVQB7lHp3B0p8qQJrMMBmQRaAEoFuN2aa+xDuEDGIj0Mx1cdJe2+iAwiDHyT
         BkiXx5YGlOzX3c9XXeMTavtyXQuA0ajsIRrpA25jrS6XhdZq2TeFj8Q6oflRo/a/6+ND
         MzGK/7siHkesGQPpkimeIp3hei/pPIoPnSf9zgTCkI8xki5N1bnhP3l9r+gkwFB3d5WA
         y9Ew==
X-Gm-Message-State: APuU4Z/ADe/VmCCwvD0CusqJQJu0Z1DthCUIidNnsBLMT6mjsshkc2Ar
	dyasP8dilkq3T/Lg3ML8i90vthRFl2z/ght2rpFJXmv+YCXHEMrFjEqMlowcGooqOQ==
X-Gm-Gg: AYBFou0TMzShnCXMYXaQtHlXoc/3uuK0Y9rN9D36JSZWvKm1N7abBU3IEl/boHvNJqJ
	ZPOEu1iri75mFjFzB1ZA8NqF3yxv7Dx3G8BcZztmfNi4d7qeMVbi73wK/CoFB2uL7EjyGqgiuW5
	SPvxgAGvsSQckpbdMlk9OljV29yWDkKIsARSqxs8g91E+aVtjj793H3PgGnQywI1LMPFnsdg+5y
	TL6n00cRFgAnsPcfsUzbiJv9Pu5lozrHDe5jBbo+Qo588w4HGiqLhsgA50eczwmgO7zKDqgY+Qw
	LVoYrFdDCLblZmE1zy9nVz09TTu4RMgl2pw5sQGhQHSJhWPEzmeHFCeohRvsHG8f58GCFZNPT2/
	zFcEV1/4lKscaBQGh/zkG20oKmKcZj7VYs7eRfvha58V/ZCELLT/PHFrrN+sxL4etJ3eD8Tkl8O
	c6T6QxGzILkrAR6DpeG7PEO94myzjNL7HFxXWzsGPGKpa1hUX2qHIiSOnCLmQ7HS6gltpX01YDt
	r5Ipkf0qDX8sfkyq624062s4lqQNV/i6eC3dv9VNhJ3tGVDf19lSP3oqIyen7eOwos4XxezhkJk
	js8td1tK3SRfFaAL7STYbL6me//PvLHC4+ASLmqG4SGqjO4++Wd9sRuwz4QIBzs5
X-Received: by 2002:a17:903:2a86:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2edd7110fa8mr255665ad.2.1794336337416;
        Tue, 10 Nov 2026 10:45:37 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86ce5fsm1317128b3a.21.2026.11.10.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:45:36 -0800 (PST)
Date: Tue, 10 Nov 2026 10:45:32 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 00/27] VFIO PCI Live Update (noiommu mode)
Message-ID: <20261110184339.GB519525.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <DMOH7D1PZUM4.1X82LVQK7E54Q@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMOH7D1PZUM4.1X82LVQK7E54Q@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_104539_785347_7AF0AB70 
X-CRM114-Status: GOOD (  16.46  )
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 10:20:10PM +0000, David Matlack wrote:
> On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:
> 
> > David Matlack (4):
> >   vfio: Enforce preserved devices are retrieved via
> >     LIVEUPDATE_SESSION_RETRIEVE_FD
> >   docs: liveupdate: Add documentation for VFIO PCI
> >   vfio: selftests: Add vfio_pci_liveupdate_uapi_test
> >   vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
> >
> > Vipin Sharma (23):
> >   vfio/pci: Factor out the reset logic in VFIO PCI device close path
> >   vfio: Export various helpers from VFIO
> >   liveupdate: Export symbols needed by modules
> >   vfio/pci: Register a file handler with Live Update Orchestrator
> >   PCI: liveupdate: Add helpers to preserve struct pci_saved_state
> >   vfio: Add helpers to identify device files that can be preserved
> >   vfio/pci: Preserve vfio-pci device files across Live Update
> >   vfio: Introduce vfio_find_device() helper
> >   vfio: Refactor vfio_device_fops_cdev_open()
> >   vfio: Add API to open cdev device for Live Update restore
> >   vfio/pci: Retrieve preserved device files after Live Update
> >   vfio/pci: Protect incoming preserved devices until they finish Live
> >     Update
> >   vfio/pci: Take over preserved devices without resetting them
> >   vfio: selftests: Build liveupdate library in VFIO selftests
> >   vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
> >   vfio: selftests: Add iommufd noiommu mode
> >   vfio: selftests: Add helpers to map DMA memory at IOVA == PA in
> >     noiommu mode
> >   vfio: selftests: Add helpers for Live Update DMA memory and sysfs
> >     state
> >   vfio: selftests: Add an attach() driver op
> >   vfio: selftests: Test preserving noiommu devices in
> >     vfio_pci_liveupdate_uapi_test
> >   vfio: selftests: Add vfio_pci_liveupdate_kexec_test
> >   vfio: selftests: Verify that opening VFIO device fails during Live
> >     Update
> >   vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test
> 
> This series is getting quite long. I would consider splitting out the
> selftests into its own series and we can iterate on each separately.

I think it is a good idea. In next version, v7,  I will send two series,
kernel and selftests patches.


