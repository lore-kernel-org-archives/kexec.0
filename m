Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83F5D2ED13
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 03:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z0PEO7XnFjUoge5CuSA9Qah4eFYfNkmemnZ5qE746gg=; b=Ibc9cDk6nyHwwb4lHZs10K6F5f
	rQ7TZIRXh5CvyL8LzKhxALAMoSCIQE5xyZp5G4bRIqYrOBin8rr+GmdJG4jwvlot+NG9yMZBBTyH0
	KligSVFrhbJxKgheY4fJrxRUlOqwD1tXK/r/5YPS8/GgLrihBEIri3rLQ4ycYRfptCQgulFYImWDF
	zih6PjECcRVzj27lobEfYtYGCUx1A/hmLX4UFm9frktB990wP6QnuZMj1IeFxgu0IQQvS9tXIonIX
	wWsqpkN6T6tfv3v3TZ3W4GbmdRV3bHw13EGbre6TmpnURJQ2OWT3w64pSmsiN3ubC8kbhMSXp+Ajc
	FzPvQYhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aW-0000000383L-2Odc;
	Tue, 20 Jan 2026 03:39:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aU-0000000381P-1Kj2
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 03:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768880365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0PEO7XnFjUoge5CuSA9Qah4eFYfNkmemnZ5qE746gg=;
	b=XZh1kHeVn58phQMKJ51yfcJKUz4cpUvwvJrTJ0rF7wtWB2HmZGr7J0WNflJvozi0A1UYve
	dMcjuEXIpmKgN+ZHzPkRsKfO0K0tpGY0vsWs9IO1IJSa+7rvS3/fmro/3xzMQD5HNz7NsL
	C2oDKRBjHAEiWE1PU9bXKb/1ngE1wAs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-8KIBa8zhOpOsJa4-cjsvSw-1; Mon, 19 Jan 2026 22:39:21 -0500
X-MC-Unique: 8KIBa8zhOpOsJa4-cjsvSw-1
X-Mimecast-MFC-AGG-ID: 8KIBa8zhOpOsJa4-cjsvSw_1768880360
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34eff656256so4485032a91.2
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 19:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880360; x=1769485160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0PEO7XnFjUoge5CuSA9Qah4eFYfNkmemnZ5qE746gg=;
        b=L5Ne9Nct/O3Svq0S8EURrQBmJiDVx4cViYhAe4hWEA0N9neBJnGE933whbD3ih+MLT
         AoaoPNO2GN/Kxfz/QYC/eRzjjI24E5f3mCOGrvZDwmE9YyCFgp6SSXWtUR0ot8eo9rOD
         vy0Li4aMz1NCXL+QYGPcW2FjECg4tzEoujBvYPOnHRlY6/VWaec27czlbQlY+l6PbxZP
         FNqdNCvY9mnTIvHRH6shixjZVJT4uryznqW8XI7HqBQKMMI5NkFXxbil3g8TmteNQPM0
         sieBra6g68YsoNi+Kto77YYn3GJ5rj8WejaO7vlrWNEIEEJShYlWE62qFOH2Z8oz0nEN
         0uqw==
X-Forwarded-Encrypted: i=1; AJvYcCVxngXHBhuLqjIbij0jJpujywzgXscI1Fqo9U+QfpqNmKkaxr+f5g8Xh6a6GORisSehaQQpdQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxdoOCDb5JoxyG7MqmAHSrr6sr+s07g0X8WtUTP4Bl+YQIqNqXV
	nf4iVBJWysJ6+xtJN3bh9QVZVfJMsb2hVkl8euKCCl6NxQhRWB+y20qKIUkRabOvETlSrF1C+UI
	bOCE/YNfdvCLsSBQmR+r/LNIucBVCzsEcdAs6evxKKAywZELQYATevWHse7WKgQ==
X-Gm-Gg: AZuq6aIMICf3GQZuOtLNMv2Y4sLOyQWyr5VeBZa9c2f7LURXKs63GqE2n7UybGklxFu
	h3LI5NsX+uj6f5r2tBiYVUpEw8wkGew5TOoRb8j3R6+1GNOaDRclpd/+SYIELIdtiCApu09FFBj
	Y82qMTCOmqhk46YO8M5R1J8mQlhGsZIgzly5N573k6lPl8FrGV3A5yGbDTCpv5yRXL5//IWGgCq
	8jTq7UVCRBSvtsDe5YtaiLWYTKkchnPXrEpH/HHLpVjTY/c92tHdTvnxXUPOtrH52ZbhZPj9cPq
	cd8Brlmtb4u3bKjN86NyjDZuLhuAy/dGHCLbDPwqc4PJPXE6FLrc12FOy3MuHXNLp8u5ymFCsDA
	+QRCF//di3G1ImLdnug==
X-Received: by 2002:a17:90b:4a0b:b0:340:54a1:d6fe with SMTP id 98e67ed59e1d1-35273166396mr11860684a91.15.1768880360318;
        Mon, 19 Jan 2026 19:39:20 -0800 (PST)
X-Received: by 2002:a17:90b:4a0b:b0:340:54a1:d6fe with SMTP id 98e67ed59e1d1-35273166396mr11860667a91.15.1768880359890;
        Mon, 19 Jan 2026 19:39:19 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm13375935a91.13.2026.01.19.19.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:39:19 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3 2/8] Implement kernel btf resolving
Date: Tue, 20 Jan 2026 15:54:54 +1300
Message-ID: <20260120025500.25095-3-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260120025500.25095-1-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ym5kOOW6ON1spmGaTTl73SI-8l3xxO7P6B9iS5A_mYU_1768880360
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_193926_438214_1B6AA209 
X-CRM114-Status: GOOD (  25.04  )
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

This patch will parse kernel's btf data using libbpf. The kernel's btf data is
located between __start_BTF and __stop_BTF symbols which are resolved by kallsyms
of the previous patch. The primary function implemented in this patch, is
recursively diving into anonymous struct/union when encountered any, to find a
member by given its name.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile   |   4 +-
 btf_info.c | 186 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_info.h |  64 ++++++++++++++++++
 3 files changed, 252 insertions(+), 2 deletions(-)
 create mode 100644 btf_info.c
 create mode 100644 btf_info.h

diff --git a/Makefile b/Makefile
index 6c450ac..f3f4da8 100644
--- a/Makefile
+++ b/Makefile
@@ -45,12 +45,12 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
 
-LIBS = -ldw -lbz2 -ldl -lelf -lz
+LIBS = -ldw -lbz2 -ldl -lelf -lz -lbpf
 ifneq ($(LINKTYPE), dynamic)
 LIBS := -static $(LIBS) -llzma
 endif
diff --git a/btf_info.c b/btf_info.c
new file mode 100644
index 0000000..e7f8d9a
--- /dev/null
+++ b/btf_info.c
@@ -0,0 +1,186 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf_legacy.h>
+#include "makedumpfile.h"
+#include "kallsyms.h"
+#include "btf_info.h"
+
+struct btf_arr_elem {
+	struct btf *btf;
+	char *module;
+};
+
+static struct btf_arr_elem* btf_arr = NULL;
+static int btf_arr_len = 0;
+static int btf_arr_cap = 0;
+
+static bool find_member_recursive(struct btf *btf,
+				int struct_typeid,
+				int base_offset,
+				char *member_name,
+				uint32_t *out_bit_offset,
+				uint32_t *out_bit_sz,
+				uint32_t *out_member_size)
+{
+	const struct btf_type *st;
+	struct btf_member *bm;
+	int i, vlen;
+
+	struct_typeid = btf__resolve_type(btf, struct_typeid);
+	st = btf__type_by_id(btf, struct_typeid);
+
+	if (!st)
+		return false;
+
+	if (BTF_INFO_KIND(st->info) != BTF_KIND_STRUCT &&
+	    BTF_INFO_KIND(st->info) != BTF_KIND_UNION)
+		return false;
+
+	vlen = BTF_INFO_VLEN(st->info);
+	bm = btf_members(st);
+
+	for (i = 0; i < vlen; i++, bm++) {
+		const char *name = btf__name_by_offset(btf, bm->name_off);
+		int member_bit_offset = btf_member_bit_offset(st, i) + base_offset;
+		int member_typeid = btf__resolve_type(btf, bm->type);
+		const struct btf_type *mt = btf__type_by_id(btf, member_typeid);
+
+		if (name && strcmp(name, member_name) == 0) {
+			*out_bit_offset = member_bit_offset;
+			*out_bit_sz = btf_member_bitfield_size(st, i);
+			*out_member_size = btf__resolve_size(btf, member_typeid);
+			return true;
+		}
+
+		if (!name || !name[0]) {
+			if (BTF_INFO_KIND(mt->info) == BTF_KIND_STRUCT ||
+			    BTF_INFO_KIND(mt->info) == BTF_KIND_UNION) {
+				if (find_member_recursive(btf, member_typeid,
+								member_bit_offset,
+								member_name,
+								out_bit_offset,
+								out_bit_sz,
+								out_member_size))
+					return true;
+			}
+		}
+	}
+	return false;
+}
+
+bool get_struct_member_by_name(struct struct_member_info *smi)
+{
+	int i, j, start_id;
+	char *fmt;
+
+	for (i = 0; i < btf_arr_len; i++) {
+		if (smi->modname != NULL) {
+			if (strcmp(smi->modname, btf_arr[i].module) != 0)
+				continue;
+		}
+		/*
+		 * vmlinux(btf_arr[0])'s typeid is 1~vmlinux_type_cnt,
+		 * modules(btf_arr[1...])'s typeid is vmlinux_type_cnt~btf__type_cnt
+		 */
+		start_id = (i == 0 ? 1 : btf__type_cnt(btf_arr[0].btf));
+
+		for (j = start_id; j < btf__type_cnt(btf_arr[i].btf); j++) {
+			const struct btf_type *bt = btf__type_by_id(btf_arr[i].btf, j);
+			const char *name = btf__name_by_offset(btf_arr[i].btf, bt->name_off);
+
+			if (name && strcmp(smi->struct_name, name) == 0) {
+				if (smi->member_name != NULL) {
+					/* Retrieve member info */
+					if (!find_member_recursive(btf_arr[i].btf, j,
+								0,
+								smi->member_name,
+								&(smi->member_bit_offset),
+								&(smi->member_bit_sz),
+								&(smi->member_size))) {
+						fprintf(stderr, "%s: Not find member %s in %s\n",
+							__func__, smi->struct_name,
+							smi->member_name);						
+						return false;
+					}
+				}
+				smi->struct_size = btf__resolve_size(btf_arr[i].btf, j);
+				return true;
+			}
+		}
+	}
+	fmt = smi->modname ?
+		"%s: Not find struct/union %s in %s\n" :
+		"%s: Not find struct/union %s%s\n";
+
+	fprintf(stderr, fmt, __func__, smi->struct_name,
+			smi->modname ? smi->modname : "");
+	return false;
+}
+
+static bool add_to_btf_arr(struct btf *btf, char *module_name)
+{
+	struct btf_arr_elem* tmp;
+	int new_cap = 0;
+
+	if (btf_arr == NULL) {
+		new_cap = 4;
+	} else if (btf_arr_len >= btf_arr_cap) {
+		new_cap = btf_arr_cap + (btf_arr_cap >> 1);
+	}
+
+	if (!module_name)
+		goto no_mem;
+
+	if (new_cap) {
+		tmp = reallocarray(btf_arr, new_cap, sizeof(struct btf_arr_elem));
+		if (!tmp)
+			goto no_mem;
+		btf_arr = tmp;
+		btf_arr_cap = new_cap;
+	}
+
+	btf_arr[btf_arr_len].btf = btf;
+	btf_arr[btf_arr_len++].module = module_name;
+	return true;
+
+no_mem:
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+	return false;
+}
+
+bool init_kernel_btf(void)
+{
+	uint64_t size;
+	struct btf *btf;
+	char *buf = NULL;
+	bool ret = false;
+
+	uint64_t start_btf = get_kallsyms_value_by_name("__start_BTF");
+	uint64_t stop_btf = get_kallsyms_value_by_name("__stop_BTF");
+	if (!start_btf || !stop_btf) {
+		fprintf(stderr, "%s: symbol __start/stop_BTF not found!\n", __func__);
+		goto out;
+	}
+
+	size = stop_btf - start_btf;
+	buf = (char *)malloc(size);
+	if (!buf) {
+		fprintf(stderr, "%s: Not enough memory!\n", __func__);
+		goto out;
+	}
+	readmem(VADDR, start_btf, buf, size);
+	btf = btf__new(buf, size);
+
+	if (libbpf_get_error(btf) != 0 ||
+	    add_to_btf_arr(btf, strdup("vmlinux")) == false) {	
+		fprintf(stderr, "%s: init vmlinux btf fail\n", __func__);
+		goto out;
+	}
+	ret = true;
+out:
+	if (buf)
+		free(buf);
+	return ret;
+}
diff --git a/btf_info.h b/btf_info.h
new file mode 100644
index 0000000..1fc6829
--- /dev/null
+++ b/btf_info.h
@@ -0,0 +1,64 @@
+#ifndef _BTF_INFO_H
+#define _BTF_INFO_H
+#include <stdint.h>
+
+struct struct_member_info {
+	/********in******/
+	char *modname;		// Set to search within the module, in case
+				// name conflict of different modules
+	char *struct_name;	// Search by struct name
+	char *member_name;	// Search by member name
+	/********out*****/
+	uint32_t member_bit_offset;	// member offset in bits
+	uint32_t member_bit_sz;	// member width in bits
+	uint32_t member_size;	// member size in bytes
+	uint32_t struct_size;	// struct size in bytes
+};
+
+bool init_kernel_btf(void);
+bool get_struct_member_by_name(struct struct_member_info *smi);
+
+struct member_off_size {
+	int m_off;
+	int m_size;
+	int s_size;
+};
+#define QUATE(x) #x
+#define INIT_MOD_STRUCT_MEMBER(MOD, S, M) \
+	struct member_off_size _##MOD##_##S##_##M; \
+	memset(&smi, 0, sizeof(struct struct_member_info)); \
+	smi.modname = QUATE(MOD); \
+	smi.struct_name = QUATE(S); \
+	smi.member_name = QUATE(M); \
+	get_struct_member_by_name(&smi); \
+	_##MOD##_##S##_##M.s_size = smi.struct_size; \
+	_##MOD##_##S##_##M.m_size = smi.member_size; \
+	_##MOD##_##S##_##M.m_off = smi.member_bit_offset;
+#define GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M) (_##MOD##_##S##_##M.m_off)
+#define GET_MOD_STRUCT_MEMBER_MSIZE(MOD, S, M) (_##MOD##_##S##_##M.m_size)
+#define GET_MOD_STRUCT_MEMBER_SSIZE(MOD, S, M) (_##MOD##_##S##_##M.s_size)
+
+#define INIT_STRUCT_MEMBER(S, M) \
+	struct member_off_size _##S##_##M; \
+	memset(&smi, 0, sizeof(struct struct_member_info)); \
+	smi.modname = NULL; \
+	smi.struct_name = QUATE(S); \
+	smi.member_name = QUATE(M); \
+	get_struct_member_by_name(&smi); \
+	_##S##_##M.s_size = smi.struct_size; \
+	_##S##_##M.m_size = smi.member_size; \
+	_##S##_##M.m_off = smi.member_bit_offset;
+#define GET_STRUCT_MEMBER_MOFF(S, M) (_##S##_##M.m_off)
+#define GET_STRUCT_MEMBER_MSIZE(S, M) (_##S##_##M.m_size)
+#define GET_STRUCT_MEMBER_SSIZE(S, M) (_##S##_##M.s_size)
+
+#define INIT_STRUCT(S) \
+	struct member_off_size _##S; \
+	memset(&smi, 0, sizeof(struct struct_member_info)); \
+	smi.modname = NULL; \
+	smi.member_name = NULL; \
+	smi.struct_name = QUATE(S); \
+	get_struct_member_by_name(&smi); \
+	_##S.s_size = smi.struct_size;
+#define GET_STRUCT_SSIZE(S) (_##S.s_size)
+#endif /* _BTF_INFO_H */
-- 
2.47.0


