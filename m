Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3CAD232C7
	for <kexec@archiver.kernel.org>; Fri,  9 Jan 2026 00:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VNtmiXXVMpIpjKeokSIj374jlcsqfD2I2+s5Exq8j0M=; b=CNtI/oOo/7+I4kslUrD+UrEFAD
	HNGhYIFxnfu1XiGrzELSdPoCLWItw4eB/8O6SLJqT7ni+hwf0Q197h3sxa24L+rZnoq7EbahEnxDr
	q/WB+eCHom5wSqPfyUxfHkAIMtZKnvhlK02dA21di8oloRs+vTGkhaJgJQelFRoWuMEh3u9sz1eYy
	QxhfwwK1xq/tJXzQzAcCzi+rOKnSBqZSQTImjbOnJGKszyZurombEXT5Ag/peXBwm6oGJkDUY7BYH
	nJT3ywBdPRHpVWE+YVz2o7+D0O7LnqDwh0udKeJzUfjucmKH2urwLUSYn7G1nQ3atbUlyVUS7tTdm
	FWRRmV4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve06M-000000011R7-2Llk;
	Fri, 09 Jan 2026 00:11:38 +0000
Received: from mail-dy1-x134a.google.com ([2607:f8b0:4864:20::134a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve06H-000000011QB-0C2k
	for kexec@lists.infradead.org;
	Fri, 09 Jan 2026 00:11:35 +0000
Received: by mail-dy1-x134a.google.com with SMTP id 5a478bee46e88-2ae56205588so4145675eec.1
        for <kexec@lists.infradead.org>; Thu, 08 Jan 2026 16:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767917491; x=1768522291; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNtmiXXVMpIpjKeokSIj374jlcsqfD2I2+s5Exq8j0M=;
        b=2Sb99U0DkM1dmeZEraSRyG+rhi1KCbWKQdQL3aaYQX+P/kobzuy6Dc3szThyIYFXLu
         bO0aJU8Aem0ansZgUgY4QLWif2tlnK/tEcn3hoU/tXm562IAtjp/8tbcyrc4zzDnnyd2
         cDp3+A9ya0WUDDAH3wTYtq9YtrGVhLy0CyUo8wLwOMr+Kn9fa0ElSh14TvgnQEAgcDpa
         B7vd/vuNvbCdSuzW2V297pL3psMBhHrNsvW0IV+6SFmo9LfOiDVZqq1+Hf0pjXl6bhfO
         eSVtbhsdJspm+kaTK27iM7ETXXIAEL8VR1R8vR9bj2xzP1jAFtubOEBp/pRgvoL9z143
         FaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767917491; x=1768522291;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNtmiXXVMpIpjKeokSIj374jlcsqfD2I2+s5Exq8j0M=;
        b=jr3sHS8Q2vEyjvwnUg6cCTnBL+Wa6mNfZYnlkU7A6n16jdBogq9Z+Pd/QefoTbiExs
         zrCHNtZn0zHrAyCk/2u1FAuYbV3Bke6C0ejOJJyz/61c8y4kcC+ZEjwTfy9BCk1Dh7gy
         mRwRassGMFcYmGSQEaLlT72/E0DD+lnIxA03V4XH/YFYeZ+HYosfL4x+TpDykgnyBleM
         Wygtq8jsDtWCvMfDVmm4QKy/yANYnjz5116P6+x/x26ybMp2YKln4qkAyFeSPYc7ifdu
         0nwwJoeai6rEH+PBXz91VcGefjcsxZ000afw0VcRg+R2GDt4E0TDrwe5nkEsJw4YgWB9
         Gqcw==
X-Forwarded-Encrypted: i=1; AJvYcCUF4E4DsiXEMVj1DBLlen2USrPh54wdOsqLcd+u9E7TFY5WWGIpYb2xDhldW98kg07NCJI8/g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcleNG52a7BW4MNVghVBpujZcD/vtqWG4XzJHDEziYlsYOhagq
	aqQPg+YU1HFwmnrAtbU0LFBAxH3A7/+RCFDP3CSVt5jB+IeQV75RJX9luDyjjdF9AV0boxf85La
	VsSL+TnSMYpMOwQ==
X-Google-Smtp-Source: AGHT+IEg07jJ9OPJkKkmCWjDY4B+wb9xBXz7fBkAifPrpk4fCrC1NnhSeBjwSL6KURgNGGSLzkcOpp7iZv8H2A==
X-Received: from dybnx41.prod.google.com ([2002:a05:7300:e7a9:b0:2ac:1eee:fdb4])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:fe88:b0:2ae:5bd8:1dc9 with SMTP id 5a478bee46e88-2b17d2519cdmr4148660eec.14.1767917491269;
 Thu, 08 Jan 2026 16:11:31 -0800 (PST)
Date: Thu,  8 Jan 2026 16:11:25 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109001127.2596222-1-jasonmiu@google.com>
Subject: [PATCH v4 0/2] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_161133_112093_D0759838 
X-CRM114-Status: GOOD (  14.44  )
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
with serialization to a radix tree data structure that can be passed
directly to the next kernel.

The key motivations for this change are to:
- Eliminate the need for data serialization before kexec.
- Remove the KHO finalize state.
- Pass preservation metadata more directly to the next kernel via the FDT.

The new approach uses a radix tree to mark preserved pages. A page's
physical address and its order are encoded into a single value. The tree
is composed of multiple levels of page-sized tables, with leaf nodes
being bitmaps where each set bit represents a preserved page. The
physical address of the radix tree's root is passed in the FDT, allowing
the next kernel to reconstruct the preserved memory map.

This series is broken down into the following patches:

1.  kho: Adopt radix tree for preserved memory tracking:    
    Replaces the xarray-based tracker with the new radix tree
    implementation and increments the ABI version.

2.  kho: Remove finalize state and clients:
    Removes the now-obsolete kho_finalize() function and its usage
    from client code and debugfs.

---

Changelog since v3 [1]:
- The patches introducing the KHO FDT ABI header [2] and relocating the
  vmalloc preservation structure to the KHO ABI header [3] were merged
  into another series [4].
- Use `struct kho_radix_tree` to encapsulate the tree structure and
  expose it to the public radix tree APIs as an argument.
- Public radix tree APIs now manage the tree structure's lock internally.
- Protect the radix tree with a mutex lock instead of a read-write
  semaphore.
- Radix tree root pointer validation and warnings are now centralized in
  kho_radix_add_page() and kho_radix_del_page().
- Updates to the KHO finalization logic are grouped into the second patch.
- kho_radix_encode_key() and kho_radix_decode_key() were removed from
  the public APIs.
- KHO radix tree callback function takes physical address and order of a page as
  inputs instead of a radix key.
- Refactored kho_radix_get_index() to use kho_radix_get_bitmap_index().
- Updated the documentation.

[1] https://lore.kernel.org/lkml/20251209025317.3846938-1-jasonmiu@google.com/
[2] https://lore.kernel.org/lkml/20251209025317.3846938-2-jasonmiu@google.com/
[3] https://lore.kernel.org/lkml/20251209025317.3846938-3-jasonmiu@google.com/
[4] https://lore.kernel.org/lkml/20260105165839.285270-1-rppt@kernel.org/

---

Jason Miu (2):
  kho: Adopt radix tree for preserved memory tracking
  kho: Remove finalize state and clients

 Documentation/admin-guide/mm/kho.rst        |  52 +-
 Documentation/core-api/kho/abi.rst          |   6 +
 Documentation/core-api/kho/index.rst        |  23 +-
 include/linux/kho/abi/kexec_handover.h      | 141 +++-
 include/linux/kho_radix_tree.h              |  72 ++
 kernel/liveupdate/kexec_handover.c          | 703 ++++++++++----------
 kernel/liveupdate/kexec_handover_debugfs.c  |  23 -
 kernel/liveupdate/kexec_handover_internal.h |   3 -
 kernel/liveupdate/luo_core.c                |  12 +-
 kernel/liveupdate/luo_flb.c                 |   2 +-
 tools/testing/selftests/kho/init.c          |  20 -
 11 files changed, 573 insertions(+), 484 deletions(-)
 create mode 100644 include/linux/kho_radix_tree.h


base-commit: f96074c6d01d8a5e9e2fccd0bba5f2ed654c1f2d
-- 
2.52.0.457.g6b5491de43-goog

