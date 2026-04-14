Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA61ED7B9A
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zgGj/9Bo4cDmdAoqv//tsMsl+FjA1t+gJX8tgRBSQhY=; b=FNbSeDRkjnCdrhI3tEGsmY9CN/
	vsTkeY/W7IHkrUxx3UK1BciRv8u6B6PWU4fe+dIJs/t39Klmyrtv/HANV64RnFOuvHh5BLmA1BnIg
	GksD1of3eDc9dQ0+T1kAXyxe9a/d8rUdP0ZYvQe9MljW0N3bdWG83COz1ZPV+XCMlYx83um5sk5US
	xlKaz05OJe0BopuicNQ936YX/4NzEaBvsItmOH+IWn1ARgY/lbnNDg72So7moFvriXht2Jpy8BXVq
	MMWyDHDAcMxTrlkZ/nDVVPdbosvhmtHM5VjZVLzZ199BJzeFtVr65DCmt80Ai0imyTmbn0YqOxPlX
	Gm4Jwo1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazX-0000000H8sR-0NCw;
	Tue, 14 Apr 2026 10:27:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazU-0000000H8r5-48SW
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:27:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgGj/9Bo4cDmdAoqv//tsMsl+FjA1t+gJX8tgRBSQhY=;
	b=CtYOVV0sqq8gm/N+NVXfJLYcVSZGvgrIeDdkFCWcavKaK+0k00O38vP8teNzubOYBJkr+g
	nArtByP55AJbdiQZ9+rRX3M2H/dyOVx0uDT7GBvjy/HZW+LUpAOMrZREn7x4/S9dWqXn9C
	B6teYP1wTvqv5fa+7jr8FkoCj3580oM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-KaEav7ADPTqOU7PxkmJxaQ-1; Tue, 14 Apr 2026 06:27:29 -0400
X-MC-Unique: KaEav7ADPTqOU7PxkmJxaQ-1
X-Mimecast-MFC-AGG-ID: KaEav7ADPTqOU7PxkmJxaQ_1776162448
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b45cd0bb96so22072075ad.3
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162448; x=1776767248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zgGj/9Bo4cDmdAoqv//tsMsl+FjA1t+gJX8tgRBSQhY=;
        b=ZUXYhD4ei1sqvcLAYF9rKAZ/12QdNpue9zPVuEjUNtyETB9WqmH2w4IkeiQ4kGqUyl
         c89kDa1AYqqQptyTiW6RIIplxjsmeDXvxdvfKcXEWkURRvyzDtdVgaNA8MfHol4b3NCI
         qm2x4rs1xZZkQ3oJON+nluSJpJc24jAknSp+1gXT0mFY0iOUvQjWP22wgpiu1BGs9U1L
         ghOxv2azpOFD4T+gsX+EAktQTyjU7RSX/oVUjnlSYKtNQgN2H4Jd+xu1UXbE7e2O64az
         QHhfQo3HbujaJ874zCK7lK2YAL+d8wyDjVOYUMexhNyuPZ1iD3FxxcgRbGfisUZmbBIQ
         DrNg==
X-Forwarded-Encrypted: i=1; AFNElJ+VejT5mNVQJZz0AjBDoWdW+kYAyMuvk+k6G2Yj9XiNPFRdzZyTP8h+7pCaJG1KMZpdBj94iA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyosvywfKha1EiHUtxBPcQG2iBO3aDkmkZ04EHkVVcBhZFe/EP7
	XEzouFLNzxKJg3UmvmD+in4JfG8EzRyEGIFdROmERncCadiP5WB1dGqJ+DfHmlICEAiSFc94gmI
	BdjSJyhr/GbRM6+1JUorhIWB3AVpI9qCViIY6YB5XBfhNC9XLaM5hqHv3blTUZA==
X-Gm-Gg: AeBDieuSZIhwOvgUDQ4amrGQxjK/QXDfocxyNqHNBJB4pPY/lbQrcCA4miIJ9WYJn+D
	d5U6U0uu8Qk4BbG4FK6nsrBtOWhkW/ptDv9ggG98+nOEGncJcBNk9elkBIx0EQLB4CdIEIlaZHW
	kpWwBswrQi78VohjDAmf/6zLM1iEqNP/PEiZRHa6q35Eg3IlFSUhLf/jsoWoEmoE4zk9MuD9f3a
	KXlxZjh2SUzKIbOIREY+Jwm/jqQbJCsne7Cp+uKi2Ucwhyb95+tGH5/HBZKXt86x8Xs22nMJT6j
	IaVUDmx/PcJSnIj4UYQtgYVG1zO8DcHapQaSqDncR3Ev/K5Hc4LVagaE/fSgMrlGS3QtzxAHezA
	h7dnY3YOfxELTfyN+T8EehCeET/iEdPw+wM8vNimd6bTLRBMOzp6O+Ls1oadlYLiy1BOT
X-Received: by 2002:a17:902:7c8e:b0:2b2:42f8:1a4b with SMTP id d9443c01a7336-2b2d5a167d2mr123054535ad.27.1776162447882;
        Tue, 14 Apr 2026 03:27:27 -0700 (PDT)
X-Received: by 2002:a17:902:7c8e:b0:2b2:42f8:1a4b with SMTP id d9443c01a7336-2b2d5a167d2mr123054275ad.27.1776162447341;
        Tue, 14 Apr 2026 03:27:27 -0700 (PDT)
Received: from localhost.localdomain (122-63-70-7.mobile.spark.co.nz. [122.63.70.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm136809165ad.79.2026.04.14.03.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:27:27 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v5][makedumpfile 3/9] Implement kernel btf resolving
Date: Tue, 14 Apr 2026 22:26:50 +1200
Message-ID: <20260414102656.55200-4-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xZKZBf0DSK38CHeKIB_nUpEot0jpFIsA_GMCk0ld4eQ_1776162448
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_032733_234927_2EC283B1 
X-CRM114-Status: GOOD (  24.71  )
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

Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile   |   2 +-
 btf_info.c | 242 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_info.h |  75 +++++++++++++++++
 3 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 btf_info.c
 create mode 100644 btf_info.h

diff --git a/Makefile b/Makefile
index a57185e..690ef3e 100644
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
index 0000000..7243674
--- /dev/null
+++ b/btf_info.c
@@ -0,0 +1,242 @@
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
+	if (!register_ktype_section((char *)__start_init_ktypes,
+				    (char *)__stop_init_ktypes))
+		return ret;
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
2.47.0


