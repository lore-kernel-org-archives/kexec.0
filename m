Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB82FD2ED12
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 03:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKQ0YsLba/ectpeg2805HF732odIUIDnxwsg+f5sOy4=; b=gtTRtGeeSE9Tnpq2E/Bt9UkRJ3
	zsoxhHXJ2uWT25hgQ6pL+KgwUuclwfOnJTcoPnFpRr91sITbxxLex00pdZfCdnDt2iiUu7EQ1xzsg
	dG/aqhi6/yoSq/t+yD2n9e/w+72oL/f4HYkJQvTOdBJf9RRblD1c+DLbRYaOol5jGqlczmEJqYiZw
	gn29Z7njFTHVQnCWuKLCjVQg9DB90sDwCY0qASn3FPTzAY20mIQU5e5oIylqoAc3HWxWbKx6n1HZo
	QY6SHEg8PtZLiAPI/hzexnLqbvWJt81ZotsN7+hnGkbxFMf7+xMOPS5qde6sKw8pKG0OsqWkg+Bei
	I7MOKbMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aU-0000000381U-0CB3;
	Tue, 20 Jan 2026 03:39:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aR-0000000380r-03sC
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 03:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768880361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKQ0YsLba/ectpeg2805HF732odIUIDnxwsg+f5sOy4=;
	b=IwroBMZdJLs/1Z2LNQmohqQSp4uNQIS++2UXMDTT+2sarlaelYaDdH14MTcMlwZ8fkmx0O
	1qLxcp/MCdSGYaH4K3QZ8alZj8c4BhiEg4BpYnn6LlXRw5EpjdWvg6B8u+8ywvTWdlQvqg
	M15xGoqdQ/MHEzCouAVsXxiZvkwUgv8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-YbCtKsvxMse4BQbt2t3RxQ-1; Mon, 19 Jan 2026 22:39:18 -0500
X-MC-Unique: YbCtKsvxMse4BQbt2t3RxQ-1
X-Mimecast-MFC-AGG-ID: YbCtKsvxMse4BQbt2t3RxQ_1768880357
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-352c79abf36so170814a91.2
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 19:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880357; x=1769485157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKQ0YsLba/ectpeg2805HF732odIUIDnxwsg+f5sOy4=;
        b=RtFuI/9CYh5H2r+mwXeaLE0kqR2Oa5BOVCahDBbT7VIVRmbnF9KN1ftf7d7HRhL6/m
         AmlvLo2N/cp5v3OWcUDnD6aRpQCy6RyHOHA5o7eNKJ6hWTwA2jgPcK6Y1WbYnJ8/XJ/W
         04vyrXZKSMMszQjAObDkBV6KO0p5dDqFC/th38coScuvbNBqOhNvoeqMoFYe6ZekHs+X
         QtKigr0qvyj83X7wsovqc+7XCSqydDC2LFybOSOKcsqbtkFZXW7gXrX62MiqzRvE3XHP
         9Gq89S7qofF3NRmywS7gMeoA7i8TSa9DJjDWVjj1W7YbvZWPuO6JRlxHWwb3K+zJbT3c
         5QIw==
X-Forwarded-Encrypted: i=1; AJvYcCVMvgqbKTE0YgCf+o0P8MWdEEPXJWErVNH4DrtWMakLOo5QqTbyfh7xYy/gG1ND74cIOg7KUw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHB5V73PjPQfZIjUfsftClKckM/uGOK1abLukYCVMNVI/6H4l2
	hBExPfDao0s9XvBhRuqUvQLS3kRjdWrcwUM9v13GEHe9B9o11iXs+z2VOyApvfJVZpDyhubVPXI
	dZqRTaJKxKHTcMyK5YUQzS9ieJdM8XUlhxGqsjqgSfMniPAm9Yx+wf+qvYn70rftx7lXQnA==
X-Gm-Gg: AZuq6aLADhj6uF4GCAd2+NwITYcYuFDruhej+Sz3hCD8nJy4E1vrD2yTXM3e1JEyn74
	Oik5PqVHiceXeQlrJpaIcrc0NgCVHIN1g7TWmO+mek+PbPGQibaCE4Ytp6cFxx+U/a0E5EnMkQL
	u6COG2wTho7N+RqOkYdAHk0VcdssX4simi+4CRGwqhoP8hzWOY75JvS4v8oviWLlzPNZ7CVkix+
	oUql/0btqwTmR/inuniHlGLcqYWeMdYniLNnyErAAnkiMlhL8d+2NRR1ilYT0NJLoANPMaoc8mH
	xJ5fZyPoXVwIEYcLnRuRX0qd47DTjIH2JhFr2Z66V4+FLe4frASoSbn3Nx+92o480jucQjkkx5l
	lTgHTrQ5d0Lp/IDuFTA==
X-Received: by 2002:a17:90b:48d1:b0:352:c995:808e with SMTP id 98e67ed59e1d1-352c9958c67mr168959a91.2.1768880356775;
        Mon, 19 Jan 2026 19:39:16 -0800 (PST)
X-Received: by 2002:a17:90b:48d1:b0:352:c995:808e with SMTP id 98e67ed59e1d1-352c9958c67mr168949a91.2.1768880356370;
        Mon, 19 Jan 2026 19:39:16 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm13375935a91.13.2026.01.19.19.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:39:15 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3 1/8] Implement kernel kallsyms resolving
Date: Tue, 20 Jan 2026 15:54:53 +1300
Message-ID: <20260120025500.25095-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260120025500.25095-1-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kPtNXM23THfyC2zKDr1pEjh3CgWlBX6VSss16yQQJ0M_1768880357
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_193923_201313_2A485951 
X-CRM114-Status: GOOD (  26.77  )
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

This patch will parse kernel's kallsyms data, and store them into a hash
table so they can be referenced later in a fast speed.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile       |   2 +-
 kallsyms.c     | 265 +++++++++++++++++++++++++++++++++++++++++++++++++
 kallsyms.h     |  17 ++++
 makedumpfile.c |   3 +
 makedumpfile.h |  11 ++
 5 files changed, 297 insertions(+), 1 deletion(-)
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h

diff --git a/Makefile b/Makefile
index 05ab5f2..6c450ac 100644
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
diff --git a/kallsyms.c b/kallsyms.c
new file mode 100644
index 0000000..ecf64e0
--- /dev/null
+++ b/kallsyms.c
@@ -0,0 +1,265 @@
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include "makedumpfile.h"
+#include "kallsyms.h"
+
+static uint32_t *kallsyms_offsets = NULL;
+static uint16_t *kallsyms_token_index = NULL;
+static uint8_t  *kallsyms_token_table = NULL;
+static uint8_t  *kallsyms_names = NULL;
+static unsigned long kallsyms_relative_base = 0;
+static unsigned int kallsyms_num_syms = 0;
+
+#define NAME_HASH 512
+static struct syment *name_hash_table[NAME_HASH] = {0};
+
+static uint64_t absolute_percpu(uint64_t base, int32_t val)
+{
+	if (val >= 0)
+		return (uint64_t)val;
+	else
+		return base - 1 - val;
+}
+
+static unsigned int hash_index(const char *name, unsigned int hash_size)
+{
+	unsigned int len, value;
+
+	len = strlen(name);
+	value = name[len - 1] * name[len / 2];
+
+	return (name[0] ^ value) % hash_size;
+}
+
+static void name_hash_install(struct syment *en)
+{
+	unsigned int index = hash_index(en->name, NAME_HASH);
+	struct syment *sp = name_hash_table[index];
+
+	if (sp == NULL) {
+		name_hash_table[index] = en;
+	} else {
+		while (sp) {
+			if (sp->name_hash_next) {
+				sp = sp->name_hash_next;
+			} else {
+				sp->name_hash_next = en;
+				break;
+			}
+		}
+	}
+}
+
+static struct syment *search_kallsyms_by_name(char *name)
+{
+	unsigned int index;
+	struct syment *sp;
+
+	index = hash_index(name, NAME_HASH);
+	for (sp = name_hash_table[index]; sp; sp = sp->name_hash_next) {
+		if (!strcmp(name, sp->name)) {
+			return sp;
+		}
+	}
+	return sp;
+}
+
+static bool is_unwanted_symbol(char *name)
+{
+	const char *unwanted_prefix[] = {
+		"__pfx_",	// CFI symbols
+		"_R",		// Rust symbols
+	};
+	for (int i = 0; i < sizeof(unwanted_prefix) / sizeof(char *); i++) {
+		if (!strncmp(name, unwanted_prefix[i], strlen(unwanted_prefix[i])))
+			return true;
+	}
+	return false;
+}
+
+uint64_t get_kallsyms_value_by_name(char *name)
+{
+	struct syment *sp;
+
+	sp = search_kallsyms_by_name(name);
+	if (!sp)
+		return 0;
+	return sp->value;
+}
+
+#define BUFLEN 1024
+static bool parse_kernel_kallsyms(void)
+{
+	char buf[BUFLEN];
+	int index = 0, i;
+	uint8_t *compressd_data;
+	uint8_t *uncompressd_data;
+	uint64_t stext;
+	uint8_t len, len_old;
+	struct syment *kern_syment;
+	bool skip;
+
+	for (i = 0; i < kallsyms_num_syms; i++) {
+		skip = false;
+		memset(buf, 0, BUFLEN);
+		len = kallsyms_names[index];
+		if (len & 0x80) {
+			index++;
+			len_old = len;
+			len = kallsyms_names[index];
+			if (len & 0x80) {
+				fprintf(stderr, "%s: BUG! Unexpected 3-byte length,"
+					" should be detected in init_kernel_kallsyms()\n",
+					__func__);
+				goto out;
+			}
+			len = (len_old & 0x7F) | (len << 7);
+		}
+		index++;
+
+		compressd_data = &kallsyms_names[index];
+		index += len;
+		while (len--) {
+			uncompressd_data = &kallsyms_token_table[kallsyms_token_index[*compressd_data]];
+			if (strlen(buf) + strlen((char *)uncompressd_data) >= BUFLEN) {
+				skip = true;
+				break;
+			}
+			strcat(buf, (char *)uncompressd_data);
+			compressd_data++;
+		}
+		if (skip || is_unwanted_symbol(&buf[1]))
+			continue;
+		kern_syment = (struct syment *)calloc(1, sizeof(struct syment));
+		if (!kern_syment)
+			goto no_mem;
+		kern_syment->value = kallsyms_offsets[i];
+		kern_syment->name = strdup(&buf[1]);
+		if (!kern_syment->name) {
+			free(kern_syment);
+			goto no_mem;
+		}
+		name_hash_install(kern_syment);
+	}
+
+	/* Now refresh the absolute each kallsyms address */
+	stext = get_kallsyms_value_by_name("_stext");
+	if (SYMBOL(_stext) == absolute_percpu(kallsyms_relative_base, stext)) {
+		for (i = 0; i < NAME_HASH; i++) {
+			for (kern_syment = name_hash_table[i];
+			     kern_syment;
+			     kern_syment = kern_syment->name_hash_next)
+				kern_syment->value = absolute_percpu(kallsyms_relative_base,
+							kern_syment->value);
+		}
+	} else if (SYMBOL(_stext) == kallsyms_relative_base + stext) {
+		for (i = 0; i < NAME_HASH; i++) {
+			for (kern_syment = name_hash_table[i];
+			     kern_syment;
+			     kern_syment = kern_syment->name_hash_next)
+				kern_syment->value += kallsyms_relative_base;
+		}
+	} else {
+		fprintf(stderr, "%s: Wrong calculate kallsyms symbol value!\n", __func__);
+		goto out;
+	}
+
+	return true;
+no_mem:
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+out:
+	return false;
+}
+
+static bool vmcore_info_ready = false;
+
+bool read_vmcoreinfo_kallsyms(void)
+{
+	READ_SYMBOL("kallsyms_names", kallsyms_names);
+	READ_SYMBOL("kallsyms_num_syms", kallsyms_num_syms);
+	READ_SYMBOL("kallsyms_token_table", kallsyms_token_table);
+	READ_SYMBOL("kallsyms_token_index", kallsyms_token_index);
+	READ_SYMBOL("kallsyms_offsets", kallsyms_offsets);
+	READ_SYMBOL("kallsyms_relative_base", kallsyms_relative_base);
+	vmcore_info_ready = true;
+	return true;
+}
+
+bool init_kernel_kallsyms(void)
+{
+	const int token_index_size = (UINT8_MAX + 1) * sizeof(uint16_t);
+	uint64_t last_token, len;
+	unsigned char data, data_old;
+	int i;
+	bool ret = false;
+
+	if (vmcore_info_ready == false) {
+		fprintf(stderr, "%s: vmcoreinfo not ready for kallsyms!\n",
+			__func__);
+		return ret;
+	}
+
+	readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms,
+		sizeof(kallsyms_num_syms));
+	readmem(VADDR, SYMBOL(kallsyms_relative_base), &kallsyms_relative_base,
+		sizeof(kallsyms_relative_base));
+
+	kallsyms_offsets = malloc(sizeof(uint32_t) * kallsyms_num_syms);
+	if (!kallsyms_offsets)
+		goto no_mem;
+	readmem(VADDR, SYMBOL(kallsyms_offsets), kallsyms_offsets,
+		kallsyms_num_syms * sizeof(uint32_t));
+
+	kallsyms_token_index = malloc(token_index_size);
+	if (!kallsyms_token_index)
+		goto no_mem;
+	readmem(VADDR, SYMBOL(kallsyms_token_index), kallsyms_token_index,
+		token_index_size);
+
+	last_token = SYMBOL(kallsyms_token_table) + kallsyms_token_index[UINT8_MAX];
+	do {
+		readmem(VADDR, last_token++, &data, 1);
+	} while(data);
+	len = last_token - SYMBOL(kallsyms_token_table);
+	kallsyms_token_table = malloc(len);
+	if (!kallsyms_token_table)
+		goto no_mem;
+	readmem(VADDR, SYMBOL(kallsyms_token_table), kallsyms_token_table, len);
+
+	for (len = 0, i = 0; i < kallsyms_num_syms; i++) {
+		readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
+		if (data & 0x80) {
+			len += 1;
+			data_old = data;
+			readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
+			if (data & 0x80) {
+				fprintf(stderr, "%s: BUG! Unexpected 3-byte length"
+					" encoding in kallsyms names\n", __func__);
+				goto out;
+			}
+			data = (data_old & 0x7F) | (data << 7);
+		}
+		len += data + 1;
+	}
+	kallsyms_names = malloc(len);
+	if (!kallsyms_names)
+		goto no_mem;
+	readmem(VADDR, SYMBOL(kallsyms_names), kallsyms_names, len);
+
+	ret = parse_kernel_kallsyms();
+	goto out;
+
+no_mem:
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+out:
+	if (kallsyms_offsets)
+		free(kallsyms_offsets);
+	if (kallsyms_token_index)
+		free(kallsyms_token_index);
+	if (kallsyms_token_table)
+		free(kallsyms_token_table);
+	if (kallsyms_names)
+		free(kallsyms_names);
+	return ret;
+}
diff --git a/kallsyms.h b/kallsyms.h
new file mode 100644
index 0000000..a4fbe10
--- /dev/null
+++ b/kallsyms.h
@@ -0,0 +1,17 @@
+#ifndef _KALLSYMS_H
+#define _KALLSYMS_H
+
+#include <stdint.h>
+#include <stdbool.h>
+
+struct __attribute__((packed)) syment {
+	uint64_t value;
+	char *name;
+	struct syment *name_hash_next;
+};
+
+bool read_vmcoreinfo_kallsyms(void);
+bool init_kernel_kallsyms(void);
+uint64_t get_kallsyms_value_by_name(char *);
+
+#endif /* _KALLSYMS_H */
\ No newline at end of file
diff --git a/makedumpfile.c b/makedumpfile.c
index 12fb0d8..dba3628 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -27,6 +27,7 @@
 #include <limits.h>
 #include <assert.h>
 #include <zlib.h>
+#include "kallsyms.h"
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -3105,6 +3106,8 @@ read_vmcoreinfo_from_vmcore(off_t offset, unsigned long size, int flag_xen_hv)
 		if (!read_vmcoreinfo())
 			goto out;
 	}
+	read_vmcoreinfo_kallsyms();
+
 	close_vmcoreinfo();
 
 	ret = TRUE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 134eb7a..0dec50e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -259,6 +259,7 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
 #define UINT(ADDR)	*((unsigned int *)(ADDR))
 #define ULONG(ADDR)	*((unsigned long *)(ADDR))
 #define ULONGLONG(ADDR)	*((unsigned long long *)(ADDR))
+#define VOID_PTR(ADDR)  *((void **)(ADDR))
 
 
 /*
@@ -1919,6 +1920,16 @@ struct symbol_table {
 	 * symbols on sparc64 arch
 	 */
 	unsigned long long		vmemmap_table;
+
+	/*
+	 * kallsyms related
+	 */
+	unsigned long long		kallsyms_names;
+	unsigned long long		kallsyms_num_syms;
+	unsigned long long		kallsyms_token_table;
+	unsigned long long		kallsyms_token_index;
+	unsigned long long		kallsyms_offsets;
+	unsigned long long		kallsyms_relative_base;
 };
 
 struct size_table {
-- 
2.47.0


