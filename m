Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B93CD13D3
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 21:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fi2jtxPM+vxOvAFAOVnwPs3gIOYE8Xix9RkoDR4vGnA=; b=bdR0+sRI6/cBAvWqtqBORlkPn7
	nG35+PEeKmB9uLnohO3WuBn1JgmumebpX+D33PaXVIJ7ZyNv1TsW8a8kDqjt7XuoT0NyHXvEE9unq
	M4w2geGOf2zmdMx5Gd9courLvy+HCS8XOIU9JwlHqSboOJx+d39JLciFcS6r/pxFvMoXeGCkVDHCj
	eLGNxjWrE6ZgQyyGnsLMHl9ZUNR2Dg+Ij25g1+K7cNltZMtH0P9EEYmr8yehTumzFx/+YMQFxex6s
	KwAkpJNxTBGh+Tq1bsmBq6pJ+NiOxK0WhRsg9/lpycKc1zxp01dWIiypvRV/K8unS1GoW0iEQWcmR
	YM7DTXEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMY-00000004EMR-2RsO;
	Wed, 29 Apr 2026 21:22:30 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMV-00000004ELc-3NZV
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 21:22:29 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-43cfbd17589so209076f8f.0
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497746; x=1778102546; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi2jtxPM+vxOvAFAOVnwPs3gIOYE8Xix9RkoDR4vGnA=;
        b=erOEHoYmgrbYkRcs3qDv4oFn/+E9NVe3cHSSp3rqFCObJRR0Y+bq8RelwgPs55bHl4
         Dx/5l4LOI88KBBEkJlsyGXh0KB49Xyyfdx56aApXxJ0vJmIxqYHjIciQWP7za55LAaIs
         XTlZdV0+DQXZM/Z4Rno336kcsBQlBYo2sYTqvAZSIU/3DVJUuyZNBdQAtY6hw7QJH7bF
         t/fZo/kwepJSoOiG4WPt/YC1o14hcu5diOP6L54nfB7QE7RbrIj5LUYgu4mKFTFrhkBv
         wk9lG4KtKhyqwjlR2NN+Qa+tpq0RUDugrfCfqBaQX3N3aE67axJ1321RsZiGqLn/YClx
         Q42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497746; x=1778102546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi2jtxPM+vxOvAFAOVnwPs3gIOYE8Xix9RkoDR4vGnA=;
        b=JmJG9uIAAonUhg7BewwXWREdFGU+iESu0cfLFf2MOyMCNwkk4CBvW1eQAbI5nAi1MV
         dxWrVW0l5y8QfHAWHxHXoRN8hVNcpRCS221xXV9GaM9gKVoPSug7l/+u+I6kvX2bJrs8
         b/xh798OU2m/vY5NvfrpNBYtk3L5ywgsQRhyl7AWfpo+8ysftLOHvRPQsfrrxevP2cFQ
         dRtymA9kXQhpwaZCbAlBtrXCE8wHSear4F4ufwx8HnZ3vKhHdkd0aVdXSV3pQu5uDhrL
         CExmu7OpvnBraWrJsIexE6USwgzhYyNreW42IPaDRIXLFGg3H8mczGkPVG6KGEWLvDpy
         bRAw==
X-Gm-Message-State: AOJu0YzuQMM3jVSCfE7baY5UulechhARArx3rbcf1N7r30/VQlYDDP3z
	ao5IhSuHGYvz3hlKityWul7S3EEyabBWH830edioCd+2o2hnbz0KkjTTk2ks7g==
X-Gm-Gg: AeBDietfGAFXf+rYFQCiZc/6BAE7gzgknygPXZ74NPVqRU/dniD6jZMwsKROIMHLU6H
	Sgydw0ZE56P7XRvcF3RNPgRCFDRMRxL3ccvZpFwqUn1ecchTdpX6KeikeZm1reENg5Sy7WElMfa
	2d89Krj/pyaF1A+XRhAM70MGnof8DPfYQ4b94vlTlMW4m65qHc8fmNro1rYS7rgW8RXlP/EOTCH
	T3ZRUBR41I6DbRsTxKdIiogW5mMN8Khm3DOKrVBSF0GCWCtZQB7FejKHXowFUMsP0ju8UFNo85l
	ReE0xgrJx0bdHgL1nhy4Q9aIKCw/CE4hisXkb67MUZ1Msnzy7Q1+MffX+lBDHL9kJ4e1yaa/mEq
	1WuD2jRCtEhhI9qVuUvXvmFRSCHSEljLi1GMANWPdXLHsD4P57OoOodjClvo+E2fJjQLs3SOOIs
	wB2eSPzk3WSHWDYIWGuXYg/MDzmBy2Tfpv8oRjoSM=
X-Received: by 2002:a5d:5f46:0:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-44649ba18f0mr16916072f8f.37.1777497745370;
        Wed, 29 Apr 2026 14:22:25 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8fc7:44bf:8aca:ebae])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-447b76e5c7csm8096196f8f.26.2026.04.29.14.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:22:24 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v11 0/4] liveupdate: bug fix for session name and new ioctl to read it
Date: Wed, 29 Apr 2026 22:21:13 +0100
Message-ID: <20260429212221.814107-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_142227_884927_D0A4CEB7 
X-CRM114-Status: GOOD (  12.74  )
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

From: Luca Boccassi <luca.boccassi@gmail.com>

A series of patches matured while implementing LUO support in userspace
in systemd.

- reject session names that are either empty strings or too long
- add new ioctl to retrieve session name from FD, so that userspace
  can query it without string parsing in procfs

Both changes come with a follow-up patch add test coverage via the
existing selftest.

v2: apply one fix from bot review about cleanup on error path:
    https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
    the other comments are invalid: luo is not a kmod, and the write hooks are not set up
v3: add test case to liveupdate selftest
v4: split test case in separate follow-up patch
v5: add r-b tag, merge series with LIVEUPDATE_SESSION_GET_NAME ioctl
    as they both change the same unit test source file, to avoid merge conflicts
    add '__u32 reserved' to the UAPI struct
v6: add more test cases as suggested
    more verbose commit message
    fix docstring
v7: apply suggestion from review bot to stub out setattr ops,
    like it was done in 22bdf3d6581a
v8: add new patches to reject session names that are empty or too long
v9: fixes following review comments on LUO_SESSION_MAGIC
v10: split out LUO_SESSION_MAGIC patch as it is undergoing more discussions,
     and the other two patches are independent aside from adding test cases
     to the same unit test source file
v11: rebased on liveupdate/next
     reject LIVEUPDATE_SESSION_GET_NAME when 'reserved' is not zero

Luca Boccassi (4):
  liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
  selftests/liveupdate: add test cases for LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
  liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
  selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME

 include/uapi/linux/liveupdate.h               |  21 ++++
 kernel/liveupdate/luo_session.c               |  20 ++++
 .../testing/selftests/liveupdate/liveupdate.c | 113 ++++++++++++++++++
 3 files changed, 154 insertions(+)

-- 
2.47.3


