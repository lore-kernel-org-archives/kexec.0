Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120CAC71133
	for <kexec@archiver.kernel.org>; Wed, 11 Jun 2025 02:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Af1QIL56uU/49EL+McMdNitvy/6rtAuatpzuZOu9wIU=; b=kJxne5ZMYTknapiuwXFllT1++f
	UTpLGi227JBWIRWVzqxEoUVfDSqKCIArkbiTaXiafqQLABAm2JrNODerSZZjih2SrpuXY0b75J3J4
	tL6aMydUhzsCU2KYCxzbEJhwRWjvZUc1pBqWf/BzJToYQmM0sh3hJt2vdKbiRKcq9kNsv9taKDRDA
	DScg0xEal9LpcYv9lW3ONvL8/szy7wzv//ZbdgadP8sj+j6FuXwa4G1wEq9udbqejhyoVo0uMZmoJ
	vn1zYCriyk/1lSB0rIn8oaN6ZkB4paMaJw2eJZeCBjDv/u3+1CCO735MKwLnq0h+jJlvWpFRjv9UJ
	2rVw8v+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPBc1-00000008h8K-1WhS;
	Wed, 11 Jun 2025 02:54:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPBCi-00000008ekv-1rm2
	for kexec@lists.infradead.org;
	Wed, 11 Jun 2025 02:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749608919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Af1QIL56uU/49EL+McMdNitvy/6rtAuatpzuZOu9wIU=;
	b=ASwX3Sed3VIAAp6co0OdxZ2gxnmLICsbL9Tq6EpN20xiUXrueRKYrMV1uz/P0McvG7lA5O
	gjtxUSSJiyFD+Y3D2DkA4W0+qD+WLmTBvMUYc8YJcmCfMfLHOVCcX94WVCrhJm+ioKlhDt
	sTRuLE7hGHqD35sH/JJ9hl2ydK3axVg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-yy1WRs3wNSCPy3MI4uZxnw-1; Tue,
 10 Jun 2025 22:27:16 -0400
X-MC-Unique: yy1WRs3wNSCPy3MI4uZxnw-1
X-Mimecast-MFC-AGG-ID: yy1WRs3wNSCPy3MI4uZxnw_1749608835
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3DF01800282;
	Wed, 11 Jun 2025 02:27:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.76])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88C4E19560A3;
	Wed, 11 Jun 2025 02:27:10 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org
Subject: [PATCH 2/2] tools/kexec: Add a zboot image building tool
Date: Wed, 11 Jun 2025 10:26:46 +0800
Message-ID: <20250611022646.7970-3-piliu@redhat.com>
In-Reply-To: <20250611022646.7970-1-piliu@redhat.com>
References: <20250611022646.7970-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_192840_685074_F18E026F 
X-CRM114-Status: GOOD (  29.88  )
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

The objcopy binary can append an section into PE file, but it disregards
the DOS header. While the zboot format carries important information:
payload offset and size in the DOS header.

In order to keep track and update such information, here introducing a
dedicated binary tool to build zboot image. The payload offset is
determined by the fact that its offset inside the .data section is
unchanged. Hence the offset of .data section in the new PE file plus the
payload offset within section renders the offset within the new PE file.

The objcopy binary can append a section to a PE file, but it disregards
the DOS header. However, the zboot format carries important information
in the DOS header: payload offset and size.

To track this information and append a new PE section, here a dedicated
binary tool is introduced to build zboot images. The payload's relative
offset within the .data section remains unchanged.  Therefore, the .data
section offset in the new PE file, plus the payload offset within that
section, yields the payload offset within the new PE file.

Finally, the new PE file 'zboot.efi' can be got by the command:
  make -C tools/kexec zboot

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 tools/kexec/Makefile              |  10 +-
 tools/kexec/zboot_image_builder.c | 279 ++++++++++++++++++++++++++++++
 2 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 tools/kexec/zboot_image_builder.c

diff --git a/tools/kexec/Makefile b/tools/kexec/Makefile
index 49de2ab309a43..335d9c15d6c0f 100644
--- a/tools/kexec/Makefile
+++ b/tools/kexec/Makefile
@@ -27,7 +27,7 @@ BPFTOOL = bpftool
 
 # List of generated target files
 HEADERS = vmlinux.h bpf_helper_defs.h image_size.h
-ZBOOT_TARGETS = bytecode.c zboot_parser_bpf.o bytecode.o
+ZBOOT_TARGETS = bytecode.c zboot_parser_bpf.o bytecode.o zboot_image_builder zboot.efi
 
 
 # Targets
@@ -74,6 +74,14 @@ bytecode.c: zboot_parser_bpf.o
 bytecode.o: bytecode.c
 	@$(CC) -c $< -o $@
 
+# Rule to build zboot_image_builder executable
+zboot_image_builder: zboot_image_builder.c
+	@$(CC) $(CFLAGS) $< -o $@
+
+zboot.efi: zboot_image_builder bytecode.o
+	@chmod +x zboot_image_builder
+	@./zboot_image_builder $(EFI_IMAGE) bytecode.o $@
+
 # Clean up generated files
 clean:
 	@rm -f $(HEADERS) $(ZBOOT_TARGETS)
diff --git a/tools/kexec/zboot_image_builder.c b/tools/kexec/zboot_image_builder.c
new file mode 100644
index 0000000000000..94632395a7ddc
--- /dev/null
+++ b/tools/kexec/zboot_image_builder.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The zboot format carries the compressed kernel image offset and size
+ * information in the DOS header. The program appends a bpf section to PE file,
+ * meanwhile maintains the offset and size information, which is lost when using
+ * objcopy to handle zboot image.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "pe.h"
+
+#ifdef DEBUG_DETAIL
+	#define dprintf(...) printf(__VA_ARGS__)
+#else
+	#define dprintf(...) ((void)0)
+#endif
+
+typedef struct {
+	union {
+		struct {
+			unsigned int mz_magic;
+			char image_type[4];
+			/* offset to the whole file start */
+			unsigned int payload_offset;
+			unsigned int payload_size;
+			unsigned int reserved[2];
+			char comp_type[4];
+		};
+		char raw_bytes[56];
+	};
+	unsigned int linux_pe_magic;
+	/* offset at: 0x3c or 60 */
+	unsigned int pe_header_offset;
+} __attribute__((packed)) pe_zboot_header;
+
+typedef unsigned long	uintptr_t;
+#define ALIGN_UP(p, size) (__typeof__(p))(((uintptr_t)(p) + ((size) - 1)) & ~((size) - 1))
+
+int main(int argc, char **argv)
+{
+	uint32_t payload_new_offset, payload_sect_off;
+	uint32_t payload_size;
+	uint32_t payload_sect_idx;
+	pe_zboot_header *zheader;
+	struct pe_hdr *pe_hdr;
+	struct pe32plus_opt_hdr *opt_hdr;
+	int base_fd, bpf_fd, out_fd;
+	char *base_start_addr, *base_cur;
+	char *out_start_addr, *out_cur;
+	uint32_t out_sz, max_va_end = 0;
+	struct stat sb;
+	int i = 0, ret = 0;
+
+	if (argc != 4) {
+	    fprintf(stderr, "Usage: %s <original_pe> <binary_file> <new_pe>\n", argv[0]);
+	    return -1;
+	}
+
+	const char *original_pe = argv[1];
+	const char *binary_file = argv[2];
+	const char *new_pe = argv[3];
+	FILE *bin_fp = fopen(binary_file, "rb");
+	if (!bin_fp) {
+	    perror("Failed to open binary file");
+	    return -1;
+	}
+	fseek(bin_fp, 0, SEEK_END);
+	size_t bin_size = ftell(bin_fp);
+	fseek(bin_fp, 0, SEEK_SET);
+	base_fd = open(original_pe, O_RDWR);
+	out_fd = open(new_pe, O_RDWR | O_CREAT, 0644);
+	if (base_fd == -1 || out_fd == -1) {
+	    perror("Error opening file");
+	    exit(1);
+	}
+
+	if (fstat(base_fd, &sb) == -1) {
+	    perror("Error getting file size");
+	    exit(1);
+	}
+	base_start_addr = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, base_fd, 0);
+	if (base_start_addr == MAP_FAILED) {
+	    perror("Error mmapping the file");
+	    exit(1);
+	}
+	/* 64KB for section table extending */
+	out_sz = sb.st_size + bin_size + (1 << 16);
+	out_start_addr = mmap(NULL, out_sz, PROT_WRITE, MAP_SHARED, out_fd, 0);
+	if (ftruncate(out_fd, out_sz) == -1) {
+		perror("Failed to resize output file");
+		ret = -1;
+		goto err;
+	}
+	if (out_start_addr == MAP_FAILED) {
+	    perror("Error mmapping the file");
+	    exit(1);
+	}
+
+	zheader = (pe_zboot_header *)base_start_addr;
+	if (zheader->mz_magic != 0x5A4D) {  // 'MZ'
+	    fprintf(stderr, "Invalid DOS signature\n");
+	    return -1;
+	}
+	uint32_t pe_hdr_offset = get_pehdr_offset((const char *)base_start_addr);
+	base_cur = base_start_addr + pe_hdr_offset;
+	pe_hdr = (struct pe_hdr *)base_cur;
+	if (pe_hdr->magic!= 0x00004550) {  // 'PE\0\0'
+	    fprintf(stderr, "Invalid PE signature\n");
+	    return -1;
+	}
+	base_cur += sizeof(struct pe_hdr);
+	opt_hdr = (struct pe32plus_opt_hdr *)base_cur;
+	uint32_t file_align = opt_hdr->file_align;
+	uint32_t section_alignment = opt_hdr->section_align;
+
+	uint16_t num_sections = pe_hdr->sections;
+	struct section_header *base_sections, *sect;
+	uint32_t section_table_offset = pe_hdr_offset + sizeof(struct pe_hdr) + pe_hdr->opt_hdr_size;
+	base_sections = (struct section_header *)(base_start_addr + section_table_offset);
+
+	/* Decide the section idx and the payload offset within the section */
+	for (i = 0; i < num_sections; i++) {
+	    sect = &base_sections[i];
+	    if (zheader->payload_offset >= sect->data_addr &&
+		zheader->payload_offset < (sect->data_addr + sect->raw_data_size)) {
+		    payload_sect_idx = i;
+		    payload_sect_off = zheader->payload_offset - sect->data_addr;
+	    }
+	}
+
+	/* Calculate the end of the last section in virtual memory */
+	for (i = 0; i < num_sections; i++) {
+	    uint32_t section_end = base_sections[i].virtual_address + base_sections[i].virtual_size;
+	    if (section_end > max_va_end) {
+	        max_va_end = section_end;
+	    }
+	}
+
+	/* Calculate virtual address for the new .bpf section */
+	uint32_t bpf_virtual_address = ALIGN_UP(max_va_end, section_alignment);
+
+	pe_zboot_header *new_zhdr = malloc(sizeof(pe_zboot_header));
+	memcpy(new_zhdr, zheader, sizeof(pe_zboot_header));
+	struct pe_hdr *new_hdr = malloc(sizeof(struct pe_hdr));
+	memcpy(new_hdr, pe_hdr, sizeof(struct pe_hdr));
+	new_hdr->sections += 1;
+	struct pe32plus_opt_hdr *new_opt_hdr = malloc(pe_hdr->opt_hdr_size);
+	memcpy(new_opt_hdr, opt_hdr, pe_hdr->opt_hdr_size);
+	/* Create new section headers array (original + new section) */
+	struct section_header *new_sections = calloc(1, new_hdr->sections * sizeof(struct section_header));
+	if (!new_sections) {
+	    perror("Failed to allocate memory for new section headers");
+	    return -1;
+	}
+	memcpy(new_sections, base_sections, pe_hdr->sections * sizeof(struct section_header));
+
+	/* Configure the new .bpf section */
+	struct section_header *bpf_section = &new_sections[new_hdr->sections - 1];
+	memset(bpf_section, 0, sizeof(struct section_header));
+	strncpy((char *)bpf_section->name, ".bpf", 8);
+	bpf_section->virtual_size = bin_size;
+	bpf_section->virtual_address = bpf_virtual_address;
+	bpf_section->raw_data_size = bin_size;
+	bpf_section->flags = 0x40000000; //Readable
+
+	/* Update headers */
+	uint32_t new_size_of_image = bpf_section->virtual_address + bpf_section->virtual_size;
+	new_size_of_image = ALIGN_UP(new_size_of_image, section_alignment);
+	new_opt_hdr->image_size = new_size_of_image;
+
+	size_t section_table_size = new_hdr->sections * (sizeof(struct section_header));
+	size_t headers_size = section_table_offset + section_table_size;
+	size_t aligned_headers_size = ALIGN_UP(headers_size, file_align);
+	new_opt_hdr->header_size = aligned_headers_size;
+
+
+	uint32_t current_offset = aligned_headers_size;
+	/*
+	 * If the original PE data_addr is covered by enlarged header_size
+	 * re-assign new data_addr for all sections
+	 */
+	if (base_sections[0].data_addr < aligned_headers_size) {
+		for (i = 0; i < new_hdr->sections; i++) {
+		    new_sections[i].data_addr = current_offset;
+		    current_offset += ALIGN_UP(new_sections[i].raw_data_size, file_align);
+		}
+	/* Keep unchanged, just allocating file pointer for bpf section */
+	} else {
+		uint32_t t;
+		i = new_hdr->sections - 2;
+		t = new_sections[i].data_addr + new_sections[i].raw_data_size;
+		i++;
+		new_sections[i].data_addr = ALIGN_UP(t, file_align);
+	}
+
+	payload_new_offset = new_sections[payload_sect_idx].data_addr + payload_sect_off;
+	/* Update */
+	new_zhdr->payload_offset = payload_new_offset;
+	new_zhdr->payload_size = zheader->payload_size;
+	dprintf("zboot payload_offset updated from 0x%x to 0x%x, size:0x%x\n",
+		zheader->payload_offset, payload_new_offset, new_zhdr->payload_size);
+
+
+	/* compose the new PE file */
+
+	/* Write Dos header */
+	memcpy(out_start_addr, new_zhdr, sizeof(pe_zboot_header));
+	out_cur = out_start_addr + pe_hdr_offset;
+
+	/* Write PE header */
+	memcpy(out_cur, new_hdr, sizeof(struct pe_hdr));
+	out_cur += sizeof(struct pe_hdr);
+
+	/* Write PE optional header */
+	memcpy(out_cur, new_opt_hdr, new_hdr->opt_hdr_size);
+	out_cur += new_hdr->opt_hdr_size;
+
+	/* Write all section headers */
+	memcpy(out_cur, new_sections, new_hdr->sections * sizeof(struct section_header));
+
+	/* Skip padding and copy the section data */
+	for (i = 0; i < pe_hdr->sections; i++) {
+		base_cur = base_start_addr + base_sections[i].data_addr;
+		out_cur = out_start_addr + new_sections[i].data_addr;
+		memcpy(out_cur, base_cur, base_sections[i].raw_data_size);
+	}
+	msync(out_start_addr, new_sections[i].data_addr + new_sections[i].raw_data_size, MS_ASYNC);
+	/* For the bpf section */
+	out_cur = out_start_addr + new_sections[i].data_addr;
+
+	/* Write .bpf section data */
+	char *bin_data = calloc(1, bin_size);
+	if (!bin_data) {
+		perror("Failed to allocate memory for binary data");
+		free(base_sections);
+		free(new_sections);
+		ret = -1;
+		goto err;
+	}
+	if (fread(bin_data, bin_size, 1, bin_fp) != 1) {
+		perror("Failed to read binary data");
+		free(bin_data);
+		free(base_sections);
+		free(new_sections);
+		ret = -1;
+		goto err;
+	}
+
+	if (out_cur + bin_size > out_start_addr + out_sz) {
+	    perror("out of out_fd mmap\n");
+	    ret = -1;
+	    goto err;
+	}
+	memcpy(out_cur, bin_data, bin_size);
+	/* calculate the real size */
+	out_sz = out_cur + bin_size - out_start_addr;
+	msync(out_start_addr, out_sz, MS_ASYNC);
+	/* truncate to the real size */
+	if (ftruncate(out_fd, out_sz) == -1) {
+		perror("Failed to resize output file");
+		ret = -1;
+		goto err;
+	}
+	printf("Create a new PE file with bpf section: %s\n", new_pe);
+err:
+	munmap(out_start_addr, out_sz);
+	munmap(base_start_addr, sb.st_size);
+	close(base_fd);
+	close(out_fd);
+	close(bpf_fd);
+
+	return ret;
+}
-- 
2.49.0


