Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA07CCD199
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 10:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3zkkb3/hxx2ZrEmxAOPFPinoGf8SbvbCWVFeKCtPhzY=; b=QC/kghMyo+lRNiR5etDO2Qc+SU
	w9LZwIulQqxhtkF5GQ6ydxVIqXVu736OrRE9VUu3gTyrqLYDQ5SSIKaEC081DvbGzSKfwGxSBXNNc
	LVePnCXSmsditv0SplbvFMvZV7wYpoyhM09ZPWmH18iH32LiVGhTPWcZp4o5SnbrY4BtMJXyOK3HS
	sLXP5HnAD9jYZgNBVKM3CDrRm2L0nATiPVizPoa4x9Dj/SnDRynIokiRj29xGjco54mA4yvfb+7Fv
	syhUhr+x3C22svbbjZvP0jvp9pyAn9r+HIW7Zc/fwfFIR9Z9VEoFPO2cX1gH31KDdGi70Ta6Yjbr5
	mBhNxHCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAmjS-0000000Ci5X-0v2Y;
	Mon, 20 Oct 2025 10:03:14 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAmjP-0000000Ci4K-1GzT
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 10:03:12 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso2878487a91.3
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760954590; x=1761559390; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3zkkb3/hxx2ZrEmxAOPFPinoGf8SbvbCWVFeKCtPhzY=;
        b=W+ippwcIImMkA1n8OHwdn5MHYo8n3cxJmssN66KaQqf2vQZvp/m2XmMmbxx//8ax1w
         TGWIPtFWv3RGLMvOEDuOYuC5QnrlRo/1IAJ1YeCaPo5VHdUhga8XypHGVoZ8rpTlc1J4
         gBy/uRm/46mStupE/vst7AMU0EjOLvx11LBW+IIHVuE7e4sCSxt6rSw2ZJ7JcgtokYGP
         jRzCPUuFF9Fy2immVwjeeIPjwFx60TIvQUKo7hXNXC5xS5/Fvqjr7liwAldFSp1x0LnI
         x/0ztWe/fVlSgB7CCvAQfjaJwOJZ6ozGUZ29FMNSkjdIq5DMkDz5fa4DtRGCOr4A/Mol
         dwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954590; x=1761559390;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zkkb3/hxx2ZrEmxAOPFPinoGf8SbvbCWVFeKCtPhzY=;
        b=hJXMcexlobOUxDQIWZPT5rTYTNMhttYRvUKRBQ7xjnBRCjr8zG1ThcqjdJLvbYATz6
         qCiIlVrjiihNhA3EALPKL/ixwQqLq6rPznjbGCmA6vimRoaRmLVc+m8KpTnhG0sW3SpM
         n8A8zBAc81AHX6vLyM9Q0RfhjyGohISDBJMzLznXIqAbqd1oWp5sFDX60RCcjt9dH7uf
         r6oyR5YYdNCm/KRsFrlBHolgFhXeU2D+KapWdrG6y2IqaxmVmyvUiAgKqZckjC49ZmKf
         OVVqQQtknx4er1gBPjui+0z2h+dKEQJ9yJtfBNhFFG6ZvsDjHDKfn/79tzXmXfSUacZ6
         gijA==
X-Forwarded-Encrypted: i=1; AJvYcCW3DeadgfTiK2O5yDiiVkKxwc5ylUnz9v44pfsyuidso7kXwGs4KrZ0TTeR9UHATNC1HxjdFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjJYKrwNFszhVTIg85clXU0AVR6JQW7+zNTRyNMRY1ahz9EcOi
	n4hd1RAMfqVBuFjpX50CeT5IZd7TtrJ3kSh+R9JGFzIRkqwujzYXzglcwXYMwb3/ObZTOSNhulb
	ilt2TjRABwTcNnQ==
X-Google-Smtp-Source: AGHT+IE39JYyDP7tyke6Ks7t0xTJvAaz4ioHAVUQMd14F2ylAQznE4GvniXnCX4D+Lio6mB0thI0FwjEvWtddA==
X-Received: from pjtk2.prod.google.com ([2002:a17:90a:c502:b0:327:7035:d848])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:270a:b0:33b:ae47:fe72 with SMTP id 98e67ed59e1d1-33bceb1cf3cmr15607754a91.0.1760954590010;
 Mon, 20 Oct 2025 03:03:10 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:03:03 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251020100306.2709352-1-jasonmiu@google.com>
Subject: [PATCH v2 0/3] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_030311_343406_61568488 
X-CRM114-Status: GOOD (  11.81  )
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
- Remove the former KHO state machine by deprecating the finalize
  and abort states.
- Pass preservation metadata more directly to the next kernel via the FDT.

The new approach uses a radix tree to mark preserved pages. A page's
physical address and its order are encoded into a single value. The tree
is composed of multiple levels of page-sized tables, with leaf nodes
being bitmap tables where each set bit represents a preserved page. The
physical address of the radix tree's root is passed in the FDT, allowing
the next kernel to reconstruct the preserved memory map.

The series includes the following changes:

1.  kho: Adopt KHO radix tree data structures: Replaces the xarray-based
    tracker with the new radix tree implementation and removes the
    serialization/finalization code, thereby eliminating the KHO finalize
    and abort states.
2.  memblock: Remove KHO notifier usage: Decouples the memblock subsystem
    from the KHO notifier system, switching it to use direct KHO API calls
    and adjusting KHO FDT completion timing. KHO selftest is also updated
    along with the APIs change.
3.  kho: Remove notifier system infrastructure: Removes the now-unused
    notifier infrastructure from the KHO core.

---
Changes in v2:
- The radix tree now uses 0-based level numbering (previously 1-based).
- Added a new public API: `kho_remove_subtree()` for clients to remove an FDT subtree.
- The output FDT is now protected by a mutex.
- FDT properties have been moved to a new header: `include/linux/live_update/abi/kexec_handover.h`.
- The KHO selftest has been updated.

---
Jason Miu (3):
  kho: Adopt KHO radix tree data structures
  memblock: kho: Remove KHO notifier usage
  kho: Remove notifier system infrastructure

 include/linux/kexec_handover.h                |  42 +-
 .../linux/live_update/abi/kexec_handover.h    |  10 +
 kernel/kexec_handover.c                       | 869 +++++++++---------
 lib/test_kho.c                                |  28 +-
 mm/memblock.c                                 |  45 +-
 tools/testing/selftests/kho/init.c            |  19 -
 6 files changed, 464 insertions(+), 549 deletions(-)
 create mode 100644 include/linux/live_update/abi/kexec_handover.h

-- 
2.51.0.858.gf9c4a03a3a-goog


