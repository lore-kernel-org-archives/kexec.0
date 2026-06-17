Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06648CD98E1
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 05:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ChzNbBfrgdOaaIZi1uD6D+VBOdxwwRnVP1y9J+Nh4zc=; b=iJIE+Ieh1BZknMbmw+/DcJZRIH
	AsIFcm8q477pxToBEkv+1R/w0fGk3Q2iuOMpmHQDMYAlHVYvY5NB9ogN/9BHa9NVDwwvgS4iRLZcA
	C0svuFLPqE2N+qKibq3ZrNJisEH4tQkHKOxZ/tadactYEik3B9aYmvslpBGX2VO5OmWsBsR1Wt/X0
	QnY1QowjPbHmQizqbYDZIEDeGdBoCzzp26EN69bR/ojAFN4SZ4NKL2HivgSRz2IcPIQ5PgqTOn4m8
	5qXwZQ/LRBwHPsgAfL4lV6JGx7OfxEs7UePi5ovH+RQfREupDVGfKCihTyl4XN2UmVwHd7IEglsdN
	ThzXVULg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihO-0000000Ge12-0lPd;
	Wed, 17 Jun 2026 05:20:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihM-0000000Gdzx-1PVP
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 05:20:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781673623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ChzNbBfrgdOaaIZi1uD6D+VBOdxwwRnVP1y9J+Nh4zc=;
	b=Diko+W0M7+hN5ihcCLPFFBYB+PifFDJh2SOQQa67B8fzJO63kwuY78YtuhMJl1GqjdRZc9
	xFwnoNK4BF2BvQR5BY3JFecVhjsFBuXSgOx7Ri5lou+fKb3ItoU8p2+6dVeOUAGMgSoB3y
	rKYWrME/nrTup/ykwDHH/wIYfB7BODE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-mwroJALWPN64oEmwBd_d1Q-1; Wed, 17 Jun 2026 01:20:22 -0400
X-MC-Unique: mwroJALWPN64oEmwBd_d1Q-1
X-Mimecast-MFC-AGG-ID: mwroJALWPN64oEmwBd_d1Q_1781673621
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8426ed9f24dso333990b3a.1
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 22:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781673621; x=1782278421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ChzNbBfrgdOaaIZi1uD6D+VBOdxwwRnVP1y9J+Nh4zc=;
        b=VwcmAt/Hf9Mkotb16Rl8bcgqwF5hNc0dLladD8QgiS1w4gkiFIzysoUihYR15u9Y5J
         OkhBqI1UbpXsmbD2mQGUOU3jGgU8LVVI3spWuX5kLaLobWCe1Jadft1hQKkiLrGcbQRD
         58UCZFxqRaIKZYD7cWq5nGnSYwdJMvYNBSHeyEZcKyZTNWNlvRSsyVa6vOxSqyzsF7NE
         MpCqlPeHLLRBYTg4cWg6fgAxe8JJtQgPqPoFQsTLFrFn/CM3WSpsJNFGfo9n5RFxm8lE
         x9TXSLbIlUrzaY0jPHexH/PEgYn16fM1ieewBKVgS2F2lQw3957n/z7uOrDiVwEzK/dZ
         VAaw==
X-Forwarded-Encrypted: i=1; AFNElJ/QTDl8LodkifpxFj9Jn7kkMxvILm0L1CTNRUoVj3/aS4kdFxfZM6fhds2WwWXPFPhDdpFv0Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YyWaxH2l+N6Qr5BpEzzouEwTmAMeqypglburJ58yjMZ2XWQGKiN
	Hjl/SvClkP2wXBNRfxog70muWsYG9rkcSTu7VUoAD+9AoPyOzFt6rXEx8w7xP7KgbGwCDWkegkw
	0RLLQTHXqd/9dIiu2k+s3KMjDi5+sGBYq/SRao9unwU9PKg9U0GcR589+9P0MQdQDPnom0Q==
X-Gm-Gg: Acq92OFC5uIok0NkmHqhfrklUVWLCwQOEp+ouSbba0xu6/7aokvBLqfEARw2Yfc8Jd+
	o6yf2cfOCyljUZektcK4VE2s8MtR+gQ2BnE254/uU8pJPVEq+cio/BJn28ZMVUj/K9ESG/OCB7P
	DG78U81xSoplvzo6alm24rRTkNskCs45XufJoVenMXd4TgjSQ0C23qN199sGRcpEm5TOCFo8dXg
	Y/R1M42vaQISKjWYeba+fncsfD1t8VRR4qO9PSw0NcrY8n8Be9+AcZNAuToHu3Gp8WBnTP/zX7j
	5cKBNo4mD9k6/f5x2eJM0imt5zkmJOgtlinZJYvLM6wXN0S2lpMZ8f2SIGTsGxk11+sKijg0bkQ
	RR8Tn2JugzI4ftHf8h4MYyJ7mnvULYvpt/XFFlyMeNN4vp7gkCA==
X-Received: by 2002:a05:6a00:2d86:b0:842:50fd:4c13 with SMTP id d2e1a72fcca58-845269ff02bmr1373052b3a.4.1781673620975;
        Tue, 16 Jun 2026 22:20:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d86:b0:842:50fd:4c13 with SMTP id d2e1a72fcca58-845269ff02bmr1373026b3a.4.1781673620428;
        Tue, 16 Jun 2026 22:20:20 -0700 (PDT)
Received: from localhost.localdomain (122-63-72-97.mobile.spark.co.nz. [122.63.72.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm17234894b3a.38.2026.06.16.22.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:20:19 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v6][makedumpfile 03/10] Implement kernel btf resolving
Date: Wed, 17 Jun 2026 17:18:27 +1200
Message-ID: <20260617051834.95404-4-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617051834.95404-1-ltao@redhat.com>
References: <20260617051834.95404-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6VLuTZPT6_yCWVS6LHTZPwswf-I5Akyn8jseNsWJVj0_1781673621
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_222024_531454_3DC56E57 
X-CRM114-Status: GOOD (  24.18  )
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

This patch will parse kernel's btf data using libbpf. The kernel's
btf data is located between __start_BTF and __stop_BTF symbols which
are resolved by kallsyms of the previous patch. Same as the previous
one, the .init_ktypes section of makedumpfile and the extensions will
be iterated, and any types which belongs to vmlinux can be resolved
at this time.

Another primary function implemented in this patch, is recursively
diving into anonymous struct/union when encountered any, to find a
member by given its name.

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile   |   2 +-
 btf_info.c | 238 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_info.h |  75 +++++++++++++++++
 3 files changed, 314 insertions(+), 1 deletion(-)
 create mode 100644 btf_info.c
 create mode 100644 btf_info.h

diff --git a/Makefile b/Makefile
index 3cd729f..1c51802 100644
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
diff --git a/btf_info.c b/btf_info.c
new file mode 100644
index 0000000..8d907f6
--- /dev/null
+++ b/btf_info.c
@@ -0,0 +1,238 @@
+#ifdef EXTENSION
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
+static struct btf_arr_elem **btf_arr = NULL;
+static int btf_arr_len = 0;
+static int btf_arr_cap = 0;
+
+/* makedumpfile & extensions' .init_ktypes section range array */
+static struct section_range **sr = NULL;
+static int sr_len = 0;
+static int sr_cap = 0;
+
+/* Which mod's btf should be inited? */
+static char **mods = NULL;
+static int mods_len = 0;
+static int mods_cap = 0;
+
+static bool add_ktype_modname(char *modname)
+{
+	return push_uniq_str((void ***)&mods, &mods_len, &mods_cap, modname);
+}
+
+bool check_ktypes_require_modname(char *modname, int *total)
+{
+	if (total)
+		*total = mods_len;
+	for (int i = 0; i < mods_len; i++) {
+		if (!strcmp(modname, mods[i]))
+			return true;
+	}
+	return false;
+}
+
+static void cleanup_ktypes_modname(void)
+{
+	if (mods) {
+		free(mods);
+		mods = NULL;
+	}
+	mods_len = 0;
+	mods_cap = 0;
+}
+
+/*
+ * Used by makedumpfile and extensions, to register their .init_ktypes section,
+ * so btf_info can know which module/type should be inited.
+*/
+REGISTER_SECTION(ktype)
+
+static void cleanup_ktypes_section_range(void)
+{
+	for (int i = 0; i < sr_len; i++) {
+		free(sr[i]);
+	}
+	if (sr) {
+		free(sr);
+		sr = NULL;
+	}
+	sr_len = 0;
+	sr_cap = 0;
+}
+
+static void find_member_recursive(struct btf *btf, int struct_typeid,
+				  int base_offset, struct ktype_info *ki)
+{
+	const struct btf_type *st;
+	struct btf_member *bm;
+	int i, vlen;
+
+	struct_typeid = btf__resolve_type(btf, struct_typeid);
+	st = btf__type_by_id(btf, struct_typeid);
+
+	if (!st)
+		return;
+
+	if (BTF_INFO_KIND(st->info) != BTF_KIND_STRUCT &&
+	    BTF_INFO_KIND(st->info) != BTF_KIND_UNION)
+		return;
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
+		if (name && strcmp(name, ki->member_name) == 0) {
+			ki->member_bit_offset = member_bit_offset;
+			ki->member_bit_sz = btf_member_bitfield_size(st, i);
+			ki->member_size = btf__resolve_size(btf, member_typeid);
+			ki->index = i;
+			return;
+		}
+
+		if (!name || !name[0]) {
+			if (BTF_INFO_KIND(mt->info) == BTF_KIND_STRUCT ||
+			    BTF_INFO_KIND(mt->info) == BTF_KIND_UNION) {
+				find_member_recursive(btf, member_typeid,
+						      member_bit_offset, ki);
+			}
+		}
+	}
+}
+
+static void get_ktype_info(struct ktype_info *ki, char *mod_to_resolve)
+{
+	int i, j, start_id;
+
+	if (mod_to_resolve != NULL) {
+		if (strcmp(ki->modname, mod_to_resolve) != 0)
+			/* Exit safely */
+			return;
+	}
+
+	for (i = 0; i < btf_arr_len; i++) {
+		if (strcmp(btf_arr[i]->module, ki->modname) != 0)
+			continue;
+		/*
+		 * vmlinux(btf_arr[0])'s typeid is 1~vmlinux_type_cnt,
+		 * modules(btf_arr[1...])'s typeid is vmlinux_type_cnt~btf__type_cnt
+		 */
+		start_id = (i == 0 ? 1 : btf__type_cnt(btf_arr[0]->btf));
+
+		for (j = start_id; j < btf__type_cnt(btf_arr[i]->btf); j++) {
+			const struct btf_type *bt =
+				btf__type_by_id(btf_arr[i]->btf, j);
+			const char *name =
+				btf__name_by_offset(btf_arr[i]->btf, bt->name_off);
+
+			if (name && strcmp(ki->struct_name, name) == 0) {
+				if (ki->member_name != NULL) {
+					/* Retrieve member info */
+					find_member_recursive(btf_arr[i]->btf, j, 0, ki);
+				} else {
+					ki->index = j;
+				}
+				ki->struct_size = btf__resolve_size(btf_arr[i]->btf, j);
+				return;
+			}
+		}
+	}
+}
+
+static bool add_to_btf_arr(struct btf *btf, char *module_name)
+{
+	struct btf_arr_elem *new_p;
+
+	new_p = malloc(sizeof(struct btf_arr_elem));
+	if (!new_p)
+		goto no_mem;
+
+	new_p->btf = btf;
+	new_p->module = module_name;
+
+	return add_to_arr((void ***)&btf_arr, &btf_arr_len, &btf_arr_cap, new_p);
+
+no_mem:
+	ERRMSG("Not enough memory!\n");
+	return false;
+}
+
+INIT_MOD_SYM(vmlinux, __start_BTF);
+INIT_MOD_SYM(vmlinux, __stop_BTF);
+
+#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
+#define KERN_SYM_EXIST(SYM) MOD_SYM_EXIST(vmlinux, SYM)
+
+/*
+ * Makedumpfile's .init_ktypes section
+*/
+extern struct ktype_info *__start_init_ktypes[];
+extern struct ktype_info *__stop_init_ktypes[];
+
+bool init_kernel_btf(void)
+{
+	uint64_t size;
+	struct btf *btf;
+	int i;
+	struct ktype_info **p;
+	char *buf = NULL;
+	bool ret = false;
+
+	uint64_t start_btf = GET_KERN_SYM(__start_BTF);
+	uint64_t stop_btf = GET_KERN_SYM(__stop_BTF);
+	if (!KERN_SYM_EXIST(__start_BTF) ||
+	    !KERN_SYM_EXIST(__stop_BTF)) {
+		ERRMSG("symbol __start/stop_BTF not found!\n");
+		goto out;
+	}
+
+	size = stop_btf - start_btf;
+	buf = (char *)malloc(size);
+	if (!buf) {
+		ERRMSG("Not enough memory!\n");
+		goto out;
+	}
+	if (!readmem(VADDR, start_btf, buf, size)) {
+		ERRMSG("Can't get kernel btf data!\n");
+		goto out;
+	}
+	btf = btf__new(buf, size);
+
+	if (libbpf_get_error(btf) != 0 ||
+	    add_to_btf_arr(btf, strdup("vmlinux")) == false) {	
+		ERRMSG("init vmlinux btf fail\n");
+		goto out;
+	}
+
+	for (i = 0; i < sr_len; i++) {
+		for (p = (struct ktype_info **)(sr[i]->start);
+		     p < (struct ktype_info **)(sr[i]->stop);
+		     p++) {
+			get_ktype_info(*p, "vmlinux");
+		}
+	}
+
+	ret = true;
+out:
+	if (buf)
+		free(buf);
+	return ret;
+}
+#endif /* EXTENSION */
+
diff --git a/btf_info.h b/btf_info.h
new file mode 100644
index 0000000..8eace67
--- /dev/null
+++ b/btf_info.h
@@ -0,0 +1,75 @@
+#ifndef _BTF_INFO_H
+#define _BTF_INFO_H
+#include <stdint.h>
+#include <stdbool.h>
+
+struct ktype_info {
+	/********in******/
+	char *modname;		// Set to search within the module, in case
+				// name conflict of different modules
+	char *struct_name;	// Search by struct name
+	char *member_name;	// Search by member name
+	bool struct_required : 1;
+	bool member_required : 1;
+	/********out*****/
+	uint32_t member_bit_offset;	// member offset in bits
+	uint32_t member_bit_sz;	// member width in bits
+	uint32_t member_size;	// member size in bytes
+	uint32_t struct_size;	// struct size in bytes
+	int index;		// -1 if type not found
+};
+
+bool check_ktypes_require_modname(char *modname, int *total);
+bool register_ktype_section(char *start, char *stop);
+bool init_kernel_btf(void);
+
+#define _GEN_NAME_PTR_IMPL(PTR, NAME)		PTR##NAME
+#define _GEN_NAME_PTR(PTR, NAME)		_GEN_NAME_PTR_IMPL(PTR, NAME)
+#define ___GEN_NAME_2(MOD, S)			_##MOD##_##S
+#define ___GEN_NAME_3(MOD, S, M)		_##MOD##_##S##_##M
+#define __GEN_NAME_SELECTOR(_1, _2, _3, NAME, ...) NAME
+#define _GEN_NAME(...) __GEN_NAME_SELECTOR(__VA_ARGS__, ___GEN_NAME_3, ___GEN_NAME_2)(__VA_ARGS__)
+
+#define _INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, R)		\
+	struct ktype_info _GEN_NAME(MOD, S, M) = {		\
+		#MOD, #S, #M, R, R, 0, 0, 0, 0, -1		\
+	};							\
+	__attribute__((section(".init_ktypes"), used))		\
+	struct ktype_info * _GEN_NAME_PTR(_ptr, _GEN_NAME(MOD, S, M)) = &_GEN_NAME(MOD, S, M)
+
+/*
+ * Required types will be checked automatically before extension running.
+ * Optinal types should be checked manually at extension runtime.
+ */
+#define INIT_MOD_STRUCT_MEMBER(MOD, S, M) \
+	_INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, 1)
+#define INIT_OPT_MOD_STRUCT_MEMBER(MOD, S, M) \
+	_INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, 0)
+
+#define DECLARE_MOD_STRUCT_MEMBER(MOD, S, M) \
+	extern struct ktype_info _GEN_NAME(MOD, S, M)
+
+#define GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M)	(_GEN_NAME(MOD, S, M).member_bit_offset)
+#define GET_MOD_STRUCT_MEMBER_MSIZE(MOD, S, M)	(_GEN_NAME(MOD, S, M).member_size)
+#define GET_MOD_STRUCT_MEMBER_SSIZE(MOD, S, M)	(_GEN_NAME(MOD, S, M).struct_size)
+#define MOD_STRUCT_MEMBER_EXIST(MOD, S, M)	(_GEN_NAME(MOD, S, M).index >= 0)
+#define TYPE_EXIST(p)				((p)->index >= 0)
+
+
+#define _INIT_MOD_STRUCT_RQD(MOD, S, R)				\
+	struct ktype_info _GEN_NAME(MOD, S) = {			\
+		#MOD, #S, 0, R, 0, 0, 0, 0, 0, -1		\
+	};							\
+	__attribute__((section(".init_ktypes"), used))		\
+	struct ktype_info * _GEN_NAME_PTR(_ptr, _GEN_NAME(MOD, S)) = &_GEN_NAME(MOD, S)
+
+#define INIT_MOD_STRUCT(MOD, S)		_INIT_MOD_STRUCT_RQD(MOD, S, 1)
+#define INIT_OPT_MOD_STRUCT(MOD, S)	_INIT_MOD_STRUCT_RQD(MOD, S, 0)
+
+#define DECLARE_MOD_STRUCT(MOD, S)	extern struct ktype_info _GEN_NAME(MOD, S);
+
+#define GET_MOD_STRUCT_SSIZE(MOD, S)	(_GEN_NAME(MOD, S).struct_size)
+#define MOD_STRUCT_EXIST(MOD, S)	(_GEN_NAME(MOD, S).index >= 0)
+
+#endif /* _BTF_INFO_H */
+
-- 
2.54.0


