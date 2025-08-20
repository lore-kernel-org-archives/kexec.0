Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04169CA0EED
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I9ncaQRD3E1PN8zy1g7oC/l30LY0E5NllfF6WnxDxg8=; b=nPlBic8mi9r+pzjV2xHNzklm3Z
	Woo/QJQOhoaJveNuwzTMCpBk7/FLMFuTBi8pIdWbHvVhHDJG/W64iRZRuLqPAdZ5ECyUkD0f9U+sU
	hETQZnDhM5zc38W88N/sr39o7TnMHB81sGr8U0ehC8PJ13JVzfFB0njzUAVRAr7i8E1kBBzQAVVEi
	vP/BmX7K2ma/RT45RXnG544q4mcsU0nu6EagWdz+xuB/RxYg7eMbnuz+MI/8XNLpUpyR81bEsonZP
	AI+8NrGogh4pL+Rgsq5Nzr3AdE/cKtmmxi4eX+ORB9//35rjyKvXxWAaZmkCkjmfrOVFV5LvUZ24V
	rcqCu5Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uofgg-0000000D52S-2p5j;
	Wed, 20 Aug 2025 10:04:58 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoewt-0000000Csyy-0i6m
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 09:17:40 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso4613604b3a.1
        for <kexec@lists.infradead.org>; Wed, 20 Aug 2025 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681458; x=1756286258; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9ncaQRD3E1PN8zy1g7oC/l30LY0E5NllfF6WnxDxg8=;
        b=DHi2DFlvTDVuc2KfFgaMCMozzunnn1iZWsMZX1WQcNcPrSagJYTSNJa2wOfkq8yPlP
         V5MHDIn+5jPxOj4mrhfc4jW2pq9ddaLRtoJjwhaNNb2X3pt6W5l3I7f1LI9tNOMvNb/z
         ycXoZKH3Ut4iiwBmH1lenLqS33IkiuTnJVo84VF4aj2n0WpU/Y7lI7VRfynrChkEuHzF
         l16lWJLJEzZEytoZgz4xGvEGKDMXnrxMx254/aGuthR8+5caM1A4lRQ/LdjjxX8r6Vu/
         4KfjxuwR17EWB/EG+jincED1OgjzXO02O7zjHLglgnFgFaP+i92poLn7jpoaznmsB8rR
         Eq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681458; x=1756286258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9ncaQRD3E1PN8zy1g7oC/l30LY0E5NllfF6WnxDxg8=;
        b=jeagVzzNOgn6z5/qPK5ZhcKTds+SotXA3APBJtsTfq+jpdeGdftHjmZKt8cgAyrHQw
         cqyUc9S3JV+LNBtL7iY3IOX1RJzFdbwpRR3+ocK6YiaXzJngHVUTduF1bWOelMjvt3IL
         12GjIeWPSAlUxn3yzvmzmaukwn0RkRFMD4OrZaDXFq8VQ6qgMeBZI5OuvU2mmtgQ0WgM
         9sM4Asm7nSQytGaLH2fcSb9c67fQKyMEMY9lVOF2XmjwepElaUQNJ+ePJGE2bjJJWzDl
         rmSPPJeLGxNXJdxZplQR8xMi5AiS5UdGwks7nAPt1YNpg40yjyni0C1cgGVkL6PKAs/u
         8XgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKrI5qpiGfuTEMZxDeFHXV/57+2v4Y8s6oriNPMvOWUcqS+meTaU2Mt3nN55abTuza40d5fw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxrwPILWWQVPJ9vHz/ACQFeJZRb81MCtoyn6X8F2k19Zb7TMDOL
	M4lGbEIDyXnIDYhuO/qv4uHGWzLXDUOyxxt291Il+UiJKk6NMoZ/2tnN
X-Gm-Gg: ASbGncvAWR7j3plvsst/yFWFg7z4oLNUMFhj4Wkw1/VhslUTlnC5e4m5N3R12Z8MhU3
	DMPl8+6FmjjCJ2BjmiqOSAEDfoA2FPizPUyq+4mnCtVuoMiyE8y5SB8XcCmJmYFWVhmn1YYtFmD
	LVKiEYzsFB5xB94AwnyjS1GI31RAN+zKUKTgksoI3LLwrQXMJLEnmSkU5+oHACeN1n1TBol57+D
	XoRrzEn/6YII9RxUMM1LbfPG3cTimAz3tcQez0hIdUvClGBq1WtZOHRjrZOsLPgAKQVtmLZzbj+
	znMDXGuGXZj9ahWVaHiwrrzeImNEkzdutfginmAYGryygEOC6J3Ou6KxCOBtU4b+syeKI9LT6KM
	RTReYMsLKOslx2U51xjlKQhtfUsR+UgPWgXKRpF7/Y8wHKYb/BRkBwmSC06BT28IM/fskEI468Y
	KVY219
X-Google-Smtp-Source: AGHT+IFHtCSYgqJrUWxhPdCX9Zi2FF1HyQPUrI8Q9X/CV07c8sMtfj7DH4mkXmliTRAFReISyuxB/Q==
X-Received: by 2002:a05:6a20:7283:b0:240:5f9:6359 with SMTP id adf61e73a8af0-2431b9a84bcmr3935623637.34.1755681458236;
        Wed, 20 Aug 2025 02:17:38 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:17:37 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	feng.tang@linux.alibaba.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	wangjinchao600@gmail.com,
	namcao@linutronix.de,
	sravankumarlpu@gmail.com,
	kexec@lists.infradead.org
Subject: [PATCH 3/9] crash_core: use panic_try_start() in crash_kexec()
Date: Wed, 20 Aug 2025 17:14:48 +0800
Message-ID: <20250820091702.512524-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-3-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_021739_211949_2676865F 
X-CRM114-Status: GOOD (  12.94  )
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

crash_kexec() had its own code to exclude
parallel execution by setting panic_cpu.
This is already handled by panic_try_start().

Switch to panic_try_start() to remove the
duplication and keep the logic consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/crash_core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a4ef79591eb2..bb38bbaf3a26 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
  */
 
+#include "linux/panic.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/buildid.h>
@@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
 
 __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 {
-	int old_cpu, this_cpu;
-
-	/*
-	 * Only one CPU is allowed to execute the crash_kexec() code as with
-	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
-	 * may stop each other.  To exclude them, we use panic_cpu here too.
-	 */
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
+	if (panic_try_start()) {
 		/* This is the 1st CPU which comes here, so go ahead. */
 		__crash_kexec(regs);
 
@@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 		 * Reset panic_cpu to allow another panic()/crash_kexec()
 		 * call.
 		 */
-		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
+		panic_reset();
 	}
 }
 
-- 
2.43.0


