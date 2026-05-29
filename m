Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004CCCD6E4C
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VWz/Ba0zwzmUZSFYwq/eHsbiY7hxxlyTIzOmzVE8aUU=; b=wx3ONXJ/GlD+zszo3YjzLcEq8G
	1Z9sydEZuF9X4tQLcKKSFYzxI/7sFkcM2W2MxLYmgMzN6MCOJwQgC8MI/+K8y8z1Xhj+9ZbYUB1IG
	iLaYOfDcBC+JkQvpLoYn13BUKTf3m4144W9nZhOU2vRwmPL+3h403sY/zLpqMEs5mxrknAScXyKw0
	Teg7AaUyZ7RK65pQVrpe/BtU2rsYmdJIOkEFT5wEjKJrUWWRsQZ7x2+JFz5iTB5oItR2ZuIoNkM59
	JrkdehEtCWO1jdQMXBRlr318tuRfvwpoIaXEym3BcIlyHAh1iMbhYX6Rjht1A8yERIqUEGOaHcdnr
	5aeZCqRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmc-00000006gRH-1IuM;
	Fri, 29 May 2026 03:21:14 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmZ-00000006gPi-0VNL
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 03:21:12 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so8115166d6.1
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 20:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780024868; x=1780629668; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWz/Ba0zwzmUZSFYwq/eHsbiY7hxxlyTIzOmzVE8aUU=;
        b=c7+YvlEscr7dJuqBlI/6ZCRp03MfBqj9Fo+3WO13XCvm7SHrTvVIabP7DqUwa6+wLE
         L0MA6O3jLDv3vGA21TV3y9yIqhqEtQ1gZZeuZIl2uvhXAwy4XjXyTGzfPyVg4j0Kwqy5
         4NyYvM7Syl4nJYh/I3l3pawjERNK16ME+7aRa/fUrwy4XXVMEIMrBq4hKJfp8n7zNyMT
         waytaoVOSkTJDH3AoIvrKrULziVhzdM5jxA4sQ6M65VM1j2rI4jCKkIxwxRXtKlD/zLq
         kT3Ez1ywlyLYyFX/uV910vMVHWoeWoXNklDdMMWJ0btdZfWOy7q/jPYrXrEOf1ZqPn/I
         +oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024868; x=1780629668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWz/Ba0zwzmUZSFYwq/eHsbiY7hxxlyTIzOmzVE8aUU=;
        b=bdrR2vk7c2C38190EgjUHif+Bmg3EAe77L6v5u8RAIwvT+wFt6oafHyxKke9HwyM+b
         gAuz5tl43sajBsRh0iaVEroEnDYK/0wr1iKANiSxB8fi6Krn2zvwbDrcqSYjTU3o2QCQ
         teIZG6VGd3IOZ84j6AL6YfZHRfNjwjcJy2xNOcjSS5Z0LEI7x4C5lHexl/4opk/W3/J1
         nSNPKytBPDjI7PkccFLmpTLwBNpWvJVLB7GuLFFhOt+eU/KkRjEfEW+iZ5U9UJhAL9SO
         GiqLfJojZJ2XSBhinXzBz4DBLs8FUxJJoSYsEVhBOeZ7IBa2hg2rq24g+0LYgO/5AbtB
         /iog==
X-Forwarded-Encrypted: i=1; AFNElJ8HzJhbmsNH8UR1PFyMmXXNGvShnDxcMlTtgIfWLdmNcG+8oiqVRCJxaqMeiZpNgNzsOYnyvQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyuAhYdKKJviic6OD186470M3VKZ6iHwphzdRX2VSM65Urxj4vJ
	J57urlBhJ8Bp+tS1xTS3CrdTOHyBk1MQrZ1Mf9TzJS9MG/itQ8ncDJYM5rLdkYzW45g=
X-Gm-Gg: Acq92OF7g7RS/t2kegTgPwsiYWhbs37GfYWq934Rm8I9Jch8xQ/vt3rX1jRaPDgfuW0
	6BZpBZ9MSorioMp4t+8cttHsV3961UrlExSbqkG3T4QqBzr4MsZvKxXTSqZFnw7Aldoq+ayxJwj
	FR46vbHQiXmBXrXvyf49lFZ4vHUx375ljsjfp4IKlenWvG4qXy5RyOwTx4vIeMelsGOmUbs7we6
	7RhJg7mcd/Q0IZSlIZj4p9GBL4TLJlKY0FZb8dZLhJeT1uboEY2t9wJrRudrQsT04njrz3SuNGi
	oKAyz0fKcK2ReXk2JcZUHBSI0kWyTMkq07xuRT+YiYUqNGdyA6eSBm77KSXVIg3H6wLeiDwlLvd
	ppsyJjeKguBZHa/rsIa5MyLTy2IgXpJMrPvfhU47RErU+PusdjDUR6AczjUPS59orrBGMvyhzRx
	u2ohFld//7VUbsSnrwEvxb12n4WR+LNrZ5yXN4u5dGrP72jsE0omL8JeduNVJkww==
X-Received: by 2002:a05:6214:2f13:b0:8a0:d08c:a720 with SMTP id 6a1803df08f44-8cce8009ba3mr14944206d6.17.1780024868221;
        Thu, 28 May 2026 20:21:08 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea26d286sm1179476d6.48.2026.05.28.20.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:21:07 -0700 (PDT)
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
Subject: [PATCH v3 00/11] liveupdate: Remove limits on the number of files and sessions
Date: Fri, 29 May 2026 03:20:55 +0000
Message-ID: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_202111_168561_80219450 
X-CRM114-Status: GOOD (  11.09  )
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
Branch: luo-remove-max-files-sessions-limits/v3

Changes v3:
    - Moved the linked-block serialization infrastructure from LUO-specific
      (luo_block.c) to generic KHO helper infrastructure (kho_block.c,
      include/linux/kho_block.h, include/linux/kho/abi/block.h).
    - Registered luo_ser directly as a raw KHO subtree instead of wrapping
      it inside FDT.
    - Collected Acked-by tags from Mike Rapoport.

Pasha Tatashin (11):
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
 kernel/liveupdate/kho_block.c                 | 382 ++++++++++++++++++
 kernel/liveupdate/luo_core.c                  |  95 ++---
 kernel/liveupdate/luo_file.c                  | 209 +++++-----
 kernel/liveupdate/luo_flb.c                   |  65 +--
 kernel/liveupdate/luo_internal.h              |  14 +-
 kernel/liveupdate/luo_session.c               | 214 +++++-----
 tools/testing/selftests/liveupdate/Makefile   |   2 +
 .../testing/selftests/liveupdate/liveupdate.c |  75 ++++
 .../selftests/liveupdate/luo_stress_files.c   | 101 +++++
 .../liveupdate/luo_stress_sessions.c          | 102 +++++
 .../selftests/liveupdate/luo_test_utils.c     |  24 ++
 .../selftests/liveupdate/luo_test_utils.h     |   2 +
 19 files changed, 1142 insertions(+), 445 deletions(-)
 create mode 100644 include/linux/kho/abi/block.h
 create mode 100644 include/linux/kho_block.h
 create mode 100644 kernel/liveupdate/kho_block.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c


base-commit: 5428435567cbe06c19914592fc22ca23c9ca1de5
-- 
2.53.0


