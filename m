Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BB2D3B7EA
	for <kexec@archiver.kernel.org>; Tue,  9 Dec 2025 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f9gZ+HAcVYxjhk69z2YeZ7p4VDGLij0no/oxgM8IiD0=; b=hOdVM+yu/ZHE662gnmGWX35jJd
	HcwdXjEzE5FLqpIsfyI4aL++Bd0E1VeE0IzoOQtQCNh4W4PDyovGjH+6vpEHMZOvtOetynQCoHSmz
	DXmH17iuO6HrAA4z1yFl4KEHXeN4RxkkPBI5sBMfmnOpEqt9n9TGFp2dq7NTG/23tCy4PbAeg2PiQ
	hO2PoZIc3PiWCGA4suIy8AxOLmuRU3OA6xJThYuroMGRFGM7ivOyGDj703EU7ZS2VjtaqYNva7GeP
	Qn/6mHlnMBLxacf91HtQIwYrc+I22udIaoH03DWrUANTJ+0x0/8jKn0PHQj7/VPL5D6ZZEGodYcLE
	kXiFYtTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSnqw-0000000DkWm-0uRj;
	Tue, 09 Dec 2025 02:53:26 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSnqu-0000000DkVr-0ZvU
	for kexec@lists.infradead.org;
	Tue, 09 Dec 2025 02:53:25 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b9d73d57328so5798470a12.1
        for <kexec@lists.infradead.org>; Mon, 08 Dec 2025 18:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765248802; x=1765853602; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9gZ+HAcVYxjhk69z2YeZ7p4VDGLij0no/oxgM8IiD0=;
        b=hPDCS8UmU6ViyBs+XBT5lnPjyx0cr4elg5dRzwJayWWnfZz6+VDxISa1UUl4RSXHWb
         inYFyrDB8iWtVVwFLzG1PfbEK5vF6yAICKYSYYC5sTZrucXRygjS04536PbBnQW6pCeE
         CpaFmAjynInD60tnl/cuwdJJxDCUzY0alobmODPGBT+guG7PtsnNLypDRKgCvRPsiWQc
         3QM+O6QzPPdy2cLCTCfTeICgr9I08su+kX5VfQ6wRwDFoMjtnmPS7KqjKvDRRdZO+zV9
         xJW9rXzEkJswGouQoW5wNWrahFA9Y+vwMFqgH4kfKZRYCRksVgdykT9SYPd8zLGBQs1o
         4J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765248802; x=1765853602;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9gZ+HAcVYxjhk69z2YeZ7p4VDGLij0no/oxgM8IiD0=;
        b=ZI4F7wnl/zrXD9JDZtxKHLJsrbjCQ1JwEbRQ0/hP2EeGuMQUMCwBKIwKE6Uxlkj+w0
         qvwssyBfwBoqa2mXA+rQSL/EzwGkSAupyhq3oct2VBu6K3uiWMx6oO+5mt/8V/u1lfM7
         mBz7VOYQz0GFR/PdTKseFrwVlIxscU1+X9QT5nes4JC1wB2QN7iT2HNwXTrs8Yaw2QcG
         sFN8ZzwxymXeNMlr45mxACYn1qKGPlCJY/xuUSpB/TZUXDsyw+wguguGLmcBVeHZJ7DM
         hPLyzeZky6rs26w1agfrvugq+0f/RGDA11x75fgTq4TKpkcMt+O/7FmJ03pgSjd9/qhT
         9ZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ41fDwDDCImnPMnnZx756G8bgaVR/n547XOrCgQrr+llG+JHI0lmvzIbh/dlhALhKHI4vLw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzQRC7dwemSmnxRrfk6jYFnjIHV1UdqM9CzTCbzDYYTCn70KSqE
	7nUza/LYLqpNTOLLZJvnCbrWkYnufZg9mIUo/BbZJuDGjT5macPBoS+RmTMxRzwEuFU2KxXokTg
	WkwEWDIbLMecjrg==
X-Google-Smtp-Source: AGHT+IG4gpI9zqTEOKN9vzBYmrGxjK0E+Np3UyMM98Hh4RHj2KGXooaQHcs0e+c2q3YeS6uW268akwQ8U9IxFQ==
X-Received: from dybtr7.prod.google.com ([2002:a05:7300:f547:b0:2a4:50ea:8fa8])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:8807:b0:2a7:343:399c with SMTP id 5a478bee46e88-2abc712a148mr3561851eec.16.1765248802275;
 Mon, 08 Dec 2025 18:53:22 -0800 (PST)
Date: Mon,  8 Dec 2025 18:53:12 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251209025317.3846938-1-jasonmiu@google.com>
Subject: [PATCH v3 0/4] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_185324_176987_85C0DD7B 
X-CRM114-Status: GOOD (  14.19  )
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

Changelog since v2 [1]:
- The preserved memory tracking data structures is defined in the ABI header.
- Relocate the `kho_vmalloc` struct and its helper macro to the KHO ABI
  header to formalize its status as a stable ABI.
- Export the core radix tree manipulation functions as a public API to
  support broader use by other kernel subsystems.
- Update the documents.
- Inline comments have been cleaned up.

[1] https://lore.kernel.org/lkml/20251020100306.2709352-1-jasonmiu@google.com/

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


