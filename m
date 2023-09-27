Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E75E810CF
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1b3uVVLN3njZEj02s8exAiGSw9yy0Z3AXJpRjCigMow=; b=U75hRSb5Avl5Mx
	Xmx4lJAouNZSGd0QilXbOfHF9Wa5/FX5PCzxuqMFiUNdfI6sBNHqd4sB38xp6b080SDm9KT9N6GqM
	4BqB4XWRhWOCW43fV5Hotscz0UAiLkNghRQMI2VOPy1Esels77fAvFt+1ehR8A0roiYk4xhhAQYvM
	otaXk4YsqEmA9QHoICMI1ZaB92tPHEYMXuOQV9mG1yzmV52GdrVrtP6RxYU0cbm0dpm7TYBLEg0pO
	kM7IsZzwaBh06VzMdEjxwyHTxCFL4ncPs9H41xFb3OnXdtZxZXUomTuA/aMaRyy7FV3+cPCYe538R
	aWDJ+znrnvkCienFCGSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSb5-000nRx-1V;
	Wed, 27 Sep 2023 11:20:51 +0000
Received: from bg4.exmail.qq.com ([43.154.221.58])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSb2-000nRW-2Z
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 11:20:50 +0000
X-QQ-mid: bizesmtp64t1695813643t39o9dqj
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Sep 2023 19:20:42 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: eSZ1CZgv+JBN+cDIUOHhmkLTfRceSJ8apOgwez+2IU796a0wKUusNMLMUtere
	eWRrnl5Xw2s1LXKDsXR0TOXKVhZw4i0bKpd7FHgCYrihYMOUKoF7mp57x3OwndldJUpAMBO
	TvNp/zOc64Z30/U6zbTEcJJYzXShZyO8YtQBZtttTkCcHdXqz4tkvM9R5hpjykJGb3DHNhF
	zHecgobCv9PKkbQjsiAubxeDjda7j96qN6xdSgr9JUtNJQHmOLptOIa/Ev2rLYjQnAU+skO
	POnqf1x5KeOJaJqc8+25DLzFBl1gIjD6/h8ymJfzg5GI7ROmJOrfeYGxrNHsmIg4txVkT+Y
	2/1tktOOyow/GyOy6J+9IuhxY9ODJMFiFKs0f5Ul1kVyyJMiBsIoJj6uympWg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11341390086915386169
From: Song Shuai <songshuaishuai@tinylab.org>
To: kexec@lists.infradead.org
Cc: Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH makedumpfile 2/2] riscv64: Correct the pfn_start for flatmem
Date: Wed, 27 Sep 2023 19:18:22 +0800
Message-Id: <20230927111822.180630-3-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230927111822.180630-1-songshuaishuai@tinylab.org>
References: <20230927111822.180630-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_042049_166383_4CDBAF65 
X-CRM114-Status: UNSURE (   6.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

To let info->max_mapnr indicte the direct max PFN and then
make the kdump header's max_mapnr_64 correct, riscv64 port
didn't define ARCH_PFN_OFFSET.

As for FLATMEM type, the pfn region of mem_map_data should
be adjusted to start from info->phys_base instead of zero.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 makedumpfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 42d5565..3705bdd 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3302,7 +3302,11 @@ get_mm_flatmem(void)
 	if (is_xen_memory())
 		dump_mem_map(0, info->dom0_mapnr, mem_map, 0);
 	else
+#ifdef __riscv64__
+		dump_mem_map((info->phys_base >> PAGESHIFT()), info->max_mapnr, mem_map, 0);
+#else
 		dump_mem_map(0, info->max_mapnr, mem_map, 0);
+#endif
 
 	return TRUE;
 }
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
