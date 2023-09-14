Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173ECEDE990
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dFKZBNNHOsfTVnGuLruvAuETEr/qZ3/58ro/vUrZcWo=; b=VUX+Gz5Wzla21c
	CwgpwCH3MkN6PVz+lvPm6XTymvY3py0wLPbFMGJBr+swbeXQ0cdROF9p1FQzujzFZFYYf0Fa3Z5hv
	B4J7RPhGsMlzJn81YSi10tzsVcg9DC4tKbGZWLWoOnHZyg5UILHRjSYN4Up6uX6SYu4vyVhkw26dD
	HiZFFfaTs67ZIWBIZo9U1XNjFASFcDjEDKluT/rJVNyYCiYgJfQQjhbiMmnaZ+kDKp0DZCrvJR3XM
	xc9/T06z2RSYrOEnoLByj2QUA+tZogabnfoo94k/9XZvzCjXIWIXeRuIgImcD0ePBnLtkHKYliPRL
	sbJFcBCcCwcAXmPsPNkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgi3M-007kau-1F;
	Thu, 14 Sep 2023 08:50:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgi3J-007kYd-00
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 08:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694681419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIJjc9/9vy47y8DMJVskrhYSK3Pw6Hx6atIzEImHgqw=;
	b=b9PFjw0HvF5e68Z8tzbwEzywagZgsoF5QMtyeJpA+AkAzJTgrX4Ab+RuU1n/XXB9DIZdTX
	BBR9IaH1dpkWL0yFYiuB53ksBy1Wyt1MrVt5SGdUxsyVb9XREs+bLK5VXlknn9OCzgsRHF
	Lq45smJLh2JP9oeXotLS4CB1hEdar+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-nOBAevonMZmJgoY1OV3vsA-1; Thu, 14 Sep 2023 04:50:15 -0400
X-MC-Unique: nOBAevonMZmJgoY1OV3vsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1F5C805566;
	Thu, 14 Sep 2023 08:50:14 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.219])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB8AB21B2413;
	Thu, 14 Sep 2023 08:50:12 +0000 (UTC)
From: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Pingfan Liu <piliu@redhat.com>
Subject: [PATCH v1 1/2] zboot: enable arm64 kexec_load for zboot image
Date: Thu, 14 Sep 2023 16:49:59 +0800
Message-Id: <20230914085000.17982-2-dyoung@redhat.com>
In-Reply-To: <20230914085000.17982-1-dyoung@redhat.com>
References: <20230914085000.17982-1-dyoung@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_015021_127155_1FB86FC1 
X-CRM114-Status: GOOD (  19.42  )
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
 kexec/arch/arm64/kexec-vmlinuz-arm64.c | 26 +++++++++++++++++++++++---
 kexec/kexec-pe-zboot.c                 |  4 +++-
 kexec/kexec.c                          |  2 +-
 kexec/kexec.h                          |  1 +
 5 files changed, 30 insertions(+), 6 deletions(-)

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
index c0ee47c8f50a..e291a34c97ad 100644
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
@@ -98,8 +99,27 @@ bad_header:
 int pez_arm64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info)
 {
-	info->kernel_fd = kernel_fd;
-	return image_arm64_load(argc, argv, buf, len, info);
+	if (kernel_fd > 0 && decompressed_size > 0) {
+		char *kbuf;
+		off_t nread;
+		int fd;
+
+		info->kernel_fd = kernel_fd;
+		fd = dup(kernel_fd);
+		if (fd < 0) {
+			dbgprintf("%s: dup fd failed.\n", __func__);
+			return -1;
+		}
+		kbuf = slurp_fd(fd, NULL, decompressed_size, &nread);
+		if (!kbuf || nread != decompressed_size) {
+			dbgprintf("%s: slurp_fd failed.\n", __func__);
+			return -1;
+		}
+		return image_arm64_load(argc, argv, kbuf, decompressed_size, info);
+	}
+
+	dbgprintf("%s: wrong kernel file descriptor.\n", __func__);
+	return -1;
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
