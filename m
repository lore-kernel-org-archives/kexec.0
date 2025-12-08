Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5F1D3B7E1
	for <kexec@archiver.kernel.org>; Mon,  8 Dec 2025 06:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZqyNPlmDIsr9igOdfXIDir5SMEz9QXEH46sRqM37UGQ=; b=ErXaBRLIgGOZmEps9rn805zf4y
	j7vwXLW7soQIOK2MAkGJ5Bxri5ZQ8kk6wk09R0DfUl1jRx6INe7UwAvUnN3FmybWX5/1tbpIuv9qW
	xkbMJltb/DEFkgSbzcXRghuYRpJiHrCNhKb3/RcgyN+wgiejQRD/hqbaVS1m5ym3L/s/OhbzWvFib
	w64r2B6sWJMA+SMweH/s6y92wopIckbFxY3DLe0p9vrfau7ngL2B/tLp542dqIkig6MROaNdfLttw
	DGjFoAWD3NCdgG34Q3IbGkSfpXx0zYkVLK1SU8lLMHf1u0e8vh/07nnVSVOHVTNbYwH2kNlx26LH/
	dKNZ39cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSUqI-0000000ChVT-2yH2;
	Mon, 08 Dec 2025 06:35:30 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSUqB-0000000ChUO-3dg5
	for kexec@lists.infradead.org;
	Mon, 08 Dec 2025 06:35:25 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so4258372a12.3
        for <kexec@lists.infradead.org>; Sun, 07 Dec 2025 22:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765175722; x=1765780522; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZqyNPlmDIsr9igOdfXIDir5SMEz9QXEH46sRqM37UGQ=;
        b=yVCpkSL1twI4gjgT6jjAHtyu41vMRs/xnYPLjbbh5f72JrSWxwN+ELkuRWPmE6Q0Yg
         Viel3f2jFH4gh0plD7sW8vKqImUnUWsEBEzS+JpatfTPjn69N3KueMlX+2sLWVSIAKBe
         FVEP4j2ifoFzoUzKuR+AZyTlzHKrWEiiJiG+kQj4lG+HbjKlgcCqmNJGnAj+av1RIhyB
         VxDljsxOBzKCe4N9tBXQHOqNs9VBbZ9n69pk6zHeYDZGav8NnyGfbGU9IHY57q0KvF9F
         VR+N4M8E2MIgTIVOmBTUXEl0o+KJuT3ynFhtsut3eWpeVHgQXCv/qekRzBcOFI8f1bxa
         aRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175722; x=1765780522;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqyNPlmDIsr9igOdfXIDir5SMEz9QXEH46sRqM37UGQ=;
        b=E2UO9rpqAXbZXwa3iGxXBLH4d09M15chxebht5c+Q2nkamFXmESynb88/AqEQbfpYE
         sKm5WhNfeV7w1m/jXDnx0eRhYko/uKqDpD8+wcMVpXemBqX3TLLjxIlsuG7QUA67p26/
         jBs/eGfLC3rAuy1cexHBblGfz3Xx8uzDTVv4VNjCq8jcvwhe1aKmjivn3UEA0EtCQmQK
         B/B36UAr/mCeqqlPPZpPRP3+mMuHhPiD0BHQUoSFSiNYwuqLXAidWnTvbvGYazHtXq1q
         jkOmo1E9udfOmIcp2OmsDhrUVQI7X+T5pxbUYOQiDeysaATQlvkDgCFLpBSMhQYfkE7m
         mVNg==
X-Forwarded-Encrypted: i=1; AJvYcCWjj1hhHrHrlnIjqi+dS2o3JQ6EVtrW3G5huSaBlJRsif9l3JJl7WHp895OJ+byvfO1zRAikw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzwyLjocE3Ht4gPJMfAED9jGZvCriXJDfj3PpQHHf8Afv8RPlk8
	dr0LEgru/eMOvyvYW6/nWQYz/j+1D59NWB57eDEoEwk1Yz5u+RIoJjqlReM3HBsq0mEfDIR2nSJ
	9XdOE6sQ/fhU/kQ==
X-Google-Smtp-Source: AGHT+IHAI3z1pMXzyBPNpREzJHkOBRWhaGBqjtnbPcPl9gXNFuPCdYXbJdbTdfH/iA28L93uYP4ZI3E2jt+oqw==
X-Received: from dygg16.prod.google.com ([2002:a05:693c:80d0:b0:2ab:9753:da7])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:7187:b0:2a4:3593:ddd4 with SMTP id 5a478bee46e88-2abc70f78e9mr2666178eec.1.1765175722204;
 Sun, 07 Dec 2025 22:35:22 -0800 (PST)
Date: Sun,  7 Dec 2025 22:35:09 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251208063513.3633942-1-jasonmiu@google.com>
Subject: [PATCH 0/4] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251207_223523_970147_5D8ED5E0 
X-CRM114-Status: GOOD (  13.56  )
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

This series transitions KHO from an xarray-based metadata tracking system
with serialization to using a radix tree data structure that can be
passed directly to the next kernel.

The key motivations for this change are to:
- Eliminate the need for data serialization before kexec.
- Remove the KHO finalize state.
- Pass preservation metadata more directly to the next kernel via the FDT.

The new approach uses a radix tree to mark preserved pages. A
page's physical address and its order are encoded into a single
value. The tree is composed of multiple levels of page-sized tables,
with leaf nodes being bitmap tables where each set bit represents a
preserved page. The physical address of the radix trees root is passed
in the FDT, allowing the next kernel to reconstruct the preserved
memory map.

This series is broken down into the following patches:

1.  kho: Introduce KHO FDT ABI header:
    Adds a dedicated ABI header to define the FDT interface.

2.  kho: Relocate vmalloc preservation structure to KHO ABI header
    Adds `struct kho_vmalloc` and related structs to the ABI header.

3.  kho: Adopt radix tree for preserved memory tracking:    
    Replaces the xarray-based tracker with the new radix tree
    implementation and increments the ABI version.

4.  kho: Remove finalize state and clients:
    Removes the now-obsolete kho_finalize() function and its usage
    from client code and debugfs.

---

Changes in v3:
- The preserved memory tracking data structures is defined in the ABI header.
- Relocate the `kho_vmalloc` struct and its helper macro to the KHO ABI
  header to formalize its status as a stable ABI.
- Export the core radix tree manipulation functions as a public API to
  support broader use by other kernel subsystems.
- Update the documents.
- Inline comments have been cleaned up.

---

Jason Miu (4):
  kho: Introduce KHO FDT ABI header
  kho: Relocate vmalloc preservation structure to KHO ABI header
  kho: Adopt radix tree for preserved memory tracking
  kho: Remove finalize state and clients

 Documentation/admin-guide/mm/kho.rst          |  46 +-
 Documentation/core-api/kho/bindings/kho.yaml  |  43 --
 .../core-api/kho/bindings/sub-fdt.yaml        |  27 -
 Documentation/core-api/kho/concepts.rst       |  28 +-
 Documentation/core-api/kho/fdt.rst            |  84 +--
 Documentation/core-api/kho/index.rst          |   1 +
 Documentation/core-api/kho/radix_tree.rst     |  17 +
 include/linux/kexec_handover.h                |  27 +-
 include/linux/kho/abi/kexec_handover.h        | 268 +++++++
 include/linux/kho/abi/memfd.h                 |   2 +-
 include/linux/kho_radix_tree.h                |  81 ++
 kernel/liveupdate/kexec_handover.c            | 694 +++++++++---------
 kernel/liveupdate/kexec_handover_debugfs.c    |  20 -
 kernel/liveupdate/kexec_handover_internal.h   |   3 -
 kernel/liveupdate/luo_core.c                  |  12 +-
 kernel/liveupdate/luo_flb.c                   |   2 +-
 lib/test_kho.c                                |   1 +
 tools/testing/selftests/kho/init.c            |  20 -
 18 files changed, 765 insertions(+), 611 deletions(-)
 delete mode 100644 Documentation/core-api/kho/bindings/kho.yaml
 delete mode 100644 Documentation/core-api/kho/bindings/sub-fdt.yaml
 create mode 100644 Documentation/core-api/kho/radix_tree.rst
 create mode 100644 include/linux/kho/abi/kexec_handover.h
 create mode 100644 include/linux/kho_radix_tree.h


base-commit: 7d31f578f3230f3b7b33b0930b08f9afd8429817
-- 
2.52.0.223.gf5cc29aaa4-goog


