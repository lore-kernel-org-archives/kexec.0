Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C08D73E85
	for <kexec@archiver.kernel.org>; Fri, 30 Jan 2026 00:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nakOP4nNLeplXpjUG2ytajYseRS79uoM0tVY0Gq55+A=; b=BAmUlKnx/xnm6fheds6kaJaw1/
	HA3X9cW2EmUigI1HSHJLyfJblDyac4IrZD6FjXgHpws0UlwAAhU4F+cUXSbjJcqW2wdR0bNZZ395t
	tmp+LwjFYCnGgyjxmAd0eptMLXNRju0It2p8KZQmr+DZWG9h5cJ5EpF2Pb+UGjsXW9CERnPzYecx7
	idY3gnvu7LpSS5ZPn3Xy82PFqwiljV92K8B4PN4+OxK0JLnH3eKGNvpMuw0nCp78aC7EmFXvf2u/M
	wMjDXniR//LHFIcO1qD+C6VwUoAKkzeuUgjpn8OZxJHrfgudec69xutCfzrw4x4HeyzJziiZXo+mG
	1QYBemZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlcpa-00000000pza-2U1y;
	Fri, 30 Jan 2026 00:57:50 +0000
Received: from mail-dl1-x1249.google.com ([2607:f8b0:4864:20::1249])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlcpX-00000000pyz-3pZr
	for kexec@lists.infradead.org;
	Fri, 30 Jan 2026 00:57:49 +0000
Received: by mail-dl1-x1249.google.com with SMTP id a92af1059eb24-123349958b2so3536351c88.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 16:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769734666; x=1770339466; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nakOP4nNLeplXpjUG2ytajYseRS79uoM0tVY0Gq55+A=;
        b=xQnmgi0c2RWjV1qFnkL0V6tlGWx59vs6NL1adTphn8AayB3OhbhVKIXuNA41p2nOT4
         b81pPRtEz3okXUnLNqiGJIoDfc+x/mCbRHV4Oi5Vm2y1pRU7DTMGG9VI1yacReLg/BTP
         Lb61U6LwFQ1lH9J9OfEB9mkE/CES1vP9p8PpDII4ITtOjPiUGvHnP/3utRxjArXn/Dam
         ju+lw30hpbFPuK6LFCxKXqm7KoVALTG8azDkBiV/KKIx9RwhYDFMbH5q7RXFOKRTFMXD
         3HedMtNMlJRtPA712aEOifGqPojIkNTeOPtabg3fxyod1cme3iuTKCWKLwDzbpSRP+rq
         l+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769734666; x=1770339466;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nakOP4nNLeplXpjUG2ytajYseRS79uoM0tVY0Gq55+A=;
        b=o5WdcXWZ8gAeMFM6JG/3gKHNmy66RaxKpgUtnUDbd40Kw6WoCBZckuzdkQfST72fvw
         aLHSw1/09KePD+ZmlhZbu/mIiCKKyDJWoLQkergFZO4rG2Ek9f+Vcvc0vvNHg3P5o67Z
         DbRshQn+dUFTi8zq5PImdWf14Qmmt5DrNaBX//11OdLcs9PyQcbJHBzO2Ro1YhKa1Vww
         o1z6nWd9ylU4cAhtwaxLCcXTh0gVYldOKMVJ0ptWLXx70tRQLZt5tpw4DcMpAHAgm7bq
         uBY+sPPy8KdT18mO9MA5UysvUhxlcGz36nG3s9DVieA24AGBPqBzhkKkFSzBBnmJm34E
         Ap8g==
X-Forwarded-Encrypted: i=1; AJvYcCUSYs/nEp33u3W0F+W1HGuhdw/uq8mbAfkBd6tLt+7ICvX94d/u/tpPz5F36MwrtTC5PeNs6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMGNxYyCQKrC2MnpBbkvlOwvap33TdWa0V2m82HPk0Wdqnc2Gy
	9n/fSMpP90gWhkqa86D9J5XzO0JK9EmMM9NqugzgegQkT54jQfVfFUMhAEymq1ka4PO99auNWqh
	YpSp12CRxWPke9Q==
X-Received: from dlbtv3.prod.google.com ([2002:a05:7022:3c83:b0:11f:3ccd:73d7])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:160b:b0:11b:2de8:6271 with SMTP id a92af1059eb24-125c0ffe445mr596408c88.39.1769734666217;
 Thu, 29 Jan 2026 16:57:46 -0800 (PST)
Date: Thu, 29 Jan 2026 16:57:37 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130005739.3163049-1-jasonmiu@google.com>
Subject: [PATCH v8 0/2] Make KHO Stateless
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_165747_987455_154F8042 
X-CRM114-Status: GOOD (  10.92  )
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

Changelog since v7 [1]:
- Initialized anchor_node to NULL in kho_radix_add_page()
- Re-added kho_get_mem_map_phys() and checked the FDT memory address
  validity in kho_populate()

[1] https://lore.kernel.org/lkml/20260116034432.1520731-1-jasonmiu@google.com/

---

Jason Miu (2):
  kho: Adopt radix tree for preserved memory tracking
  kho: Remove finalize state and clients

 Documentation/admin-guide/mm/kho.rst        |  53 +-
 Documentation/core-api/kho/abi.rst          |   6 +
 Documentation/core-api/kho/index.rst        |  18 +-
 include/linux/kho/abi/kexec_handover.h      | 144 ++++-
 include/linux/kho_radix_tree.h              |  70 ++
 kernel/liveupdate/kexec_handover.c          | 674 ++++++++++----------
 kernel/liveupdate/kexec_handover_debugfs.c  |  23 -
 kernel/liveupdate/kexec_handover_internal.h |   3 -
 kernel/liveupdate/luo_core.c                |  12 +-
 tools/testing/selftests/kho/init.c          |  20 -
 10 files changed, 573 insertions(+), 450 deletions(-)
 create mode 100644 include/linux/kho_radix_tree.h


base-commit: 33a647c659ffa5bdb94abc345c8c86768ff96215
-- 
2.53.0.rc1.225.gd81095ad13-goog


