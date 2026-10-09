Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E002CA6019
	for <kexec@archiver.kernel.org>; Fri,  9 Oct 2026 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/u+W/q014IW8dyqef7naigWPTxu03SqdYawuKAyTR1s=; b=aXtENW1WpqmJqg+kiU+gCaIsvE
	rJWSIWDvCeZzCLIQrQ7XMf+rh/La2OJEkqJPIWwvTODl6bu6kz/XicgEGqav+hQgHUhUA8qHYfKy0
	3JL9MhgjKkl6/pupoORzHuIl9xZfYcc9Bx7MGil5mrk8p/kR3Vpb8VmQh5yT4uBmbHcYrwWU34Lmm
	qxI6hp3KmXkj5FuwE6L1umYbll2q8RWWpctLLH6aBReSMa4WKUIhRdbGJejSN2hX+5n2KJXpvEyB6
	YAoixW1C7VVmz6Xfh8mpDajug0+1lBFUcmC2PTtR7Py/J/VmWhA24qBI4Ip9ow+S0vdoTKqFh/8kj
	OaXCgVjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF7kP-000000062Xq-305x;
	Fri, 09 Oct 2026 10:22:41 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF7kN-000000062XB-0dAI;
	Fri, 09 Oct 2026 10:22:40 +0000
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id CA3CE20B7168; Fri,  9 Oct 2026 03:22:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA3CE20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791541357;
	bh=/u+W/q014IW8dyqef7naigWPTxu03SqdYawuKAyTR1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZW30kdqyNSg9txUY4QT7DBVcH3KLfEi7h8/n/Bzrx+VxqpUTiFhvz5WNuQzEZ1RhK
	 K5/VETnOFunvBPUSTU4oUF16tspipb/qY1X9/IdDDpDLlBaWzwxgulu4LSidCFVUmy
	 PNdLvam8OuH3YHyfOnx7U459RQJYIvnoS3TGhp0g=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: mhklinux@outlook.com,
	wei.liu@kernel.org,
	catalin.marinas@arm.com,
	baoquan.he@linux.dev
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	will@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	arnd@arndb.de,
	hpa@zytor.com,
	maz@kernel.org,
	mark.rutland@arm.com,
	linux-hyperv@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	broonie@kernel.org,
	kees@kernel.org,
	brads@mainlining.org,
	namjain@linux.microsoft.com
Subject: [PATCH v4 1/2] kexec: Add helper to report an active kexec reboot
Date: Fri,  9 Oct 2026 03:22:32 -0700
Message-ID: <20261009102236.3361019-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261009_032239_224427_65B05600 
X-CRM114-Status: GOOD (  12.00  )
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
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

