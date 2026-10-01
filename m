Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D771CA5FCB
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 13:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GISBfCNPceIZSjVaURcaK2XPuYCZTPOv4jPbHJzoivY=; b=YTioaKlarr9/UOsGXqasJJI2LO
	TWFUYQw5jBaGaOkW60ZHJYO7AJoOcxLIcSx4cizRwJSozg+LhLKWe01zOyz2iLG7YdS3VRqmqomPX
	kiqXvOioIWZWi3Z7FI9WcZoQ1FJVUKtUweqLX/T1UlI03WxkxKAXYOEkJ8MadNT/WpnJzb24W1qn5
	/1G7mb3vzrdLRfyychZK0Y1yEOqVdTxwwpd4uDQOq6ua7p1eu1MBwGaqA5MpHVV5brhx9Qof57hhN
	QnzqvnlXm2LmnwJTtbL/gHIrW8K4fFokLqpQhJnzfIe0rqRr1s9Tul4Zs5Ip8joAbJPQynWl9g0pY
	+QP5swLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCGkH-00000009E4M-20iO;
	Thu, 01 Oct 2026 13:22:45 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCGkE-00000009E3D-2wV7
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 13:22:43 +0000
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 0062D20B7168; Thu,  1 Oct 2026 06:21:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0062D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790860909;
	bh=GISBfCNPceIZSjVaURcaK2XPuYCZTPOv4jPbHJzoivY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDmSABufyhX1yZ1RR4wJ2LCnh2cL6ZgHS7YPAIQcLYNot3Y2Ljzc7exn+pd6dLj4z
	 SNli2qg4G8RNSzyZzOLJH5eu7VNcEQA9uvjAaCZ3YooNxum55H6LkU7touRKSf0vt0
	 hrCP1Rd5135XHBp3B5sLwjNuRJAmWgaUW7gWkhAI=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <kees@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] kexec: Add helper to report an active kexec reboot
Date: Thu,  1 Oct 2026 06:21:44 -0700
Message-ID: <20261001132147.1703600-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_062242_774691_B08168EE 
X-CRM114-Status: GOOD (  12.97  )
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

A shutdown callback in a loadable module may need to distinguish a
kexec reboot from a normal restart, halt, or poweroff. The Hyper-V
VMBus driver needs this distinction when moving its kexec cleanup into
a common syscore shutdown callback.

Add kexec_is_in_progress() and export it to GPL modules so the callback
can remain guarded when VMBus is built as a module. Provide a false
inline implementation when CONFIG_KEXEC_CORE is disabled.

The helper reports only the normal kexec reboot path. Crash kexec and
preserve-context kexec do not set this state.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 include/linux/kexec.h | 2 ++
 kernel/kexec_core.c   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8a22bc9b8c6c..827a5311d97a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -468,6 +468,7 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
+bool kexec_is_in_progress(void);
 
 #ifndef page_to_boot_pfn
 static inline unsigned long page_to_boot_pfn(struct page *page)
@@ -544,6 +545,7 @@ static inline void *kimage_map_segment(struct kimage *image, int idx)
 { return NULL; }
 static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
+static inline bool kexec_is_in_progress(void) { return false; }
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_KEXEC_SIG
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..282c7b3c6c35 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -23,6 +23,7 @@
 #include <linux/hardirq.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
+#include <linux/export.h>
 #include <linux/utsname.h>
 #include <linux/numa.h>
 #include <linux/suspend.h>
@@ -54,6 +55,12 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
+bool kexec_is_in_progress(void)
+{
+	return kexec_in_progress;
+}
+EXPORT_SYMBOL_GPL(kexec_is_in_progress);
+
 bool kexec_file_dbg_print;
 
 /*
-- 
2.43.0

