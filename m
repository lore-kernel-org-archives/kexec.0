Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B3BC7EE23
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 02:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I8+dn51DzA40musXJysLluiz+88IPG/DdlsvLe2MEss=; b=NenHq8EJKI+J8S
	1/pIpCufKjT5SIiRokE6q2SKCrqp+bqYOrC+FS9jOdIMrawrK2Y/k7+pXeHC4eA+fHVTzlo6Iy4q0
	BuoGVp71MZ0y9vIxwk9Lbb1HBFNYuw4vBglGHh1WODWWkCMtXbfdhvv/rI9UY/+l/dA+bbsWjoB6c
	XRWDZ2i92cM5jIz+lygOEK4LDkcZ7SCYpKRAA3FXv2bRZnKqYSUrvzJUUlrrWkacl9eGq6hb19ZPW
	SmChC9nmEk4vNEdC+U5sLkBVQoVOAZUQ5gkg+eaSj/cgrTBfAx5ZX1fJ9SUPCTkZYmvolRWwpuAmp
	gWLlKx1rxyuTOVtyJETQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puld5-009aVR-1n;
	Fri, 05 May 2023 02:57:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pulcz-009aSf-2c
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 02:57:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683255421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWmME+Wf2htDvp7cZAVeIR2CG5P7NtS7ATscLpB9eNc=;
	b=UvZjK0eaiffOKELcwEXfoRYz213P/TOG5CqdGuWSENPAUXirQIohDu9mmizzkmMRaojVjM
	skV3V2tFd9RNYlhVJCrFhLCggSvsdSm43/haTL35RLKSy6M4nxFjJf/r81DjClrqjckhoh
	E/HjuSqlg22reCwyOeYkCjbigEFLtu8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-_za07jrrPxKNXFds625MCQ-1; Thu, 04 May 2023 22:55:04 -0400
X-MC-Unique: _za07jrrPxKNXFds625MCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57DA91C04B6D;
	Fri,  5 May 2023 02:55:04 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED4BA407D450;
	Fri,  5 May 2023 02:55:01 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCH 3/5] arm64: change the prototype of image probe function
Date: Fri,  5 May 2023 10:54:35 +0800
Message-Id: <20230505025438.11943-4-piliu@redhat.com>
In-Reply-To: <20230505025438.11943-1-piliu@redhat.com>
References: <20230505025438.11943-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_195701_949583_1AEE2567 
X-CRM114-Status: GOOD (  21.49  )
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

Changing the aarch64 probe's prototype  from
	typedef int (probe_t)(const char *kernel_buf, off_t kernel_size);
to
	typedef int (probe_t)(const char *kernel_buf, off_t kernel_size, struct kexec_info *info);

Later, info can be used to return both the file descriptor and parsed kernel
buffer. The fd is passed to sys_kexec_file_load, and the parsed kernel
buffer is used by image's load function.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com

---
 kexec/arch/arm/kexec-arm.h            |  4 ++--
 kexec/arch/arm/kexec-uImage-arm.c     |  2 +-
 kexec/arch/arm64/kexec-arm64.h        |  8 ++++----
 kexec/arch/arm64/kexec-elf-arm64.c    |  2 +-
 kexec/arch/arm64/kexec-image-arm64.c  |  2 +-
 kexec/arch/arm64/kexec-uImage-arm64.c |  2 +-
 kexec/arch/arm64/kexec-zImage-arm64.c |  2 +-
 kexec/kexec.c                         | 15 +++++++++++++--
 kexec/kexec.h                         |  6 ++++++
 9 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/kexec/arch/arm/kexec-arm.h b/kexec/arch/arm/kexec-arm.h
index a74cce2..18069f3 100644
--- a/kexec/arch/arm/kexec-arm.h
+++ b/kexec/arch/arm/kexec-arm.h
@@ -9,12 +9,12 @@
 
 extern off_t initrd_base, initrd_size;
 
-int zImage_arm_probe(const char *buf, off_t len);
+int zImage_arm_probe(const char *buf, off_t len, struct kexec_info *info);
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		        struct kexec_info *info);
 void zImage_arm_usage(void);
 
-int uImage_arm_probe(const char *buf, off_t len);
+int uImage_arm_probe(const char *buf, off_t len, struct kexec_info *info);
 int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		        struct kexec_info *info);
 extern int have_sysfs_fdt(void);
diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
index 03c2f4d..d955eb3 100644
--- a/kexec/arch/arm/kexec-uImage-arm.c
+++ b/kexec/arch/arm/kexec-uImage-arm.c
@@ -9,7 +9,7 @@
 #include "../../kexec.h"
 #include "kexec-arm.h"
 
-int uImage_arm_probe(const char *buf, off_t len)
+int uImage_arm_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	return uImage_probe_kernel(buf, len, IH_ARCH_ARM);
 }
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 5eb9fc0..88bb508 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -29,22 +29,22 @@
 #define NOT_KV_ADDR	(0x0)
 #define NOT_PADDR	(ULONGLONG_MAX)
 
-int elf_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int elf_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info);
 int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void elf_arm64_usage(void);
 
-int image_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int image_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info);
 int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void image_arm64_usage(void);
 
-int uImage_arm64_probe(const char *buf, off_t len);
+int uImage_arm64_probe(const char *buf, off_t len, struct kexec_info *info);
 int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
 		      struct kexec_info *info);
 void uImage_arm64_usage(void);
 
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info);
 int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void zImage_arm64_usage(void);
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index e14f8e9..9238dd5 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -16,7 +16,7 @@
 #include "kexec-elf.h"
 #include "kexec-syscall.h"
 
-int elf_arm64_probe(const char *kernel_buf, off_t kernel_size)
+int elf_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index aa8f2e2..84aca72 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -14,7 +14,7 @@
 #include "kexec-syscall.h"
 #include "arch/options.h"
 
-int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
+int image_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info)
 {
 	const struct arm64_image_header *h;
 
diff --git a/kexec/arch/arm64/kexec-uImage-arm64.c b/kexec/arch/arm64/kexec-uImage-arm64.c
index c466913..f5b94c8 100644
--- a/kexec/arch/arm64/kexec-uImage-arm64.c
+++ b/kexec/arch/arm64/kexec-uImage-arm64.c
@@ -9,7 +9,7 @@
 #include "../../kexec.h"
 #include "kexec-arm64.h"
 
-int uImage_arm64_probe(const char *buf, off_t len)
+int uImage_arm64_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	int ret;
 
diff --git a/kexec/arch/arm64/kexec-zImage-arm64.c b/kexec/arch/arm64/kexec-zImage-arm64.c
index 166d7ef..7877741 100644
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ b/kexec/arch/arm64/kexec-zImage-arm64.c
@@ -40,7 +40,7 @@
  * fd : File descriptor of the temp file containing the decompressed
  *      Image.
  */
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
+int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size, struct kexec_info *info)
 {
 	int ret = -1;
 	int fd = 0;
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 614cd1d..116fb4a 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -742,14 +742,25 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 			return -1;
 		} else {
 			/* make sure our file is really of that type */
+#ifndef __aarch64__
 			if (file_type[i].probe(kernel_buf, kernel_size) < 0)
 				guess_only = 1;
+#else
+			if (file_type[i].probe(kernel_buf, kernel_size, &info) < 0)
+				guess_only = 1;
+
+#endif
 		}
 	}
 	if (!type || guess_only) {
 		for (i = 0; i < file_types; i++) {
+#ifndef __aarch64__
 			if (file_type[i].probe(kernel_buf, kernel_size) == 0)
 				break;
+#else
+			if (file_type[i].probe(kernel_buf, kernel_size, &info) == 0)
+				break;
+#endif
 		}
 		if (i == file_types) {
 			fprintf(stderr, "Cannot determine the file type "
@@ -1304,12 +1315,12 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 #ifdef __aarch64__
 		/* handle Image.gz like cases */
 		if (is_zlib_file(kernel, &kernel_size)) {
-			if ((ret = file_type[i].probe(kernel, kernel_size)) >= 0) {
+			if ((ret = file_type[i].probe(kernel, kernel_size, &info)) >= 0) {
 				kernel_fd = ret;
 				break;
 			}
 		} else
-			if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
+			if (file_type[i].probe(kernel_buf, kernel_size, &info) >= 0)
 				break;
 #else
 		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0d820ad..6e8430e 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -191,7 +191,13 @@ unsigned long locate_hole(struct kexec_info *info,
 	unsigned long hole_min, unsigned long hole_max,
 	int hole_end);
 
+#ifndef __aarch64__
 typedef int (probe_t)(const char *kernel_buf, off_t kernel_size);
+#else
+typedef int (probe_t)(const char *kern_fname, off_t kernel_size,
+	struct kexec_info *info);
+#endif
+
 typedef int (load_t )(int argc, char **argv,
 	const char *kernel_buf, off_t kernel_size, 
 	struct kexec_info *info);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
