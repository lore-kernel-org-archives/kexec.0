Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55821CD5BD0
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l0Pvi4u9YaDjGAHaiBChsK2kBa75JO+Ko/uXGwG0BtI=; b=zXl/o5DCnvp7I4nBkNwXLcpQ5l
	0GDRc4O5Ul0t5C/OLaL13fsbjsVxlla7/PouPM85LznCzSHEOCb46dgb11LTIYA6yMEwySKc+rmGT
	w77KxS+ZPXV4hv3vuauHlzmOxSXCVORLIT+ZP1i9Fju7TqrUAJkLM46oPQl+LUW6bKoCjmpoXgF4A
	MULHdS6skXDwQI//XFfFqPd3vjO8h2kPtsvJ/cepBnoWY/ZDjlETVNpRQpOb1z2gVpqk8300Bb39C
	Od+fCoG/HC3wiI9H4qrjqrDWaGmkIi6gerItd5rCHiQ5CM7FPtZTiqWrxwYEqiThhktktVQnmUVG3
	uFKNlXIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS1y-000000095iQ-0Ir1;
	Sat, 30 May 2026 22:19:46 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS1v-000000095hq-1Ceb
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:19:44 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-9154ca1aa1dso53032885a.0
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179581; x=1780784381; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0Pvi4u9YaDjGAHaiBChsK2kBa75JO+Ko/uXGwG0BtI=;
        b=F3ihFcBTbUoQ5wgP+3uh0Ip9ZMWt1IqGXFpvUKuIiaTgiEbvn59mDgZasnNSrbd6MN
         HZQxU5jv5x0xkTE3AC/xhm9wYQL/uqu7BG1UfzjA1q/fMep+lIZQ7li/wa8t1DLutWiy
         z5h3hLoBB4avDuWeglS/kmDb05sPLhLAmJuxPAzNg8xVQmzJYn2pTExv2SthybnP+kj9
         TMP4CpUcLOz8xAQMNm/w1RRX+O7/DUfWtz4HBgPMueHlJSSahObcyBAjSRbxMysOlYDc
         LS9vaStH+t56t12bpQ+XJLP3b4sopeIngAJ6G8BPuaocUgri1qkuuPUYDsM0d3KDgYzP
         0xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179581; x=1780784381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0Pvi4u9YaDjGAHaiBChsK2kBa75JO+Ko/uXGwG0BtI=;
        b=Vv8r8BPzo8IWcaBvm7zBDg18bshH1FX3zQaUJz9Y3RYvWobwmy5UT36lU1A/4v1IMB
         7L6A3a41GQSSM3YDtRn8ygpfRYeYAgAqjGqmoux6mIuV6swG0giiQuERJGrAwkNPwaQj
         GPAoGlZ3brYfYI4BEbuHm9BKDP7E17YIWYQeMx2sy29WwAB85rQ5L9Ftkwa5cL2jt/i7
         J+tDhUEoRequKJNKJHjMt4XFAF29/kGw7SWA4rjn2and/RxwQsxG7QGAJsEAhjQccanx
         ZObqR5oktIp2s6XzR/g+GBkc4NSkDZZ//vFs9RcIm7T2/pJ05LVf3URE8Zq8HEroiZ8q
         Ec0w==
X-Forwarded-Encrypted: i=1; AFNElJ+b++wagJll43yt1Je3s94OphMO/xPCZmuCBQdgpOL5GXiGOYDymczftn9WV4vCdSDyyGMhHA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwCzNtlRtWwTa17avkbmLfKgjb8t0OzQWKWmqtKTXr8Y7Ef/YeH
	nU+1bK6hgbaj/AJgSFwqcs5aKY74G5TuNkYiFWIb9ixDvYgnTju5++XEsC7OGSJVjdI=
X-Gm-Gg: Acq92OHYtKzxQbDo5QhPGV6yjhEKQu7Q1AfEZ+QUS0H/vAURBDPGRgZHF+A7cONtitk
	SFuEBK+5W8ow5CMNRZxKAuPy5vaxJ8IZzoB2IQ13j647hFmiOzaQaP1n6bzoNHWVGdosntIBfOA
	fiQ8HFYg9aS+EgEyljxWhj6dQkiMKtxWDbzMr8Jp2GutVq6Ag7RpYO3bdqZ+2ItriYzU/9cxx2A
	XLNyFbbTH5ACTCVTg5+ELA5GyiUrHo41GsD1PjheDNlSyUmRqI8XxjPD7eI82GO9bTTTxd2Avry
	d7haR4IuB45SeSrIh9rMVw5a5MW5SDyxqC9XtbqZo2SLII93NKSYPb8O/1qyS8HCn+Mht9UUDwV
	Pe3306g99uS08QhA17VZhovzuNzEzBZ4SL4pdm70ULmqaP7f6D5HR/WKRU61r0MlUXdoSbSGcZX
	nJbIpjFvZ67BOMcwPeqfsHwGp4ZK8ILl8C/wGHqD3DKY5va1VeBpF1Px4hh83WdQ==
X-Received: by 2002:a05:620a:172a:b0:8cf:d80c:5ab0 with SMTP id af79cd13be357-9153e0a76dbmr564555385a.17.1780179581378;
        Sat, 30 May 2026 15:19:41 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:19:40 -0700 (PDT)
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
Subject: [PATCH v4 00/13] liveupdate: Remove limits on sessions and files
Date: Sat, 30 May 2026 22:19:25 +0000
Message-ID: <20260530221938.115978-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_151943_344374_08FD428E 
X-CRM114-Status: GOOD (  14.00  )
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
Branch: luo-remove-max-files-sessions-limits/v4

Changes v4:
- Addressed comments from Sashiko:
  - Enforced file count mismatches during deserialization as a hard
    failure.
  - Reset bs->head_pa to 0 in kho_block_restore() on cyclic block
    detection.
  - Added two small fixes to pre-existing problems at the beginning of
    the series:
    - "liveupdate: change file_set->count type to u64 for type safety"
    - "liveupdate: avoid mixing cleanup guards with goto in
      luo_session_retrieve_fd"

Changes v3:
- Moved the linked-block serialization infrastructure from
  LUO-specific (luo_block.c) to generic KHO helper infrastructure
  (kho_block.c, include/linux/kho_block.h,
  include/linux/kho/abi/block.h).
- Registered luo_ser directly as a raw KHO subtree instead of
  wrapping it inside FDT.
- Collected Acked-by tags from Mike Rapoport.

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
 include/linux/kho_block.h                     |  79 ++++
 kernel/liveupdate/Makefile                    |   1 +
 kernel/liveupdate/kho_block.c                 | 384 ++++++++++++++++++
 kernel/liveupdate/luo_core.c                  |  99 ++---
 kernel/liveupdate/luo_file.c                  | 211 +++++-----
 kernel/liveupdate/luo_flb.c                   |  65 +--
 kernel/liveupdate/luo_internal.h              |  16 +-
 kernel/liveupdate/luo_session.c               | 242 +++++------
 tools/testing/selftests/liveupdate/Makefile   |   2 +
 .../testing/selftests/liveupdate/liveupdate.c |  75 ++++
 .../selftests/liveupdate/luo_stress_files.c   |  97 +++++
 .../liveupdate/luo_stress_sessions.c          | 102 +++++
 .../selftests/liveupdate/luo_test_utils.c     |  24 ++
 .../selftests/liveupdate/luo_test_utils.h     |   2 +
 19 files changed, 1161 insertions(+), 460 deletions(-)
 create mode 100644 include/linux/kho/abi/block.h
 create mode 100644 include/linux/kho_block.h
 create mode 100644 kernel/liveupdate/kho_block.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c


base-commit: 5428435567cbe06c19914592fc22ca23c9ca1de5
-- 
2.53.0


