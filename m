Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31F9CD6E4A
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P4+c0fQ4LYrHNLHZUplyns5z+KGYVI4xj+rLgvLL9F4=; b=peZ2krLakenkPr3ulx7lhWb+g2
	qvdLEqtA+OOie/ozMtpgM/rWVYBia1tY590TYDwmNyOaHp8j7JcBJEOEvlWl1nMg19EIT+w4kZTjw
	ISlHIW1T1QPE3T+OUG2IQ96kEGKdDQCu8SUjigt4+0kVUCZGOMefvrgxUhVgvyBTCDXi2zlvld+GD
	rAcgAHiWG9Kw7bBt9nJo+pXo2j/d04QJxOd9DAmt/nhzlaIJ8aYDXXE9c8GeW0nxjJKR8fLUvug4q
	wFJGIp0zdWy+fe8g5Fij1B/aSrnCPKyhZ+fU/trXlO1zHoyPUyiSMZ/b6AOpTD+F8LX1mCGYrwvzR
	0dujrYAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcI2-0000000EAsJ-3OrU;
	Wed, 03 Jun 2026 03:29:10 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcI0-0000000EArk-0nVp
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:09 +0000
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-8ccce57762cso70424896d6.3
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457347; x=1781062147; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4+c0fQ4LYrHNLHZUplyns5z+KGYVI4xj+rLgvLL9F4=;
        b=PEHjSktw0XTAzNXyOqgjk4I7JBchHvn9Rd3dN/wN9ITGrsGhHCqNttS6edw+sizd1x
         oS59OyYiiKxE0EAy/160W6uF18t/+2R6nCA7dJldXS0rz9/AmVxmFgdnRov/oy2kXN8z
         ZLelSjFZYbSjQgtEeSOKuhNvGcte+QWqD4ZiWTC8QD8ouA7hXSKhrsfyLythhz9EO2o/
         ihd17OA8vlGSy2JB6LBQVk2ZqGt7fpEu08a7mPlUedBVzGlVuM2KwvhOyBfBcR9+bE69
         P2ai5I7avP0qA1EoaFWbyZeGOBkuCmQEYiNhqRPpljGNOF1CY3jdH0yLJuJSNgVjVSvr
         3c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457347; x=1781062147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4+c0fQ4LYrHNLHZUplyns5z+KGYVI4xj+rLgvLL9F4=;
        b=XYfWErSTXia/eJ6aql84x6SoUNyXL9utSSNIMa7zPsfU00OnnryiSsmUv3GyDqjwRF
         yupXxGF50J8CabGeomVsmU7aP/cYLNQvp0wWG0vmeMq1/4kneX4QxR0Ori3Eh4WiHY5B
         tjAdpqIWb4OC2J1EHmggBfVtSIjnEBeFXf5zvez6i0mVvrU/rmzFlKmNTYe/YxGNa8q4
         kx2PQCXpUYytFr98IIeL+tMVSbAeCDOaKIR1sd79S5bUYOyQv52yyfrgnASv7d/iY2P5
         x0WFyglvsO9QRLzftxZJw9T1OLjG6zsrEDFFpxMu2AXxPtEQDwWIj2rj/JNF2cEkdxjb
         otvw==
X-Forwarded-Encrypted: i=1; AFNElJ87qH1fBuWOKRD8zTJBWgLj1FPezsK3xokiJst9oi7Bkb5QpNf2Erf0/uVgJR2KEI/XaeBung==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxd4MpYWHNxeFIWzcz1z2B7k/jbg4z2VwS2u4BmZqTgU9BnSOTb
	ynaLHVsXc+AvhR1yQnzd0jchEfHPD4Zp0SGSW4hBu8ENh0agWXeecX/I467HYZsKexI=
X-Gm-Gg: Acq92OHnRk6oaXIy8Uuq6kinRLZ6vtdF4uKsXbU8gZyKLpzwaFvJ13BypHatJzpjSS9
	YNjbpw8H/Quev9KeS5nCcWelpdj9gMbpQ1pnQfjclQmB5nfzirY7GsxT2k2LIzukRZCBiq5AqXs
	S3bFKj8plZkUlKBbgZNXcntPgxldL2xQox5i4dzgEFxBkV/mZ267ZPFHIZjkegdqH5JZ1XCm4eL
	4yJm7zIEF7w/50n26oQmgcQhzlNO18nFJQbdABEmkLbKN1PYUXbUdQvoJyYAZMgfWVFTn++qmZf
	ROplAG9JW7bjQgNTZyODqwaQJHv15gSLxPiCNtXFRqc4BF5EVctzb0Sa1rIAVJEeXVUFFvf93pE
	jwO6qbz/O+9aKryViPu8GMiHzdk1UVKOFgq5qgN89yzT7xhk/vpkrWq0H1CgwjhIV3G8ev1CUj0
	ZzyXEDMo5GFL81QqjhhCdp9UrYUEHlpJbk6CCnqk02iR1k73fVcqsPC+aqg2eK6g==
X-Received: by 2002:a05:6214:493:b0:8a1:8b0a:6678 with SMTP id 6a1803df08f44-8cece03811amr23330036d6.31.1780457346835;
        Tue, 02 Jun 2026 20:29:06 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:06 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v6 00/13] liveupdate: Remove limits on sessions and files
Date: Wed,  3 Jun 2026 03:28:51 +0000
Message-ID: <20260603032905.344462-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202908_271350_932823F6 
X-CRM114-Status: GOOD (  14.83  )
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

Hi all,

This series removes the fixed limits on the number of files that can
be preserved within a single session, and the total number of sessions
managed by the Live Update Orchestrator (LUO).

The core of the change is a transition from single contiguous memory
blocks for metadata serialization to a chain of linked blocks. This
allows LUO to scale dynamically.

1.  ABI Evolution:
    - Introduced linked-block headers for both file and session
      serialization.
    - Bumped session ABI version to v4.

2.  Memory Management & Security:
    - Implemented a dynamic block allocation and reuse strategy. Blocks
      are allocated only when existing ones are exhausted and are reused
      during session/file removal cycles.
    - Introduced KHO_MAX_BLOCKS (10000) as a safeguard against stupid
      excessive allocations or corrupted cyclic lists during restore.

3.  Expanded Selftests:
    - Added new kexec-based tests verifying preservation of
      2000 sessions and 500 files per session.
    - Added self-tests for many sessions and many files management.

Tree: git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git
Branch: luo-remove-max-files-sessions-limits/v6

Changes v6:
- Addressed comments from Mike and Pratyush:
- Simplified kho_block_set_destroy() to only free successfully tracked blocks
- Enabled dynamic entry count tracking in kho_block_set_it_reserve_entry()
  to automatically update the count field in block headers on every reserve.
- Removed the error kho_block_set_it_finalize().
- Renamed various kho_block_* APIs to kho_block_set_* (e.g. kho_block_set_grow,
  kho_block_set_shrink, struct kho_block_set_it, etc.).

Changes v5:
- Addressed comments from Pratyush:
  - Renamed kho_block_restore -> kho_block_set_restore, kho_block_destroy -> kho_block_set_destroy.
  - Renamed block iterator next/read functions to reserve_entry/read_entry.
  - Added public helpers kho_block_set_head_pa() and kho_block_set_is_empty().
  - Added validation to treat zero-count blocks as errors during restoration.
  - Simplified block iterator reading loop from a while to an if statement.
  - Changed standard WARN_ON macros to WARN_ON_ONCE on iterator allocation checks, and added warning details.
  - Simplified session serialization by removing a redundant NULL check on sessions_pa.

Please review.

Thanks,
Pasha

Pasha Tatashin (13):
  liveupdate: change file_set->count type to u64 for type safety
  liveupdate: avoid mixing cleanup guards with goto in
    luo_session_retrieve_fd
  liveupdate: centralize state management into struct luo_ser
  liveupdate: register luo_ser as KHO subtree
  liveupdate: Extract luo_file_deserialize_one helper
  liveupdate: Extract luo_session_deserialize_one helper
  kho: add support for linked-block serialization
  liveupdate: defer session block allocation and physical address
    setting
  liveupdate: Remove limit on the number of sessions
  liveupdate: Remove limit on the number of files per session
  selftests/liveupdate: Test session and file limit removal
  selftests/liveupdate: Add stress-sessions kexec test
  selftests/liveupdate: Add stress-files kexec test

 Documentation/core-api/kho/abi.rst            |   5 +
 Documentation/core-api/kho/index.rst          |  11 +
 MAINTAINERS                                   |   1 +
 include/linux/kho/abi/block.h                 |  56 +++
 include/linux/kho/abi/luo.h                   | 149 ++-----
 include/linux/kho_block.h                     | 106 +++++
 kernel/liveupdate/Makefile                    |   1 +
 kernel/liveupdate/kho_block.c                 | 411 ++++++++++++++++++
 kernel/liveupdate/luo_core.c                  |  99 ++---
 kernel/liveupdate/luo_file.c                  | 205 ++++-----
 kernel/liveupdate/luo_flb.c                   |  60 +--
 kernel/liveupdate/luo_internal.h              |  16 +-
 kernel/liveupdate/luo_session.c               | 219 +++++-----
 tools/testing/selftests/liveupdate/Makefile   |   2 +
 .../testing/selftests/liveupdate/liveupdate.c |  75 ++++
 .../selftests/liveupdate/luo_stress_files.c   |  97 +++++
 .../liveupdate/luo_stress_sessions.c          | 102 +++++
 .../selftests/liveupdate/luo_test_utils.c     |  24 +
 .../selftests/liveupdate/luo_test_utils.h     |   2 +
 19 files changed, 1196 insertions(+), 445 deletions(-)
 create mode 100644 include/linux/kho/abi/block.h
 create mode 100644 include/linux/kho_block.h
 create mode 100644 kernel/liveupdate/kho_block.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c


base-commit: 2935777b418d2bfcbfe96705bb2c0fa6c0d94e18
-- 
2.53.0


