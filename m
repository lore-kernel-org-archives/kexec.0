Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C67ACD4F52
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XIQkjzlj7+tfVd0l2pHhoOhwHtfKoMpDvgkiferBx10=; b=kybTt2b4Rl3LEqqG46VTPGJg7w
	ONv7yXVivEJxKSvS735v1X/9MCrDq7HvA1yH88cdf40DwR2Ss56h3s672e2uj2yTrQd+ApvzyADx8
	DKttW3TAqR2mGPfLOKlug68nCZd8Qj9FS9b7uoV7dYrdZ6BCOUKEVAMhhbd9Qu7x6eL8SiyKvD4FD
	DDUYECVo/wbgkEk+2IWiV9M0skU1OwwoLSKXcXBTmS/gSkTZ1lai1/SGAlxXo56zSwj+eaGSJEoNx
	SL6vI5wXvZAYPFBW8VCI0cY1/g0GDGnNIUPweclnlKpyVEv/3PJmJPNxIrGBxUAVPkxzj0M7teKJy
	APIXL4Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUv-0000000FiGH-0JLI;
	Mon, 18 May 2026 12:55:05 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUs-0000000FiEk-42Nw
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 12:55:04 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-8c9166b26b4so30019676d6.0
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779108902; x=1779713702; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XIQkjzlj7+tfVd0l2pHhoOhwHtfKoMpDvgkiferBx10=;
        b=Q7B6So+2fzqp/c6CbmoEqX6bBc3UIBoHo6rkW6ElRyhiOojWTR6GRSg8JTZ/ZafB1S
         9za0KmkW2poKJrS7cwkENapoqCjCjOF3SkENXtC7HzTBuLUkpVMqD4IAX2ga0bGAUQ5I
         agLYhMJw2gAbeVsRTv7h2b/3OBQ0ytEKz9oZH2v/ykgrmjKCmAnfTfqiy+VcaE6mNzvT
         EUZcNmMmIWiHOwOmU0yiJ2m4Pqa/016pF/tFCs3nY9beysoltHbEPnuCaw1UPbPP8TDb
         FGUmqFRGBA7YKdIpsKkL9ijYcBTdJ3zF96AckPoMuTuG31RuqJFZl2b8B9/dDIYFG89/
         p+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108902; x=1779713702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIQkjzlj7+tfVd0l2pHhoOhwHtfKoMpDvgkiferBx10=;
        b=PImRC3kAp4Lyn9z8hjutQYTdL5slzzvLoAhLTj3iQ6ZtmxX8N/xf1UP7NYJ5m2uE+I
         1ys3saeQoSKigXMyKaM0PelPWkaJsj+bHMQ9V6N55SpiO4Xe9yx17O8LPpJDNEgpm+k6
         eftr+2HCcyiABvON++SfA4Rc7IVcEcN5Ze28dcCVUPtXYl+SuE5yhAOWGatfl8lE811I
         wXg0cqN9PChS9f8nAT6Tvglecq/+myUsFBinVceygzklyJ4BlEG7wP4cI8WUZETfCQis
         3ooa1jytXmA5SfpLgO4KfohuRjNS2ipPGDZZq9CS6wHX0TKYCU7xE5lSt+ex7Dnt+fV7
         8FRw==
X-Forwarded-Encrypted: i=1; AFNElJ9YjeYGQoxXEVXemFTbZW3Es7DfRQGto3C4EnP/JycI7HS3L9M8z63Pr5ycQlxSqBk7BtjLSg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyg+eGhEZoCjGWpbt5lO8SZ1uvcw6BY91eNAYSNa7hTakT+dmZs
	7J2+wjaU2CdyEKF+/0h5lQd+eb5N+tNG4d2qgByiun3RxJSRTndvhwEAnhrCfEA8dH4=
X-Gm-Gg: Acq92OHMaSemS+dLUVR94HJT23VngClF2cfMsUlI6y/+ziuGYGi9eU26584fLPwJSwI
	5fZsfS0fOiDFpCbNLDxDJ9I++GClXSuetcrp4V79J66X7B88bLgLzVBCikNt9RseXwO4KP6H5dO
	n/Llgc4aR2TG+D4mP2jvAbZ72/K7ZmF3bDWHyeA3kGQv/GtqgHrLXCjVBj8KM419D10PxNY/SoD
	W1KikPP/c59ZiuqzyA/XEMNXIYih9/orRrPAilwLw7K5a186xyxFMAZK+JanvDidfE+qA+HccRe
	RLv3F270Gvp1XuZQrwGe5PSh9aD0kwqWFVqGn7EI6eWMrkkBpg7vHHcB1A6i13mlQk+fBMA4PmS
	Y8h3xAFMkRUou9Lr4IAc1L6+cn1MDzrFOoE6C8UQOB47MDrn6elCztTmspWqYIaNf00k086fd1/
	QMT7p1sTRYBk9JVAd7JyuYtTZC/BkbkvkavbhcNrAXXhiHU20Zw/w=
X-Received: by 2002:a05:6214:2f8e:b0:8ae:62aa:665a with SMTP id 6a1803df08f44-8ca0f6f4d04mr240721926d6.28.1779108901661;
        Mon, 18 May 2026 05:55:01 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3608c1desm54511756d6.2.2026.05.18.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:55:01 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v5 0/5] liveupdate: serialization safety and race fixes
Date: Mon, 18 May 2026 12:54:54 +0000
Message-ID: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_055503_009466_5DE17298 
X-CRM114-Status: UNSURE (   8.85  )
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

Changes in v5:
- Collected Acked-by from Mike Rapoport.
- In "block session mutations during reboot" (#3):
  - Moved down_read(&luo_session_serialize_rwsem) after luo_session_alloc()
    to minimize the critical section, and simplify cleanup.
  - Replaced scoped_guard() with explicit mutex_lock/unlock in
    luo_session_create() for consistency.

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
luo-reboot-sync/v5

Pasha Tatashin (5):
  liveupdate: skip serialization for context-preserving kexec
  liveupdate: fix TOCTOU race in luo_session_retrieve()
  liveupdate: block session mutations during reboot
  liveupdate: fix u-a-f in luo_file_unpreserve_files() and
    luo_file_finish()
  liveupdate: Remove unused ser field from struct luo_session

 kernel/kexec_core.c              |  8 +++++---
 kernel/liveupdate/luo_file.c     |  5 +++--
 kernel/liveupdate/luo_internal.h |  2 --
 kernel/liveupdate/luo_session.c  | 35 ++++++++++++++++++++++++--------
 4 files changed, 34 insertions(+), 16 deletions(-)


base-commit: b1378127003b61930ce30064328640503ad3ef6d
-- 
2.53.0


