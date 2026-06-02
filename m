Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E89CD6E65
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M1YZ6pkpMukmY0PpCar7lQ0cU7Gg/pAjVgGHiG98i3c=; b=rWUmeo+z/d/CttaRReiPIabeVe
	mkdCga05Bs6wPlTbidr/xkIRGDY+4HvuEoFF5KdCIChcqmXKokbvB+omulo+MFMX694WCZJjLyAj4
	9gc3uhmsUiAye484ONWboQeNgjFnj+6RI2vU8sZg7P1WzGAxApBMbN9m5tetMEZBBHrbpS66oCYsr
	qH4SEJ+yj6eXI+bxVrMbSm9GVE57XAgqwApDQKScSq+FFu/XAifLkAe0FSJ19l9b9NVMDwFPOdIX/
	KLhP8kqionoUkuE+uLBOk09vRysKf1TRt9Gw9LTMzV2rYvbJ6LLjZ2Ix3JozM9eqIfDsu2zNqxi7K
	FRxsiJlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFd5-0000000CDAd-3M4I;
	Tue, 02 Jun 2026 03:17:23 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFd2-0000000CD9h-3Zgs
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:22 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-51758478240so8151481cf.2
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370239; x=1780975039; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1YZ6pkpMukmY0PpCar7lQ0cU7Gg/pAjVgGHiG98i3c=;
        b=cyX9sy+a/03+S1+kEqz9J+YAKaEyTcqMLeey0Wox9VcRuRc3ZhMgyt2l11oRCYnpIg
         XNEKzLj8VX28oMCH70KFVAFFY3Jn4HT5sTjpSGhe16XQNFQPfkFUgWmy4iDTzhpYFkfR
         cr/qSeF+p3Xzu3dDMZSFMNTvtsx4HZB/WlCa2bEIZbi1h8lUX7dlJeMlkr2HsgSA9KAA
         xQYLNaZsY2B+CiXt5MMUuFv3QUiF+d+n4tKKp5E4F+n3ly86ZmZ7NTU8Nk9Hx8ET/T7R
         oVPUn1BS2WLPkOnGFPov3btizViFOlzRKJP6jvCi1Xugwi/VijxAGUJjkztbieSOwnty
         4Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370239; x=1780975039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1YZ6pkpMukmY0PpCar7lQ0cU7Gg/pAjVgGHiG98i3c=;
        b=foBJQHmRUMN5sV4v1s6xObRHDdusAU97e+aHvxgBFC0wVck1sdlpSz/F6ooKrFSYUy
         wt2Ltgvw8vWd9apAHUHC+pZEnVIawA7aU8LF31G/EJZD4EXtO6tRkRN4Z/JGxEgjooVl
         uw6doXc+MRZip9zzRQwTGhu0f8SnBdBAaaYvxpsuB8nIQtZYde99VxvxYJBrKLeGKjOW
         vSb5vKxcomrHl0hhf/NueYYwMcF3ZpK4801flLhEv7a4E5ukdSL+LFjfTNvfOdtioowP
         YOJXNtecUJBPbnCS74f/SZJiDG8xkFYjkkKV21VemYmlkVFNdkSPqVAOWC7t5z4RMU5I
         1sTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vxwe9dpbZ69wK78cpOCB2gvjxkzhgJpT+CxFyRst97IdEov5H+HnvmQNgJU7y7AJEcz1SCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwsCSIEAIgvZnzTLrl+jJShsno92SN/dNef8eod6iyUTh6rAXC4
	GQ4WSHlzj5inM3dcUX12ph8+YHY59ciQlX9x2ZpNKE6lHPnUXBZbQviONjcN8tq5fAo=
X-Gm-Gg: Acq92OGyVR4AVa+oZcQQ8ww57vsckXh+i8sK25IoYfZ+k7LFMh8wdpEa3M1UnUEAnNo
	tSu0ClY1TxD0Z4N1qRJ/EUw3u59vBEI4GNJTT+jjoyMRQYU23wbTDV70T53MaSusjBLLMoodPFl
	eOW7ow/Y4soI/BUskH+SBCtVHP7TZ0cFkyDyvrSwXVF7dF0jIFCUU+0u0LPld8d99znRdElU95R
	8AI2rhaVT4rDzDzYqsJgaN9YTcdsf9UoUADnAuaSs7fTkaKq9XJ7Phx0a/zQhOCvWSAfmxoo7gw
	7Xi6IOAStJI/XV96hFnxf510DnFqstG+ftQBYR23JvOgeShJGhz4e1qzWhmfYyFSlnEknJyxNKj
	u1QLI/9+YIymSm8CUYfq3OP2OPHzQZQHVjq4GH7fd60FgRbVYGyJiGjViJqJn6sUnDOykTSBgt7
	HtPvw2h6TseSqOvSAe1oOb2BvI43pgOD53hkEU2iw8HLbTLoGQeBDsSJY75ITRkRcb4cTsYlp8
X-Received: by 2002:a05:622a:a9c9:20b0:50f:f0be:dc7b with SMTP id d75a77b69052e-5173a7fe8aemr158846631cf.39.1780370239332;
        Mon, 01 Jun 2026 20:17:19 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:18 -0700 (PDT)
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
Subject: [PATCH v5 00/13] liveupdate: Remove limits on sessions and files
Date: Tue,  2 Jun 2026 03:17:04 +0000
Message-ID: <20260602031717.197696-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201720_917915_A482946B 
X-CRM114-Status: GOOD (  13.47  )
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
Branch: luo-remove-max-files-sessions-limits/v5

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
  liveupdate: defer session block allocation and PA setting
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
 include/linux/kho_block.h                     | 101 +++++
 kernel/liveupdate/Makefile                    |   1 +
 kernel/liveupdate/kho_block.c                 | 390 ++++++++++++++++++
 kernel/liveupdate/luo_core.c                  |  99 ++---
 kernel/liveupdate/luo_file.c                  | 206 ++++-----
 kernel/liveupdate/luo_flb.c                   |  65 +--
 kernel/liveupdate/luo_internal.h              |  16 +-
 kernel/liveupdate/luo_session.c               | 241 +++++------
 tools/testing/selftests/liveupdate/Makefile   |   2 +
 .../testing/selftests/liveupdate/liveupdate.c |  75 ++++
 .../selftests/liveupdate/luo_stress_files.c   |  97 +++++
 .../liveupdate/luo_stress_sessions.c          | 102 +++++
 .../selftests/liveupdate/luo_test_utils.c     |  24 ++
 .../selftests/liveupdate/luo_test_utils.h     |   2 +
 19 files changed, 1184 insertions(+), 459 deletions(-)
 create mode 100644 include/linux/kho/abi/block.h
 create mode 100644 include/linux/kho_block.h
 create mode 100644 kernel/liveupdate/kho_block.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c


base-commit: 2935777b418d2bfcbfe96705bb2c0fa6c0d94e18
-- 
2.53.0


