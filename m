Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD655F9D0F8
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 20:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1JKwITjeCygFFMWgjlHnhRhK9rZVbof5rkADvxp5LiY=; b=OsnMZjPLvvTCeNm+W/Bv6ins6Q
	bFRN4gOnzR8/YqKlG68bX/15ZNLMfFqRIXOjd0Hi0piHzBNETb0Enx2FAlwggNZqabjTilq2Lit+y
	FDeOWHX2KVoCcYZH5uMBk1CcWNSBQ8K2OvDDHhU3/3O/vkJB+JfBIYzlmQZwz2Qo/KJS/W+x6X1iB
	Rl2bDNGb8h52EtNamgWlayj/bguysSXB7dwfPYlpEhH8K7n8LDsAPxK4AhwTO/8tOOHyRkR3leI+u
	ri7QGdRAJum0Swsehpu3r+xPVExOmnPLBAb/4o7sj2C8Ut7RHuJoyKlEPZZnK22j2PwObf8uoB7Eu
	0kcRP3Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjy7-00000000B1q-1VC5;
	Tue, 14 Apr 2026 20:02:43 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjy5-00000000B1G-0eIe
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 20:02:42 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-953a44f8404so1451161241.0
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776196960; x=1776801760; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JKwITjeCygFFMWgjlHnhRhK9rZVbof5rkADvxp5LiY=;
        b=IS2BXZBeIfvSZ/EUx+96owA522DDwpg/6bnd3YMRdbB3SRig+nF/Tzervskfu7eQna
         hCjNC47Xw1mR46qto6psJ+WYcmTvxoxO/A/T8uBSXcTy5udq0vGzs4whCXxujcds8Jmo
         A1ybW7BBlxRWE00tMt/XDYrxYXbzA6U7Hu2BhrhntSXJS6p8P5OIxP58sczJX/OW9w3w
         9vcja42IQutUw0yL8kd3epGK3NBYzLgAnV6DOgqeCvxZjZeeURMaeo3Ki+m2BUK2ktqy
         vPBMcJCGmyALKJjBlaSED9viKuo6E8Li4935gwhDzIXq7CIjTqj5fUIFVN6xhS+64SIu
         519Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196960; x=1776801760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JKwITjeCygFFMWgjlHnhRhK9rZVbof5rkADvxp5LiY=;
        b=ctQqHmLQox35ft3xUeAiOLBScPFmkt8jyrX2AUETffr2NmEyjQyD8F880kkMkNaVM1
         HecSXcJD0qhK0bTqPHtfq0JkB2GTrKu2zC3bnvBTolmU86VfZSoPa3LX3/34c8n2qSwY
         Xb492HscXThtSstYJ71/D8VeDywcFfzpRCrtqpZJoO+3hqFQuzvDRYEqFWZNunrokvAG
         pzeu0ViQkb5EATW+sVG7JR9GGkzVrkjNmZm2pMSHJBQPphYv4nE8+kRrlJpv+T3TlFnY
         I1MVdcX5BLeFvhEAGdnEWZ3srQdIpgJVHpq/CBLnPWFP2jweEF71BjjNY9EKI6IoUyW/
         wVwg==
X-Forwarded-Encrypted: i=1; AFNElJ+XYCF2ckP3pOlfvABU7ivp+Q9HuGdqVWs77XxAcEJGm/XX7VGWL75QIoCO+mswp7ZrTsEIEw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEEvyH2JYoKWRyKJGf0GmnUq9MzvGVK5rPV+os2wzfPodHMSnj
	sTo/EEuFPWPr6jrzhMnJUbv7/Gf6Ax69LUqK+oXcnxI1X719CQ9gGU9GBo3oHIX2Cgc=
X-Gm-Gg: AeBDietarYC+ThSZtoXVLA/a6XpWpF0grnNCC7f9CsyB9MLNPeJPyQnZxZM+i6TEZDV
	NwP376JqO1P4XSUgHIpd2E9i7DQwit6WkB1HtZH7Fd38MyCbotoWjWgbVMdt8TH6GSYA+E13OG4
	X0E2cYjk9yD0kkVOncMRMCcosdL8yEaaCPTRN7oPpExahzMQRgjgzVAZvAS3rF6R5FfnpA9wOBx
	Ozkq6p7kt9mrqFvuMlap/36yEEoxuW7rDp9OiTUddAYWU5IDqxwFl++35CS4WTLRj3yq5gC5ERR
	yHQvEg5gEHjUzmb6up8ZSrc/PjhAGiIrVEN270dRI0MBWc1h4t7M9klmLm4fNj8sxUol9Epcdrm
	y4xBLPZWJkdDr3i9DOqdG8ZTZP308bzyiHXK/lagG7ZujdNAwg7SoZX0xCthhWiYAryKom7y4wm
	O9z7rF5WCfvnd0HmM+K0ZRnBPfGQZA6GFubFhM4tNmNvF/ysD23CTsThezsMMNEBIQVQ==
X-Received: by 2002:a05:6102:1526:b0:5ff:2963:52dc with SMTP id ada2fe7eead31-609fe7a6ademr8406630137.4.1776196959613;
        Tue, 14 Apr 2026 13:02:39 -0700 (PDT)
Received: from plex.localdomain ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a180a2sm132213656d6.15.2026.04.14.13.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:02:39 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH 0/5] liveupdate: Remove limits on the number of files and sessions
Date: Tue, 14 Apr 2026 20:02:32 +0000
Message-ID: <20260414200237.444170-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_130241_213976_AF275765 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
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

Pasha Tatashin (5):
  liveupdate: Remove limit on the number of sessions
  liveupdate: Remove limit on the number of files per session
  selftests/liveupdate: Test session and file limit removal
  selftests/liveupdate: Add stress-sessions kexec test
  selftests/liveupdate: Add stress-files kexec test

 include/linux/kho/abi/luo.h                   |  52 +++-
 kernel/liveupdate/luo_file.c                  | 226 +++++++++++------
 kernel/liveupdate/luo_internal.h              |  29 ++-
 kernel/liveupdate/luo_session.c               | 237 +++++++++++++-----
 tools/testing/selftests/liveupdate/Makefile   |   2 +
 .../testing/selftests/liveupdate/liveupdate.c |  99 ++++++++
 .../selftests/liveupdate/luo_stress_files.c   |  98 ++++++++
 .../liveupdate/luo_stress_sessions.c          |  98 ++++++++
 .../selftests/liveupdate/luo_test_utils.c     |  25 ++
 .../selftests/liveupdate/luo_test_utils.h     |   2 +
 10 files changed, 709 insertions(+), 159 deletions(-)
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c

-- 
2.43.0


