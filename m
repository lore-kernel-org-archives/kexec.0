Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357560A2638
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NoW4ZYsi;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PXg06mL1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=c0rc/quhwxN60DpjROoJEjycH9qA4Mz3L7opctQFNIY=; b=NoW4ZYsihsF95skCLAWQjmMJgo
	dT6BmQBa98m2ls69MQtMTlJPokoMQRLyBihU62o6XPw/2Ba4YFwP3LFToLOeUjyi7UX0fiuEKBxhL
	61lSpiScoGawUcbSl10/CnZ5c0TqXZGotfktTOQvplAZHC+SX8tRw5XdNueWeDrMng7m+lPkJZQeM
	3/bsbMDgwB4HaVFD3ddgZhCzBE+0h3vOaETPMH1i+o+qZvye0eDS9wBOutYh8oDE78yE/wpojSLoX
	uNCkYaY6kCPKtU3xt01wtQvdEESNCdRllV9kvnUUsgQctdILz2wyXjEjeF1WhPItb8HIC9aat/4le
	JFMfp/SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzm-00000002RET-0JLs;
	Tue, 10 Nov 2026 05:02:10 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQdzj-00000002RCj-3yXX
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:09 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c4048584447so134541366b.1
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286925; x=1794891725; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c0rc/quhwxN60DpjROoJEjycH9qA4Mz3L7opctQFNIY=;
        b=PXg06mL1kWBRhiYeUeFoh/RwDG/nIbYxkx+pycr8m01WecMYl882Va34ExHUeDIk+5
         POoML1lv0ouHWLuUokCnuJSDIlhy3PKgr6X5YatEfiq7tgkX/Uj+5Rk0mEwOV9q8wOW1
         MXfg7MXyFZB/BUsw8GvzoHJ/i65olJwO3MNJPCw1lZPKCZvqUVWjpWEYIQamF+ppTXRa
         okYiy0KKO/f6KhtyiJHnuF540XurN2+bgqjpxLIKqecv4UUYL9niVmgirCR4vYA7tTPC
         FcigK8dEXMjUBunS0wCnRqvPNzp85JAbxriec+DoKo5Q/d0fRh/85NZijPwY2G3Pdy0n
         KS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286925; x=1794891725;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c0rc/quhwxN60DpjROoJEjycH9qA4Mz3L7opctQFNIY=;
        b=Nak++XHT8zeunKEufbJBTkPtARVOhw0+H7nTMWyYUAK5s3NuVn5iWsjm6V4BlWeLy8
         aPc9WCnDGDLrsjmfMH1mtAK216DKUkE+QYlvN3f/D+USpUYqS/mE7QWCAYn4HK90bM7j
         rM2HzW44228UsD1/QFK8e0/8QUBXJFazzJZ8sW4upXz+FMnHDmBqLYW2uG099ii+o+ir
         8zUCHwWrifwodeSrdl6qOHjfjLwyeOzbRWbCxJao9QK91O8R0dmPIJ4V8Y/LGkyH8aqL
         LQZkGE2Xf9h49vOQwPoNXoXP0sx1c70JW1BZhOZ0nYAbhOdURzuJuoOZwWLlp3u0lEbQ
         NaeA==
X-Forwarded-Encrypted: i=1; AL+hErE5qln/s3MGqA3nA32MxoPIR+UngrKdBtaeyQtewQEl9FcnZoFzR26WxXp6/ZlHe/68WRU2Kg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+Ta0AuOHlG74qZirYdg4fGv6rlYpDn0vij9Ddaird5uVdV+oam
	xKER35RJZgOm4UbzrUwb02BCwr5ftLTFGcwLHOX2rhOYNfog/9NtFU2J1pt9y+GDsyyPfAEJ41y
	4+gx2gLz3W2rTMHJAiw==
X-Received: from ejai3.prod.google.com ([2002:a17:906:1143:b0:c3f:6b4b:bcf8])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f58d:b0:c41:7e99:c6c2 with SMTP id a640c23a62f3a-c5049656cbamr129203766b.44.1794286925434;
 Mon, 09 Nov 2026 21:02:05 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:43 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-1-tarunsahu@google.com>
Subject: [PATCH v4 00/19] kho, liveupdate: Add feature header for fine-grained
 ABI compatibility
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_210208_037346_FED236C1 
X-CRM114-Status: GOOD (  25.82  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This v4 of feature flags support for LUO and KHO is no longer an RFC.
This has gone through multiple design changes over the past few months,
and I thank everyone for providing their suggestions and reviewing it
promptly. Below I talk briefly about the evolution of this series to set
context and try to make it easy for everyone to review.

Initially, Logan proposed the feature flags in RFC v1 [1], which tried
to solve the problem of dependency on the compatible string. Feature
flags introduced finer-grained compatibility. This series had three
fields: active, supported, and required. The number of flags was limited
and didn't have flexibility, which reduced the complexity of the patch,
but put a limitation on the extensibility of the features.

After LPC and a few design discussions, I proposed RFC v2 [2], which
changed the flags to optional and required and converted the encoding to
2 bits per feature instead of having two separate variables. But This still
has the number of flags limited and fixed the feature header size to
128 bytes. Though each serialized structure is being allocated in
multiples of PAGE_SIZE (folio order = 0, 1, 2...), where 128 bytes is
not a problem, it still carries two fundamental issues: limited feature
flags, and a fixed 128-byte memory overhead for each preserved file. In
the future, as there are plans for moving to KHO slab, the allocation
for serialized structures can be significantly reduced and this 128-byte
size will be a problem again.

Based on the RFC v2 discussion, this v4 (v3 [3] was intentionally ignored)
moves to extensible feature flags with a variable-length flags[] array,
avoiding the fixed 128-byte overhead and feature-count limit.

Along with this, as discussed on RFC v2, v4 uses separate bit ranges for
required and optional flags (1 bit per feature). It builds on the
consideration that a feature in its lifetime will either be required or
optional; it can't be toggled into the other. In the future, if such a
need arises, a new feature flag can be introduced to replicate the
feature as optional or required, opposite to its ancestor flag.

This new layout and encoding in memory is as follows:

struct kho_ser_hdr {
	u32 size;
	u16 nr_required;
	u16 nr_optional;
	u64 flags[];
}

where,
	flags[i] = (BIT_MAP(optional_features) << nr_required) |
		   BIT_MAP(required_features)

This series introduces the feature header in the KHO subsystem, and it
is used by serialized structures across KHO and LUO. A few of the
serialized structures embed other serialized structures directly. To
keep the relative offsets of fields to be same across kernels, we cannot
have an embedded serialized structure's size changed; otherwise, direct
casting will not be possible. To solve this, this series converts those
embedded structures to KHOSER_PTR, which points to the memory just after
the parent serialized structure, and allocation and preservation happen
for the total memory (parent_ser_size + embedded_ser_size).

<Iamparent>_ser {
	u64 a;
	u64 b;
	struct <Iamembedded>_ser e_ser;
	u64 d;
}
	CONVERTS TO ===>

<Iamparent>_ser {
	u64 a;
	u64 b;
	DECLARE_KHOSER_PTR(e_ser, <Iamembedded>_ser);
	u64 d;
}

There are only two such instances: kho_vmalloc and luo_file_set_ser.

This series introduces kho_ser_hdr for the following structures:

  - struct kho_kexec_metadata
  - struct kho_vmalloc
  - struct kho_block_header_ser
  - struct luo_ser
  - struct luo_session_ser
  - struct luo_file_set_ser
  - struct luo_file_ser
  - struct luo_flb_header_ser
  - struct luo_flb_ser
  - struct pci_ser
  - struct pci_dev_ser
  - struct memfd_luo_ser
  - struct memfd_luo_folio_ser

If you notice, this also includes the PCI ser structures. PCI LUO
support is merged in liveupdate/next, and this series is developed on
top of it.

Each serialized structure is preceded in memory by struct kho_ser_hdr
and registered via DECLARE_KHO_SER(name, payload_size, nr_required,
nr_optional). Both struct kho_kexec_metadata and struct pci_dev_ser are
explicitly marked with __aligned(8) because their largest member is a
32-bit integer, and 8-byte alignment is required by DECLARE_KHO_SER() so
trailing feature payloads remain 8-byte aligned across 32-bit and 64-bit
kernels.

Also, Introduce DECLARE_KHO_SER_HDR(ser_name, fhdr) which is just the
wrapper for struct kho_ser_hdr fhdr, This makes it clear
To which ser_name, this fhdr belongs to.


Series structure:
  - Patch 1 removes __packed from KHO, LUO, and memfd ABI structures and
    asserts their natural size and 8-byte alignment under CONFIG_64BIT.
  - Patch 2 records entry_size in struct kho_block_header_ser so the
    incoming kernel derives the entry stride from the block header.
  - Patch 3 converts callers that embedded struct kho_vmalloc by value
    (memfd_luo and test_kho) to reference it via DECLARE_KHOSER_PTR so
    struct kho_vmalloc can grow independently.
  - Patch 4 converts struct luo_session_ser to reference
    struct luo_file_set_ser via DECLARE_KHOSER_PTR instead of embedding
    it by value so both structures can grow independently.
  - Patch 5 introduces struct kho_ser_hdr, DECLARE_KHO_SER(),
    DECLARE_KHO_SER_HDR(), and the serialization/validation helpers in
    include/linux/kho/abi/feature.h.
  - Patches 6-18 add the feature header to each of the 13 KHO, LUO, PCI,
    and memfd serialized structures in independent patches.
  - Patch 19 adds a KUnit test suite (kho_feature) covering the feature
    header helpers.

[1] https://lore.kernel.org/all/20260903023452.721732-1-loganodell@google.com/
[2] https://lore.kernel.org/all/20261021152527.375070-1-tarunsahu@google.com/
[3] https://lore.kernel.org/all/20261026174217.603114-1-tarunsahu@google.com/

Tarun Sahu (19):
  liveupdate, kho: Remove __packed from KHO, LUO and memfd ABI
    structures
  kho: block: Record the entry size in the block header
  kho, memfd_luo: Reference struct kho_vmalloc via serialized pointer
  liveupdate: Reference struct luo_file_set_ser via serialized pointer
  kho: Add feature header for fine-grained ABI compatibility
  kho: kexec_metadata: Add the feature header
  kho: vmalloc: Add the feature header
  kho: block: Add the feature header to blocks
  liveupdate: Add feature header to struct luo_ser
  liveupdate: Add feature header to struct luo_session_ser
  liveupdate: Add feature header to struct luo_file_set_ser
  liveupdate: Add feature header to struct luo_file_ser
  liveupdate: Add feature header to struct luo_flb_header_ser
  liveupdate: Add feature header to struct luo_flb_ser
  PCI: liveupdate: Add feature header to struct pci_ser
  PCI: liveupdate: Add feature header to struct pci_dev_ser
  mm: memfd_luo: Add feature header to struct memfd_luo_ser
  mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser
  kho: Add KUnit test for the feature header helpers

 MAINTAINERS                            |   1 +
 drivers/pci/liveupdate.c               |  99 +++----
 include/linux/kexec_handover.h         |  15 +-
 include/linux/kho/abi/block.h          |  21 +-
 include/linux/kho/abi/feature.h        | 372 +++++++++++++++++++++++++
 include/linux/kho/abi/kexec_handover.h |  11 +-
 include/linux/kho/abi/kexec_metadata.h |  17 +-
 include/linux/kho/abi/luo.h            | 102 ++++---
 include/linux/kho/abi/memfd.h          |  27 +-
 include/linux/kho/abi/pci.h            |  66 ++---
 include/linux/kho_block.h              |   8 +-
 kernel/liveupdate/kexec_handover.c     |  98 ++++---
 kernel/liveupdate/kho_block.c          | 172 +++++++++---
 kernel/liveupdate/luo_core.c           |  43 +--
 kernel/liveupdate/luo_file.c           |  58 ++--
 kernel/liveupdate/luo_flb.c            |  69 +++--
 kernel/liveupdate/luo_internal.h       |   9 +-
 kernel/liveupdate/luo_session.c        |  55 +++-
 lib/Kconfig.debug                      |  13 +
 lib/test_kho.c                         |  38 ++-
 lib/tests/Makefile                     |   1 +
 lib/tests/kho_feature_kunit.c          | 184 ++++++++++++
 mm/memfd_luo.c                         | 183 ++++++++----
 23 files changed, 1271 insertions(+), 391 deletions(-)
 create mode 100644 include/linux/kho/abi/feature.h
 create mode 100644 lib/tests/kho_feature_kunit.c

-- 
2.56.0.506.g506a7eabc5-goog


