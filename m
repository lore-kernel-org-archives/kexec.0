Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C2AD4A5F9
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 03:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XajjLO2IfEQWNmg3arj/S1hgJxiIRRitST6jLheATpY=; b=iig/swTm3QM3cbbq6tsxgAIAlG
	Vc0nYRdZaK+yVMvPhMMkCB+4kT2QMuKCNgyZ5dRI5IzV1dA1LDi84MFRHHNxybSo1Vcyoscm31KdR
	EbKs77Nbw9BeiZ4/wLOlZF/h0ziZUBSbY25y5ULDX2MJ60qJXkGYx1pYR4pXtGRO+ugpWMFJUW0Zw
	EwqOtcVqr+qWvsFQlF2V+Yn/vm8WgNGIjUBDgL4Df9Xp3ensG8h14rkStc+7s+n3zPrvaLfA1dsQU
	h0jJNk0BQkZF9iUCTjdgYUrJ7TkzSlx+mzWo7Q7azxJliprRM3ckh6NwSSjaCKKZDUMVlQ/nyeFJW
	xOKX3UHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgalN-0000000DXcq-0Pr1;
	Fri, 16 Jan 2026 03:44:41 +0000
Received: from mail-dl1-x1249.google.com ([2607:f8b0:4864:20::1249])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgalJ-0000000DXby-2TiO
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 03:44:38 +0000
Received: by mail-dl1-x1249.google.com with SMTP id a92af1059eb24-11b9786fb51so10332602c88.1
        for <kexec@lists.infradead.org>; Thu, 15 Jan 2026 19:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768535076; x=1769139876; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XajjLO2IfEQWNmg3arj/S1hgJxiIRRitST6jLheATpY=;
        b=31WXM2+raZjCv8nqzcAE2eAkWR3V5U5qj5Di+C/gWfOWiSQntXPZ96SLi/lTuHdiBR
         LvLAKyC5tkxPGg5smpqEIkqJdRdTCbsKYRwtHYHyr+ET/OJg7Z6t0yhdkgofCoIMXUZv
         0qJaffqHEZ4tokq73XiMIV5nzoP2PS8c+qcy2V8AYPauIvWGR9zLJjYltY8+ev5pyf6J
         poFb5PpefEFkzotRhlWrVPVvVMnpXAPxu8ecX22OgAL/EeZ2KswwHC6zIlhnlW9HFSx9
         3Pa6YeOjInBAs1IA4aEz807+7kKqiuPIp6D4Df0rXb3SHxm2FTS//li6dfkyxfSb6i+H
         b8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768535076; x=1769139876;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XajjLO2IfEQWNmg3arj/S1hgJxiIRRitST6jLheATpY=;
        b=clWKNTMbVCMoJomDMhVaXqwo7IsuZfCV6Sg+uL2FANX+zPZ2FTV1di+ZCFZt65kHff
         dtcM4kSQ2Xl/9vyeGUu0YqGGL3l74b9ymG/z6OUpAcGa2DF7I2DHvO0ZPkG4Ds1/Ucow
         uZxNaG5aRGipmwExl4ln+921fxJjzsMcjD1dMGB7dzX41J+VeXJ750UpwM6AdRTuRYcK
         bdHeLtJtYNhMEQIresnBSaV7fldfvlSYwhtesHPp769+p09UEqUylj4MGn6lFPSy9igQ
         fVEa4j/Q526Hgt78g3Mzb8e3zJNjBYVoBI5wUwsgOZvRQeTHp+SMgFlxZZL5BztMUgNs
         DyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZUIVE20Hkx1FPxiAA3tElS2sYdB9Hc7p+EgWTZcZIUoq4XSpEAZ5CLy7sOBcsR4mD20hoQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3qoGIuJ1dZ1OMf7S4EV4teIrrr41r8PwN/gkp40Nf2rv2YZZD
	8Nmhbet6OFblRl6CWM3AJfrffP/kIUjVi75Zf2FASvpUbl4TfWtv8itcVGiwvsOhvs78qlJty8M
	QcRoHQZoOMJ7BuQ==
X-Received: from dlkk2.prod.google.com ([2002:a05:7022:6082:b0:11b:b064:f5dc])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:a8a:b0:11b:9386:825c with SMTP id a92af1059eb24-1244a791c71mr1740076c88.41.1768535076050;
 Thu, 15 Jan 2026 19:44:36 -0800 (PST)
Date: Thu, 15 Jan 2026 19:44:30 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260116034432.1520731-1-jasonmiu@google.com>
Subject: [PATCH v7 0/2] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_194437_630071_1CEDC3A2 
X-CRM114-Status: GOOD (  11.03  )
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

Changelog since v6 [1]:
- Fixed a potential dangling pointer in kho_radix_add_page() on allocation failure
- Fixed a premature return in __kho_radix_walk_tree()
- Corrected the size type in kho_preserved_memory_reserve() to match memblock_reserve()

[1] https://lore.kernel.org/lkml/20260115230047.1220580-1-jasonmiu@google.com/

---

Jason Miu (2):
  kho: Adopt radix tree for preserved memory tracking
  kho: Remove finalize state and clients

 Documentation/admin-guide/mm/kho.rst        |  53 +-
 Documentation/core-api/kho/abi.rst          |   6 +
 Documentation/core-api/kho/index.rst        |  18 +-
 include/linux/kho/abi/kexec_handover.h      | 144 +++-
 include/linux/kho_radix_tree.h              |  70 ++
 kernel/liveupdate/kexec_handover.c          | 695 ++++++++++----------
 kernel/liveupdate/kexec_handover_debugfs.c  |  23 -
 kernel/liveupdate/kexec_handover_internal.h |   3 -
 kernel/liveupdate/luo_core.c                |  12 +-
 kernel/liveupdate/luo_flb.c                 |   2 +-
 tools/testing/selftests/kho/init.c          |  20 -
 11 files changed, 573 insertions(+), 473 deletions(-)
 create mode 100644 include/linux/kho_radix_tree.h


base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
-- 
2.52.0.457.g6b5491de43-goog


