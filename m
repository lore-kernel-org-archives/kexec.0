Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F84CD3423
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8CXENGFI680//+XMLD9o6Yj9f9pS4CJGNcNi4QeEBC0=; b=Rxevu53rDbUYy/w5UVG6FShyXS
	3TcJPOhh7XPBi6FHgCHHy/3fT3C6ARlHlZ6/kZxptZja5XkSu1d3ybFkHwIYjiAVdsKiwGB8fr6sC
	74fHrGD+0qafmyUfDSzFJcTPEMO2ziQzgm+yYb67B+QyoVQL/iV7NcTIlFvaXFf2w0xh+//HgxgOc
	lsFooL7vEc4P5C/3kqbK4Yx5md8aqJRVN7VRz/N93LzOuLfJo7uMnE/6MMjQZvSvSFppg4XnBvHpq
	d11U8JzDoYQfV+nR0WW6M1dwGn/S9hPCw1dK51mTNiXumaWEe4WeWqh2IjNo5A+UdwkNJKhAyfPBo
	5XoBpkbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIriD-00000007VmT-3M8g;
	Fri, 01 May 2026 17:31:37 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIriB-00000007VlD-2y6L
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 17:31:36 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ad9f316d68so8933945ad.2
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656695; x=1778261495; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CXENGFI680//+XMLD9o6Yj9f9pS4CJGNcNi4QeEBC0=;
        b=ltZdKrfzP7o+lkPtH3d7Kx7mOnZZO4FpZyMjs5LDY7ij+0QmhWVse2uNRhehSm+2UI
         jE0OKue4SfBBnr8Ra/zI4Uty1yjTz5kHGOr9OdwIANjUOVZRMl+2ojUDJKp2F6dgNDSy
         D/mnX2TdYmfsU1OHcF9fCCoxbLFeTPCq5/YqWxAWQECQXegupF4O8jwlfGQjGVFe5iT4
         7EXKayRoEECHAm8NxRee/W1+hd73VuBy48wmsyDzK2oaH6hdwwrPvNyHOeo/rWUEO2Fy
         i7AGNVWSFbOLJJc8iqbVMonOSj+bVU9TDGi7ZRkox+ohzbLbTtrQCK4r9KY7VZcmrr4s
         6Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656695; x=1778261495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8CXENGFI680//+XMLD9o6Yj9f9pS4CJGNcNi4QeEBC0=;
        b=Gua/sdnIUrb6OBPx7gvFfDUIv/lscCEHUhj8O5junrtJU7a5ZvoqfUKcfYyayvTRxg
         B6zlnV3DI32pjmymYWOcM1rEI9JqpRUVCHof2/Qv4JvEAwgvpSl65Di3DC1RToZg2VRc
         8j9sJJJ1QAZME5Qis0QSfq9vwH4NlsZWecbtdONd6bwVWEqPwsg6K8+gMofHZGagGu8y
         849HdnqTInEzjE/oQ3la5nkLbhcyhRE88UYZbJ2PjdX9yvXViZBHgqLAjos3/H9kN9JC
         gNlppYxwScJaeDCBhVek1ll9v5869W8tXc/6BvuAm3Ky8byZ6oF42DrtRhuVCKqYSfNU
         6q6g==
X-Forwarded-Encrypted: i=1; AFNElJ/AJSbUs2KSODiiai8RdLKhZJvn83qb6GfacoPSMoJ64zWR90GGLymPxGQgBDTBf2KBgytocw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yydn7JK1P7XuMvDnyXKjTLK5HnBMApsMZK5eAiKmWT9UFJr1TQq
	VmyNc0JxvdSvpuHo5BOLTFCUSOf9fTK6x5OZYXpJ06OJKqNd0AZaV1g0
X-Gm-Gg: AeBDievoJUP6lz0Ab/HwYZ8Y1ZBEx7cXg7kBSZvds0B0fzsZAC+kjBhPgFMaHPwWCU0
	T8MjzSPnSbZqHKVOh4a1gcORqyUu2kw7ViN4F5OgjLv6b6B0pic99gBUJ/anM8NCN+kuFfg0T4V
	d8+ggVQo+D5C/6H+XCjfvlQwruQnQwpBD5wVi8R9A+ngQTi2REO2hRn+UZSbrNLvPRir2qVC696
	qkvt/XfUqrNUOJRVQGaSCYCff/2+fOmsrtLJi/TYdBiX35vXH6Rd5JJldKDJsBigDEHDRw21owL
	rlAj0h2yErJMWUD6SN/Wpef0D1WV5Sj54P4SVWaFodcvqemAG3njxF5gMdD2U7bDn5VNdx+PYQb
	Bz/emBMzEmgN13BsIVfEMGj6DMQkKPJsITlT/kIUSw4AVLzIq3HvnaKZyMX/eNXn4ub9gzxTO+D
	RwovpEujIaCBn/EIZp5rp3JGItes0H18aPMvfuXQ==
X-Received: by 2002:a17:903:380f:b0:2b2:9f9f:fe6b with SMTP id d9443c01a7336-2b9f2821038mr1393735ad.40.1777656695011;
        Fri, 01 May 2026 10:31:35 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:15cc:43cd:8af9:5a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caad2459sm27094895ad.33.2026.05.01.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:34 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] liveupdate: validate restored LUO session metadata
Date: Sat,  2 May 2026 01:30:51 +0800
Message-ID: <20260501173053.73116-4-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501173053.73116-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
 <20260501173053.73116-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_103135_749360_964DD6D4 
X-CRM114-Status: GOOD (  13.74  )
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

The restored FDT contains the physical address of the LUO session header,
which LUO maps before reading session metadata. Check that physical range
against KHO-preserved memory before calling phys_to_virt(), and abort the
restore if the physical range is not covered.

The session header has a count that controls how far LUO walks the
serialized session array. Check that count against LUO_SESSION_MAX before
deserialization, and abort the restore if the value is out of range.

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


