Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FE606A333
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Phx1gCcZ;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=V/061A9t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZGhJU+UzWHjWLO2uCHz/PaJEOnJdiVDGFcBGvFMPQDM=; b=Phx1gCcZAUJV9u
	Wpg2Jwxcjgj3c4BfCDRhVFyPUyhpBTf6xb7vlI3vVVi1tuBOplkb8TlJYxBoBYt+OGn1fU3VTQt/8
	zRj1m11sgAU02G7OxxzM5PfqNJAgqJRvhNbodUAXqCt+3XpV5BGdks4fYmtq+l/X4VhstMsZSHkRX
	X38kQ7cBJMKcU5dOwroL7zudlsBr2PZRGkkWynaN47uGw9+O7iKi/W46oghBFecN3AMPuO6HNbvhE
	BUvbuKo4X/Tu2wfF7i/sL0X/4HXPcbIe85M2CuyMc5EjwRVSIXUFNoNNBG76tipkNKQFX3C6hHxse
	bIHaMyt9bE4beJY08L9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlHG-00000003ukW-1Ujc;
	Tue, 10 Nov 2026 12:48:42 +0000
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlHD-00000003ujZ-45VI
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 12:48:41 +0000
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-5ec20398b05so1117593e0c.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 04:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794314918; x=1794919718; darn=lists.infradead.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZGhJU+UzWHjWLO2uCHz/PaJEOnJdiVDGFcBGvFMPQDM=;
        b=V/061A9tdUFNSyKEeC1ID+Kf0eyrGpWScI+rvp/9Ij0ky6QnKakWwKCYXvF4vNT1+T
         2p2ghLGCIK8kutYGNHiaoNeXErfbzXe4DaKuN07eiefS/tnQyNVOiAuG80S7t4Pi01Gc
         NOAWHDUNzFiAGl4WTfVknX84QcuZxd72WrpPMbVpKzHGOhDwcDQV9yeWiodhhmjkJpUr
         t8TPP9Kk8M0Vhoh55sECxIDMPRIG9MmeY+z68B2IuMNTjo+vHoe4ulO6A6VEuuKJkvPS
         D7CrLxxlv6j/roxWm3K6N7O85EMCd7AKtChlLh5PPIYy9eMEWUmTb59LvCMv22EiiAvQ
         81TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314918; x=1794919718;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGhJU+UzWHjWLO2uCHz/PaJEOnJdiVDGFcBGvFMPQDM=;
        b=xKX6bK5R215LeUywRtWBROQZCQPidixbquo6iruS0ukDs+BC8R+fsMBh/9bm3MtWg2
         cOWNI/vtVLzZL+MDj3Qibqp14U3wVVOl+X229brLrHiluD+mgOZrTV4UVSJy2WyuN6a+
         ehj8JI5RP130Cd4b0IfKWiq1lA2EtWl2xkcthTCnmKiIEF+mLCDiG49kZ+yPaW3jO/88
         9X3Wma+deVtjD5P6Rc2FTBC7KeyBOMsQ02OdP0/plFF/Ixs/6w/GCQZrppxpekNsYXe3
         YSMqMa8N3QN+X5GkynG6gz+5naLT4JPe7boB2DoadD+vo1X40oz1YHQNcrv9s1OE6Bpp
         uGlg==
X-Forwarded-Encrypted: i=1; AL+hErGkD1q0TyRuFI0oGIAI/Xen8RCpno8GW9AJRU4sii/CA4cEwi75U/4s2B0c6uu8g12f1OsI2A==@lists.infradead.org
X-Gm-Message-State: APuU4Z+xOGaCx/XIYspyS0kA9PDRbMuUWcgIZfGtC7lE1F49Kf6clBJS
	QTXCs5+PRVNoQS7pAVUavuphU3nGydqzTPQP82HngYD2tlrZguUA6NGP6wJC51TKNq0=
X-Gm-Gg: AYBFou0vbTloWeuAirNGofzRE90PeL4s98wfavpVubTTypw1dyK54+Nfho2pFdjnxf1
	T1sv3SMlGfy5ObcRBZDPFzzEdbM7CaL/kmnI/AS5o5EVAsBJ7vpb3YgKSG6fUzc8vjl3ZlgJK5A
	OLyGClam3KWVVSauNGVyrqtzqlSSM1nBxDdAVjRMcu0gU5H28IicHm54wIropfndw991ipOCZ2c
	Qz8fj1rtxvBsWLVDFu6Acprga1rFWKkcxB7xYa1qpFgGj1VoQhZpU8dYZqZNHrrIxfbAg7viCRW
	1GsUxIgSMW3oQieG8uRgORsbiTG8Dc/StFoaw6To5L3TpBL9VZnUB6Yhhvu5z+v771KmBANs02S
	HQe2FSlhIFOb3a0Ikr7fRC90+5dTlXlA/DELDRNvClMs1/Y98HwU8EY6/4zGtBeKOnCzM5ogpKm
	dmVcxgEqbEN6e+X4xW9FpyJ80RjbUOGsLpVC5jgt38qsoEHefJrwcvZ/DnpyqNMz14BLNfPSPGW
	xslOroXGPIc2iPF+BftPxgqZNpYkKz9KN+x5zH5kDx4Ak4tCh9iKbWc9SZvyp1s9aUDTXVc6uJn
	VVCglscwcNqhLQBxJggaUPCA6m/0eOSghmDqJw8lAOdo5fGlm4WcM72/L1KGoVopQjEXPn4FPOD
	DSaMUgt+qVw33g+nRI2MI8x2mkDtye+STKcnILpGPTDC9wHM0Xuzg
X-Received: by 2002:a05:6122:32ce:b0:5ea:b972:1403 with SMTP id 71dfb90a1353d-5ee0cf152b1mr755444e0c.3.1794314918133;
        Tue, 10 Nov 2026 04:48:38 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5fd00esm1555554e0c.16.2026.11.10.04.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:48:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 07:48:36 -0500
Message-Id: <DMRJJX2ZSYQT.2U1TTBGE7R4RA@soleen.com>
Subject: Re: [PATCH v4 00/19] kho, liveupdate: Add feature header for
 fine-grained ABI compatibility
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261110050202.529473-1-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_044840_037789_1F92CD8B 
X-CRM114-Status: GOOD (  40.40  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
> This v4 of feature flags support for LUO and KHO is no longer an RFC.
> This has gone through multiple design changes over the past few months,
> and I thank everyone for providing their suggestions and reviewing it
> promptly. Below I talk briefly about the evolution of this series to set
> context and try to make it easy for everyone to review.
>
> Initially, Logan proposed the feature flags in RFC v1 [1], which tried
> to solve the problem of dependency on the compatible string. Feature
> flags introduced finer-grained compatibility. This series had three
> fields: active, supported, and required. The number of flags was limited
> and didn't have flexibility, which reduced the complexity of the patch,
> but put a limitation on the extensibility of the features.
>
> After LPC and a few design discussions, I proposed RFC v2 [2], which
> changed the flags to optional and required and converted the encoding to
> 2 bits per feature instead of having two separate variables. But This sti=
ll
> has the number of flags limited and fixed the feature header size to
> 128 bytes. Though each serialized structure is being allocated in
> multiples of PAGE_SIZE (folio order =3D 0, 1, 2...), where 128 bytes is
> not a problem, it still carries two fundamental issues: limited feature
> flags, and a fixed 128-byte memory overhead for each preserved file. In
> the future, as there are plans for moving to KHO slab, the allocation
> for serialized structures can be significantly reduced and this 128-byte
> size will be a problem again.
>
> Based on the RFC v2 discussion, this v4 (v3 [3] was intentionally ignored=
)
> moves to extensible feature flags with a variable-length flags[] array,
> avoiding the fixed 128-byte overhead and feature-count limit.
>
> Along with this, as discussed on RFC v2, v4 uses separate bit ranges for
> required and optional flags (1 bit per feature). It builds on the
> consideration that a feature in its lifetime will either be required or
> optional; it can't be toggled into the other. In the future, if such a
> need arises, a new feature flag can be introduced to replicate the
> feature as optional or required, opposite to its ancestor flag.
>
> This new layout and encoding in memory is as follows:
>
> struct kho_ser_hdr {
> 	u32 size;
> 	u16 nr_required;
> 	u16 nr_optional;
> 	u64 flags[];
> }
>
> where,
> 	flags[i] =3D (BIT_MAP(optional_features) << nr_required) |
> 		   BIT_MAP(required_features)
>
> This series introduces the feature header in the KHO subsystem, and it
> is used by serialized structures across KHO and LUO. A few of the
> serialized structures embed other serialized structures directly. To
> keep the relative offsets of fields to be same across kernels, we cannot
> have an embedded serialized structure's size changed; otherwise, direct
> casting will not be possible. To solve this, this series converts those
> embedded structures to KHOSER_PTR, which points to the memory just after
> the parent serialized structure, and allocation and preservation happen
> for the total memory (parent_ser_size + embedded_ser_size).
>
> <Iamparent>_ser {
> 	u64 a;
> 	u64 b;
> 	struct <Iamembedded>_ser e_ser;
> 	u64 d;
> }
> 	CONVERTS TO =3D=3D=3D>
>
> <Iamparent>_ser {
> 	u64 a;
> 	u64 b;
> 	DECLARE_KHOSER_PTR(e_ser, <Iamembedded>_ser);
> 	u64 d;
> }
>
> There are only two such instances: kho_vmalloc and luo_file_set_ser.
>
> This series introduces kho_ser_hdr for the following structures:
>
>   - struct kho_kexec_metadata
>   - struct kho_vmalloc
>   - struct kho_block_header_ser
>   - struct luo_ser
>   - struct luo_session_ser
>   - struct luo_file_set_ser
>   - struct luo_file_ser
>   - struct luo_flb_header_ser
>   - struct luo_flb_ser
>   - struct pci_ser
>   - struct pci_dev_ser
>   - struct memfd_luo_ser
>   - struct memfd_luo_folio_ser
>
> If you notice, this also includes the PCI ser structures. PCI LUO
> support is merged in liveupdate/next, and this series is developed on
> top of it.
>
> Each serialized structure is preceded in memory by struct kho_ser_hdr
> and registered via DECLARE_KHO_SER(name, payload_size, nr_required,
> nr_optional). Both struct kho_kexec_metadata and struct pci_dev_ser are
> explicitly marked with __aligned(8) because their largest member is a
> 32-bit integer, and 8-byte alignment is required by DECLARE_KHO_SER() so

I do not believe we need __aligned(8), because the struct immediately=20
follows the newly introduced kho_ser_hdr, which is 8-byte aligned.=20
However, we should verify that the combined size (header + payload)=20
is 8-byte aligned.

> trailing feature payloads remain 8-byte aligned across 32-bit and 64-bit
> kernels.
>
> Also, Introduce DECLARE_KHO_SER_HDR(ser_name, fhdr) which is just the
> wrapper for struct kho_ser_hdr fhdr, This makes it clear
> To which ser_name, this fhdr belongs to.
>
>
> Series structure:
>   - Patch 1 removes __packed from KHO, LUO, and memfd ABI structures and
>     asserts their natural size and 8-byte alignment under CONFIG_64BIT.
>   - Patch 2 records entry_size in struct kho_block_header_ser so the
>     incoming kernel derives the entry stride from the block header.
>   - Patch 3 converts callers that embedded struct kho_vmalloc by value
>     (memfd_luo and test_kho) to reference it via DECLARE_KHOSER_PTR so
>     struct kho_vmalloc can grow independently.
>   - Patch 4 converts struct luo_session_ser to reference
>     struct luo_file_set_ser via DECLARE_KHOSER_PTR instead of embedding
>     it by value so both structures can grow independently.
>   - Patch 5 introduces struct kho_ser_hdr, DECLARE_KHO_SER(),
>     DECLARE_KHO_SER_HDR(), and the serialization/validation helpers in
>     include/linux/kho/abi/feature.h.
>   - Patches 6-18 add the feature header to each of the 13 KHO, LUO, PCI,
>     and memfd serialized structures in independent patches.
>   - Patch 19 adds a KUnit test suite (kho_feature) covering the feature
>     header helpers.
>
> [1] https://lore.kernel.org/all/20260903023452.721732-1-loganodell@google=
.com/
> [2] https://lore.kernel.org/all/20261021152527.375070-1-tarunsahu@google.=
com/
> [3] https://lore.kernel.org/all/20261026174217.603114-1-tarunsahu@google.=
com/
>
> Tarun Sahu (19):
>   liveupdate, kho: Remove __packed from KHO, LUO and memfd ABI
>     structures
>   kho: block: Record the entry size in the block header
>   kho, memfd_luo: Reference struct kho_vmalloc via serialized pointer
>   liveupdate: Reference struct luo_file_set_ser via serialized pointer
>   kho: Add feature header for fine-grained ABI compatibility
>   kho: kexec_metadata: Add the feature header
>   kho: vmalloc: Add the feature header
>   kho: block: Add the feature header to blocks
>   liveupdate: Add feature header to struct luo_ser
>   liveupdate: Add feature header to struct luo_session_ser
>   liveupdate: Add feature header to struct luo_file_set_ser
>   liveupdate: Add feature header to struct luo_file_ser
>   liveupdate: Add feature header to struct luo_flb_header_ser
>   liveupdate: Add feature header to struct luo_flb_ser
>   PCI: liveupdate: Add feature header to struct pci_ser
>   PCI: liveupdate: Add feature header to struct pci_dev_ser
>   mm: memfd_luo: Add feature header to struct memfd_luo_ser
>   mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser
>   kho: Add KUnit test for the feature header helpers
>
>  MAINTAINERS                            |   1 +
>  drivers/pci/liveupdate.c               |  99 +++----
>  include/linux/kexec_handover.h         |  15 +-
>  include/linux/kho/abi/block.h          |  21 +-
>  include/linux/kho/abi/feature.h        | 372 +++++++++++++++++++++++++
>  include/linux/kho/abi/kexec_handover.h |  11 +-
>  include/linux/kho/abi/kexec_metadata.h |  17 +-
>  include/linux/kho/abi/luo.h            | 102 ++++---
>  include/linux/kho/abi/memfd.h          |  27 +-
>  include/linux/kho/abi/pci.h            |  66 ++---
>  include/linux/kho_block.h              |   8 +-
>  kernel/liveupdate/kexec_handover.c     |  98 ++++---
>  kernel/liveupdate/kho_block.c          | 172 +++++++++---
>  kernel/liveupdate/luo_core.c           |  43 +--
>  kernel/liveupdate/luo_file.c           |  58 ++--
>  kernel/liveupdate/luo_flb.c            |  69 +++--
>  kernel/liveupdate/luo_internal.h       |   9 +-
>  kernel/liveupdate/luo_session.c        |  55 +++-
>  lib/Kconfig.debug                      |  13 +
>  lib/test_kho.c                         |  38 ++-
>  lib/tests/Makefile                     |   1 +
>  lib/tests/kho_feature_kunit.c          | 184 ++++++++++++
>  mm/memfd_luo.c                         | 183 ++++++++----
>  23 files changed, 1271 insertions(+), 391 deletions(-)
>  create mode 100644 include/linux/kho/abi/feature.h
>  create mode 100644 lib/tests/kho_feature_kunit.c

--=20
Pasha


