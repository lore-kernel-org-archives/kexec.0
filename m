Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D29DCD4F3D
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jxxd56FWFr3mbRx7ARcFT5EAWO1SeGE6Gu94V8HneZg=; b=TQj7bRxhH7iczs1B3R5fDEfBGo
	kmLrw0LxaQDmeqG4JSwUhXF2Vm7pnC5wMzeOEQ5CP592pll0dVB2X/qmJTtq8LUzwfi+xrv7ya7jQ
	2I8hZBkviWWX7+iZ9Tnfni16YhpFwrwR35hEdIwyW18B8noQFxg07jLgqtxaSLnb8dK+zA2O553c4
	Ym1SqFkL91EfTysAQyDSI2eZg9SFTVq100+oDk2SdUwBiYL52/dESlbgwMMM3wEvEoHyGZliQdpCA
	wrRzePLZNnpwUFqjlarpswGt6d3IRZbRCnvEYGjGGX1KdMhTh9EfO4h2oWXGtkPJMq3pCPBgBYjrs
	S36kZEZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8b-0000000DKPb-3LDm;
	Sun, 17 May 2026 19:26:57 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8Z-0000000DKOF-0Yap
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 19:26:56 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-50d75bfb259so9852761cf.1
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779046014; x=1779650814; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxxd56FWFr3mbRx7ARcFT5EAWO1SeGE6Gu94V8HneZg=;
        b=cK5hDur5NQCfZC4MApy5LQ3bBRBtUP5j446E+51oMiZpy46eLGFLABYz+EaiNDhRSh
         CjkrFu1f5syc3B6TcKxe4RMwS7KXHTwTLibESE99BGJjHu5hvs/SyYr8J2HlsRlRUnUU
         XMkkwRLRhXi5WaC/rz12N+BFjIN5azjel1jvdwoGDB3IEHjK89sr2AabIEzKi8w1O2O0
         vzGqMUaMpM5fNMfqwN9QMd+GORSqXaAwE8KqsTeW7vO4hBSpAJxO1M0Ml8bYaVnigv0F
         A4/8jSGdKaoo90A6syvdndauLYyfoztUkIKqa9ECzmDgxx6x2usxyn9nF68vZfgeprgD
         Y4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779046014; x=1779650814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxxd56FWFr3mbRx7ARcFT5EAWO1SeGE6Gu94V8HneZg=;
        b=TJKGDB/3e6eMsLdzd7W9fTAtBWsezXX6vVF2SYxk1MyxY57NVp0pcyTLT+ivX+1Ebo
         E0l7XipBK06fVNX7+bf+EXjlLD4BNFXB+jcKnr+9fJXtsQTvxRl01+R0EaVYHXuSS2lL
         0pvDqf/THoulh13KSXKDr9Bfl650Wzp2CRJ3728aTU4cvlYqtdZ2D99EaKZRhafrNfel
         ChH1RkReFSu2tRUAvAr63TfSoubQ5B0IWLhWJxbL8RSWEq326cEm+niShsII9KL47We7
         y2AeRpkkadcRd9E+FCJ681XZYqsjFcwRY8fFILd3lxVaCU9Mo7GogISok5PywFSkQw57
         bqVg==
X-Forwarded-Encrypted: i=1; AFNElJ+lNXN7Qwok8eFhrnidOzNOwwkWroSc3iFHuKmByymDfFK4j7sFv+ciIxsJx5UWd1+wR1xpPg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yws12u9d40qGcnPa00nYwwRpY8KH5nMl6NHxx+dXxTTnhAQ6WZ0
	ESLg/8G5gw9S4ydPdajhAo3Mruu3+pToTmi+P/iP63xFBKxl0MOud/G9x+p5aeipYCA=
X-Gm-Gg: Acq92OHqlhhNKqH1Sue7mfNu4tzFLJCzvsiHygL1bV0DOxbM0kSe84uT+e+2lKl2ewe
	i7puFQRKjtlwCPAYg9jHl0+9QKO7KkcMEBBUTkvgU/nW2hHEfbQLDGxZMqI+TEA52P2kN9a7RR5
	XbTFSekEQ+FyzR3jhJ1FKJygP++8n60n80d2pjDXssEPptrYZcL7gz7hTXgSKhcqrVqFiIgx8hj
	OUCk76mrm1b0AZcoT9EyA9uLn7nSWebYrR0Z5/5KI7N9gy7eIuGb9D0l4dVdytweswZ6uWj2usJ
	6jkOO+EQkHU8ztByHCYvqKM2jsiZxLHfdn2f++fmdu7KfW07uZ9ft7WSKruK/wPPhklaT/5Wx9i
	wZhNUrtKUubTcfLpjokJSmtZ2Nx4qGmOQ3lnnnCE02kr1/aHX567IIxATVy1IP8/C3KgVZ9l+x0
	8OgeBPOOBLdAX/ti3VJTMmRsRdbqUAl/tn3g55HX8JdOP+mNgKCJA=
X-Received: by 2002:a05:622a:1aa1:b0:50f:b2e6:c033 with SMTP id d75a77b69052e-5165a29e0a5mr177009741cf.58.1779046013784;
        Sun, 17 May 2026 12:26:53 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d5c4dsm108828621cf.12.2026.05.17.12.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:26:52 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	liaoyuanhong@vivo.com,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v4 0/5] liveupdate: serialization safety and race fixes
Date: Sun, 17 May 2026 19:26:45 +0000
Message-ID: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_122655_187579_E9B4C08F 
X-CRM114-Status: UNSURE (   9.00  )
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

This series addresses several issues related to the synchronization
between the reboot process and LUO session management.

Changes in v4:
- Addressed some comments from Sashiko:
- Reordered patches: "fix TOCTOU race" moved to #2.
- In "block session mutations during reboot" (#3):
  - Updated to use manual down_read()/up_read() in luo_session_create()
    to accommodate existing error labels and ensure consistent unlocking.
  - Added missing unlock of sh->rwsem in the success path of
    luo_session_serialize().

1. Skip LUO serialization for context-preserving kexec: A
preserve_context kexec returns to the current kernel, which is unrelated
to live update where state is passed to the next kernel. Skipping
serialization avoids unnecessary work and prevents sessions from being
left in a frozen state upon return.

2. Fix TOCTOU race in luo_session_retrieve(): Extend the rwsem lock
scope to prevent a session from being released between lookup and
mutex acquisition.

3. Block session mutations during reboot: During the reboot() syscall,
user processes may still be running concurrently and attempting to
mutate sessions. To prevent this, we introduce luo_session_serialize_rwsem.
All mutation operations (create, retrieve, release, ioctl) hold the
read lock. The serialization process holds the write lock indefinitely
on success, effectively freezing the subsystem.

4. Fix use-after-free in luo_file_unpreserve_files(): Reorder module_put()
to ensure the file handler module remains pinned while its operations
are being accessed during cleanup.

5. Remove unused ser field from struct luo_session: Clean up the
session structure by removing a field that was never utilized.

Tree: git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git Branch:
luo-reboot-sync/v4

Pasha Tatashin (5):
  liveupdate: skip serialization for context-preserving kexec
  liveupdate: fix TOCTOU race in luo_session_retrieve()
  liveupdate: block session mutations during reboot
  liveupdate: fix u-a-f in luo_file_unpreserve_files() and
    luo_file_finish()
  liveupdate: Remove unused ser field from struct luo_session

 kernel/kexec_core.c              |  8 ++++---
 kernel/liveupdate/luo_file.c     |  5 +++--
 kernel/liveupdate/luo_internal.h |  2 --
 kernel/liveupdate/luo_session.c  | 38 ++++++++++++++++++++++++--------
 4 files changed, 37 insertions(+), 16 deletions(-)


base-commit: b1378127003b61930ce30064328640503ad3ef6d
-- 
2.53.0


