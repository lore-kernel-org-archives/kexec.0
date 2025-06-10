Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59582C71135
	for <kexec@archiver.kernel.org>; Fri, 13 Jun 2025 08:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w2FLPT7Vmy8bnwgEyXeSQiVQzZO2SSccezTvBIrXFeA=; b=QvHTkwS/BI//+eQtbnnTTP9XlY
	/jsbrhu0DixrGcuyOkRXF8HRRy2sVkC8qmkmXrHM8OYEnXTDLYcA72ABU1segk2HmdpkUtlscdr3R
	KbWAsMmSPDO4gJCXPUYTRZwk7BW2x8XLpqQdiLY2h58xD92S3HwxVj9CgHsX08EZdiT5dWUHRDEf+
	wz3YW8mFaV6qn849Lf3joKo5+0V2PNXDC6Jp5rbXcqSK71IR4JQsYrrzBmuUpxoe3FdSMS5HMKaWz
	P/tP+jRaVHHDY3kw6ou1/McBaVMgMG/8bkOiAnPIW+e8t8FlBgLlZQ4vUqYyW2GIMhUdW9qGY1pWd
	l2eQkPzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPzb0-0000000FjcX-0TR3;
	Fri, 13 Jun 2025 08:17:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvli-00000006Qg8-1Rwq
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 09:59:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2FLPT7Vmy8bnwgEyXeSQiVQzZO2SSccezTvBIrXFeA=;
	b=H+ItaQ1mg7vnCgLOWB2qe4gAEXY1xjCRns+IgA0uFpoD2OaZ0WtCJ0Aa82syMqDG6YlV+F
	yTQze/fy9yxiBhjWCSR1gjDln3x9Ahi4a7I94Aqpw5ExxB4FIRnW4ge9inYtIh9zA8spkW
	AU5GzzUrkEJS49Cz8tqg2G6v7m1csFU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-j6ksmduZOQ6OvPMqfYIaLQ-1; Tue, 10 Jun 2025 05:58:11 -0400
X-MC-Unique: j6ksmduZOQ6OvPMqfYIaLQ-1
X-Mimecast-MFC-AGG-ID: j6ksmduZOQ6OvPMqfYIaLQ_1749549490
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2350804a43eso85025595ad.0
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549490; x=1750154290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2FLPT7Vmy8bnwgEyXeSQiVQzZO2SSccezTvBIrXFeA=;
        b=daofESBLwe0v+Je69HgeNVI+zIS4kyPPCdGm5bX5KsMjzkZ2OqgxWdO4ZszGT8/ogC
         +lbS7W4aMDxB7doKu3tAAWgJx11zm8aog2iZmleHEpLyZOrAz8KonLUK0qwqLxdLhia7
         kwgpYskKjIynv1+przft67cpv/H4P+phjrP0gSU3fyFlDhK4BmjJWk57ynx5xPqffdQ5
         HAeFozj0SiAtxbN1fFHGmxYu+KwF9Y5SOlypj8fruJYmxhDcf3DkMGB2AlhOMsalN9wV
         xqNV22XhNyUbeLk6LEFIBmNJLQQX6CG3RBg3bN12JKGZui7Bvb4xYlenobRBKTp3QSIY
         VcWA==
X-Forwarded-Encrypted: i=1; AJvYcCXnlCl91qtIXPtjeAk/FnXFyZvWY5/ZVwhDruunbHVTGQlwV59WQU0FwyH4WIg4WWtMgz/mIQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwSE37CedFE0z9jP0Y9mtRdKUvovU/a+K8NT+qA5ZudlAZHRqKW
	svoUT+HuqdTEM+9CqbunYPcX4NwGu4zq19hni5ObOPPh2fVkkVwGFoeY9XjyW6xbqO5E2Iy0WxU
	Pk2ir/ghBASYRiqUZsHUnLPJ4U7zDS3lT/x1O4iNyFRoBaRem0rKgc/cYoxGPWYiNHKzC6g==
X-Gm-Gg: ASbGncvPRE0yBvSLPNSVWy9/BDVtK85iVCHxfPACmGGo9jQg7XOPRvZyXIq6LZVFi9q
	sRjnNhmelGgWMOlD4aaqIYLs5joDWvo3kqp2Gd/l7vug5wIyV3wfsKAwCW1afoPdh6SL+9tk3Xw
	Y5dwrLCyjafD3d6/rrBqIGCXWgXAhlM6KRH6WXfj18HKfTvq0Q+QDnPMHNFYCpx/2P2eF7IF9+O
	7qD3IYVyiWYBI4R2YbAQqE2lfLNUuc/Pt9+pqit9a/6nLShZjLV3Z3gIXiaHw5moogq6aPXs9Zv
	3JTHey16UrG8fksD6FwDFE2+pKSmU54=
X-Received: by 2002:a17:902:d48d:b0:235:15f5:cc30 with SMTP id d9443c01a7336-23601d0716cmr227082855ad.16.1749549489022;
        Tue, 10 Jun 2025 02:58:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFmzQuzVG9SaPKCfyeMXnEeWaOKZBiZtpvmhVLXC7Z3bPq2w3SR5vt2oJpiG16MaRGg6+QsA==
X-Received: by 2002:a17:902:d48d:b0:235:15f5:cc30 with SMTP id d9443c01a7336-23601d0716cmr227082595ad.16.1749549488392;
        Tue, 10 Jun 2025 02:58:08 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:58:07 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 04/10] Add btf/kallsyms support for symbol type/address resolving
Date: Tue, 10 Jun 2025 21:57:37 +1200
Message-ID: <20250610095743.18073-5-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Q5y2jT5ON_J3X68JQ3nHcNRO-p2Xr17NRp7sZvtKq4_1749549490
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_025946_645881_D1BE6668 
X-CRM114-Status: GOOD (  28.17  )
X-Mailman-Approved-At: Fri, 13 Jun 2025 01:15:21 -0700
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

btf data contains symbols' type and size, which is essential to determine a
structure/member size & offset. kallsyms contains symbols' address. All the
data can provide complete info for symbol resolving.

To initialize, we will:
1st) read vmcore info and parse kernel's kallsyms data;
2nd) read kernel data range of "__start/stop_BTF" and parse kernel's btf data,
     now we have complete type/address info for kernel symbols;
3rd) iterate kernel's module and parse all kernel modules' kallsyms data;
4th) iterate btf_modules and parse all kernel modules' btf data, now we have
     complete type/address info for kernel and modules symbols.

Also to speed up the converting of symbol name to address/type, the parsed
btf/kallsyms data are stored in hash tables.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile       |   2 +-
 btf.c          | 919 +++++++++++++++++++++++++++++++++++++++++++++++++
 btf.h          | 176 ++++++++++
 kallsyms.c     | 371 ++++++++++++++++++++
 kallsyms.h     |  42 +++
 makedumpfile.c |   3 +
 makedumpfile.h |  11 +
 7 files changed, 1523 insertions(+), 1 deletion(-)
 create mode 100644 btf.c
 create mode 100644 btf.h
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h

diff --git a/Makefile b/Makefile
index 18d3a17..fbc9f5b 100644
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
diff --git a/btf.c b/btf.c
new file mode 100644
index 0000000..c91c841
--- /dev/null
+++ b/btf.c
@@ -0,0 +1,919 @@
+#include "btf.h"
+#include <stdio.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <libelf.h>
+#include <gelf.h>
+#include <dirent.h>
+#include "kallsyms.h"
+#include "makedumpfile.h"
+
+// btf_files_array[0] must be kernel itself
+// btf_files_array[1..] are kernel modules
+static struct btf_file **btf_files_array = NULL;
+static int btf_files_array_index = 0;
+
+static const char *kind_names[NR_BTF_KINDS] = {
+	[BTF_KIND_UNKN] = "UNKN",
+	[BTF_KIND_INT] = "INT",
+	[BTF_KIND_PTR] = "PTR",
+	[BTF_KIND_ARRAY] = "ARRAY",
+	[BTF_KIND_STRUCT] = "STRUCT",
+	[BTF_KIND_UNION] = "UNION",
+	[BTF_KIND_ENUM] = "ENUM",
+	[BTF_KIND_FWD] = "FWD",
+	[BTF_KIND_TYPEDEF] = "TYPEDEF",
+	[BTF_KIND_VOLATILE] = "VOLATILE",
+	[BTF_KIND_CONST] = "CONST",
+	[BTF_KIND_RESTRICT] = "RESTRICT",
+	[BTF_KIND_FUNC] = "FUNC",
+	[BTF_KIND_FUNC_PROTO] = "FUNC_PROTO",
+	[BTF_KIND_VAR] = "VAR",
+	[BTF_KIND_DATASEC] = "DATASEC",
+	[BTF_KIND_FLOAT] = "FLOAT",
+	[BTF_KIND_DECL_TAG] = "DECL_TAG",
+	[BTF_KIND_TYPE_TAG] = "TYPE_TAG",
+	[BTF_KIND_ENUM64] = "ENUM64",
+};
+
+static inline uint16_t btf_vlen(uint32_t info)
+{
+	return info & 0xFFFF;
+}
+
+static inline uint32_t btf_kind_flag(uint32_t info)
+{
+	return info & (1 << 31);
+}
+
+static inline uint32_t btf_member_bit_offset(uint32_t value)
+{
+	return value & 0xffffff;
+}
+
+static inline uint32_t btf_member_bitfield_size(uint32_t value)
+{
+	return value >> 24;
+}
+
+static struct btf_type *btf_next(struct btf_type *tp)
+{
+	uintptr_t next = (uintptr_t)&tp[1];
+
+	switch (btf_kind(tp->info)) {
+	case BTF_KIND_INT:
+		next += sizeof(uint32_t);
+		break;
+
+	case BTF_KIND_ARRAY:
+		next += sizeof(struct btf_array);
+		break;
+
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		next += btf_vlen(tp->info) * sizeof(struct btf_member);
+		break;
+
+	case BTF_KIND_ENUM:
+		next += btf_vlen(tp->info) * sizeof(struct btf_enum);
+		break;
+
+	case BTF_KIND_FUNC_PROTO:
+		next += btf_vlen(tp->info) * sizeof(struct btf_param);
+		break;
+
+	case BTF_KIND_VAR:
+		next += sizeof(struct btf_var);
+		break;
+
+	case BTF_KIND_DATASEC:
+		next += btf_vlen(tp->info) * sizeof(struct btf_var_secinfo);
+		break;
+
+	case BTF_KIND_DECL_TAG:
+		next += sizeof(struct btf_decl_tag);
+		break;
+
+	case BTF_KIND_ENUM64:
+		next += btf_vlen(tp->info) * sizeof(struct btf_enum64);
+		break;
+
+	case BTF_KIND_PTR:
+	case BTF_KIND_FWD:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_FUNC:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_TYPE_TAG:
+		break; // no extra data
+
+	default:
+		__builtin_unreachable();
+	}
+	return (struct btf_type *)next;
+}
+
+#define NAME_HASH 512
+static struct name_entry *name_hash_table[NAME_HASH] = {0};
+
+static void *get_name_entry_next(void *entry)
+{
+	return ((struct name_entry *)entry)->name_hash_next;
+}
+
+static void set_name_entry_next(void *entry, void *next)
+{
+	((struct name_entry *)entry)->name_hash_next = next;
+}
+
+static void name_hash_install(struct name_entry *en)
+{
+	hash_install((void **)name_hash_table, NAME_HASH, en, en->name,
+			get_name_entry_next, set_name_entry_next);
+}
+
+static unsigned int name_hash_index(char *name)
+{
+	return hash_index(name, NAME_HASH);
+}
+
+static int read_file_at_offset(char *f, int f_off, int r_size, void *buf)
+{
+	int got = 0;
+	int r, fd, ret = -1;
+
+	fd = open(f, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "%s: Failed to open file %s\n", __func__, f);
+		goto out;
+	}
+
+	while (got < r_size) {
+		r = pread(fd, buf + got, r_size - got, f_off + got);
+		if (r < 0) {
+			fprintf(stderr, "%s: Failed to read file %s\n", __func__, f);
+			goto clean_fd;
+		}
+		got += r;
+	}
+	ret = got;
+
+clean_fd:
+	close(fd);
+out:
+	return ret;
+}
+
+static char *get_str_by_name_off(struct btf_file *bf, uint32_t name_off)
+{
+	struct btf_file *bf_vmlinux = btf_files_array[0];
+
+	if (bf != bf_vmlinux && name_off >= bf_vmlinux->str_cache_len)
+		return bf->str_cache + name_off - bf_vmlinux->str_cache_len;
+	else
+		return bf_vmlinux->str_cache + name_off;
+}
+
+int get_btf_type_by_type_id(struct btf_file *bf_in, uint32_t id_in,
+			    struct btf_type *bt_out, struct name_entry **en_out)
+{
+	struct name_entry *en;
+	struct btf_file *bf_vmlinux = btf_files_array[0];
+
+	if (bf_in != bf_vmlinux && id_in > bf_vmlinux->array_len) {
+		en = bf_in->array[id_in - bf_vmlinux->array_len - 1];
+	} else {
+		en = bf_vmlinux->array[id_in - 1];
+	}
+	if (en_out)
+		*en_out = en;
+	return read_file_at_offset(en->bf->file_name,
+		en->btf_type_offset + en->bf->types_data_offset,
+		sizeof(*bt_out), bt_out);
+}
+
+/*
+* Parse the btf data and install elements into hashtable and array for quick
+* reference.
+*/
+static int parse_btf_data(char *file_path, char *data_start, uint32_t data_len)
+{
+	struct btf_header *hdr = (struct btf_header *)data_start;
+	struct btf_file *bf = NULL;
+	void *type_start;
+	char *str_start;
+	struct btf_type *tp;
+	struct name_entry *en;
+	int i, j, scale;
+
+	/* We do some check first */
+	if (hdr->magic != BTF_MAGIC) {
+		fprintf(stderr, "%s: Invalid BTF magic in %s\n",
+			__func__, file_path);
+		goto out;
+	}
+	if (hdr->hdr_len != sizeof(*hdr)) {
+		fprintf(stderr, "%s: Invalid BTF header length in %s\n",
+			__func__, file_path);
+		goto out;
+	}
+	if (hdr->hdr_len + hdr->str_off + hdr->str_len > data_len) {
+		fprintf(stderr, "%s: String section exceeds data length in %s\n",
+			__func__, file_path);
+		goto out;
+	}
+	if (hdr->hdr_len + hdr->type_off + hdr->type_len > data_len) {
+		fprintf(stderr, "%s: Type section exceeds data length in %s\n",
+			__func__, file_path);
+		goto out;
+	}
+
+	/* Let's start parsing */
+	bf = (struct btf_file *)malloc(sizeof(*bf));
+	if (!bf)
+		goto no_mem;
+	memset(bf, 0, sizeof(*bf));
+
+	/* Enlarge array when reach power of 2 */
+	btf_files_array[btf_files_array_index++] = bf;
+	if ((btf_files_array_index & (btf_files_array_index - 1)) == 0) {
+		struct btf_file **tmp = (struct btf_file **)reallocarray(btf_files_array,
+						btf_files_array_index << 1,
+						sizeof(struct btf_file *));
+		if (!tmp)
+			goto no_mem;
+		btf_files_array = tmp;
+	}
+
+	type_start = data_start + hdr->hdr_len + hdr->type_off;
+	str_start = data_start + hdr->hdr_len + hdr->str_off;
+
+	bf->str_cache = malloc(hdr->str_len);
+	if (!bf->str_cache)
+		goto no_mem;
+	memcpy(bf->str_cache, str_start, hdr->str_len);
+    	bf->str_cache_len = hdr->str_len;
+
+	bf->array_len = 64;
+	bf->array = (struct name_entry **)calloc(bf->array_len,
+			sizeof(struct name_entry *));
+	if (!bf->array)
+		goto no_mem;
+
+	bf->file_name = strdup(file_path);
+	if (!bf->file_name)
+		goto no_mem;
+	bf->types_data_offset = (char *)type_start - data_start;
+
+	for (tp = (struct btf_type *)type_start, i = 0;
+	     (void *)tp < type_start + hdr->type_len;
+	     tp = btf_next(tp), i++) {
+		en = (struct name_entry *)malloc(sizeof(struct name_entry));
+		if (!en) {
+			bf->array_len = i;
+			goto no_mem;
+		}
+		memset(en, 0, sizeof(struct name_entry));
+
+		en->btf_type_offset = (void *)tp - type_start;
+		en->id = i + 1;
+		en->bf = bf;
+		if (tp->name_off) {
+			en->name = get_str_by_name_off(bf, tp->name_off);
+			if (en->name[0])
+				name_hash_install(en);
+		}
+		bf->array[i] = en;
+
+		/* Now deal with sub elements which also have a name */
+		if (btf_kind(tp->info) == BTF_KIND_ENUM ||
+		    btf_kind(tp->info) == BTF_KIND_ENUM64) {
+			scale = btf_kind(tp->info) == BTF_KIND_ENUM ?
+				sizeof(struct btf_enum) : sizeof(struct btf_enum64);
+			for (j = 0; j < btf_vlen(tp->info); j++) {
+				en = (struct name_entry *)malloc(sizeof(struct name_entry));
+				if (!en) {
+					bf->array_len = i + 1;
+					goto no_mem;
+				}
+				memset(en, 0, sizeof(struct name_entry));
+				en->id = 0;
+				en->p_id = i + 1;
+				en->p_id += btf_files_array_index == 1 ?
+					0 : btf_files_array[0]->array_len;
+				en->bf = bf;
+				en->name = get_str_by_name_off(bf,
+					*(uint32_t *)((char *)&tp[1] + j * scale));
+				// printf("%s\n", en->name);
+				name_hash_install(en);
+			}
+		}
+
+		/* Enlarge array when over 3/4 */
+		if (i > (bf->array_len >> 2) * 3) {
+			struct name_entry **tmp = (struct name_entry **)reallocarray(bf->array,
+				bf->array_len << 1, sizeof(struct name_entry *));
+			if (!tmp)
+				goto no_mem;
+			bf->array = tmp;
+			bf->array_len <<= 1;
+		}
+	}
+	bf->array_len = i;
+	return 0;
+no_mem:
+	/* All the memory free will be dealed later. */
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+out:
+	return -1;
+}
+
+/* 
+ * Used by search_name_by_cond() for searching specific type:
+ * such as struct/union/typedef
+ */
+static bool is_type(struct name_entry *sp, void *data_in, void *data_out)
+{
+	struct btf_type *bt = (struct btf_type *)data_out;
+	int type = *(int *)data_in;
+	if (sp->id) {
+		read_file_at_offset(sp->bf->file_name,
+			sp->btf_type_offset + sp->bf->types_data_offset,
+			sizeof(*bt), bt);
+		return btf_kind(bt->info) == type;
+	}
+	return false;
+}
+
+static struct name_entry *search_name_by_cond(char *name,
+			bool (*fn)(struct name_entry *, void *, void *),
+			void *data_in, void *data_out)
+{
+	unsigned int index;
+	struct name_entry *sp;
+
+	index = name_hash_index(name);
+	for (sp = name_hash_table[index]; sp; sp = sp->name_hash_next) {
+		if (!strcmp(name, sp->name) && fn(sp, data_in, data_out)) {
+			return sp;
+		}
+	}
+	return sp;
+}
+
+// caller should prepare bt
+void resolve_typedef(struct name_entry *en_in, struct name_entry **en_out,
+		     struct btf_type *bt)
+{
+	uint32_t id;
+	struct name_entry *en;
+
+	read_file_at_offset(en_in->bf->file_name,
+		en_in->btf_type_offset + en_in->bf->types_data_offset,
+		sizeof(*bt), bt);
+	if (btf_kind(bt->info) == BTF_KIND_TYPEDEF) {
+		id = bt->type;
+		get_btf_type_by_type_id(en_in->bf, id, bt, &en);
+		return resolve_typedef(en, en_out, bt);
+	} else {
+		*en_out = en_in;
+	}
+}
+
+struct cond_args {
+	int index;
+	char *name;
+};
+
+static bool cond(struct cond_args *c1, struct cond_args *c2)
+{
+	if (c1->name && c2->name)
+		/* Check if the member name is what we want */
+		return !strcmp(c1->name, c2->name);
+	else
+		/* Check if the member index is what we want */
+		return c1->index == c2->index;
+}
+
+static bool get_internal_member_info(struct name_entry *en, int base_position,
+				     int *global_index, struct cond_args *tar_arg,
+				     struct member_info *mi, bool initial_dive)
+{
+	struct btf_type bt, sub_bt;
+	int member_num;
+	char *member_array_buf = NULL;
+	int i;
+	struct btf_member *bm;
+	struct btf_array *ba;
+	int bm_position;
+	struct name_entry *sub_en;
+	bool res;
+	struct cond_args cur_arg = {0};
+
+	read_file_at_offset(en->bf->file_name,
+		en->btf_type_offset + en->bf->types_data_offset,
+		sizeof(bt), &bt); // this struct 
+	if (initial_dive ||
+	    ((!en->name || en->name[0] == '\0') &&
+	     ((btf_kind(bt.info) == BTF_KIND_STRUCT) ||
+	      (btf_kind(bt.info) == BTF_KIND_UNION)))) {
+		/* anonymous struct/union, dive into */
+		member_num = btf_vlen(bt.info);
+		member_array_buf = calloc(member_num, sizeof(struct btf_member));
+		if (!member_array_buf) {
+			fprintf(stderr, "%s: Not enough memory!\n", __func__);
+			return false;
+		}
+		read_file_at_offset(en->bf->file_name,
+			en->btf_type_offset + en->bf->types_data_offset + sizeof(bt),
+			member_num *sizeof(struct btf_member), member_array_buf);
+		for (i = 0, bm = (struct btf_member *)member_array_buf;
+		i < member_num; i++) {
+			if (btf_kind_flag(bt.info)) {
+				bm_position = base_position +
+					btf_member_bit_offset(bm[i].offset);
+				mi->bits = btf_member_bitfield_size(bm[i].offset);
+			} else {
+				bm_position = base_position +
+					bm[i].offset;
+			}
+			mi->sname = get_str_by_name_off(en->bf, bm[i].name_off);
+			get_btf_type_by_type_id(en->bf, bm[i].type,
+						&sub_bt, &sub_en);
+			// Dive into this member
+			res = get_internal_member_info(sub_en, bm_position, global_index,
+						tar_arg, mi, false);
+			if (res) {
+				free(member_array_buf);
+				return res;
+			}			
+		}
+		free(member_array_buf);
+		return false;
+	}
+
+	cur_arg.index = *global_index;
+	cur_arg.name = mi->sname;
+	if (cond(&cur_arg, tar_arg)) {
+		mi->bit_pos = base_position;
+		resolve_typedef(en, &sub_en, &bt);
+		mi->uniq_id = id_to_uniq_id(sub_en->id, sub_en->bf);
+		if (btf_kind(bt.info) == BTF_KIND_PTR) {
+			/* 
+			 * BUG? No pointer size in btf,
+			 * 32bit btf target on 64bit machine
+			 */
+			mi->size = sizeof(void *);
+			mi->type = "char *";
+		} else if (btf_kind(bt.info) == BTF_KIND_ARRAY) {
+			en = sub_en;
+			ba = (struct btf_array *)malloc(sizeof(struct btf_array));
+			if (!ba) {
+				fprintf(stderr, "%s: Not enough memory!\n", __func__);
+				return false;
+			}
+			read_file_at_offset(en->bf->file_name,
+				en->btf_type_offset + en->bf->types_data_offset + sizeof(bt),
+				sizeof(struct btf_array), ba);
+			mi->size = ba->nelems; // array elements
+			get_btf_type_by_type_id(en->bf, ba->type, &sub_bt, &sub_en);
+			resolve_typedef(sub_en, &en, &bt);
+			free(ba);
+			mi->size *= bt.size; // element size
+			mi->type = NULL; // "char [64]? Leave it NULL for now"
+		} else {
+			mi->size = bt.size;
+			mi->type = get_str_by_name_off(sub_en->bf, bt.name_off);
+		}
+		return true;
+	} else {
+		(*global_index)++;
+		return false;
+	}
+}
+
+static bool get_member_info_by_index(struct name_entry *en, int target_index,
+				     struct member_info *mi)
+{
+	int g_index = 1;
+	struct cond_args args = {0};
+	args.index = target_index;
+	memset(mi, 0, sizeof(*mi));
+	return get_internal_member_info(en, 0, &g_index, &args, mi, true);
+}
+
+static bool get_member_info_by_member_name(struct name_entry *en, char *member_name,
+					   struct member_info *mi)
+{
+	int g_index = 1;
+	struct cond_args args = {0};
+	args.name = member_name;
+	memset(mi, 0, sizeof(*mi));
+	return get_internal_member_info(en, 0, &g_index, &args, mi, true);
+}
+
+/* 
+ * Entry for query struct members
+ * Return: struct size, mi_out: member details
+ */
+uint32_t get_struct_member_by_name(char *struct_name, char *member_name,
+				   struct member_info *mi_out)
+{
+	struct name_entry *en;
+	struct btf_type bt = {0};
+	int type = BTF_KIND_STRUCT;
+
+	en = search_name_by_cond(struct_name, is_type, (void *)&type, (void *)&bt);
+	if (!en)
+		goto out;	
+	if (get_member_info_by_member_name(en, member_name, mi_out))
+		return bt.size;
+out:
+	return 0;
+}
+
+/* 
+ * Entry for query type members, similar as above
+ * Return: found-the-type, mi_out: member details
+ */
+static uint32_t uniq_id_to_id(uint32_t, struct btf_file **);
+bool get_type_member_by_index(uint64_t type_uniq_id, int member_index,
+			      struct member_info *mi_out)
+{
+	uint32_t id;
+	struct btf_file *bf;
+
+	id = uniq_id_to_id((uint32_t)type_uniq_id, &bf);
+	return get_member_info_by_index(bf->array[id - 1], member_index, mi_out);
+}
+
+uint32_t id_to_uniq_id(uint32_t id, struct btf_file *bf)
+{
+	int i;
+	uint32_t uniq_id = 0;
+	for (i = 0; i < btf_files_array_index; i++) {
+		if (btf_files_array[i] != bf)
+			uniq_id += btf_files_array[i]->array_len;
+		else
+			return id + uniq_id;
+	}
+	__builtin_unreachable();
+	assert(false);
+}
+
+static uint32_t uniq_id_to_id(uint32_t uid, struct btf_file **bf)
+{
+	int i;
+	
+	for (i = 0; i < btf_files_array_index; i++) {
+		if (uid > btf_files_array[i]->array_len) {
+			uid -= btf_files_array[i]->array_len;
+		} else {
+			if (bf)
+				*bf = btf_files_array[i];
+			return uid;
+		}
+
+	}
+	__builtin_unreachable();
+	assert(false);
+}
+
+// api for eppic
+uint32_t get_type_size_by_name(char *type_name, int type, uint32_t *uniq_id)
+{
+	struct name_entry *en;
+	struct btf_type bt = {0};
+
+	en = search_name_by_cond(type_name, is_type, (void *)&type, (void *)&bt);
+	if (!en)
+		goto out;
+	if (uniq_id)
+		*uniq_id = id_to_uniq_id(en->id, en->bf);
+	return bt.size;
+out:
+	return 0;	
+}
+
+// Caller should prepare bt_out
+struct name_entry *get_en_by_uniq_id(uint32_t uniq_id, struct btf_type *bt_out)
+{
+	uint32_t id;
+	struct btf_file *bf;
+	struct name_entry *en;
+	struct name_entry *en_sub;
+
+	id = uniq_id_to_id((uint32_t)uniq_id, &bf);
+	en = bf->array[id - 1];
+	resolve_typedef(en, &en_sub, bt_out);
+	return en_sub;
+}
+
+/* Deal with btf file */
+static int btf_file_init(int fd)
+{
+	struct stat f_stat;
+	char *buf = NULL;
+	char proc_path[32];
+	char real_path[512];
+	int ret = -1;
+
+	memset(real_path, 0, sizeof(real_path));
+	if (fstat(fd, &f_stat) < 0) {
+		fprintf(stderr, "%s: fstat fail!\n", __func__);
+		goto out;
+	}
+	buf = malloc(f_stat.st_size);
+	if (!buf) {
+		fprintf(stderr, "%s: Not enough memory!\n", __func__);
+		goto out;
+	}
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/self/fd/%d", fd);
+	readlink(proc_path, real_path, sizeof(real_path) - 1);
+	if (read_file_at_offset(real_path, 0, f_stat.st_size, buf) < 0)
+		goto out;
+
+	ret = parse_btf_data(real_path, buf, f_stat.st_size);
+out:
+	if (buf)
+		free(buf);
+	return ret;
+}
+
+/* Deal with elf file which contains .BTF section */
+static int elf_file_init(int fd)
+{
+	char proc_path[32];
+	char real_path[512];
+	Elf *elf = NULL;
+	Elf_Scn *scn = NULL;
+	size_t shstrndx;
+	GElf_Shdr shdr;
+	Elf_Data *data = NULL;
+	char *str, *databuf = NULL;
+	int ret = -1;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/self/fd/%d", fd);
+	readlink(proc_path, real_path, sizeof(real_path) - 1);
+
+	if (elf_version(EV_CURRENT) == EV_NONE)
+		goto elf_err;
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (!elf || elf_getshdrstrndx(elf, &shstrndx))
+		goto elf_err;
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		if (!gelf_getshdr(scn, &shdr))
+			continue;
+		str = elf_strptr(elf, shstrndx, shdr.sh_name);
+		if (!strcmp(str, ".BTF"))
+			break;
+	}
+	if (!scn) {
+		fprintf(stderr, "%s: No .BTF found in %s!\n", __func__, real_path);
+		goto out;
+	}
+
+	data = elf_rawdata(scn, data);
+	databuf = malloc(data->d_size);
+	if (!databuf) {
+		fprintf(stderr, "%s: Not enough memory!\n", __func__);
+		goto out;
+	}
+	memcpy(databuf, data->d_buf, data->d_size);
+	elf_end(elf);
+	elf = NULL;
+	ret = parse_btf_data(real_path, databuf, data->d_size);
+	goto out;
+
+elf_err:
+	fprintf(stderr, "%s: elf error in %s!\n", __func__, real_path);
+out:
+	if (databuf)
+		free(databuf);
+	if (elf)
+		elf_end(elf);
+	return ret;
+}
+
+/*
+ * Entry for parse btf file and elf file.
+ */
+static int file_init(char *name)
+{
+	int fd = 0, ret = -1;
+	char buf[4] = {0};
+
+	/* Will be enlarged automatically */
+	if (!btf_files_array) {
+		btf_files_array = calloc(1, sizeof(struct btf_file *));
+		if (!btf_files_array) {
+			fprintf(stderr, "%s: Not enough memory!\n", __func__);
+			goto out;
+		}
+	}
+	
+	fd = open(name, O_RDONLY);
+	if (read_file_at_offset(name, 0, sizeof(buf), buf) < 0)
+		goto out;
+	if (*(u_int16_t *)&buf == BTF_MAGIC) {
+		ret = btf_file_init(fd);
+	} else if (*(u_int32_t *)&buf == (((u_int32_t)ELFMAG0 << 24) | 
+					  ((u_int32_t)ELFMAG1 << 16) |
+					  ((u_int32_t)ELFMAG2 << 8)  |
+					  ((u_int32_t)ELFMAG3 << 0))) {
+		ret = elf_file_init(fd);
+	} else {
+		__builtin_unreachable();
+	}
+
+out:
+	if (fd)
+		close(fd);
+	return ret;
+}
+
+/* For pure buffer data, wrap it as a file, and handover to file_init() */
+char temp[] = "/tmp/btf_XXXXXX";
+static int init_btf_from_buf(char *mod_name, char *buf, int size)
+{
+	int fd;
+	char name_buf[64];
+	int w, got = 0;
+	static char *temp_dir = NULL;
+
+	if (!temp_dir)
+		temp_dir = mkdtemp(temp);
+	snprintf(name_buf, sizeof(name_buf), "%s/%s", temp_dir, mod_name);
+	fd = open(name_buf, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
+	if (fd < 0) {
+		fprintf(stderr, "%s: open fail in %s!\n", __func__, name_buf);
+		return -1;
+	}
+
+	while (got < size) {
+		w = pwrite(fd, buf + got, size - got, got);
+		if (w < 0) {
+			fprintf(stderr, "%s: pwrite fail in %s!\n", __func__, name_buf);
+			return -1;
+		}
+		got += w;
+	}
+	close(fd);
+	return file_init(name_buf);
+}
+
+int init_kernel_btf(void)
+{
+	uint64_t size;
+	char *buf;
+	int ret;
+
+	uint64_t start_btf = get_kallsyms_value_by_name("__start_BTF");
+	uint64_t stop_btf = get_kallsyms_value_by_name("__stop_BTF");
+	if (!start_btf || !stop_btf) {
+		fprintf(stderr, "%s: symbol __start/stop_BTF not found!\n", __func__);
+		return -1;
+	}
+
+	size = stop_btf - start_btf;
+	buf = (char *)malloc(size);
+	if (!buf) {
+		fprintf(stderr, "%s: Not enough memory!\n", __func__);
+		return -1;
+	}
+	readmem(VADDR, start_btf, buf, size);
+	ret = init_btf_from_buf("vmlinux", buf, size);
+	free(buf);
+
+	return ret;
+}
+
+int init_module_btf(void)
+{
+	uint64_t btf_modules, list;
+	struct member_info mi;
+	uint64_t btf = 0, data = 0, module = 0;
+	int data_size = 0;
+	char *btf_buf = NULL;
+	char *modname = NULL;
+
+	btf_modules = get_kallsyms_value_by_name("btf_modules");
+	if (!btf_modules)
+		/* Maybe module is not enabled, this is not an error */
+		return 0;
+
+	INIT_MEMBER_OFF_SIZE(btf_module, list);
+	INIT_MEMBER_OFF_SIZE(btf_module, btf);
+	INIT_MEMBER_OFF_SIZE(btf_module, module);
+	INIT_MEMBER_OFF_SIZE(module, name);
+	INIT_MEMBER_OFF_SIZE(btf, data);
+	INIT_MEMBER_OFF_SIZE(btf, data_size);
+	modname = (char *)malloc(GET_MEMBER_SIZE(module, name));
+	if (!modname) {
+		fprintf(stderr, "%s: Not enough memory!\n", __func__);
+		goto out;
+	}
+
+	for (list = next_list(btf_modules); list != btf_modules; list = next_list(list)) {
+		readmem(VADDR, list - GET_MEMBER_OFF(btf_module, list) +
+				GET_MEMBER_OFF(btf_module, btf),
+			&btf, GET_MEMBER_SIZE(btf_module, btf));
+		readmem(VADDR, list - GET_MEMBER_OFF(btf_module, list) +
+				GET_MEMBER_OFF(btf_module, module),
+			&module, GET_MEMBER_SIZE(btf_module, module));
+		readmem(VADDR, module + GET_MEMBER_OFF(module, name),
+			modname, GET_MEMBER_SIZE(module, name));
+		readmem(VADDR, btf + GET_MEMBER_OFF(btf, data),
+			&data, GET_MEMBER_SIZE(btf, data));		
+		readmem(VADDR, btf + GET_MEMBER_OFF(btf, data_size),
+			&data_size, GET_MEMBER_SIZE(btf, data_size));
+		btf_buf = (char *)malloc(data_size);
+		if (!btf_buf) {
+			fprintf(stderr, "%s: Not enough memory!\n", __func__);
+			goto out;
+		}
+		readmem(VADDR, data, btf_buf, data_size);
+		if (init_btf_from_buf(modname, btf_buf, data_size))
+			goto out;
+		free(btf_buf);
+	}
+	return 0;
+out:
+	if (modname)
+		free(modname);
+	if (btf_buf)
+		free(btf_buf);
+	return -1;
+}
+
+void cleanup_btf(void)
+{
+	int bf_index, i;
+	struct btf_file *bf;
+	struct name_entry *en, *en_tmp;
+	DIR *temp_dir;
+	struct dirent *entry;
+	char path[512];
+
+	/* Free no-hashtable-installed elements */
+	for (bf_index = 0; bf_index < btf_files_array_index; bf_index++) {
+		bf = btf_files_array[bf_index];
+		if (bf && bf->array) {
+			for (i = 0; i < bf->array_len; i++) {
+				if (!bf->array[i]->name || !bf->array[i]->name[0])
+					free(bf->array[i]);
+			}
+		}
+	}
+
+	/* Free the hashtable-installed elements */
+	for (i = 0; i < NAME_HASH; i++) {
+		for (en = name_hash_table[i]; en;) {
+			en_tmp = en;
+			en = en->name_hash_next;
+			free(en_tmp);
+		}
+	}
+
+	/* Cleanup anything else */
+	for (bf_index = 0; bf_index < btf_files_array_index; bf_index++) {
+		bf = btf_files_array[bf_index];
+		if (bf && bf->array) {
+			free(bf->array);
+		}
+		if (bf && bf->file_name)
+			free(bf->file_name);
+		if (bf && bf->str_cache)
+			free(bf->str_cache);
+		if (bf)
+			free(bf);
+	}
+
+	if (btf_files_array)
+		free(btf_files_array);
+	
+	/* Cleanup the dir /tmp/btf_XXXXXX */
+	temp_dir = opendir(temp);
+	if (!temp_dir)
+		return;
+	while ((entry = readdir(temp_dir)) != NULL) {
+		if (!strcmp(entry->d_name, ".") || !strcmp(entry->d_name, ".."))
+			continue;
+		snprintf(path, sizeof(path), "%s/%s", temp, entry->d_name);
+		if (remove(path)) {
+			fprintf(stderr, "%s: fail del %s!\n", __func__, path);
+			/* In case too many fail messages of files in the dir */
+			return;
+		}
+	}
+	closedir(temp_dir);
+	rmdir(temp);
+}
diff --git a/btf.h b/btf.h
new file mode 100644
index 0000000..a0d13e6
--- /dev/null
+++ b/btf.h
@@ -0,0 +1,176 @@
+#ifndef _BTF_H
+#define _BTF_H
+#include <stdint.h>
+#include <stdbool.h>
+
+typedef uint8_t  __u8;
+typedef uint16_t __u16;
+typedef uint32_t __u32;
+typedef int32_t __s32;
+
+#define BTF_MAGIC	0xeb9f
+
+enum {
+	BTF_KIND_UNKN		= 0,	/* Unknown	*/
+	BTF_KIND_INT		= 1,	/* Integer	*/
+	BTF_KIND_PTR		= 2,	/* Pointer	*/
+	BTF_KIND_ARRAY		= 3,	/* Array	*/
+	BTF_KIND_STRUCT		= 4,	/* Struct	*/
+	BTF_KIND_UNION		= 5,	/* Union	*/
+	BTF_KIND_ENUM		= 6,	/* Enumeration	*/
+	BTF_KIND_FWD		= 7,	/* Forward	*/
+	BTF_KIND_TYPEDEF	= 8,	/* Typedef	*/
+	BTF_KIND_VOLATILE	= 9,	/* Volatile	*/
+	BTF_KIND_CONST		= 10,	/* Const	*/
+	BTF_KIND_RESTRICT	= 11,	/* Restrict	*/
+	BTF_KIND_FUNC		= 12,	/* Function	*/
+	BTF_KIND_FUNC_PROTO	= 13,	/* Function Proto	*/
+	BTF_KIND_VAR		= 14,	/* Variable	*/
+	BTF_KIND_DATASEC	= 15,	/* Section	*/
+	BTF_KIND_FLOAT		= 16,	/* Floating point	*/
+	BTF_KIND_DECL_TAG	= 17,	/* Decl Tag */
+	BTF_KIND_TYPE_TAG	= 18,	/* Type Tag */
+	BTF_KIND_ENUM64	= 19,	/* Enumeration up to 64-bit values */
+
+	NR_BTF_KINDS,
+	BTF_KIND_MAX		= NR_BTF_KINDS - 1,
+};
+
+struct btf_type {
+	__u32 name_off;
+
+	/* "info" bits arrangement
+	 * bits  0-15: vlen (e.g. # of struct's members)
+	 * bits 16-23: unused
+	 * bits 24-27: kind (e.g. int, ptr, array...etc)
+	 * bits 28-30: unused
+	 * bit     31: kind_flag, currently used by
+	 *             struct, union and fwd
+	 */
+	__u32 info;
+
+	/* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
+	 * "size" tells the size of the type it is describing.
+	 *
+	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
+	 * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
+	 * "type" is a type_id referring to another type.
+	 */
+	union {
+		__u32 size;
+		__u32 type;
+	};
+};
+
+struct btf_header {
+	__u16	magic;
+	__u8	version;
+	__u8	flags;
+	__u32	hdr_len;
+
+	/* All offsets are in bytes relative to the end of this header */
+	__u32	type_off;	/* offset of type section	*/
+	__u32	type_len;	/* length of type section	*/
+	__u32	str_off;	/* offset of string section	*/
+	__u32	str_len;	/* length of string section	*/
+};
+
+struct btf_array {
+	__u32	type;
+	__u32	index_type;
+	__u32	nelems;
+};
+
+struct btf_member {
+	__u32	name_off;
+	__u32	type;
+	/* If the type info kind_flag is set, the btf_member offset
+	 * contains both member bitfield size and bit offset. The
+	 * bitfield size is set for bitfield members. If the type
+	 * info kind_flag is not set, the offset contains only bit
+	 * offset.
+	 */
+	__u32	offset;
+};
+
+struct btf_enum {
+	__u32	name_off;
+	__s32	val;
+};
+
+struct btf_enum64 {
+	__u32   name_off;
+	__u32   val_lo32;
+	__u32   val_hi32;
+};
+
+struct btf_param {
+	__u32	name_off;
+	__u32	type;
+};
+
+struct btf_var {
+	__u32	linkage;
+};
+
+struct btf_var_secinfo {
+	__u32	type;
+	__u32	offset;
+	__u32	size;
+};
+
+struct btf_decl_tag {
+	__s32   component_idx;
+};
+
+/*************************************/
+struct btf_file {
+	char *file_name;
+	char *str_cache;
+	uint32_t str_cache_len;
+	uint32_t types_data_offset;
+	uint32_t array_len;
+	struct name_entry **array;
+};
+
+struct name_entry {
+	union {
+		uint32_t btf_type_offset;
+		uint32_t p_id;
+	};
+
+	uint32_t id;
+	char *name;
+	struct btf_file *bf;
+	struct name_entry *name_hash_next;
+};
+
+struct member_info {
+	char *sname;	// member name
+	char *type;	// member type: int, long etc
+	uint32_t bit_pos;	// member position in bits
+	uint32_t bits;	// member width in bits
+	uint32_t size;	// member size in bytes
+	int uniq_id;	// uniq_id of btf
+};
+
+/*************************************/
+
+int init_kernel_btf(void);
+uint32_t get_struct_member_by_name(char *, char *, struct member_info *);
+bool get_type_member_by_index(uint64_t, int, struct member_info *);
+uint32_t get_type_size_by_name(char *, int, uint32_t *);
+struct name_entry *get_en_by_uniq_id(uint32_t, struct btf_type *);
+void resolve_typedef(struct name_entry *, struct name_entry **, struct btf_type *);
+int get_btf_type_by_type_id(struct btf_file *, uint32_t,
+			    struct btf_type *, struct name_entry **);
+uint32_t id_to_uniq_id(uint32_t, struct btf_file *);
+int init_module_btf(void);
+void cleanup_btf(void);
+
+static inline uint32_t btf_kind(uint32_t info)
+{
+	return (info & 0x1F000000) >> 24;
+}
+
+#endif /* _BTF_H */
diff --git a/kallsyms.c b/kallsyms.c
new file mode 100644
index 0000000..89f6bfa
--- /dev/null
+++ b/kallsyms.c
@@ -0,0 +1,371 @@
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <assert.h>
+#include "makedumpfile.h"
+#include "kallsyms.h"
+#include "btf.h"
+
+static uint32_t *kallsyms_offsets = NULL;
+static uint16_t *kallsyms_token_index = NULL;
+static uint8_t  *kallsyms_token_table = NULL;
+static uint8_t  *kallsyms_names = NULL;
+static unsigned long kallsyms_relative_base = 0;
+static unsigned int kallsyms_num_syms = 0;
+
+#define NAME_HASH 512
+static struct syment *symtable = NULL;
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
+static void *get_syment_next(void *entry)
+{
+	return ((struct syment *)entry)->name_hash_next;
+}
+
+static void set_syment_next(void *entry, void *next)
+{
+	((struct syment *)entry)->name_hash_next = next;
+}
+
+static unsigned int name_hash_index(char *name)
+{
+	return hash_index(name, NAME_HASH);
+}
+
+static void name_hash_install(struct syment *en)
+{
+	hash_install((void **)name_hash_table, NAME_HASH, en, en->name,
+		     get_syment_next, set_syment_next);
+}
+
+struct syment *search_kallsyms_by_name(char *name)
+{
+	unsigned int index;
+	struct syment *sp;
+
+	index = name_hash_index(name);
+	for (sp = name_hash_table[index]; sp; sp = sp->name_hash_next) {
+		if (!strcmp(name, sp->name)) {
+			return sp;
+		}
+	}
+	return sp;	
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
+#define BUFLEN 512
+int parse_kernel_kallsyms(void)
+{
+	char buf[BUFLEN];
+	int len = 0;
+	int index = 0, i;
+	uint8_t *compressd_data;
+	uint8_t *uncompressd_data;
+	uint64_t stext;
+
+	symtable = calloc(kallsyms_num_syms, sizeof(struct syment));
+	if (!symtable)
+		goto no_mem;
+
+	for (i = 0; i < kallsyms_num_syms; i++) {
+		memset(buf, 0, BUFLEN);
+		len = kallsyms_names[index++];
+		compressd_data = &kallsyms_names[index];
+		index += len;
+		while (len--) {
+			uncompressd_data = &kallsyms_token_table[kallsyms_token_index[*compressd_data]];
+			assert(strlen(buf) + strlen((char *)uncompressd_data) < BUFLEN);
+			strcat(buf, (char *)uncompressd_data);
+			compressd_data++;
+		}
+		symtable[i].value = kallsyms_offsets[i];
+		symtable[i].type = buf[0];
+		symtable[i].name = strdup(&buf[1]);
+		if (!symtable[i].name)
+			goto no_mem;
+		name_hash_install(&symtable[i]);
+	}
+
+	/* Now refresh the absolute each kallsyms address */
+	stext = get_kallsyms_value_by_name("_stext");
+	if (SYMBOL(_stext) == absolute_percpu(kallsyms_relative_base, stext)) {
+		for (i = 0; i < kallsyms_num_syms; i++) {
+			symtable[i].value = absolute_percpu(kallsyms_relative_base,
+							symtable[i].value);
+		}
+	} else if (SYMBOL(_stext) == kallsyms_relative_base + stext) {
+		for (i = 0; i < kallsyms_num_syms; i++) {
+			symtable[i].value += kallsyms_relative_base;
+		}
+	} else {
+		fprintf(stderr, "%s: Wrong calculate kallsyms symbol value!\n", __func__);
+		goto out;
+	}
+
+	return 0;
+no_mem:
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+out:
+	return -1;
+}
+
+static bool vmcore_info_ready = false;
+
+int read_vmcoreinfo_kallsyms(void)
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
+int init_kernel_kallsyms(void)
+{
+	const int token_index_size = (UINT8_MAX + 1) * sizeof(uint16_t);
+	uint64_t last_token, len;
+	char data;
+	int i;
+	int ret = -1;
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
+			printf("BUG! long sym name");
+			goto out;
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
+
+uint64_t next_list(uint64_t list)
+{
+	static int list_head_next_offset = 0;
+	static int list_head_next_size = 0;
+
+	struct member_info mi;
+	uint64_t next = 0;
+
+	if (!list_head_next_size) {
+		get_struct_member_by_name("list_head", "next", &mi);
+		list_head_next_size = mi.size;
+		list_head_next_offset = mi.bit_pos / 8;
+	}
+	readmem(VADDR, list + list_head_next_offset, &next, list_head_next_size);
+	return next;
+}
+
+int init_module_kallsyms(void)
+{
+	struct member_info mi;
+	uint64_t modules, list, value = 0, symtab = 0, 
+		strtab = 0, typetab = 0;
+	uint32_t st_name = 0;
+	int num_symtab, i, j;
+	struct syment *mod_syment;
+	char symname[512], ch;
+	int ret = -1;
+
+	modules = get_kallsyms_value_by_name("modules");
+	if (!modules) {
+		/* Not a failure if no module enabled */
+		ret = 0;
+		goto out;
+	}
+
+	INIT_MEMBER_OFF_SIZE(module, list);
+	INIT_MEMBER_OFF_SIZE(module, core_kallsyms);
+	INIT_MEMBER_OFF_SIZE(mod_kallsyms, symtab);
+	INIT_MEMBER_OFF_SIZE(mod_kallsyms, num_symtab);
+	INIT_MEMBER_OFF_SIZE(mod_kallsyms, strtab);
+	INIT_MEMBER_OFF_SIZE(mod_kallsyms, typetab);
+	INIT_MEMBER_OFF_SIZE(elf64_sym, st_name);
+	INIT_MEMBER_OFF_SIZE(elf64_sym, st_value);
+
+	for (list = next_list(modules); list != modules; list = next_list(list)) {
+		readmem(VADDR, list - GET_MEMBER_OFF(module, list) +
+				GET_MEMBER_OFF(module, core_kallsyms) +
+				GET_MEMBER_OFF(mod_kallsyms, num_symtab),
+			&num_symtab, GET_MEMBER_SIZE(mod_kallsyms, num_symtab));
+		readmem(VADDR, list - GET_MEMBER_OFF(module, list) +
+				GET_MEMBER_OFF(module, core_kallsyms) +
+				GET_MEMBER_OFF(mod_kallsyms, symtab),
+			&symtab, GET_MEMBER_SIZE(mod_kallsyms, symtab));
+		readmem(VADDR, list - GET_MEMBER_OFF(module, list) +
+				GET_MEMBER_OFF(module, core_kallsyms) +
+				GET_MEMBER_OFF(mod_kallsyms, strtab),
+			&strtab, GET_MEMBER_SIZE(mod_kallsyms, strtab));
+		readmem(VADDR, list - GET_MEMBER_OFF(module, list) +
+				GET_MEMBER_OFF(module, core_kallsyms) +
+				GET_MEMBER_OFF(mod_kallsyms, typetab),
+			&typetab, GET_MEMBER_SIZE(mod_kallsyms, typetab));
+		for (i = 0; i < num_symtab; i++) {
+			j = 0;
+			readmem(VADDR, symtab + i * GET_STRUCT_SIZE(elf64_sym, st_value) +
+					GET_MEMBER_OFF(elf64_sym, st_value),
+				&value, GET_MEMBER_SIZE(elf64_sym, st_value));
+			readmem(VADDR, symtab + i * GET_STRUCT_SIZE(elf64_sym, st_name) +
+					GET_MEMBER_OFF(elf64_sym, st_name),
+				&st_name, GET_MEMBER_SIZE(elf64_sym, st_name));
+			do {
+				readmem(VADDR, strtab + st_name + j++, &ch, 1);
+			} while (ch != '\0');
+			if (j == 1)
+				/* Skip empty string */
+				continue;
+			assert(j <= sizeof(symname));
+			mod_syment = (struct syment *)calloc(1, sizeof(struct syment));
+			if (!mod_syment)
+				goto no_mem;
+			readmem(VADDR, strtab + st_name, symname, j);
+			mod_syment->name = strdup(symname);
+			if (!mod_syment->name) {
+				free(mod_syment);
+				goto no_mem;
+			}
+			mod_syment->value = value;
+			readmem(VADDR, typetab + i, &mod_syment->type, 1);
+			name_hash_install(mod_syment);
+		}	
+	}
+	ret = 0;
+	goto out;
+no_mem:
+	/* Hashtable will be cleaned later */
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+out:
+	return ret;
+}
+
+void cleanup_kallsyms(void)
+{
+	struct syment *en, *en_tmp;
+	int i;
+
+	/* Free the module's kallsyms first */
+	for (i = 0; i < NAME_HASH; i++) {
+		for (en = name_hash_table[i]; en;) {
+			en_tmp = en;
+			en = en->name_hash_next;
+			if (en_tmp <= &symtable[kallsyms_num_syms - 1] &&
+			    en_tmp >= &symtable[0])
+				continue;
+			free(en_tmp->name);
+			free(en_tmp);
+		}
+	}
+	
+	/* Free the kernel ones */
+	for (i = 0; i < kallsyms_num_syms; i++) {
+		if (symtable[i].name)
+			free(symtable[i].name);
+	}
+	free(symtable);
+}
+
+/* Hash table utils */
+unsigned int hash_index(const char *name, unsigned int hash_size)
+{
+	unsigned int len, value;
+
+	len = strlen(name);
+	value = name[len - 1] * name[len / 2];
+
+	return (name[0] ^ value) % hash_size;
+}
+
+void hash_install(void **hash_table, unsigned int hash_size,
+		  void *entry, const char *name,
+		  void *(*get_next)(void *),
+		  void (*set_next)(void *, void *))
+{
+	unsigned int index = hash_index(name, hash_size);
+	void *sp = hash_table[index];
+
+	assert(index < hash_size);
+	if (sp == NULL) {
+		hash_table[index] = entry;
+	} else {
+		while (sp) {
+			if (get_next(sp)) {
+				sp = get_next(sp);
+			} else {
+				set_next(sp, entry);
+				break;
+			}
+		}
+	}
+}
\ No newline at end of file
diff --git a/kallsyms.h b/kallsyms.h
new file mode 100644
index 0000000..96ea970
--- /dev/null
+++ b/kallsyms.h
@@ -0,0 +1,42 @@
+#ifndef _KALLSYMS_H
+#define _KALLSYMS_H
+
+#include <stdint.h>
+
+struct syment {
+	uint64_t value;
+	char *name;
+	struct syment *name_hash_next;
+	char type;
+};
+
+int init_kernel_kallsyms(void);
+int read_vmcoreinfo_kallsyms(void);
+int parse_kernel_kallsyms(void);
+struct syment *search_kallsyms_by_name(char *);
+uint64_t next_list(uint64_t);
+uint64_t get_kallsyms_value_by_name(char *);
+int init_module_kallsyms(void);
+void cleanup_kallsyms(void);
+int read_vmcoreinfo_kallsyms(void);
+
+struct member_off_size {
+	int m_off;
+	int m_size;
+	int s_size;
+};
+#define QUATE(x) #x
+#define INIT_MEMBER_OFF_SIZE(S, M) \
+	struct member_off_size S##_##M; \
+	S##_##M.s_size = get_struct_member_by_name(QUATE(S), QUATE(M), &mi); \
+	S##_##M.m_off = mi.bit_pos / 8; \
+	S##_##M.m_size = mi.size;
+#define GET_MEMBER_OFF(S, M) (S##_##M.m_off)
+#define GET_MEMBER_SIZE(S, M) (S##_##M.m_size)
+#define GET_STRUCT_SIZE(S, M) (S##_##M.s_size)
+
+unsigned int hash_index(const char *, unsigned int);
+void hash_install(void **, unsigned int, void *, const char *,
+		void *(*)(void *), void (*)(void *, void *));
+
+#endif /* _KALLSYMS_H */
\ No newline at end of file
diff --git a/makedumpfile.c b/makedumpfile.c
index 33fad32..cdfcfeb 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -27,6 +27,7 @@
 #include <limits.h>
 #include <assert.h>
 #include <zlib.h>
+#include "kallsyms.h"
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -3103,6 +3104,8 @@ read_vmcoreinfo_from_vmcore(off_t offset, unsigned long size, int flag_xen_hv)
 		if (!read_vmcoreinfo())
 			goto out;
 	}
+	read_vmcoreinfo_kallsyms();
+
 	close_vmcoreinfo();
 
 	ret = TRUE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 944397a..cc474ad 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -257,6 +257,7 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
 #define UINT(ADDR)	*((unsigned int *)(ADDR))
 #define ULONG(ADDR)	*((unsigned long *)(ADDR))
 #define ULONGLONG(ADDR)	*((unsigned long long *)(ADDR))
+#define VOID_PTR(ADDR)  *((void **)(ADDR))
 
 
 /*
@@ -1917,6 +1918,16 @@ struct symbol_table {
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


