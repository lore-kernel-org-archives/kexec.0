Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB45CD4F39
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jKaeCysGolB8wQTRAqT3H/WnxvkmBcYreAX7ZFxRMf8=; b=1dIi3ImKuCCZrLe7O6w73FSlZP
	V4TTUaykQYAXU3khlGj6fm8WxyamYufzUHtC8o8MnsKgVnhF6mdmw5sduuKJbp6AUnOA997W4OTVG
	oc5b10zrN8pVQtaTge65Gyxavn7lF7bovMwkYSQbYvJRS1DAhr2nYYsq90KVcj8dzpd5EVXihBhcj
	972lOhfs/RVBCOLPjhW4mb8R9oDCyZp3D73hyhIml4xK3e0JOQZhmUy0YXD/U57D8yY2sKhRqDiIS
	S/3zKPoA7u6leMAXyzgzPPkoqsmkh4ANaVMJJ6LOnIdoumHtHcc8zsS2sRubwhcNiuHBia/aGQARG
	T2GBglrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVs-00000006iG0-0yy7;
	Thu, 14 May 2026 22:26:40 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVl-00000006iEc-2LGx
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 22:26:34 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-910f734b477so119385785a.0
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 15:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778797591; x=1779402391; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKaeCysGolB8wQTRAqT3H/WnxvkmBcYreAX7ZFxRMf8=;
        b=K9FCQZAEXvpcIW/j+a81WtHENaEvWr+fYv/bh0KlkNk+h5fgI3nBW4j6kfHM5vZGTB
         VfQ0d28xYdGawPUpwmlIlK2dAbKG54u26bPvLVB1/iBCdh0I/9RqcjF8A7iIJOn1CQeJ
         Izz5YNCe3rzMM8bnhOuDj351oueUJ/nvXzuSZLe2Hl4ec3JIIaekjEZQ1fbTX/BgbedD
         fgzssVdbXM3O3sJxXh6JlxGHMr77qnj3jwg2qgu68wEDdFnPpwPTygA4tRjQxgfW5g0B
         yambHlWAhvBFzWFJynN0TaXctqLzxnGpXHQWJJFo6pPtsRowFmgP6xuu5hsj0A0CI2S9
         0atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797591; x=1779402391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKaeCysGolB8wQTRAqT3H/WnxvkmBcYreAX7ZFxRMf8=;
        b=Kj+wAsGpE6Ms660zRt8H1IRYcJ9D5raB4dd97qsRibTpvVQtk9O2AHC7uCot/7ucWz
         HV/Rho4g8ElnxEP/lHyZtvCzw2+hYyQd3yFKuxCuVqhyRv+RUfWfPhiiRSIeiyXGL1rd
         snsHljKh8cfRo0ITqvrXkuv/Ouv5plikoYFj0w4DQY2E3KVdjF+/w+ifW8EUp1v0uSN5
         K7iuHY+oWCFUPr8w1pRHWS6KSkBkSJxlMNEirIY3DZTl89SN09gX/2WK6NGuKsTCxZOr
         JywRMu4O/MCOHnD1+uLM4vmucqTMB8lUG1FaiKdI1mXa5Q28HE+nkqdI+Cj9R18LPyQk
         xmxg==
X-Forwarded-Encrypted: i=1; AFNElJ/tPSczZ+lvfXikB15dAJOUhgcH+GswEYs62UtiVFSp2YE8bOISQzwhAR3ydWzZ6kJt3FNqkA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyhwO7xMNDFTh8UMa6gQDUEouPu33hwFRip+2XRqQvHePE1Oodk
	6Z32bVpSUvaPPg7fyVdgEE6i7rsa/cbzP96Bc/V5ON9Uqta8nkJ18x3j1Fr7zLWqO08=
X-Gm-Gg: Acq92OHcNTEjWUHZWT2rSACjTG4LdErfBQXMHGSASaIyPkp4b5EZfNV2ONakA3l/HvN
	T6NAcTLWQ1hcMToqOgRKtB1gEYtSxtbcaMbtLcJ58Axa9ADISDQTxKFDhab8s7cD2FUEDEqz9my
	FIE+PnV7emCdSrAiD1Mj2YB9omf3ja2G/3ScU44UbHrXUfT3H/+jLquwJcygLbuQe9ObXNAwNrm
	82jpon2IwYnD5fqx8E62OmK3PrveWNb9STSNi4HjXVHfwZsHKA2JOC5qrda+TjRqtkxJewXMGDa
	sZ+pLODqY8g6YrghkKqw1xrvi0wgxNzXT9qYnpEAzGp4bMqpzpZFtpyDvaDAsgIYFMZCce8L5hq
	n179h2HtKbWLUxyB7fGpS9NQV84pXZeWoN0OZDKKrLhsAKgaLFP44hm4YMfAoXSriLWl4HnHqkz
	FnI9M1k/+OucfYrug+2NtDSs1eGjAGAOfqekUFjnXEMUvYwCXUdsY=
X-Received: by 2002:a05:622a:6201:b0:50f:817c:2fe6 with SMTP id d75a77b69052e-51659fe0269mr20823261cf.2.1778797591454;
        Thu, 14 May 2026 15:26:31 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm28671901cf.9.2026.05.14.15.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:26:30 -0700 (PDT)
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
Subject: [PATCH v2 00/10] liveupdate: Remove limits on the number of files and sessions
Date: Thu, 14 May 2026 22:26:18 +0000
Message-ID: <20260514222628.931312-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_152633_606907_F6AF8157 
X-CRM114-Status: GOOD (  10.96  )
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
managed by the Live Update Orchestrator.

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
    - Introduced LUO_MAX_BLOCKS (10000) as a safeguard against stupid
      excessive allocations or corrupted cyclic lists during restore.

3.  Expanded Selftests:
    - Added new kexec-based tests verifying preservation of
      2000 sessions and 500 files per session.
    - Added self-tests for many sessions and many files management.

Changes v2:
   - Addressed all comments from Pratyush
   - Consolidated LUO state management from FDT into struct luo_ser.
   - Extracted luo_file_deserialize_one and luo_session_deserialize_one
     helpers to improve modularity, and later review (Pratyush).
   - Added dedicated luo_block.c for unified linked-block serialization
     and management.

Pasha Tatashin (10):
  liveupdate: centralize state management into struct luo_ser
  liveupdate: Extract luo_file_deserialize_one helper
  liveupdate: Extract luo_session_deserialize_one helper
  liveupdate: add support for linked-block serialization
  liveupdate: defer session block allocation and PA setting
  liveupdate: Remove limit on the number of sessions
  liveupdate: Remove limit on the number of files per session
  selftests/liveupdate: Test session and file limit removal
  selftests/liveupdate: Add stress-sessions kexec test
  selftests/liveupdate: Add stress-files kexec test

 Documentation/core-api/liveupdate.rst         |   8 +
 include/linux/kho/abi/luo.h                   | 140 +++----
 kernel/liveupdate/Makefile                    |   1 +
 kernel/liveupdate/luo_block.c                 | 388 ++++++++++++++++++
 kernel/liveupdate/luo_core.c                  |  57 ++-
 kernel/liveupdate/luo_file.c                  | 209 +++++-----
 kernel/liveupdate/luo_flb.c                   |  65 +--
 kernel/liveupdate/luo_internal.h              |  70 +++-
 kernel/liveupdate/luo_session.c               | 202 ++++-----
 tools/testing/selftests/liveupdate/Makefile   |   2 +
 .../testing/selftests/liveupdate/liveupdate.c |  75 ++++
 .../selftests/liveupdate/luo_stress_files.c   | 101 +++++
 .../liveupdate/luo_stress_sessions.c          | 102 +++++
 .../selftests/liveupdate/luo_test_utils.c     |  24 ++
 .../selftests/liveupdate/luo_test_utils.h     |   2 +
 15 files changed, 1068 insertions(+), 378 deletions(-)
 create mode 100644 kernel/liveupdate/luo_block.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c


base-commit: 34e8f02817e31826e76bb2ded48bf28fe921f20b
-- 
2.53.0


