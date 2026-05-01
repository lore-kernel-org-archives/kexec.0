Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F8DCD3424
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jpzP5NyCyl9kBFJtSorUnmMXLVo8P2gspi2fH3AtFbE=; b=qJdDTHERCE92vy6zciyYEvsXOs
	wqFv9jU93TsbSlT7LQhCqzR39Ygl5UtCU6ujT090GC1nU646P7x1K4kwDY0z2sueratP6GMm4fwMk
	ysunQ6c11tzFiEM5j28fiH/jdgyQADE4S/ei8/nW2sKgu8T3c3beRg/LCJn834SUmois9yx5AVeFY
	UkYdimee0l1ieGYrcU1PBMNjVmU232h6rWJ7L2Knb3YCmqHvhV8J7YFFGr/anyPHEEPWAR0TqkfVf
	6iN1aOv1SZvmKmQHVYE/ettVnj8d0W1+lWKJzLIhNOQ5PzjsP0bAHO3/3bWDGr2AUU4hJPtSmNJGs
	QG83MMAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkVC-00000006YjA-0uc4;
	Fri, 01 May 2026 09:49:42 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkV9-00000006Yi6-3x4f
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 09:49:40 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8318293f02bso1027108b3a.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777628979; x=1778233779; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpzP5NyCyl9kBFJtSorUnmMXLVo8P2gspi2fH3AtFbE=;
        b=Rra82o/BCzj3FXse88inh2YPoYsxC7CFmN1pAaVzjNhLI5o+JB3kLwVhc/pi0MO+9p
         bUTiGHMmdgRCTpL1BMUdu1J9l9EQNK9cP8m6F7WvY04kJTmsmoodhM0b28UazZkniCE5
         E2VXXk8aErKIsdWbnP2rlYXa+2m/17x5zasLDmZlWfA3m2r3LD1rZP8dwR/w5A6Zmd2y
         /f1PW1ArziFR9wnJNNQ0OGzGPqloW1gSml2vZaRPnFsLYx8kblgH4tCkfg81ydvA9vWa
         SYuvdt8hEc3MFen1H1XqS9ik54MId5JijLDDP8TcLNgOYm9s4CgBS2s4XBTetolwo3ok
         XqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777628979; x=1778233779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jpzP5NyCyl9kBFJtSorUnmMXLVo8P2gspi2fH3AtFbE=;
        b=K+hLVaHNQeNPhoLo/doEcPtAPHiZJZequXiK2wZwiSMC4+ZyomZKl0ec+Q2ybaZj/6
         AKTjNIUnLGHixJ7iS2MielMsQ65W1YZ+RjYRjkmQIrXt59vN0o4/OPpEJpOphHWUNz0G
         XKKJnVw7K2otGnaYOrMeZfd4HXEwiW9zowAAB/slOuPM1uLQ4tL3xMW4DHykk59iEz4O
         lAYBSSQoIHCzoswE42/GNp+RuSiy6Q8Nn03Etylor58cwzZC01hZFmp1p4TrxL3s4Lrk
         9+2WmFfxaZm4JliCnSYrNQQvOOyanFYHbbzn/OqRmCDrY9o57NKpiK+vzDX87jUeEO0E
         2E5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8mWFa03uN6zvTc/0/GaWMpgpjbroFnQ8QxdbVg8I1QCWcPVWEK4SkdUE3bxkzgBx9m7EwXrg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzTwQ1hghEzbRwn4kctQReVVkCGtKtqenrzOyNAKcTYaRRSxUlC
	CGMYBf43wS+Jz1gOVopRjPGLZ33HOHVRVEItWQNlgqeqUkW15ijRiMWg
X-Gm-Gg: AeBDietWWFjQgjykbXzXm39jHGT7SVPSLrymNH7eFtjAjLHk01bZc8X7QlNP8Kk09yv
	isScrylPAoFBqfK1ozbXTrGlX10gwoXtOa+6F8PWz93a55lFVXLJ1GkSYw00fAdha9K0z3q+xpy
	N9VSr1BfD0xFP70G+luc8lva6ipisf+B05NPEb8kAEfEpSLCk/rcJqnhiORSf4qIoRH0Br1XdC5
	tAiavUyrn2R+qr4i4LA8W6oqLZ+KovY1I+wFN0I8miBJ1gA1O7C7skCJrXzmFAS6LdMyaE02rg4
	xFRjprMoq8GXqaNQA7FOZjZlOhkFopX8E9SPK7IIKeQOXHKNS+JC/YpWCtm+jlYqF/AtetrO4Z7
	hj4Yx+AbstHsIfNtr0fSTOMuLfZmgSD6KxM0yspkogLGJ0wrNBDTQVf5FFVZm2XGY7wEwLpWw1F
	pLnO5CFskOMcTfQSkh22KMW6KucIaxdgktoKddKg==
X-Received: by 2002:aa7:88c6:0:b0:82c:9c4e:66ca with SMTP id d2e1a72fcca58-834fff74303mr5699537b3a.2.1777628978910;
        Fri, 01 May 2026 02:49:38 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:eebe:247e:613c:24d7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582dd55sm2042729b3a.1.2026.05.01.02.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:49:38 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/5] liveupdate: validate restored LUO session metadata
Date: Fri,  1 May 2026 17:46:35 +0800
Message-ID: <20260501094637.38650-4-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_024939_980544_3F5860BD 
X-CRM114-Status: GOOD (  12.03  )
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

Signed-off-by: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
---
 kernel/liveupdate/luo_session.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3327a28fc1f..0244c071936d 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -501,7 +501,18 @@ int __init luo_session_setup_incoming(void *fdt_in)
 	}
 
 	header_ser_pa = get_unaligned((u64 *)ptr);
+	if (!kho_is_preserved(header_ser_pa, LUO_SESSION_PGCNT)) {
+		pr_err("Session header is not KHO preserved: %#llx\n",
+		       (unsigned long long)header_ser_pa);
+		return -EINVAL;
+	}
+
 	header_ser = phys_to_virt(header_ser_pa);
+	if (header_ser->count > LUO_SESSION_MAX) {
+		pr_err("Invalid session count: %llu\n",
+		       (unsigned long long)header_ser->count);
+		return -EINVAL;
+	}
 
 	luo_session_global.incoming.header_ser = header_ser;
 	luo_session_global.incoming.ser = (void *)(header_ser + 1);
@@ -515,6 +526,7 @@ int luo_session_deserialize(void)
 	struct luo_session_header *sh = &luo_session_global.incoming;
 	static bool is_deserialized;
 	static int err;
+	u64 count;
 
 	/* If has been deserialized, always return the same error code */
 	if (is_deserialized)
@@ -524,6 +536,13 @@ int luo_session_deserialize(void)
 	if (!sh->active)
 		return 0;
 
+	count = sh->header_ser->count;
+	if (count > LUO_SESSION_MAX) {
+		pr_err("Invalid session count: %llu\n",
+		       (unsigned long long)count);
+		return -EINVAL;
+	}
+
 	/*
 	 * Note on error handling:
 	 *
@@ -539,7 +558,7 @@ int luo_session_deserialize(void)
 	 * userspace to detect the failure and trigger a reboot, which will
 	 * reliably reset devices and reclaim memory.
 	 */
-	for (int i = 0; i < sh->header_ser->count; i++) {
+	for (u64 i = 0; i < count; i++) {
 		struct luo_session *session;
 
 		session = luo_session_alloc(sh->ser[i].name);
@@ -606,4 +625,3 @@ int luo_session_serialize(void)
 
 	return err;
 }
-
-- 
2.53.0


