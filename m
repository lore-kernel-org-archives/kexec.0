Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F27D29DCD
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 05:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9CxZpP/TD91KuOGl9bFKk1rpeztgtL+/Anznpdt7LJs=; b=rLjebfjEk1Y0iBWzabXNZpVld9
	lFJCTq+SwU4wfrBTAPXwvTCWmb6V5wU1ZXDOcAKyrDyR8hfnzCOrl9nnrpY3qHwmwqR8Dn41k7fKE
	r7tba8OOVIVlM5y3Nw1sCB17ONZAKIJyUZ0/NdOnoYj61nDv9CHfEDxOfRnMDgudkPQgE6bGz5A55
	WGFlhpCmavXkFrSZqWO0WXtVj4RcyNeBcuwcpPRZhi6kOACePKqIQ5b5N/LYt1FWoK5xOuS6gNZaX
	Vywche6xcOmTAsH8X+J4xQvItqloFIev8vGTyt9MCBjGiM098IoRFl+wM+AD+1CGprfWKGx+8x6zp
	PtUgI0Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfX40-00000006Yey-315a;
	Tue, 13 Jan 2026 05:35:32 +0000
Received: from mail-dy1-x134a.google.com ([2607:f8b0:4864:20::134a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfX3y-00000006YeN-11KD
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 05:35:31 +0000
Received: by mail-dy1-x134a.google.com with SMTP id 5a478bee46e88-2ae29a21e7eso4178401eec.0
        for <kexec@lists.infradead.org>; Mon, 12 Jan 2026 21:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768282528; x=1768887328; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9CxZpP/TD91KuOGl9bFKk1rpeztgtL+/Anznpdt7LJs=;
        b=Euo0hnkfvoQiCXuFuw89nVewtlOvf8SkN3SvCD2szd7/ktlBr4wId4TI3SwSLOR3Mg
         3qZxEi6cYJgxJ40jHDEoMCzeHhLdOxjlpklJLC2ipmId/hkrB/n7AiEGoPtQm94jSp0N
         fWHzT0Gvnnu/noRsIYomd4IypIBm71cIFVmJ8VZC5QoLdd8snCwvswqdB2HmZPc2MR/S
         fCyQpKtOKNuVVX81GSwaQrufmwdtPq12HERMrGN0/0RgpErQYAWkji2rDUBfaSgicxi7
         xcEinChlZZ/sCGzkJHd3SBPPUd2drxpjrHdxELg4hdQjmFOo9yl///r3t0T65CQYDwOO
         yD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768282528; x=1768887328;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CxZpP/TD91KuOGl9bFKk1rpeztgtL+/Anznpdt7LJs=;
        b=odvubi1EyaPO7xRpitR7cLjoS+tVrhhDhtJDYp5SPV+s6Via5LVzPHR63+VOzKHXDW
         H7AlOzmAuEvVkAvlrXzx98k1WV1liTlOR8TaUXgvR4RpKAM5gdrdErNKYf9yLHwwu1KA
         x610V6LEZb4H5yAYtwz6N/N9ssldc/cPFUP8pBYbnaXK/wC3hXN39NNXTqred4nJcQwj
         A5sleXjRaf5oR/UAYdGmURRdlQNnGA7BhRNdRxXykbhyTGnDsvjsgNLDSngtOCfoGYFw
         ZKGgvs9D/MreCstIOoQ5ZMMJ+NYKt146/OKwnFP7lFSmTx3r+RObgI8cORmW2FSFX4ae
         a0pA==
X-Forwarded-Encrypted: i=1; AJvYcCVXeOLb/RfHFF38fmErNzaMQ/HqiRPz+WkfN5svqPzoO+guiNEcLBt49zJdmGhxbc6oHlWq+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzwRmuxcpeaHOjQKFVlc+qCw8xnsmDmaX3rZlMhtfGp2Fw6OdzY
	YQuPOm5GTLEFwtJzIZiQRP3AEkkY/poqxhQpmtXYM5IBOFWx28BxrlWZ0ncE4IipQcHZ0DtEHdR
	xuTu90YWn3Qo2vw==
X-Received: from dybdr38.prod.google.com ([2002:a05:7300:b2a6:b0:2a4:733c:4a27])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:a148:b0:2ae:5a2e:de70 with SMTP id 5a478bee46e88-2b44f21b4b9mr1940864eec.8.1768282528208;
 Mon, 12 Jan 2026 21:35:28 -0800 (PST)
Date: Mon, 12 Jan 2026 21:35:21 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113053524.84186-1-jasonmiu@google.com>
Subject: [PATCH v5 0/2] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_213530_291281_AB64776D 
X-CRM114-Status: GOOD (  12.72  )
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

Changelog since v4 [1]:
- Removed the 'level' and 'start' arguments from the KHO radix tree API
  kho_radix_walk_tree().
- Removed locking of the KHO radix tree root during module initialization,
  as it is the sole user of the tree at that stage.
- Renamed kho_radix_get_index() to kho_radix_get_table_index() and updated
  callers to invoke kho_radix_get_bitmap_index() explicitly for the bitmap
  (leaf) level.
- Updated documentation to clarify that "page offset" is now referred to as
  "shifted physical address".

[1] https://lore.kernel.org/lkml/20260109001127.2596222-1-jasonmiu@google.com/

---

Jason Miu (2):
  kho: Adopt radix tree for preserved memory tracking
  kho: Remove finalize state and clients

 Documentation/admin-guide/mm/kho.rst        |  53 +-
 Documentation/core-api/kho/abi.rst          |   6 +
 Documentation/core-api/kho/index.rst        |  18 +-
 include/linux/kho/abi/kexec_handover.h      | 141 +++-
 include/linux/kho_radix_tree.h              |  70 ++
 kernel/liveupdate/kexec_handover.c          | 682 ++++++++++----------
 kernel/liveupdate/kexec_handover_debugfs.c  |  23 -
 kernel/liveupdate/kexec_handover_internal.h |   3 -
 kernel/liveupdate/luo_core.c                |  12 +-
 kernel/liveupdate/luo_flb.c                 |   2 +-
 tools/testing/selftests/kho/init.c          |  20 -
 11 files changed, 557 insertions(+), 473 deletions(-)
 create mode 100644 include/linux/kho_radix_tree.h


base-commit: f417b7ffcbef7d76b0d8860518f50dae0e7e5eda
-- 
2.52.0.457.g6b5491de43-goog

