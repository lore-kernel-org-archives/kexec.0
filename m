Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5F8CD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MIUnOidiefXcspEuuyeBWqUN2o/RTn4ccvxerf6qmvg=; b=GiIsXt9QLZ2wGVxcLv9rekFPq0
	3+V2FCzPEskx8PgR+XLQUf9fepvMj7FYIjgQeSKpziCvS6unK6PlOXJtMLgausbq8l2Uh8I+/elg4
	YYMXLSxTFvBMReyR9AUb9R2ysrOJh+plGHKujp2SnbVYqboNehXadzENt1HJ7fuY4LmNdK0IdfRSq
	g+B43eQYg3MuEhzYVNzp373I69k0RxjK4MhE4f7+hQWfi7/TNFJy7Jd3GWliO06eudsrv3nqw6OQr
	DdWUhN2ivLXFIGjPWrFinOFeLlQbjWQIdPwSbPkaLc3E3qB8v1isQKkAn8qf0g3erwdhsJIECZap2
	VFULIQiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnlJ-0000000FRcl-1G0t;
	Wed, 03 Jun 2026 15:44:09 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnlF-0000000FRc2-1Tkq
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:44:07 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-51761d27612so28497461cf.3
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780501444; x=1781106244; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIUnOidiefXcspEuuyeBWqUN2o/RTn4ccvxerf6qmvg=;
        b=h2slVaEc7aDr68/qirsTohrFHUkEYJGTHWw96KUNTPG6rZfAWxydzLOE01tNEExkoK
         3UYgUGpDNwCP7A13Yt0MioYIzQDgcdZhmJanYY9SbxHZNniDWh1dD26m4d74jyd7h1Dy
         TH6a4IdRB8aM8lxCcHx0pBdVhLb1QGLF8ZmiMUpiejTmTQi/rtNBICy2q5tJJVybt9/R
         mqBaQBiP6vkz0e23pwN9ttDl1bdRKINyyDZoZ1NF2ik9owN/6dDKxZAx7XbE59lGZ12G
         4lquK9APN8rMNh9aD2otd0+MC1IQao9CFtlmhLle6PfdRdY9IYvy9eQc5GHiXcJSDTpn
         hGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501444; x=1781106244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIUnOidiefXcspEuuyeBWqUN2o/RTn4ccvxerf6qmvg=;
        b=WWoj71kNXSbunjH4SnvZ9IuAGjgOZKQkARRLNRoBjKeGJXTRcA2UCqb5dTSbPu8sdA
         15cZIO43tuTgZq08bEDFhgWTBbZxCwvpBJx31OjDE+2BC4tGeIYbRJFFs+LK7ZESFl0E
         6XrQqeGYtG2H6eS7mNY44+Oyp08wUuP0HrongLl+AQ5143aUJFUxlRC627D5ZkIT/S2r
         sveRW0Vyoctvekhc2pAsOaELzPwkH+s09WDTATTxapDON3/UgOGchIhS5fIWEw02UVC4
         z7ccsM9IBPI4WqlQiID6hmxQ+sjxWNkNMoIlrMqHMa9dzALQEjOE8I7n8l7W3WZQfB5P
         kx5A==
X-Forwarded-Encrypted: i=1; AFNElJ+W+RNKzAy9yASFVL17mxZFjRUGdHU1pcLbvYiQt8ekQEDU78KoRcB+CH90CraE5W79u+WZXg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4PrzRrpcU5JUao2x/sHcCyggWpD+RTomnSTH5Z9inlfI3GcMp
	IvaT9clVVrRkLF5z2OuV+sqjzVad8/UGtfWa/hwe2Z1rC2IvV8c8nSADw8x6amXGe/M=
X-Gm-Gg: Acq92OETsCRqo4upsYyxSikT1APaPrWEDbQZAJ2N6iWFfV5XSTQfF31Xjy2Xs1fwOnL
	Nwf9ipFMUYP3CpEoRZkXaooSydy0URXaYo8nVnsHbCCmIFdNkMN8GOMWD32cFLNKAY8+nvV18V8
	S2VtCbTswxH9Ul6HMQPE3G+imQBeIvfzZzeN+dqRnHLEw/1C71ZKoLXP1Jo9KOuZPyzmzIdCzUp
	iP7vRV5x8JIgiWP2lc2DztwmIutnP/L1p/E6918wdt2KDgRKQgubwhgXyJKi1UUR/A7zJIeVWvV
	17HTpD5Pnd2tPKUGZ8NRoVLo542qVUUuO9Q0TZJlY0UAJxJll9nNznoJBAwBSb5lsbEAQOEGayH
	EudA0nCTZACmPZ1n3MS4K7+Soi3L0gCSUnvWIPCvJd6RJLZUGKJcynf8/qoC1nJX+6saY9FJ+FS
	NNh1nWFauIGJhO4idkGP9zPdZBIb2eiKfhwBVdwPBBr002A9Jv5iQWqJ+3Ij1FBg==
X-Received: by 2002:a05:622a:313:b0:516:508b:bf4d with SMTP id d75a77b69052e-51778789b11mr58906021cf.56.1780501444077;
        Wed, 03 Jun 2026 08:44:04 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm26996561cf.4.2026.06.03.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:44:03 -0700 (PDT)
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
Subject: [PATCH v7 00/13] liveupdate: Remove limits on sessions and files
Date: Wed,  3 Jun 2026 15:43:49 +0000
Message-ID: <20260603154402.468928-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_084405_875075_AB816E76 
X-CRM114-Status: GOOD (  12.96  )
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

Changes v7:
- Addressed comments from Mike.
- For changes in kho_block.c, and updated to use gloval KHO compatability.
- Collected review-by's and acks.

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
 include/linux/kho/abi/block.h                 |  54 +++
 include/linux/kho/abi/kexec_handover.h        |   2 +-
 include/linux/kho/abi/luo.h                   | 148 ++-----
 include/linux/kho_block.h                     | 106 +++++
 kernel/liveupdate/Makefile                    |   1 +
 kernel/liveupdate/kho_block.c                 | 416 ++++++++++++++++++
 kernel/liveupdate/luo_core.c                  |  99 ++---
 kernel/liveupdate/luo_file.c                  | 205 ++++-----
 kernel/liveupdate/luo_flb.c                   |  60 +--
 kernel/liveupdate/luo_internal.h              |  16 +-
 kernel/liveupdate/luo_session.c               | 219 +++++----
 tools/testing/selftests/liveupdate/Makefile   |   2 +
 .../testing/selftests/liveupdate/liveupdate.c |  75 ++++
 .../selftests/liveupdate/luo_stress_files.c   |  97 ++++
 .../liveupdate/luo_stress_sessions.c          | 102 +++++
 .../selftests/liveupdate/luo_test_utils.c     |  24 +
 .../selftests/liveupdate/luo_test_utils.h     |   2 +
 20 files changed, 1199 insertions(+), 446 deletions(-)
 create mode 100644 include/linux/kho/abi/block.h
 create mode 100644 include/linux/kho_block.h
 create mode 100644 kernel/liveupdate/kho_block.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c


base-commit: 2935777b418d2bfcbfe96705bb2c0fa6c0d94e18
-- 
2.53.0


