Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2E4E77180
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 21:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rQKNSR/8zPuJViq4eKVnttXHkZlyJBF73LrTpttFHi0=; b=s8P1TecK/RDEis/qtxNiZopnCo
	FJ0BSm8J1d6K4WynR7fJBTIHGFzhM741SjpphW5QSkuws582zPg/CiPrEdWx9j1h+ccQHwbo9cKsF
	aDLDJG/Wl552/XaU54Uxjq0u2+cSKXuNfWklVOT4vlleKEbfnHMkbpaQszE7yJJoOqhTsjXnwFdQY
	L0h1uFudBjf+P/ylu8Jec48NwAIzonK7jPl9NrhZc8TIDiJP4ISz+K46mZU9UTKNcAXA/vKEI6ATV
	CJ/00uG3n0pD/an9re8MTlXynmF3nK0GAp0sOwjaivjhSCfqmBhQXPotKDV/j363u+xk3Vnf6taTu
	S1OkS/+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLqWE-00000001vLX-0UcS;
	Thu, 12 Dec 2024 21:14:46 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLqVK-00000001vEL-2eH2
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 21:13:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B5501A32;
	Thu, 12 Dec 2024 13:14:18 -0800 (PST)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82353F58B;
	Thu, 12 Dec 2024 13:13:49 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: piliu@redhat.com,
	horms@kernel.org,
	arb@kernel.org,
	dyoung@redhat.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [Patch v2 2/2] kexec: Enable zstd in kexec decompression paths
Date: Thu, 12 Dec 2024 15:13:25 -0600
Message-ID: <20241212211325.805138-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241212211325.805138-1-jeremy.linton@arm.com>
References: <20241212211325.805138-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_131350_724442_D9692B91 
X-CRM114-Status: UNSURE (   8.60  )
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

The kexec decompression routines support detecting zlib or lzma
compressed images. Lets add the ability to automatically decompress
zstd ones as well. The zstd attempt is made after gzip because its
fairly inexpensive relative lzma, and gzip remains a popular option.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Pingfan Liu <piliu@redhat.com>
---
 kexec/kexec-pe-zboot.c |  3 ++-
 kexec/kexec.c          | 10 +++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kexec/kexec-pe-zboot.c b/kexec/kexec-pe-zboot.c
index 3abd17d..0a82097 100644
--- a/kexec/kexec-pe-zboot.c
+++ b/kexec/kexec-pe-zboot.c
@@ -59,8 +59,9 @@ int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
 	 * algorithms than are supported here, error out if we detect that.
 	 */
 	if (memcmp(&z->compress_type, "gzip", 4) &&
+	    memcmp(&z->compress_type, "zstd", 4) &&
 	    memcmp(&z->compress_type, "lzma", 4)) {
-		dbgprintf("%s: kexec can only decompress gziped and lzma images.\n", __func__);
+		dbgprintf("%s: kexec can only decompress gziped, lzma and zstd images\n", __func__);
 		return -1;
 	}
 
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 4f51987..70097ae 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -55,6 +55,7 @@
 #include "kexec-sha256.h"
 #include "kexec-zlib.h"
 #include "kexec-lzma.h"
+#include "kexec-zstd.h"
 #include <arch/options.h>
 
 #define KEXEC_LOADED_PATH "/sys/kernel/kexec_loaded"
@@ -639,9 +640,12 @@ char *slurp_decompress_file(const char *filename, off_t *r_size)
 
 	kernel_buf = zlib_decompress_file(filename, r_size);
 	if (!kernel_buf) {
-		kernel_buf = lzma_decompress_file(filename, r_size);
-		if (!kernel_buf)
-			return slurp_file(filename, r_size);
+	        kernel_buf = zstd_decompress_file(filename, r_size);	        
+		if (!kernel_buf) {
+                        kernel_buf = lzma_decompress_file(filename, r_size);
+			if (!kernel_buf)
+				return slurp_file(filename, r_size);
+		}
 	}
 	return kernel_buf;
 }
-- 
2.47.0


