Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F277CD98EE
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 05:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WRwifh+WHocL0GPrY4bxLe2c4rcrkgwIVSsB1QsK0tU=; b=p5xE14zRk3pd7YBd2b56HLIMhQ
	wGjtZRw+ISz5M5a80vRS6IpAv2Qu6AdSof0nCI+H1w+opoAJ5AFWdZY2CbMNhWSF3YtTdURsGcwM9
	Ku1QkmgLcUvlEzPUekaX+T2nDtcUVnFJlPU5hBgG9jWajO7g/6yD/kIp86Yvl91DjIRwm3Y2oh8yz
	I+wu7Upww0VN4ulaLxYMQn7TYJChq0sItgUdjT0pHnUh3jhWzOAbyX33jFMcVpmE8nOAG3jmMkcy+
	DkW6jL8evRUx3xA1pQBCCHlhKWrA7UbqVXJYHz4QVSSLefzYppQUW7dXp0Cm3p0H5AUJxfeh5z1St
	00vDyWRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihL-0000000GdzY-0JOr;
	Wed, 17 Jun 2026 05:20:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihI-0000000GdyS-38mQ
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 05:20:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781673619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRwifh+WHocL0GPrY4bxLe2c4rcrkgwIVSsB1QsK0tU=;
	b=HYAK+9CgF5181p/J5SevCbEJZdA57GGALO+lQV+sr/mML3LDRzySnx4I3DUxoYrfuY/J3x
	bKquTJlXDyFZn08dUu1z3YgGvo6EEvMl/fUjUnFMbBwZCSWuRmXmkkwVCdYc9q1woRqzuU
	QeWe04S8xGjOi6/x1wIRO13dc/AEl4k=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-o_gReyvxMuWrQky2lIzmUA-1; Wed, 17 Jun 2026 01:20:17 -0400
X-MC-Unique: o_gReyvxMuWrQky2lIzmUA-1
X-Mimecast-MFC-AGG-ID: o_gReyvxMuWrQky2lIzmUA_1781673616
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-842688fa7b8so517944b3a.0
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 22:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781673616; x=1782278416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WRwifh+WHocL0GPrY4bxLe2c4rcrkgwIVSsB1QsK0tU=;
        b=dZWAbwTgJuTesvqT7ZuiV5nrCnr/EPTGbOpugT/zr3Jc75unlR/SeayRFwINmaVHgg
         i4VgCPtk84ly8y2TydoSNIWGt3piPddUO4J6elm2brqzk3SUUFS6LWcLd8cI3VRLhmME
         48/zzcEvTTwm1HD4U69pB/ek1hZC2i7t8RjiTIcrW3HapXcZxtsqUHbjqiTqtcr8mj/d
         OJfh46zSK/DDMdJtf9QXZKVAeaYxtaGnARgS9Zhl49iIzGlukGAHcpycba7+tO46nDaR
         3MI+TdYV/Se9eg45ei5vAw0EtDxIsdrTcmzChXM7RqCX1A5f4JavUnDaxi2PWc7WZV9l
         NIDA==
X-Forwarded-Encrypted: i=1; AFNElJ+0Vw5XPyrE+aR0QQ/giQs95pKI7Xw1uyA9GvHS+MVsMeIWgKtFLyHsoyT+iKPcW7UJ8Ip4rQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMa42uctw1Woc5mGFPc5A2hFsRFB5m9DF/St3lt1/MG0LMy/CA
	RmMCLfnL/Odm3gpKDq1zs263BjZQ4/L4A3VJdrrGDoyxMM9CbwRsm32orZOd4ppO96MfGa8Z7oB
	TZks6dWhXuNZpel1bWBcvIqRRpT5crhQfokzmnzRnR8gHDS5mHS30tLupG8+3SQ==
X-Gm-Gg: Acq92OF80UgEnuo7NgCusvz4gNXyY6MzHrwbxclT8EM0ab1M+MWnSDgRv5lX9KhfkZE
	DSxOVi9KeEiVAsMxSrt40aJ4zz6nCQT3ZrPE2EVONEqhOreyoEwvXwniNmSmENVWBD3GfWNFro7
	Bkm1gIgY/25bQv9OLQQRxFocAKCni7y25cehW+YdHHoUuwpTN92FRvPgEAwBwh6lzW9LaUxQkXq
	hhp+SZ/puYd9XlY1LQgf0KkIdWnqHA4qNZXYZQVTQl5LZdRvZQDlCPDCMlmF+q7k9uGHU9SZN6C
	pqpu/6qBK6JbgXAlGoyvZgFQZA01BxUgx9lgItzhRfH1LefddkLTPFOoI2dvgkd40DlSyW8uxng
	1kA9Bh3a+P73zUWq0jL00+xddDRsRqZGY2/8GA30HwQtEfo/D3w==
X-Received: by 2002:a05:6a00:23cc:b0:837:f111:b70 with SMTP id d2e1a72fcca58-845269fc6c5mr1485582b3a.4.1781673616202;
        Tue, 16 Jun 2026 22:20:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:23cc:b0:837:f111:b70 with SMTP id d2e1a72fcca58-845269fc6c5mr1485548b3a.4.1781673615595;
        Tue, 16 Jun 2026 22:20:15 -0700 (PDT)
Received: from localhost.localdomain (122-63-72-97.mobile.spark.co.nz. [122.63.72.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm17234894b3a.38.2026.06.16.22.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:20:15 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v6][makedumpfile 02/10] Implement kernel kallsyms resolving
Date: Wed, 17 Jun 2026 17:18:26 +1200
Message-ID: <20260617051834.95404-3-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617051834.95404-1-ltao@redhat.com>
References: <20260617051834.95404-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TN7pbhaWPTUeI8fXagJLZBUbbAGDIp-52fLjcZyQ9UI_1781673616
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_222020_956566_3A3BA390 
X-CRM114-Status: GOOD (  25.69  )
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

This patch will parse kernel's kallsyms data. During the parsing
process, the .init_ksyms sections of makedumpfile and the
extensions will be iterated, so the kallsyms symbols which belongs
to vmlinux can be resolved at this moment.

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile       |   2 +-
 kallsyms.c     | 392 +++++++++++++++++++++++++++++++++++++++++++++++++
 kallsyms.h     |  83 +++++++++++
 makedumpfile.c |   3 +
 makedumpfile.h |  11 ++
 5 files changed, 490 insertions(+), 1 deletion(-)
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h

diff --git a/Makefile b/Makefile
index 9482332..3cd729f 100644
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
index 0000000..a55dcc6
--- /dev/null
+++ b/kallsyms.c
@@ -0,0 +1,392 @@
+#define _GNU_SOURCE
+#include <stdbool.h>
+#ifdef EXTENSION
+#include <stdlib.h>
+#include <stdint.h>
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
+/* makedumpfile & extensions' .init_ksyms section range array */
+static struct section_range **sr = NULL;
+static int sr_len = 0;
+static int sr_cap = 0;
+
+/* Which mod's kallsyms should be inited? */
+static char **mods = NULL;
+static int mods_len = 0;
+static int mods_cap = 0;
+
+INIT_MOD_SYM(vmlinux, _stext);
+
+/*
+ * Utility: add elem to arr, which can auto extend its capacity.
+ * (*arr) is a pointer array, holding pointers of elem
+*/
+bool add_to_arr(void ***arr, int *arr_len, int *arr_cap, void *elem)
+{
+	void *tmp;
+	int new_cap = 0;
+
+	if (*arr == NULL) {
+		*arr_len = 0;
+		new_cap = 4;
+	} else if (*arr_len >= *arr_cap) {
+		new_cap = (*arr_cap) + ((*arr_cap) >> 1);
+	}
+
+	if (new_cap) {
+		tmp = reallocarray(*arr, new_cap, sizeof(void *));
+		if (!tmp)
+			goto no_mem;
+		*arr = tmp;
+		*arr_cap = new_cap;
+	}
+
+	(*arr)[(*arr_len)++] = elem;
+	return true;
+
+no_mem:
+	ERRMSG("Not enough memory!\n");
+	return false;
+}
+
+/*
+ * Utility: add uniq string to arr, which can auto extend its capacity.
+*/
+bool push_uniq_str(void ***arr, int *arr_len, int *arr_cap, char *str)
+{
+	for (int i = 0; i < (*arr_len); i++) {
+		if (!strcmp((*arr)[i], str))
+			/* String already exists, skip it */
+			return true;
+	}
+	return add_to_arr(arr, arr_len, arr_cap, str);
+}
+
+static bool add_ksym_modname(char *modname)
+{
+	return push_uniq_str((void ***)&mods, &mods_len, &mods_cap, modname);
+}
+
+bool check_ksyms_require_modname(char *modname, int *total)
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
+static void cleanup_ksyms_modname(void)
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
+ * Used by makedumpfile and extensions, to register their .init_ksyms section.
+ * so kallsyms can know which module/sym should be inited.
+*/
+REGISTER_SECTION(ksym)
+
+static void cleanup_ksyms_section_range(void)
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
+static uint64_t absolute_percpu(uint64_t base, int32_t val)
+{
+	if (val >= 0)
+		return (uint64_t)val;
+	else
+		return base - 1 - val;
+}
+
+static uint64_t calc_addr_absolute_percpu(struct ksym_info *p)
+{
+	return absolute_percpu(kallsyms_relative_base, p->value);
+}
+
+static uint64_t calc_addr_relative_base(struct ksym_info *p)
+{
+	return p->value + kallsyms_relative_base;
+}
+
+static uint64_t calc_addr_place_relative(struct ksym_info *p)
+{
+	return SYMBOL(kallsyms_offsets) + p->index * sizeof(uint32_t) +
+		(int32_t)kallsyms_offsets[p->index];
+}
+
+static bool parse_kernel_kallsyms(void)
+{
+	char buf[BUFSIZE];
+	int index = 0, i, j;
+	uint8_t *compressd_data;
+	uint8_t *uncompressd_data;
+	uint8_t len, len_old;
+	struct ksym_info **p;
+	uint64_t (*calc_addr)(struct ksym_info *);
+	struct ksym_info *stext_p;
+	bool skip_symbol;
+
+	for (i = 0; i < kallsyms_num_syms; i++) {
+		skip_symbol = false;
+		memset(buf, 0, BUFSIZE);
+		len = kallsyms_names[index];
+		if (len & 0x80) {
+			index++;
+			len_old = len;
+			len = kallsyms_names[index];
+			if (len & 0x80) {
+				ERRMSG("BUG! Unexpected 3-byte length, "
+				       "should be detected in init_kernel_kallsyms()\n");
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
+			if (strlen(buf) + strlen((char *)uncompressd_data) >= BUFSIZE) {
+				skip_symbol = true;
+				break;
+			}
+			strcat(buf, (char *)uncompressd_data);
+			compressd_data++;
+		}
+
+		if (skip_symbol)
+			continue;
+
+		/* Now check if the symbol is we wanted */
+		for (j = 0; j < sr_len; j++) {
+			for (p = (struct ksym_info **)(sr[j]->start);
+			     p < (struct ksym_info **)(sr[j]->stop);
+			     p++) {
+				if (!strcmp((*p)->modname, "vmlinux") &&
+				    !strcmp((*p)->symname, &buf[1])) {
+					(*p)->value = kallsyms_offsets[i];
+					(*p)->index = i;
+				}
+			}
+		}
+	}
+
+	/* Check the approach for calc absolute kallsyms address
+	 *
+	 * A complete comment of each approaches please refer to:
+	 * https://github.com/osandov/drgn/commit/744f36ec3c3f64d7e1323a0037898158698585c4
+	 */
+	if (!MOD_SYM_EXIST(vmlinux, _stext)) {
+		ERRMSG("symbol _stext not found!\n");
+		goto out;
+	}
+
+	stext_p = GET_MOD_SYM_PTR(vmlinux, _stext);
+
+	if (SYMBOL(_stext) == calc_addr_absolute_percpu(stext_p)) {
+		calc_addr = calc_addr_absolute_percpu;
+	} else if (SYMBOL(_stext) == calc_addr_relative_base(stext_p)) {
+		calc_addr = calc_addr_relative_base;
+	} else if (SYMBOL(_stext) == calc_addr_place_relative(stext_p)) {
+		calc_addr = calc_addr_place_relative;
+	} else {
+		ERRMSG("Wrong calculate kallsyms symbol value!\n");
+		goto out;
+	}
+
+	/* Now do the calc */
+	for (j = 0; j < sr_len; j++) {
+		for (p = (struct ksym_info **)(sr[j]->start);
+		     p < (struct ksym_info **)(sr[j]->stop);
+		     p++) {
+			if (!strcmp((*p)->modname, "vmlinux") &&
+			    SYM_EXIST(*p)) {
+				(*p)->value = calc_addr(*p);
+			}
+		}
+	}
+
+	return true;
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
+	if (SYMBOL(kallsyms_names) != NOT_FOUND_SYMBOL) {
+		vmcore_info_ready = true;
+	} else {
+		vmcore_info_ready = false;
+	}
+	return true;
+}
+
+/*
+ * Makedumpfile's .init_ksyms section
+*/
+extern struct ksym_info *__start_init_ksyms[];
+extern struct ksym_info *__stop_init_ksyms[];
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
+		ERRMSG("vmcoreinfo not ready for kallsyms!\n");
+		return ret;
+	}
+
+	if (!readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms,
+		sizeof(kallsyms_num_syms))) {
+		ERRMSG("Can't get kallsyms_num_syms!\n");
+		goto out;
+	}
+	if (SYMBOL(kallsyms_relative_base) != NOT_FOUND_SYMBOL) {
+		if (!readmem(VADDR, SYMBOL(kallsyms_relative_base),
+			&kallsyms_relative_base, sizeof(kallsyms_relative_base))) {
+			ERRMSG("Can't get kallsyms_relative_base!\n");
+			goto out;
+		}
+	}
+
+	kallsyms_offsets = malloc(sizeof(uint32_t) * kallsyms_num_syms);
+	if (!kallsyms_offsets)
+		goto no_mem;
+	if (!readmem(VADDR, SYMBOL(kallsyms_offsets), kallsyms_offsets,
+		kallsyms_num_syms * sizeof(uint32_t))) {
+		ERRMSG("Can't get kallsyms_offsets!\n");
+		goto out;
+	}
+
+	kallsyms_token_index = malloc(token_index_size);
+	if (!kallsyms_token_index)
+		goto no_mem;
+	if (!readmem(VADDR, SYMBOL(kallsyms_token_index), kallsyms_token_index,
+		token_index_size)) {
+		ERRMSG("Can't get kallsyms_token_index!\n");
+		goto out;
+	}
+
+	last_token = SYMBOL(kallsyms_token_table) + kallsyms_token_index[UINT8_MAX];
+	do {
+		if (!readmem(VADDR, last_token++, &data, 1)) {
+			ERRMSG("Can't get last_token!\n");
+			goto out;
+		}
+	} while(data);
+	len = last_token - SYMBOL(kallsyms_token_table);
+	kallsyms_token_table = malloc(len);
+	if (!kallsyms_token_table)
+		goto no_mem;
+	if (!readmem(VADDR, SYMBOL(kallsyms_token_table), kallsyms_token_table, len)) {
+		ERRMSG("Can't get kallsyms_token_table!\n");
+		goto out;
+	}
+
+	for (len = 0, i = 0; i < kallsyms_num_syms; i++) {
+		if (!readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1)) {
+			ERRMSG("Can't get kallsyms_names len1!\n");
+			goto out;
+		}
+		/*
+		 * The 2-byte representation was added in commit 73bbb94466fd3
+		 * ("kallsyms: support "big" kernel symbols") in v6.1, thus for
+		 * v6.1+, they indicate a long symbol, but for kernel versions
+		 * prior to v6.1, they might be ambiguous.
+		 */
+		if (data & 0x80) {
+			len += 1;
+			data_old = data;
+			if (!readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1)) {
+				ERRMSG("Can't get kallsyms_names len2!\n");
+				goto out;
+			}
+			if (data & 0x80) {
+				ERRMSG("BUG! Unexpected 3-byte length "
+					"encoding in kallsyms names\n");
+				goto out;
+			}
+			data = (data_old & 0x7F) | (data << 7);
+		}
+		len += data + 1;
+	}
+	kallsyms_names = malloc(len);
+	if (!kallsyms_names)
+		goto no_mem;
+	if (!readmem(VADDR, SYMBOL(kallsyms_names), kallsyms_names, len)) {
+		ERRMSG("Can't get kallsyms_names!\n");
+		goto out;
+	}
+
+	ret = parse_kernel_kallsyms();
+	goto out;
+
+no_mem:
+	ERRMSG("Not enough memory!\n");
+out:
+	if (kallsyms_offsets) {
+		free(kallsyms_offsets);
+		kallsyms_offsets = NULL;
+	}
+	if (kallsyms_token_index) {
+		free(kallsyms_token_index);
+		kallsyms_token_index = NULL;
+	}
+	if (kallsyms_token_table) {
+		free(kallsyms_token_table);
+		kallsyms_token_table = NULL;
+	}
+	if (kallsyms_names) {
+		free(kallsyms_names);
+		kallsyms_names = NULL;
+	}
+	return ret;
+}
+#else /* EXTENSION */
+
+bool read_vmcoreinfo_kallsyms(void)
+{
+	return true;
+}
+
+#endif /* EXTENSION */
+
diff --git a/kallsyms.h b/kallsyms.h
new file mode 100644
index 0000000..5d605ce
--- /dev/null
+++ b/kallsyms.h
@@ -0,0 +1,83 @@
+#ifndef _KALLSYMS_H
+#define _KALLSYMS_H
+
+#include <stdint.h>
+#include <stdbool.h>
+
+struct ksym_info {
+	/********in******/
+	char *modname;
+	char *symname;
+	bool sym_required;
+	/********out*****/
+	uint64_t value;
+	int index;	// -1 if sym not found
+};
+
+#define INIT_MOD_SYM_RQD(MOD, SYM, R)			\
+	struct ksym_info _##MOD##_##SYM = {		\
+		#MOD, #SYM, R, 0, -1			\
+	};						\
+	__attribute__((section(".init_ksyms"), used))	\
+	struct ksym_info * _ptr_##MOD##_##SYM = &_##MOD##_##SYM
+
+#define GET_MOD_SYM(MOD, SYM) (_##MOD##_##SYM.value)
+#define GET_MOD_SYM_PTR(MOD, SYM) (&_##MOD##_##SYM)
+#define MOD_SYM_EXIST(MOD, SYM) (_##MOD##_##SYM.index >= 0)
+#define SYM_EXIST(p) ((p)->index >= 0)
+
+/*
+ * Required syms will be checked automatically before extension running.
+ * Optinal syms should be checked manually at extension runtime.
+ */
+#define INIT_MOD_SYM(MOD, SYM) INIT_MOD_SYM_RQD(MOD, SYM, 1)
+#define INIT_OPT_MOD_SYM(MOD, SYM) INIT_MOD_SYM_RQD(MOD, SYM, 0)
+
+struct section_range {
+	char *start;
+	char *stop;
+};
+
+#define REGISTER_SECTION(T)						\
+bool register_##T##_section(char *start, char *stop)			\
+{									\
+	struct section_range *new_sr;					\
+	struct T##_info **p;						\
+	bool ret = false;						\
+									\
+	if (!start || !stop) {						\
+		ERRMSG("Invalid section start/stop\n");			\
+		goto out;						\
+	}								\
+									\
+	for (p = (struct T##_info **)start;				\
+	     p < (struct T##_info **)stop;				\
+	     p++) {							\
+		if (!add_##T##_modname((*p)->modname))			\
+			goto out;					\
+	}								\
+									\
+	new_sr = malloc(sizeof(struct section_range));			\
+	if (!new_sr) {							\
+		ERRMSG("Not enough memory!\n");				\
+		goto out;						\
+	}								\
+	new_sr->start = start;						\
+	new_sr->stop = stop;						\
+	if (!add_to_arr((void ***)&sr, &sr_len, &sr_cap, new_sr)) {	\
+		free(new_sr);						\
+		goto out;						\
+	}								\
+	ret = true;							\
+out:									\
+	return ret;							\
+}
+
+bool add_to_arr(void ***arr, int *arr_len, int *arr_cap, void *elem);
+bool push_uniq_str(void ***arr, int *arr_len, int *arr_cap, char *str);
+bool check_ksyms_require_modname(char *modname, int *total);
+bool register_ksym_section(char *start, char *stop);
+bool read_vmcoreinfo_kallsyms(void);
+bool init_kernel_kallsyms(void);
+#endif /* _KALLSYMS_H */
+
diff --git a/makedumpfile.c b/makedumpfile.c
index 80637a7..53a8812 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -27,6 +27,7 @@
 #include <limits.h>
 #include <assert.h>
 #include <zlib.h>
+#include "kallsyms.h"
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -3114,6 +3115,8 @@ read_vmcoreinfo_from_vmcore(off_t offset, unsigned long size, int flag_xen_hv)
 		if (!read_vmcoreinfo())
 			goto out;
 	}
+	read_vmcoreinfo_kallsyms();
+
 	close_vmcoreinfo();
 
 	ret = TRUE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 66cbd29..19bb6a5 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -259,6 +259,7 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
 #define UINT(ADDR)	*((unsigned int *)(ADDR))
 #define ULONG(ADDR)	*((unsigned long *)(ADDR))
 #define ULONGLONG(ADDR)	*((unsigned long long *)(ADDR))
+#define VOID_PTR(ADDR)	*((void **)(ADDR))
 
 
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
2.54.0


