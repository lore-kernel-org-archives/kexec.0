Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743ADC77B75
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BETDYAsqO5oxCDv8UNFqKGiN/DYf2XwZXglIXiR8Vfk=; b=YEzW0vi2Dwo8B8
	vnAI+mlIeTFDXW7p8Fywz8dxv+/j2aig5EdZkZQEFFB3+h2zq7rf+PhkTHbSEjx6uzVTXgseGjAOl
	bNDaR0saDKw+X1VkfDvVvpm/IJguumBGVBpisJ+67Fs39WGvoqjixZKy/ETTDMCVZvFarJcpfXeyb
	cpjDTxRu2wuBjz2tyJ71XqOkdxr5r7ka1QWUFtmeDzJB+X2/4wYAXmErOUT3TgPxt/LhNFI/yFUI4
	Z+XSRgU/JHVirOxikWozd7Kywpl9AMEUln8P0BYRt6YXEL1l85SQ3tCuCZJMpFLM+fS4wUwnLehqi
	ikZaYOuFhPrM/sh1j2Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyp9u-004epR-34;
	Tue, 16 May 2023 07:31:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyp9q-004enU-1c
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 07:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684222301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Of9m/DRupg003q5BYdtYLyKsQykNxMh7+DJkFvGncbY=;
	b=WYfOFQXa0f31YVloTzLXDu5YACNzsnQGyPa/zDYYXtw4Uq9i43aK9Xe2xqesP3KkxlWBN0
	Hc0jBP0pXfgHntTcSatCd5qnNZDJ2s8gVlVCIQBaXV/LNL75ChCs1CdcjbD7fJStXHJ3RB
	hc7o9DM0YRalSLYU3zBmKU2W+r48TT0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-HeZD-fWTNYK1JqmK1pTS4A-1; Tue, 16 May 2023 03:31:38 -0400
X-MC-Unique: HeZD-fWTNYK1JqmK1pTS4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 981DE863E83;
	Tue, 16 May 2023 07:31:37 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 080651121314;
	Tue, 16 May 2023 07:31:33 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv2 1/6] kexec: Change the image probe's prototype
Date: Tue, 16 May 2023 15:31:19 +0800
Message-Id: <20230516073124.23531-2-piliu@redhat.com>
In-Reply-To: <20230516073124.23531-1-piliu@redhat.com>
References: <20230516073124.23531-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_003142_682523_FDE6FA82 
X-CRM114-Status: GOOD (  25.41  )
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

As more complicated kernel format occurs such as zboot, where the
compressed kernel is stored as a payload. The straight forward
decompression can not meet the demand.

A new image probe method is expected to read in the kernel file and decide
how to unfold the content by itself.

This patch aims to change the image probe's prototype from
            typedef int (probe_t)(const char *kernel_buf, off_t kernel_size);
to
            typedef int (probe_t)(const char *kernel_buf, off_t kernel_size, struct kexec_info *info);

Later, info can be used to return both the file descriptor and the
parsed kernel buffer.

In case your are curious, the remaing part of the log describes the
process of the substitution of the new prototype, which can be divided
into three groups.

1. change function pointer and its callsites:
  sed -i 's/(probe_t)(const char \*kernel_buf, off_t kernel_size);/(probe_t)(const char \*kernel, off_t kernel_size, struct kexec_info \*info);/g' kexec/kexec.h
  sed -i 's/\.probe(\([^,]*\), \([^)]*\))/\.probe(\1, \2, NULL)/g' kexec/kexec.c

2. change the function declaration and definition of each 'probe'
   instance by coccinelle because they may cross lines

The cocci file looks like:

@ rule1 @
identifier fn =~ "_probe";
identifier buf, size;
typedef off_t;
@@

-int fn(const char *buf, off_t size)
+int fn(const char *buf, off_t size, struct kexec_info *info)
{
        ...
}

@ rule2 @
identifier fn =~ "_probe";
identifier buf, size;
typedef off_t;
@@

+int fn(const char *buf, off_t size, struct kexec_info *info);
-int fn(const char *buf, off_t size);

Then running the command
spatch --sp-file cocci/define.cocci --dir kexec --include-headers > ../define.patch
git apply --directory=kexec ../define.patch

3. change the direct calls to the probe instances

Originally I planned to achieve this by coccinelle, but failed similar
to [1]. I have tried using "-I and --include" option for coccinelle, but it
still did not work.

Checking the direct callsite by "git grep "_probe(" | grep -v const"
Fortunatelly, it turns out that only a few direct callsites exist, which
lies in i386, and easy to be amended manually.

Anyway, just FYI, the cocci file looks like:
@ rule1 @
identifier fn =~ "_probe";
identifier buf, size;
identifier info;
typedef off_t;
@@

int fn(const char *buf, off_t size, struct kexec_info *info);

/* change the direct callsite of any probe */
@ rule2 @
identifier rule1.fn;
expression E1, E2;
@@

 fn(E1, E2
+  ,NULL
   )

Then running the command:
spatch --sp-file cocci/direct.cocci --dir kexec --include-headers

[1]: https://lore.kernel.org/all/alpine.DEB.2.22.394.2202280705080.3112@hadrien/T/

Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/arch/arm/kexec-arm.h                 |  6 ++++--
 kexec/arch/arm/kexec-uImage-arm.c          |  2 +-
 kexec/arch/arm64/kexec-arm64.h             | 15 +++++++++++----
 kexec/arch/arm64/kexec-elf-arm64.c         |  3 ++-
 kexec/arch/arm64/kexec-image-arm64.c       |  3 ++-
 kexec/arch/arm64/kexec-uImage-arm64.c      |  2 +-
 kexec/arch/arm64/kexec-zImage-arm64.c      |  3 ++-
 kexec/arch/cris/kexec-cris.h               |  3 ++-
 kexec/arch/cris/kexec-elf-cris.c           |  2 +-
 kexec/arch/hppa/kexec-elf-hppa.c           |  2 +-
 kexec/arch/hppa/kexec-hppa.h               |  3 ++-
 kexec/arch/i386/kexec-beoboot-x86.c        |  4 ++--
 kexec/arch/i386/kexec-bzImage.c            |  2 +-
 kexec/arch/i386/kexec-elf-x86.c            |  2 +-
 kexec/arch/i386/kexec-mb2-x86.c            |  5 +++--
 kexec/arch/i386/kexec-multiboot-x86.c      |  7 ++++---
 kexec/arch/i386/kexec-nbi.c                |  2 +-
 kexec/arch/i386/kexec-x86.h                | 19 +++++++++++++------
 kexec/arch/ia64/kexec-elf-ia64.c           |  2 +-
 kexec/arch/ia64/kexec-ia64.h               |  3 ++-
 kexec/arch/loongarch/kexec-elf-loongarch.c |  3 ++-
 kexec/arch/loongarch/kexec-loongarch.h     |  7 +++++--
 kexec/arch/loongarch/kexec-pei-loongarch.c |  3 ++-
 kexec/arch/m68k/kexec-elf-m68k.c           |  2 +-
 kexec/arch/m68k/kexec-m68k.h               |  3 ++-
 kexec/arch/mips/kexec-elf-mips.c           |  2 +-
 kexec/arch/mips/kexec-mips.h               |  3 ++-
 kexec/arch/ppc/kexec-dol-ppc.c             |  2 +-
 kexec/arch/ppc/kexec-elf-ppc.c             |  2 +-
 kexec/arch/ppc/kexec-ppc.h                 |  9 ++++++---
 kexec/arch/ppc/kexec-uImage-ppc.c          |  2 +-
 kexec/arch/ppc64/kexec-elf-ppc64.c         |  2 +-
 kexec/arch/ppc64/kexec-ppc64.h             |  3 ++-
 kexec/arch/sh/kexec-elf-sh.c               |  2 +-
 kexec/arch/sh/kexec-sh.h                   | 12 ++++++++----
 kexec/arch/sh/kexec-uImage-sh.c            |  2 +-
 kexec/arch/x86_64/kexec-bzImage64.c        |  2 +-
 kexec/arch/x86_64/kexec-elf-x86_64.c       |  2 +-
 kexec/arch/x86_64/kexec-x86_64.h           | 10 +++++++---
 kexec/kexec.c                              | 10 +++++-----
 kexec/kexec.h                              |  2 +-
 41 files changed, 109 insertions(+), 66 deletions(-)

diff --git a/kexec/arch/arm/kexec-arm.h b/kexec/arch/arm/kexec-arm.h
index a74cce2..4d447b2 100644
--- a/kexec/arch/arm/kexec-arm.h
+++ b/kexec/arch/arm/kexec-arm.h
@@ -9,12 +9,14 @@
 
 extern off_t initrd_base, initrd_size;
 
-int zImage_arm_probe(const char *buf, off_t len);
+int zImage_arm_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		        struct kexec_info *info);
 void zImage_arm_usage(void);
 
-int uImage_arm_probe(const char *buf, off_t len);
+int uImage_arm_probe(const char *buf, off_t len, struct kexec_info *info);
+
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
index 5eb9fc0..2825c46 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -29,22 +29,29 @@
 #define NOT_KV_ADDR	(0x0)
 #define NOT_PADDR	(ULONGLONG_MAX)
 
-int elf_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int elf_arm64_probe(const char *kernel_buf, off_t kernel_size,
+		    struct kexec_info *info);
+
 int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void elf_arm64_usage(void);
 
-int image_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int image_arm64_probe(const char *kernel_buf, off_t kernel_size,
+		      struct kexec_info *info);
+
 int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void image_arm64_usage(void);
 
-int uImage_arm64_probe(const char *buf, off_t len);
+int uImage_arm64_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
 		      struct kexec_info *info);
 void uImage_arm64_usage(void);
 
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
+		       struct kexec_info *info);
+
 int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void zImage_arm64_usage(void);
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index e14f8e9..0299349 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -16,7 +16,8 @@
 #include "kexec-elf.h"
 #include "kexec-syscall.h"
 
-int elf_arm64_probe(const char *kernel_buf, off_t kernel_size)
+int elf_arm64_probe(const char *kernel_buf, off_t kernel_size,
+		    struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index aa8f2e2..e8b72f9 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -14,7 +14,8 @@
 #include "kexec-syscall.h"
 #include "arch/options.h"
 
-int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
+int image_arm64_probe(const char *kernel_buf, off_t kernel_size,
+		      struct kexec_info *info)
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
index 6ee82ff..c04669f 100644
--- a/kexec/arch/arm64/kexec-zImage-arm64.c
+++ b/kexec/arch/arm64/kexec-zImage-arm64.c
@@ -40,7 +40,8 @@
  * fd : File descriptor of the temp file containing the decompressed
  *      Image.
  */
-int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size)
+int zImage_arm64_probe(const char *kernel_buf, off_t kernel_size,
+		       struct kexec_info *info)
 {
 	int ret = -1;
 	int fd = 0;
diff --git a/kexec/arch/cris/kexec-cris.h b/kexec/arch/cris/kexec-cris.h
index 7ee9945..40b7b83 100644
--- a/kexec/arch/cris/kexec-cris.h
+++ b/kexec/arch/cris/kexec-cris.h
@@ -1,7 +1,8 @@
 #ifndef KEXEC_CRIS_H
 #define KEXEC_CRIS_H
 
-int elf_cris_probe(const char *buf, off_t len);
+int elf_cris_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int elf_cris_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_cris_usage(void);
diff --git a/kexec/arch/cris/kexec-elf-cris.c b/kexec/arch/cris/kexec-elf-cris.c
index 7e251e6..124f059 100644
--- a/kexec/arch/cris/kexec-elf-cris.c
+++ b/kexec/arch/cris/kexec-elf-cris.c
@@ -40,7 +40,7 @@
 #include <arch/options.h>
 #include "kexec-cris.h"
 
-int elf_cris_probe(const char *buf, off_t len)
+int elf_cris_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/hppa/kexec-elf-hppa.c b/kexec/arch/hppa/kexec-elf-hppa.c
index 474a919..92c4b12 100644
--- a/kexec/arch/hppa/kexec-elf-hppa.c
+++ b/kexec/arch/hppa/kexec-elf-hppa.c
@@ -30,7 +30,7 @@
 
 extern unsigned long phys_offset;
 
-int elf_hppa_probe(const char *buf, off_t len)
+int elf_hppa_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/hppa/kexec-hppa.h b/kexec/arch/hppa/kexec-hppa.h
index 485e5b6..9e37516 100644
--- a/kexec/arch/hppa/kexec-hppa.h
+++ b/kexec/arch/hppa/kexec-hppa.h
@@ -1,7 +1,8 @@
 #ifndef KEXEC_HPPA_H
 #define KEXEC_HPPA_H
 
-int elf_hppa_probe(const char *buf, off_t len);
+int elf_hppa_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int elf_hppa_load(int argc, char **argv, const char *buf, off_t len,
 		  struct kexec_info *info);
 void elf_hppa_usage(void);
diff --git a/kexec/arch/i386/kexec-beoboot-x86.c b/kexec/arch/i386/kexec-beoboot-x86.c
index d949ab8..e72d64f 100644
--- a/kexec/arch/i386/kexec-beoboot-x86.c
+++ b/kexec/arch/i386/kexec-beoboot-x86.c
@@ -38,7 +38,7 @@
 #include "kexec-x86.h"
 #include <arch/options.h>
 
-int beoboot_probe(const char *buf, off_t len)
+int beoboot_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	struct beoboot_header bb_header;
 	const char *cmdline, *kernel;
@@ -57,7 +57,7 @@ int beoboot_probe(const char *buf, off_t len)
 	 */
 	cmdline = buf + sizeof(bb_header);
 	kernel  = cmdline + bb_header.cmdline_size;
-	result = bzImage_probe(kernel, bb_header.kernel_size);
+	result = bzImage_probe(kernel, bb_header.kernel_size, NULL);
 	
 	return result;
 }
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 1b8f20c..0415df2 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -42,7 +42,7 @@
 static const int probe_debug = 0;
 int bzImage_support_efi_boot = 0;
 
-int bzImage_probe(const char *buf, off_t len)
+int bzImage_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	const struct x86_linux_header *header;
 	if ((uintmax_t)len < (uintmax_t)(2 * 512)) {
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index 8eba242..87ac41d 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -96,7 +96,7 @@ int elf_x86_any_probe(const char *buf, off_t len, enum coretype arch)
 	return result;
 }
 
-int elf_x86_probe(const char *buf, off_t len) {
+int elf_x86_probe(const char *buf, off_t len, struct kexec_info *info) {
 	return elf_x86_any_probe(buf, len, CORE_TYPE_ELF32);
 }
 
diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
index 0d2e93b..0d2b734 100644
--- a/kexec/arch/i386/kexec-mb2-x86.c
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -72,7 +72,8 @@ struct multiboot2_header_info {
 #define ALIGN_UP(addr, align) \
 	((addr + (typeof (addr)) align - 1) & ~((typeof (addr)) align - 1))
 
-int multiboot2_x86_probe(const char *buf, off_t buf_len)
+int multiboot2_x86_probe(const char *buf, off_t buf_len,
+			 struct kexec_info *info)
 /* Is it a good idea to try booting this file? */
 {
 	int i, len;
@@ -438,7 +439,7 @@ int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
 	uint64_t rel_min, rel_max;
 
 	/* Probe for the MB header if it's not already found */
-	if (mbh == NULL && multiboot_x86_probe(buf, len) != 1)
+	if (mbh == NULL && multiboot_x86_probe(buf, len, NULL) != 1)
 	{
 		fprintf(stderr, "Cannot find a loadable multiboot2 header.\n");
 		return -1;
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 33c885a..e4ec1c9 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -69,7 +69,8 @@ static off_t mbh_offset = 0;
 #define MIN(_x,_y) (((_x)<=(_y))?(_x):(_y))
 
 
-int multiboot_x86_probe(const char *buf, off_t buf_len)
+int multiboot_x86_probe(const char *buf, off_t buf_len,
+			struct kexec_info *info)
 /* Is it a good idea to try booting this file? */
 {
 	int i, len;
@@ -119,7 +120,7 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
 				return -1;
 			}
 		} else {
-			if ((i=elf_x86_probe(buf, buf_len)) < 0)
+			if ((i=elf_x86_probe(buf, buf_len, NULL)) < 0)
 				return i;
 		}
 		if (mbh->flags & MULTIBOOT_UNSUPPORTED) {
@@ -252,7 +253,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "";
 	
 	/* Probe for the MB header if it's not already found */
-	if (mbh == NULL && multiboot_x86_probe(buf, len) != 1) {
+	if (mbh == NULL && multiboot_x86_probe(buf, len, NULL) != 1) {
 		fprintf(stderr, "Cannot find a loadable multiboot header.\n");
 		return -1;
 	}
diff --git a/kexec/arch/i386/kexec-nbi.c b/kexec/arch/i386/kexec-nbi.c
index 8eb2154..16f5d6b 100644
--- a/kexec/arch/i386/kexec-nbi.c
+++ b/kexec/arch/i386/kexec-nbi.c
@@ -68,7 +68,7 @@ struct imgheader
 
 static const int probe_debug = 0;
 
-int nbi_probe(const char *buf, off_t len)
+int nbi_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	struct imgheader hdr;
 	struct segheader seg;
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 46e2898..01e5a41 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -55,7 +55,8 @@ struct arch_options_t {
 	uint8_t		reuse_video_type;
 };
 
-int multiboot_x86_probe(const char *buf, off_t len);
+int multiboot_x86_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void multiboot_x86_usage(void);
@@ -63,15 +64,19 @@ void multiboot_x86_usage(void);
 int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info);
 void multiboot2_x86_usage(void);
-int multiboot2_x86_probe(const char *buf, off_t buf_len);
+int multiboot2_x86_probe(const char *buf, off_t buf_len,
+			 struct kexec_info *info);
+
+
+int elf_x86_probe(const char *buf, off_t len, struct kexec_info *info);
 
-int elf_x86_probe(const char *buf, off_t len);
 int elf_x86_any_probe(const char *buf, off_t len, enum coretype arch);
 int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_x86_usage(void);
 
-int bzImage_probe(const char *buf, off_t len);
+int bzImage_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int bzImage_load(int argc, char **argv, const char *buf, off_t len, 
 	struct kexec_info *info);
 void bzImage_usage(void);
@@ -82,12 +87,14 @@ int do_bzImage_load(struct kexec_info *info,
 	const char *dtb, off_t dtb_len,
 	int real_mode_entry);
 
-int beoboot_probe(const char *buf, off_t len);
+int beoboot_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int beoboot_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void beoboot_usage(void);
 
-int nbi_probe(const char *buf, off_t len);
+int nbi_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int nbi_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void nbi_usage(void);
diff --git a/kexec/arch/ia64/kexec-elf-ia64.c b/kexec/arch/ia64/kexec-elf-ia64.c
index 142dee3..f01ea46 100644
--- a/kexec/arch/ia64/kexec-elf-ia64.c
+++ b/kexec/arch/ia64/kexec-elf-ia64.c
@@ -53,7 +53,7 @@ extern unsigned long saved_efi_memmap_size;
  *
  * Make sure that the file image has a reasonable chance of working.
  */
-int elf_ia64_probe(const char *buf, off_t len)
+int elf_ia64_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/ia64/kexec-ia64.h b/kexec/arch/ia64/kexec-ia64.h
index 31e4041..a481215 100644
--- a/kexec/arch/ia64/kexec-ia64.h
+++ b/kexec/arch/ia64/kexec-ia64.h
@@ -2,7 +2,8 @@
 #define KEXEC_IA64_H
 
 extern int max_memory_ranges;
-int elf_ia64_probe(const char *buf, off_t len);
+int elf_ia64_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_ia64_usage(void);
diff --git a/kexec/arch/loongarch/kexec-elf-loongarch.c b/kexec/arch/loongarch/kexec-elf-loongarch.c
index 45387ca..8484b04 100644
--- a/kexec/arch/loongarch/kexec-elf-loongarch.c
+++ b/kexec/arch/loongarch/kexec-elf-loongarch.c
@@ -23,7 +23,8 @@
 
 off_t initrd_base, initrd_size;
 
-int elf_loongarch_probe(const char *kernel_buf, off_t kernel_size)
+int elf_loongarch_probe(const char *kernel_buf, off_t kernel_size,
+			struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/loongarch/kexec-loongarch.h b/kexec/arch/loongarch/kexec-loongarch.h
index 5120a26..d6b077d 100644
--- a/kexec/arch/loongarch/kexec-loongarch.h
+++ b/kexec/arch/loongarch/kexec-loongarch.h
@@ -18,12 +18,15 @@
 #define KiB(x) ((x) * 1024UL)
 #define MiB(x) (KiB(x) * 1024UL)
 
-int elf_loongarch_probe(const char *kernel_buf, off_t kernel_size);
+int elf_loongarch_probe(const char *kernel_buf, off_t kernel_size,
+			struct kexec_info *info);
+
 int elf_loongarch_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_loongarch_usage(void);
 
-int pei_loongarch_probe(const char *buf, off_t len);
+int pei_loongarch_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int pei_loongarch_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void pei_loongarch_usage(void);
diff --git a/kexec/arch/loongarch/kexec-pei-loongarch.c b/kexec/arch/loongarch/kexec-pei-loongarch.c
index 1a11103..326ce4a 100644
--- a/kexec/arch/loongarch/kexec-pei-loongarch.c
+++ b/kexec/arch/loongarch/kexec-pei-loongarch.c
@@ -24,7 +24,8 @@
 #include "kexec-loongarch.h"
 #include "arch/options.h"
 
-int pei_loongarch_probe(const char *kernel_buf, off_t kernel_size)
+int pei_loongarch_probe(const char *kernel_buf, off_t kernel_size,
+			struct kexec_info *info)
 {
 	const struct loongarch_image_header *h;
 
diff --git a/kexec/arch/m68k/kexec-elf-m68k.c b/kexec/arch/m68k/kexec-elf-m68k.c
index a2bf7ee..e3a71c8 100644
--- a/kexec/arch/m68k/kexec-elf-m68k.c
+++ b/kexec/arch/m68k/kexec-elf-m68k.c
@@ -33,7 +33,7 @@
 #define PAGE_SIZE	4 KiB
 
 
-int elf_m68k_probe(const char *buf, off_t len)
+int elf_m68k_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/m68k/kexec-m68k.h b/kexec/arch/m68k/kexec-m68k.h
index 99482c4..74eb67c 100644
--- a/kexec/arch/m68k/kexec-m68k.h
+++ b/kexec/arch/m68k/kexec-m68k.h
@@ -1,7 +1,8 @@
 #ifndef KEXEC_M68K_H
 #define KEXEC_M68K_H
 
-int elf_m68k_probe(const char *buf, off_t len);
+int elf_m68k_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int elf_m68k_load(int argc, char **argv, const char *buf, off_t len,
 		  struct kexec_info *info);
 void elf_m68k_usage(void);
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index 230d806..628cc68 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -92,7 +92,7 @@ static int patch_initrd_info(char *cmdline, unsigned long base,
 	return 0;
 }
 
-int elf_mips_probe(const char *buf, off_t len)
+int elf_mips_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/mips/kexec-mips.h b/kexec/arch/mips/kexec-mips.h
index 222c815..0fbd6a4 100644
--- a/kexec/arch/mips/kexec-mips.h
+++ b/kexec/arch/mips/kexec-mips.h
@@ -12,7 +12,8 @@
 #define CORE_TYPE_ELF32 1
 #define CORE_TYPE_ELF64 2
 
-int elf_mips_probe(const char *buf, off_t len);
+int elf_mips_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_mips_usage(void);
diff --git a/kexec/arch/ppc/kexec-dol-ppc.c b/kexec/arch/ppc/kexec-dol-ppc.c
index 800c072..0c44c13 100644
--- a/kexec/arch/ppc/kexec-dol-ppc.c
+++ b/kexec/arch/ppc/kexec-dol-ppc.c
@@ -234,7 +234,7 @@ void fix_dol_segments_overlaps(dol_segment * seg, int max_segs)
 	}
 }
 
-int dol_ppc_probe(const char *buf, off_t dol_length)
+int dol_ppc_probe(const char *buf, off_t dol_length, struct kexec_info *info)
 {
 	dol_header header, *h;
 	int i, valid = 0;
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 4a4886e..7f81310 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -73,7 +73,7 @@ static struct boot_notes {
 };
 #endif
 
-int elf_ppc_probe(const char *buf, off_t len)
+int elf_ppc_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 
 	struct mem_ehdr ehdr;
diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
index 04e728e..8c9e385 100644
--- a/kexec/arch/ppc/kexec-ppc.h
+++ b/kexec/arch/ppc/kexec-ppc.h
@@ -25,17 +25,20 @@ extern struct {
 
 #define SIZE_16M	(16*1024*1024UL)
 
-int elf_ppc_probe(const char *buf, off_t len);
+int elf_ppc_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int elf_ppc_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_ppc_usage(void);
 
-int uImage_ppc_probe(const char *buf, off_t len);
+int uImage_ppc_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int uImage_ppc_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void uImage_ppc_usage(void);
 
-int dol_ppc_probe(const char *buf, off_t len);
+int dol_ppc_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int dol_ppc_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void dol_ppc_usage(void);
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index e8f7adc..cea0278 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -76,7 +76,7 @@ char *slurp_ramdisk_ppc(const char *filename, off_t *r_size)
 	return buf;
 }
 	
-int uImage_ppc_probe(const char *buf, off_t len)
+int uImage_ppc_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	return uImage_probe_kernel(buf, len, IH_ARCH_PPC);
 }
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 01d045f..429851f 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -45,7 +45,7 @@ uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
 const char *ramdisk;
 
-int elf_ppc64_probe(const char *buf, off_t len)
+int elf_ppc64_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/ppc64/kexec-ppc64.h b/kexec/arch/ppc64/kexec-ppc64.h
index 434b4bf..fea3640 100644
--- a/kexec/arch/ppc64/kexec-ppc64.h
+++ b/kexec/arch/ppc64/kexec-ppc64.h
@@ -19,7 +19,8 @@ extern int get_devtree_value(const char *fname, unsigned long long *pvalue);
 
 int setup_memory_ranges(unsigned long kexec_flags);
 
-int elf_ppc64_probe(const char *buf, off_t len);
+int elf_ppc64_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_ppc64_usage(void);
diff --git a/kexec/arch/sh/kexec-elf-sh.c b/kexec/arch/sh/kexec-elf-sh.c
index 897552c..00c0c7e 100644
--- a/kexec/arch/sh/kexec-elf-sh.c
+++ b/kexec/arch/sh/kexec-elf-sh.c
@@ -40,7 +40,7 @@
 #include "crashdump-sh.h"
 #include "kexec-sh.h"
 
-int elf_sh_probe(const char *buf, off_t len)
+int elf_sh_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
 	int result;
diff --git a/kexec/arch/sh/kexec-sh.h b/kexec/arch/sh/kexec-sh.h
index 7d28ade..d320240 100644
--- a/kexec/arch/sh/kexec-sh.h
+++ b/kexec/arch/sh/kexec-sh.h
@@ -3,21 +3,25 @@
 
 #define COMMAND_LINE_SIZE 2048
 
-int uImage_sh_probe(const char *buf, off_t len);
+int uImage_sh_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int uImage_sh_load(int argc, char **argv, const char *buf, off_t len,
 		        struct kexec_info *info);
 
-int zImage_sh_probe(const char *buf, off_t len);
+int zImage_sh_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int zImage_sh_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void zImage_sh_usage(void);
 
-int elf_sh_probe(const char *buf, off_t len);
+int elf_sh_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int elf_sh_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_sh_usage(void);
 
-int netbsd_sh_probe(const char *buf, off_t len);
+int netbsd_sh_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int netbsd_sh_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void netbsd_sh_usage(void);
diff --git a/kexec/arch/sh/kexec-uImage-sh.c b/kexec/arch/sh/kexec-uImage-sh.c
index 130f12c..7b8284b 100644
--- a/kexec/arch/sh/kexec-uImage-sh.c
+++ b/kexec/arch/sh/kexec-uImage-sh.c
@@ -11,7 +11,7 @@
 #include "../../kexec.h"
 #include "kexec-sh.h"
 
-int uImage_sh_probe(const char *buf, off_t len)
+int uImage_sh_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	return uImage_probe_kernel(buf, len, IH_ARCH_SH);
 }
diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index aba4e3b..35dce27 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -43,7 +43,7 @@
 
 static const int probe_debug = 0;
 
-int bzImage64_probe(const char *buf, off_t len)
+int bzImage64_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	const struct x86_linux_header *header;
 
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index 7f9540a..f61e670 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -41,7 +41,7 @@
 #include "../i386/crashdump-x86.h"
 #include <arch/options.h>
 
-int elf_x86_64_probe(const char *buf, off_t len)
+int elf_x86_64_probe(const char *buf, off_t len, struct kexec_info *info)
 {
 	return elf_x86_any_probe(buf, len, CORE_TYPE_ELF64);
 }
diff --git a/kexec/arch/x86_64/kexec-x86_64.h b/kexec/arch/x86_64/kexec-x86_64.h
index 21c3a73..8dbec70 100644
--- a/kexec/arch/x86_64/kexec-x86_64.h
+++ b/kexec/arch/x86_64/kexec-x86_64.h
@@ -23,12 +23,14 @@ struct entry64_regs {
 	uint64_t rip;
 };
 
-int elf_x86_64_probe(const char *buf, off_t len);
+int elf_x86_64_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_x86_64_usage(void);
 
-int bzImage64_probe(const char *buf, off_t len);
+int bzImage64_probe(const char *buf, off_t len, struct kexec_info *info);
+
 int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info);
 void bzImage64_usage(void);
@@ -36,6 +38,8 @@ void bzImage64_usage(void);
 int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info);
 void multiboot2_x86_usage(void);
-int multiboot2_x86_probe(const char *buf, off_t buf_len);
+int multiboot2_x86_probe(const char *buf, off_t buf_len,
+			 struct kexec_info *info);
+
 
 #endif /* KEXEC_X86_64_H */
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 36bb2ad..f5ea73c 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -742,13 +742,13 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 			return -1;
 		} else {
 			/* make sure our file is really of that type */
-			if (file_type[i].probe(kernel_buf, kernel_size) < 0)
+			if (file_type[i].probe(kernel_buf, kernel_size, NULL) < 0)
 				guess_only = 1;
 		}
 	}
 	if (!type || guess_only) {
 		for (i = 0; i < file_types; i++) {
-			if (file_type[i].probe(kernel_buf, kernel_size) == 0)
+			if (file_type[i].probe(kernel_buf, kernel_size, NULL) == 0)
 				break;
 		}
 		if (i == file_types) {
@@ -1304,15 +1304,15 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 #ifdef __aarch64__
 		/* handle Image.gz like cases */
 		if (is_zlib_file(kernel, &kernel_size)) {
-			if ((ret = file_type[i].probe(kernel, kernel_size)) >= 0) {
+			if ((ret = file_type[i].probe(kernel, kernel_size, NULL)) >= 0) {
 				kernel_fd = ret;
 				break;
 			}
 		} else
-			if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
+			if (file_type[i].probe(kernel_buf, kernel_size, NULL) >= 0)
 				break;
 #else
-		if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
+		if (file_type[i].probe(kernel_buf, kernel_size, NULL) >= 0)
 			break;
 #endif
 	}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0d820ad..0706e46 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -191,7 +191,7 @@ unsigned long locate_hole(struct kexec_info *info,
 	unsigned long hole_min, unsigned long hole_max,
 	int hole_end);
 
-typedef int (probe_t)(const char *kernel_buf, off_t kernel_size);
+typedef int (probe_t)(const char *kernel, off_t kernel_size, struct kexec_info *info);
 typedef int (load_t )(int argc, char **argv,
 	const char *kernel_buf, off_t kernel_size, 
 	struct kexec_info *info);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
