Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254C4FED9E3
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wNmgN5aALkHPZyMRZfk6qtY4JZl6ekbOKlPzXi33NPA=; b=qCP+NvmX4z7xWFrdGV4HQcMbwI
	beVRBT6bP9CUa/mzMjAbh5S1x5S7VV4lDRB/no4Zl+hApTyrf1seR/Kuitwf2fYKi8xRkmj15xy5t
	XGwMwyAQNTNthl7IEhlZ/3iCYFxtY7RcDn6BIwADrhnrEAGHwav/ok6hUg2VJSy/DnXVOA4kwYpiG
	WVEpBMg9REc0ZlMO8Q1q6Y2qRnptc6QbYOo6DgDkLC+yWAR5bXND6QRLl+Z5CWyfpVsLaHw2kmftO
	OL3SWGi50c0PNvwqCxSg+MyeMC/kS3d2yqpt+t/ls15p0ZUeFvgkT/f3fjwtx58vYOHfn0irAUcul
	qeUMRZOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W4X-00000006hQn-42Db;
	Tue, 17 Mar 2026 15:11:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W4V-00000006hPl-2XmA
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 15:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNmgN5aALkHPZyMRZfk6qtY4JZl6ekbOKlPzXi33NPA=;
	b=Lxu0GjNZTYoR+WwPdo3OPntzrpNHiRn62J0E/v6lhkXHkGHxpFyW/vXmEalYy5sfcwKSft
	o92C5QrbgC3ByVmvy/UEaW3mkAQLP8F7EBRrbafEUm/ojDOOFUvUC2wqYb+72yjqrt6fzX
	1MBkHL2UyOgpdf2wRkpx2YaVel4lZfc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-aF2Sa-dPM-WMR5RvK4TMzw-1; Tue, 17 Mar 2026 11:09:07 -0400
X-MC-Unique: aF2Sa-dPM-WMR5RvK4TMzw-1
X-Mimecast-MFC-AGG-ID: aF2Sa-dPM-WMR5RvK4TMzw_1773760146
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8299499d582so20776146b3a.2
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 08:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760146; x=1774364946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNmgN5aALkHPZyMRZfk6qtY4JZl6ekbOKlPzXi33NPA=;
        b=d2/ZmzsLJZS0W8FpDg2z3I8P1r/jJWzL5V/24xejPRrBdA4t2q9l+xxau5nDnql5GN
         6HE9Eb4Hr1qdKV9SdmSCW/gpQq6cspI2ttNuJbvrld1D145q3f/AJ+vNSNq+l8W6kEPs
         kf7dfxDvwjE/tU605C18UIqwNuQU395xEAQu1uSVo4ZqA5/QYgpkSDIjhABqeEyOvpTi
         tfu79len/hVwRbh24oiEy+VgFg0XYgT6mB6Hn1P7cFFqAhEMEheI/ZEsr2UH1NyCNKb4
         FcUO9yRGtn1IbSa8wmmwrAsSb4NqYYdE/Qbk+q2clBQsf+YlDlwYgspcXED1GGjvrYmT
         O/mg==
X-Forwarded-Encrypted: i=1; AJvYcCXaxAh5Nm9StSvX2u5/jh7f2p53mPVS11A8QiqFcG3rF+qMf/9po2L5OZCkAd7OS1/2HKVZzw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9zCyEqyKxy7kahRbH1GfIgM+o7f+nlYXINDKVbR8FwL0AJETh
	thpFpUQ5gIrFWanWIhIr17EiUWeNU4VqNm4G6hcu976kHpT+7l/I9KdwHtoIHnxRzgHPdtGTMb0
	OwlYcDAL3L9qAqOXW22gWImvp0VOzvYj1+aov0tA+teo4caCd7ioOvhdPJisaO1Pw74lSZQ==
X-Gm-Gg: ATEYQzzfTpmengwloLQm5EW+7ngwhnMBe19TET1n6n9KsMTEo7IezU/g61L/W1P3yIe
	ZsOx0DUDDLw5zYZpQsg/X7/Lb88epiul90Jn/Eg9LpKqWIz8PMv1PLlcXeTtdpMrhgfx88QQLPS
	ZMYaCoRHN3UyqfWJO08RVyWbW+HzQH+RWjPedsf9rMENsIECclxqx8CIbPM0E/tNC59ApgIpMGg
	5SEeS8dqo99mAP25mwdqsgcscR5XY2HkIpVuAfKF/b35rBUmK6NyOgzb8PIETMeWb8l9WU4oylC
	DFfZOQb8xb68w+G3KvkVSJZbCWyCdqDKgdvvgYS4YQxQBSt+BjnXiRRl0o0ahOgUxZ3X9tt03Me
	aF2qwdd15CEHupGsJU43WebfF02TAgWj7UA==
X-Received: by 2002:a05:6a00:4b15:b0:824:374a:13f7 with SMTP id d2e1a72fcca58-82a198e26cdmr15208438b3a.55.1773760145692;
        Tue, 17 Mar 2026 08:09:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b15:b0:824:374a:13f7 with SMTP id d2e1a72fcca58-82a198e26cdmr15208391b3a.55.1773760144932;
        Tue, 17 Mar 2026 08:09:04 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340417sm16993404b3a.39.2026.03.17.08.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:09:04 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v4][makedumpfile 3/7] Implement kernel btf resolving
Date: Wed, 18 Mar 2026 04:07:39 +1300
Message-ID: <20260317150743.69590-4-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260317150743.69590-1-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mIrsmnNjHoXvqT8F9c3xYt-gwxZjm68qKb9dfvWNj7c_1773760146
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_081103_783842_CCFFE5F0 
X-CRM114-Status: GOOD (  25.70  )
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
 Makefile   |   4 +-
 btf_info.c | 233 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_info.h |  90 +++++++++++++++++++++
 3 files changed, 325 insertions(+), 2 deletions(-)
 create mode 100644 btf_info.c
 create mode 100644 btf_info.h

diff --git a/Makefile b/Makefile
index a57185e..320677d 100644
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
index 0000000..1cb66e2
--- /dev/null
+++ b/btf_info.c
@@ -0,0 +1,233 @@
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
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+	return false;
+}
+
+INIT_KERN_SYM(__start_BTF);
+INIT_KERN_SYM(__stop_BTF);
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
+		fprintf(stderr, "%s: symbol __start/stop_BTF not found!\n", __func__);
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
\ No newline at end of file
diff --git a/btf_info.h b/btf_info.h
new file mode 100644
index 0000000..2cf6b07
--- /dev/null
+++ b/btf_info.h
@@ -0,0 +1,90 @@
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
+#define QUATE(x) #x
+#define INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, R)			\
+	struct ktype_info _##MOD##_##S##_##M = {			\
+		QUATE(MOD), QUATE(S), QUATE(M), R, R, 0, 0, 0, 0, -1	\
+	};								\
+	__attribute__((section(".init_ktypes"), used))			\
+	struct ktype_info * _ptr_##MOD##_##S##_##M = &_##MOD##_##S##_##M
+
+/*
+ * Required types will be checked automatically before extension running.
+ * Optinal types should be checked manually at extension runtime.
+ */
+#define INIT_MOD_STRUCT_MEMBER(MOD, S, M) \
+	INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, 1)
+#define INIT_OPT_MOD_STRUCT_MEMBER(MOD, S, M) \
+	INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, 0)
+
+#define DECLARE_MOD_STRUCT_MEMBER(MOD, S, M) \
+	extern struct ktype_info _##MOD##_##S##_##M
+
+#define GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M)  (_##MOD##_##S##_##M.member_bit_offset)
+#define GET_MOD_STRUCT_MEMBER_MSIZE(MOD, S, M) (_##MOD##_##S##_##M.member_size)
+#define GET_MOD_STRUCT_MEMBER_SSIZE(MOD, S, M) (_##MOD##_##S##_##M.struct_size)
+#define MOD_STRUCT_MEMBER_EXIST(MOD, S, M) (_##MOD##_##S##_##M.index >= 0)
+#define TYPE_EXIST(p) ((p)->index >= 0)
+
+#define INIT_KERN_STRUCT_MEMBER(S, M) \
+	INIT_MOD_STRUCT_MEMBER(vmlinux, S, M)
+#define INIT_OPT_KERN_STRUCT_MEMBER(S, M) \
+	INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, S, M)
+
+#define DECLARE_KERN_STRUCT_MEMBER(S, M) \
+	DECLARE_MOD_STRUCT_MEMBER(vmlinux, S, M)
+
+#define GET_KERN_STRUCT_MEMBER_MOFF(S, M)  GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M)
+#define GET_KERN_STRUCT_MEMBER_MSIZE(S, M) GET_MOD_STRUCT_MEMBER_MSIZE(vmlinux, S, M)
+#define GET_KERN_STRUCT_MEMBER_SSIZE(S, M) GET_MOD_STRUCT_MEMBER_SSIZE(vmlinux, S, M)
+#define KERN_STRUCT_MEMBER_EXIST(S, M) MOD_STRUCT_MEMBER_EXIST(vmlinux, S, M)
+
+#define INIT_MOD_STRUCT_RQD(MOD, S, R)				\
+	struct ktype_info _##MOD##_##S = {			\
+		QUATE(MOD), QUATE(S), 0, R, 0, 0, 0, 0, 0, -1	\
+	};							\
+	__attribute__((section(".init_ktypes"), used))		\
+	struct ktype_info * _ptr_##MOD##_##S = &_##MOD##_##S
+
+#define INIT_MOD_STRUCT(MOD, S) INIT_MOD_STRUCT_RQD(MOD, S, 1)
+#define INIT_OPT_MOD_STRUCT(MOD, S) INIT_MOD_STRUCT_RQD(MOD, S, 0)
+
+#define DECLARE_MOD_STRUCT(MOD, S) \
+	extern struct ktype_info _##MOD##_##S;
+
+#define GET_MOD_STRUCT_SSIZE(MOD, S) (_##MOD##_##S.struct_size)
+#define MOD_STRUCT_EXIST(MOD, S) (_##MOD##_##S.index >= 0)
+
+#define INIT_KERN_STRUCT(S) INIT_MOD_STRUCT(vmlinux, S)
+#define INIT_OPT_KERN_STRUCT(S) INIT_OPT_MOD_STRUCT(vmlinux, S)
+
+#define DECLARE_KERN_STRUCT(S) \
+	DECLARE_MOD_STRUCT(vmlinux, S)
+
+#define GET_KERN_STRUCT_SSIZE(S) GET_MOD_STRUCT_SSIZE(vmlinux, S)
+#define KERN_STRUCT_EXIST(S) MOD_STRUCT_EXIST(vmlinux, S)
+
+#endif /* _BTF_INFO_H */
\ No newline at end of file
-- 
2.47.0


