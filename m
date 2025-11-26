Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4C7D10395
	for <kexec@archiver.kernel.org>; Wed, 26 Nov 2025 08:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZCgdJ6wSf1lbQtjUTeGU2iEfKy0JpdjJL00moVGe2s=; b=y0lHAq1YUSpm6/RV9HGuVojppp
	pcJ7W3YWGqhXJrrJpFLgMhpopvCMiR0sNa52GHSfoEsDiqpP69KovKDo2N/Ml8SFWhf7LiHp+/6pl
	04ts5mNWck2Ka3M2UslhuKg2mUXunDbOLnwij+DUmW8TnVDMNHbl88DBc+pclV+eWmMpSXVEEepy5
	eZ48Zyqj4uUMRreuh91YI3fmNwvj0pJ3KMlMzBQVazbyEMX17NXvN0YQs/tNUBKCrFgOGNc4Sjk4+
	aWjcutsMLQaUiWwMfAgZjpw1LZ+sJ0JJZ/uJSB/rHG6+3JYJPmF9RdA0jtBX+cIh1XD3qKflLZQk0
	f4VR0jJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBAE-0000000EdsU-0ovJ;
	Wed, 26 Nov 2025 08:46:14 +0000
Received: from smtpbgeu1.qq.com ([52.59.177.22])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBA7-0000000Edlx-39ol
	for kexec@lists.infradead.org;
	Wed, 26 Nov 2025 08:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764146739;
	bh=tZCgdJ6wSf1lbQtjUTeGU2iEfKy0JpdjJL00moVGe2s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nLCTK4kd93wxfS99Tfw8iH3g281slWiayxJth715EtdRyUQmdZRr4si6kar7TPqG5
	 /GhZMqlSB61aqGsZ+XnQcdnjyFztZIXxWIYPA7WoJdvMuawU/fQ8IIiJHzZDx0CXwX
	 hHUXcRpuaAqMx6J52hyRFF6doZt2IbWjXPvfnXDU=
X-QQ-mid: zesmtpgz7t1764146735tbed976db
X-QQ-Originating-IP: xoV5lrxXt6GCOYkdPevaU868SaCX+M/fBGhMs9dYeD4=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 16:45:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12371583234594709573
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v3 2/3] kexec: add kexec flag to control debug printing
Date: Wed, 26 Nov 2025 16:44:26 +0800
Message-Id: <20251126084427.3222212-3-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251126084427.3222212-1-maqianga@uniontech.com>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OZsapEVPoiO6Qg5kvumin7El44TTwIOHw4YEtbhE9q8ibGhPZiz+i7S+
	YWFoEK0ne0zKD8h/iYBrcxlehgLJtwkI1lvOja/hu8TwSlS8pxxQ3nmCKPbHsiw0YTpy7Ef
	ucTX4qx15A54w0bLi9CtmTxtRzbdF1Yewv8UhVrxGSOUDCpAhe/iSVCLQR6+M8D/qeVci0V
	QRnMkF4o2UQYhPsQYKc1BspxmqYjpU8pBFNyelXH42/QPb1nDdaIRTkqzaJ2wSsYOUX5usZ
	qrnTqjnz8mQBN0K7fJqzwcs1F1XMMBFLeZYDanw+aIbGIo0wwsagh9mul1EvXWEIb/mEdwX
	mszl8vEMJFYuWZlqmXGfBuLk2lH9FpDfCmwQKF1kkZh/DdmhzDVMRIfdxY+o0dTgVjFxQZH
	QPsIuMR7WArYueK0tdGuAlsGyIqAKYdaxDsSuouqG3mo9rImC475bJLFcVTgeZES9+KtzF2
	Q5oAlyx/5oFkKWTt7F1mJNl3fEbwqbNh+Jf8zLYWWZ+2Sfrc/I4ZA2csUDwt/yZxcB6XmkY
	5ez3RqlOB/t1266tyAvnGS7p9f4vjXKfrdzB++VPaj6vrTtqr5jicL/B7p6YzoZLwR6WEC1
	ttD/Gmh65Mhs08hz4OGFmf96fpACdXPGYHDCu8LqhlTGqAm8yxBXMUNm0eKP1GMvcqmyd0O
	Ws/SLyb0QQkLI3ypuqxLWvPpW3dV2/eojb1jVJ+sp/ak1w40A0kxZl11X8fdd8WNk75eff8
	aDaXBpg+YqTCnunnb1iv/ib7BoQ6XCWKdws4/s/iyPpjvMHVBAfGOEs4f2pbo8iRBMZqgKv
	zdrbYMgOuIp0tTpgOJxuQBJMLquqb5Pfja7QaegnAqrasAV7W8hoPeb1CMMVE0UuqPXWxiK
	MhBmeY/vrj8jrbZVjlLW5aQRtbY2ootYR4hdFFqg30753Ww8KcDI7A6OslQqVD1N6lm7D9x
	ylsNXR8lfHVJq+3YlVIHirOhRRQXsmJ7jkw1Xf4P41uLCuHuXHgxwxjLrbFJDiJ80kF1X7P
	P3tiqx/XAp2fnzuRQtQ5ZgDDpRG7o=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_004608_300098_B597744A 
X-CRM114-Status: GOOD (  15.27  )
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

The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().

Since kexec_load and kexec_file_load are not triggered
simultaneously, we can unify the debug flag of kexec and kexec_file
as kexec_dbg_print.

Next, we need to do four things:

1. rename kexec_file_dbg_print to kexec_dbg_print
2. Add KEXEC_DEBUG
3. Initialize kexec_dbg_print for kexec
4. Set the reset of kexec_dbg_print to kimage_free

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 include/linux/kexec.h      | 9 +++++----
 include/uapi/linux/kexec.h | 1 +
 kernel/kexec.c             | 1 +
 kernel/kexec_core.c        | 4 +++-
 kernel/kexec_file.c        | 4 +---
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ff7e231b0485..23f10aec0b34 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -455,10 +455,11 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT | \
+			KEXEC_DEBUG)
 #else
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
-			KEXEC_CRASH_HOTPLUG_SUPPORT)
+			KEXEC_CRASH_HOTPLUG_SUPPORT | KEXEC_DEBUG)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -525,10 +526,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
-extern bool kexec_file_dbg_print;
+extern bool kexec_dbg_print;
 
 #define kexec_dprintk(fmt, arg...) \
-        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
+	do { if (kexec_dbg_print) pr_info(fmt, ##arg); } while (0)
 
 extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
 extern void kimage_unmap_segment(void *buffer);
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 55749cb0b81d..819c600af125 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -14,6 +14,7 @@
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
+#define KEXEC_DEBUG		0x00000010
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 9bb1f2b6b268..f6c58c767eb0 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -42,6 +42,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	if (!image)
 		return -ENOMEM;
 
+	kexec_dbg_print = !!(flags & KEXEC_DEBUG);
 	image->start = entry;
 	image->nr_segments = nr_segments;
 	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..7bc1cd4105fc 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -53,7 +53,7 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
-bool kexec_file_dbg_print;
+bool kexec_dbg_print;
 
 /*
  * When kexec transitions to the new kernel there is a one-to-one
@@ -576,6 +576,8 @@ void kimage_free(struct kimage *image)
 	kimage_entry_t *ptr, entry;
 	kimage_entry_t ind = 0;
 
+	kexec_dbg_print = false;
+
 	if (!image)
 		return;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eb62a9794242..3f1d6c4e8ff2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -138,8 +138,6 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	 */
 	kfree(image->image_loader_data);
 	image->image_loader_data = NULL;
-
-	kexec_file_dbg_print = false;
 }
 
 #ifdef CONFIG_KEXEC_SIG
@@ -314,7 +312,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	if (!image)
 		return -ENOMEM;
 
-	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
+	kexec_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
 	image->file_mode = 1;
 
 #ifdef CONFIG_CRASH_DUMP
-- 
2.20.1


