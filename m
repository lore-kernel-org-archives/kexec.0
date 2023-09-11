Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00B4EE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 10:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/dzcU7KqpFsO2ZjQSlwH/qQgdjME7tPfIiFamhLztN0=; b=neCdMhBpqjbyYB
	zxINl4vRt3rrTtFM2V+ymT4tup2btBqusY/lL32gp3GmLbPoaw1XDFGf1Ex3qhSCRHXJO5x3BaJHN
	0AWot/ICuWDWLTgg/yxyO82hFD+TQSjtmJZlqRGkdWpBN3gZCDhMhddxZmpYoh3eKOY057kq/80oN
	piAIIPP/Zq/2XygYidMEFA4sRO8rf6hCpa5anqWdZi6nuZR+jLoRypTehK02rmpqMuKa+pAwsX49e
	oTpkbmtTwhR20uQEOjFmbqE2C6dwOKnfcoIH6wJY8R6if0qmSnzSA8BaBlo6jY9AmvEVW+kjcZ9+8
	glPXGMIC0qUojfTCDZdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfeIW-000HD8-0m;
	Mon, 11 Sep 2023 10:37:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfeIT-000H9T-0Q
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 10:37:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694428654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x+GIKG0+QWhazz4vzf/BgCwK4+E3GrXL0V04spD/dAg=;
	b=f4GMXMXTBLG1FeQBTkV6gmwwSH45KJ7hGaHl1VFrSqWeN7ZE5LB4gKAW9/dhcwqfCs7zKW
	PmpoRq5iFI1JgrLxH1dsSOugIYIihWvz9mSbA3NQfEDDVPbaQbfnlfuZjZqXpVHIyvHdn7
	HU9UtwM/rS7O3jmtZUz0o6zvr8IWgKA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-L2A1rv3qP7OIRvb8h5gD3A-1; Mon, 11 Sep 2023 06:37:33 -0400
X-MC-Unique: L2A1rv3qP7OIRvb8h5gD3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55857916EE2;
	Mon, 11 Sep 2023 10:37:33 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.254])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3CDFC44029;
	Mon, 11 Sep 2023 10:37:30 +0000 (UTC)
From: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>,
	Pingfan Liu <piliu@redhat.com>
Subject: [PATCH 1/2] zboot: enable arm64 kexec_load for zboot image
Date: Tue, 12 Sep 2023 02:37:21 +0800
Message-Id: <20230911183722.11173-1-dyoung@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_033737_254729_3861D386 
X-CRM114-Status: GOOD (  18.47  )
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

kexec_file_load support of zboot kernel image decompressed the vmlinuz,
so in kexec_load code just load the kernel with reading the decompressed
kernel fd into a new buffer and use it directly.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 include/kexec-pe-zboot.h               |  3 ++-
 kexec/arch/arm64/kexec-vmlinuz-arm64.c | 20 ++++++++++++++++++--
 kexec/kexec-pe-zboot.c                 |  4 +++-
 kexec/kexec.c                          |  2 +-
 kexec/kexec.h                          |  1 +
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/kexec-pe-zboot.h b/include/kexec-pe-zboot.h
index e2e0448a81f2..374916cbe883 100644
--- a/include/kexec-pe-zboot.h
+++ b/include/kexec-pe-zboot.h
@@ -11,5 +11,6 @@ struct linux_pe_zboot_header {
 	uint32_t compress_type;
 };
 
-int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd);
+int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
+		off_t *kernel_size);
 #endif
diff --git a/kexec/arch/arm64/kexec-vmlinuz-arm64.c b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
index c0ee47c8f50a..8f378d8fa6d0 100644
--- a/kexec/arch/arm64/kexec-vmlinuz-arm64.c
+++ b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
@@ -34,6 +34,7 @@
 #include "arch/options.h"
 
 static int kernel_fd = -1;
+static off_t decompressed_size;
 
 /* Returns:
  * -1 : in case of error/invalid format (not a valid PE+compressed ZBOOT format.
@@ -72,7 +73,7 @@ int pez_arm64_probe(const char *kernel_buf, off_t kernel_size)
 		return -1;
 	}
 
-	ret = pez_prepare(buf, buf_sz, &kernel_fd);
+	ret = pez_prepare(buf, buf_sz, &kernel_fd, &decompressed_size);
 
 	if (!ret) {
 	    /* validate the arm64 specific header */
@@ -98,8 +99,23 @@ bad_header:
 int pez_arm64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info)
 {
+	char *kbuf;
+
 	info->kernel_fd = kernel_fd;
-	return image_arm64_load(argc, argv, buf, len, info);
+	if (kernel_fd > 0 && decompressed_size > 0) {
+		off_t nread;
+
+		kbuf = slurp_fd(kernel_fd, NULL, decompressed_size, &nread);
+		if (!kbuf || nread != decompressed_size) {
+			dbgprintf("%s: failed.\n", __func__);
+			return -1;
+		}
+	} else {
+		dbgprintf("%s: wrong file descriptor.\n", __func__);
+		return -1;
+	}
+
+	return image_arm64_load(argc, argv, kbuf, decompressed_size, info);
 }
 
 void pez_arm64_usage(void)
diff --git a/kexec/kexec-pe-zboot.c b/kexec/kexec-pe-zboot.c
index 2f2e052b76c5..3abd17d9fe59 100644
--- a/kexec/kexec-pe-zboot.c
+++ b/kexec/kexec-pe-zboot.c
@@ -37,7 +37,8 @@
  *
  * crude_buf: the content, which is read from the kernel file without any processing
  */
-int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd)
+int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
+		off_t *kernel_size)
 {
 	int ret = -1;
 	int fd = 0;
@@ -110,6 +111,7 @@ int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd)
 		goto fail_bad_header;
 	}
 
+	*kernel_size = decompressed_size;
 	dbgprintf("%s: done\n", __func__);
 
 	ret = 0;
diff --git a/kexec/kexec.c b/kexec/kexec.c
index c3b182e254e0..1edbd349c86d 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -489,7 +489,7 @@ static int add_backup_segments(struct kexec_info *info,
 	return 0;
 }
 
-static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
+char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
 {
 	char *buf;
 	off_t progress;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index ed3b499a80f2..093338969c57 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -267,6 +267,7 @@ extern void die(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 extern void *xmalloc(size_t size);
 extern void *xrealloc(void *ptr, size_t size);
+extern char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread);
 extern char *slurp_file(const char *filename, off_t *r_size);
 extern char *slurp_file_mmap(const char *filename, off_t *r_size);
 extern char *slurp_file_len(const char *filename, off_t size, off_t *nread);
-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
