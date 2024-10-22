Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BBCD1CDA1
	for <kexec@archiver.kernel.org>; Tue, 22 Oct 2024 06:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KT+xmSAYoSCopaICc91AVUv5rjxv8uOpReQjsjRcz6A=; b=Kzj+h3QIab8B2z
	PFK7Uv6osgKppnJ9i6jRZpGrJXm6PZ1tDuiBcvFXApuz8YIyr172rGpevJZq7Jrw+by/PH9EkYsyw
	5iP8B2Z4JNq9VX6Mq674VlGW3iWAJH0ZZB8ii0bY2i919lcmYRSFaGFsDKXYMFQPD8UBNQwNuUkJF
	9t/6qsbRwBHbvTp52G92pmKf3BToIr2cwDJQysNQ5jROwdT1t8dwqgqajt8yJStBM48FMWotDpR0E
	ZPCJNjKCf2Zs2fNwQ7m/Q8CFWR9fd7mTXVMFDVFvyjhe3d9v81USFfah0nhBhffpNVxkdlj7KQbHH
	FppZ0m/lw2mclJrx6KRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t38N2-00000009o9Z-3Nuv;
	Tue, 22 Oct 2024 06:27:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t38Mz-00000009o8d-0Onw
	for kexec@lists.infradead.org;
	Tue, 22 Oct 2024 06:27:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729578472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/7y0RIkrXyKe7zsAHBL6ZHpYoQ7gklzgFx59AtCFzE=;
	b=PioevkMrhh1pmmonn5p41mwkQ8h7NN69ZgDO+RUTnZf6iDuSqjm/x31mVAbW2ergul+Qt6
	Dqjd9OQq1BXv17ieF9ajbZv9+/HQjBlxezRWDwzDUDwQnN49Aiqc7mY9xK2aXyxhCkYvvc
	uZ9kl3AgdzLrfyCl+KPjnBK304Sp63M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-v9lkcTKQOwubZ1FoZEHlZw-1; Tue,
 22 Oct 2024 02:27:48 -0400
X-MC-Unique: v9lkcTKQOwubZ1FoZEHlZw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CB4919560AD;
	Tue, 22 Oct 2024 06:27:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.98])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1529F1956088;
	Tue, 22 Oct 2024 06:27:44 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>,
	kexec@lists.infradead.org
Subject: [PATCHv3 2/3] kexec: Introduce UKI image parser
Date: Tue, 22 Oct 2024 14:27:18 +0800
Message-ID: <20241022062734.9857-1-piliu@redhat.com>
In-Reply-To: <20241016113418.22568-3-piliu@redhat.com>
References: <20241016113418.22568-3-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_232753_238504_6CDA7BC3 
X-CRM114-Status: GOOD (  26.58  )
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

A UKI image is a PE file that consists of several sections, typically
including: .text, .data, .linux, .initrd, .cmdline, and others.

The kernel image is stored in the .linux section, which is one of the
formats currently recognized by kexec-tools. Therefore, the UKI parser
can be used to strip away the UKI layer, allowing the other parser to
continue the procession of the kernel image.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
---
 include/Makefile  |   1 +
 include/pe.h      | 104 +++++++++++++++++++++++++++++++++++++++
 kexec/Makefile    |   1 +
 kexec/kexec-uki.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 kexec/kexec.h     |   4 ++
 5 files changed, 233 insertions(+)
 create mode 100644 include/pe.h
 create mode 100644 kexec/kexec-uki.c

diff --git a/include/Makefile b/include/Makefile
index cd88a26..6a3e854 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -8,6 +8,7 @@ dist += include/Makefile		\
 	include/x86/mb_header.h		\
 	include/x86/multiboot2.h	\
 	include/elf.h			\
+	include/pe.h			\
 	include/image.h			\
 	include/unused.h		\
 	include/boot/linuxbios_tables.h	\
diff --git a/include/pe.h b/include/pe.h
new file mode 100644
index 0000000..2617074
--- /dev/null
+++ b/include/pe.h
@@ -0,0 +1,104 @@
+/*
+ * Extract from linux kernel include/linux/pe.h
+ */
+
+#ifndef __PE_H__
+#define __PE_H__
+
+struct pe_hdr {
+	uint32_t magic;		/* PE magic */
+	uint16_t machine;	/* machine type */
+	uint16_t sections;	/* number of sections */
+	uint32_t timestamp;	/* time_t */
+	uint32_t symbol_table;	/* symbol table offset */
+	uint32_t symbols;	/* number of symbols */
+	uint16_t opt_hdr_size;	/* size of optional header */
+	uint16_t flags;		/* flags */
+};
+
+/* the fact that pe32 isn't padded where pe32+ is 64-bit means union won't
+ * work right.  vomit. */
+struct pe32_opt_hdr {
+	/* "standard" header */
+	uint16_t magic;		/* file type */
+	uint8_t  ld_major;	/* linker major version */
+	uint8_t  ld_minor;	/* linker minor version */
+	uint32_t text_size;	/* size of text section(s) */
+	uint32_t data_size;	/* size of data section(s) */
+	uint32_t bss_size;	/* size of bss section(s) */
+	uint32_t entry_point;	/* file offset of entry point */
+	uint32_t code_base;	/* relative code addr in ram */
+	uint32_t data_base;	/* relative data addr in ram */
+	/* "windows" header */
+	uint32_t image_base;	/* preferred load address */
+	uint32_t section_align;	/* alignment in bytes */
+	uint32_t file_align;	/* file alignment in bytes */
+	uint16_t os_major;	/* major OS version */
+	uint16_t os_minor;	/* minor OS version */
+	uint16_t image_major;	/* major image version */
+	uint16_t image_minor;	/* minor image version */
+	uint16_t subsys_major;	/* major subsystem version */
+	uint16_t subsys_minor;	/* minor subsystem version */
+	uint32_t win32_version;	/* reserved, must be 0 */
+	uint32_t image_size;	/* image size */
+	uint32_t header_size;	/* header size rounded up to
+				   file_align */
+	uint32_t csum;		/* checksum */
+	uint16_t subsys;	/* subsystem */
+	uint16_t dll_flags;	/* more flags! */
+	uint32_t stack_size_req;/* amt of stack requested */
+	uint32_t stack_size;	/* amt of stack required */
+	uint32_t heap_size_req;	/* amt of heap requested */
+	uint32_t heap_size;	/* amt of heap required */
+	uint32_t loader_flags;	/* reserved, must be 0 */
+	uint32_t data_dirs;	/* number of data dir entries */
+};
+
+struct pe32plus_opt_hdr {
+	uint16_t magic;		/* file type */
+	uint8_t  ld_major;	/* linker major version */
+	uint8_t  ld_minor;	/* linker minor version */
+	uint32_t text_size;	/* size of text section(s) */
+	uint32_t data_size;	/* size of data section(s) */
+	uint32_t bss_size;	/* size of bss section(s) */
+	uint32_t entry_point;	/* file offset of entry point */
+	uint32_t code_base;	/* relative code addr in ram */
+	/* "windows" header */
+	uint64_t image_base;	/* preferred load address */
+	uint32_t section_align;	/* alignment in bytes */
+	uint32_t file_align;	/* file alignment in bytes */
+	uint16_t os_major;	/* major OS version */
+	uint16_t os_minor;	/* minor OS version */
+	uint16_t image_major;	/* major image version */
+	uint16_t image_minor;	/* minor image version */
+	uint16_t subsys_major;	/* major subsystem version */
+	uint16_t subsys_minor;	/* minor subsystem version */
+	uint32_t win32_version;	/* reserved, must be 0 */
+	uint32_t image_size;	/* image size */
+	uint32_t header_size;	/* header size rounded up to
+				   file_align */
+	uint32_t csum;		/* checksum */
+	uint16_t subsys;	/* subsystem */
+	uint16_t dll_flags;	/* more flags! */
+	uint64_t stack_size_req;/* amt of stack requested */
+	uint64_t stack_size;	/* amt of stack required */
+	uint64_t heap_size_req;	/* amt of heap requested */
+	uint64_t heap_size;	/* amt of heap required */
+	uint32_t loader_flags;	/* reserved, must be 0 */
+	uint32_t data_dirs;	/* number of data dir entries */
+};
+
+struct section_header {
+	char name[8];			/* name or "/12\0" string tbl offset */
+	uint32_t virtual_size;		/* size of loaded section in ram */
+	uint32_t virtual_address;	/* relative virtual address */
+	uint32_t raw_data_size;		/* size of the section */
+	uint32_t data_addr;		/* file pointer to first page of sec */
+	uint32_t relocs;		/* file pointer to relocation entries */
+	uint32_t line_numbers;		/* line numbers! */
+	uint16_t num_relocs;		/* number of relocations */
+	uint16_t num_lin_numbers;	/* srsly. */
+	uint32_t flags;
+};
+
+#endif
diff --git a/kexec/Makefile b/kexec/Makefile
index 11682bf..d4f26d7 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -18,6 +18,7 @@ KEXEC_SRCS_base += kexec/kexec-elf-core.c
 KEXEC_SRCS_base += kexec/kexec-elf-rel.c
 KEXEC_SRCS_base += kexec/kexec-elf-boot.c
 KEXEC_SRCS_base += kexec/kexec-pe-zboot.c
+KEXEC_SRCS_base += kexec/kexec-uki.c
 KEXEC_SRCS_base += kexec/kexec-iomem.c
 KEXEC_SRCS_base += kexec/firmware_memmap.c
 KEXEC_SRCS_base += kexec/crashdump.c
diff --git a/kexec/kexec-uki.c b/kexec/kexec-uki.c
new file mode 100644
index 0000000..210ebb6
--- /dev/null
+++ b/kexec/kexec-uki.c
@@ -0,0 +1,123 @@
+#include <limits.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <pe.h>
+#include "kexec.h"
+
+#define UKI_LINUX_SECTION ".linux"
+#define UKI_INITRD_SECTION ".initrd"
+#define UKI_CMDLINE_SECTION ".cmdline"
+#define UKI_DTB_SECTION ".dtb"
+
+#define FILENAME_UKI_INITRD          "/tmp/InitrdXXXXXX"
+
+static int embeded_linux_format_index = -1;
+
+/*
+ * Return -1 if not PE, else offset of the PE header
+ */
+static int get_pehdr_offset(const char *buf)
+{
+	int pe_hdr_offset;
+
+	pe_hdr_offset = *((int *)(buf + 0x3c));
+	buf += pe_hdr_offset;
+	if (!!memcmp(buf, "PE\0\0", 4)) {
+		printf("Not a PE file\n");
+		return -1;
+	}
+
+	return pe_hdr_offset;
+}
+
+int uki_image_probe(const char *file_buf, off_t buf_sz)
+{
+	struct pe_hdr *pe_hdr;
+	struct pe32plus_opt_hdr *opt_hdr;
+	struct section_header *sect_hdr;
+	int pe_hdr_offset, section_nr, linux_sz = -1;
+	char *pe_part_buf, *linux_src;
+	char *initrd_fname = NULL;
+	int initrd_fd = -1;
+
+	pe_hdr_offset = get_pehdr_offset(file_buf);
+	pe_part_buf = (char *)file_buf + pe_hdr_offset;
+	pe_hdr = (struct pe_hdr *)pe_part_buf;
+	if (pe_hdr->opt_hdr_size == 0) {
+		printf("ERR: optional header is missing\n");
+		return -1;
+	}
+	section_nr = pe_hdr->sections;
+	opt_hdr = (struct pe32plus_opt_hdr *)(pe_part_buf + sizeof(struct pe_hdr));
+	sect_hdr = (struct section_header *)((char *)opt_hdr + pe_hdr->opt_hdr_size);
+
+	for (int i = 0; i < section_nr; i++) {
+		if (!strcmp(sect_hdr->name, UKI_LINUX_SECTION)) {
+			/* data_addr is relative to the whole file */
+			linux_src = (char *)file_buf + sect_hdr->data_addr;
+			linux_sz = sect_hdr->raw_data_size;
+
+		} else if (!strcmp(sect_hdr->name, UKI_INITRD_SECTION)) {
+			if (!(initrd_fname = strdup(FILENAME_UKI_INITRD))) {
+				dbgprintf("%s: Can't duplicate strings\n", __func__);
+				goto next;
+			}
+
+			if ((initrd_fd = mkstemp(initrd_fname)) < 0) {
+				dbgprintf("%s: Can't open file %s\n", __func__,	initrd_fname);
+				goto next;
+			}
+
+			if (write(initrd_fd, (char *)file_buf + sect_hdr->data_addr,
+					sect_hdr->raw_data_size) != sect_hdr->raw_data_size) {
+				dbgprintf("%s: Can't write the compressed file %s\n",
+						__func__, initrd_fname);
+				close(initrd_fd);
+				goto next;
+			} else {
+				implicit_initrd_fd = open(initrd_fname, O_RDONLY);
+				close(initrd_fd);
+			}
+		}
+next:
+		sect_hdr++;
+	}
+
+	if (linux_sz == -1) {
+		printf("ERR: can not find .linux section\n");
+		return -1;
+	}
+	/*
+	 * After stripping the UKI coat, the real kernel format can be handled now.
+	 */
+	for (int i = 0; i < file_types; i++) {
+		/* kernel_fd will be created by probe */
+		if (file_type[i].probe != uki_image_probe &&
+		    file_type[i].probe(linux_src, linux_sz) >= 0) {
+			embeded_linux_format_index = i;
+			break;
+		}
+	}
+	if (embeded_linux_format_index < 0) {
+		printf("Can not recognize the kernel format in .linux section\n");
+		return -1;
+	}
+	return 0;
+}
+
+int uki_image_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info)
+{
+	return file_type[embeded_linux_format_index].load(argc, argv, buf, len, info);
+}
+
+void uki_image_usage(void)
+{
+	printf(
+"     An UKI image.\n");
+}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index e70c18d..a2e19c4 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -357,4 +357,8 @@ static inline void ultoa(unsigned long val, char *str)
 	str[pos] = 0;
 }
 
+extern int uki_image_probe(const char *file_buf, off_t buf_sz);
+extern int uki_image_load(int argc, char **argv, const char *buf, off_t len,
+		struct kexec_info *info);
+extern void uki_image_usage(void);
 #endif /* KEXEC_H */
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
