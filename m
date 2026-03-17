Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A1FFED9E3
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3DlyxLOawV1cgn0Q3P18Q7hAiqVexQlOrAP7ODKUII8=; b=retZ7yR3NtgEQovaYfOBcfiBQt
	K35pKuGgJM6YOfo7uaByKy8O7CwW0chuGwp1wnddiXZrGxBo8rdQknSQu5/2qJbzcpjJuAikrMzu9
	nDiHjIfls1W7uiWV7DdBPytgUGiCEuLbb8d/PQht7lfZv7aiMJARNeVe5AlmALyDsdeROsYexyM7i
	6jgHzCIqsYs2I8e7p47fZNBKTpAEk/mlYK3vHj4FMyE5l00K1HlHpjWodXGdx/c9k5eyBwGz7eTDn
	D9a5P2Hi2upggh4HH//KJge0HJTBKEAH1Tbd4GFWooFke8kd/DWvXpep9msDT6mpzJjsO4n+iH+AT
	WOEzJHXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W40-00000006hEF-01jm;
	Tue, 17 Mar 2026 15:10:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W3x-00000006hDm-05Fk
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 15:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DlyxLOawV1cgn0Q3P18Q7hAiqVexQlOrAP7ODKUII8=;
	b=hZVLWqFAErzV3G4kMmPaIWHaQoRn7y6ZJucLdIS06bwr3Et5Uj5B0gbJgcEqELCiCKZt+s
	qPKTm9tpaaOY+20UFu5/kZotxD4Daqc0IUwty4OIBHpkLLxnrPKR4fdShZCXddyHzhKQnM
	ApY6Z+m8H0ktm3d9AX05L14S+4hMYCM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-coEdihF_PoeFLymkErDl1A-1; Tue, 17 Mar 2026 11:09:02 -0400
X-MC-Unique: coEdihF_PoeFLymkErDl1A-1
X-Mimecast-MFC-AGG-ID: coEdihF_PoeFLymkErDl1A_1773760141
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82a0686edbcso2972502b3a.3
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 08:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760141; x=1774364941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DlyxLOawV1cgn0Q3P18Q7hAiqVexQlOrAP7ODKUII8=;
        b=CEQBUAJd1YOmOyASffPo4Y0O0XL8LXvQo3+kzWPTfJF0ZUev/azoEwwiZ6yijACJA+
         69t4W2C/monaL7ODoq5Kjky8Tzd3rqFo+mtLc43aXaWtAXQlQ+T1U9law6e0k9pJVKBr
         NbBM2SITAQ6UqWalQ3Iqo5AB75cEOIPuPu0A4HQS8el3CdeWnSvHc7JFXCiw2mm+wSxn
         rFHZqRkBekqDvC0ONe1gI9xHZjl/391WV6833JWoZpzrSNPGc7OO+mqb+ZXEA7wzEXdo
         1qktEbgQ8m/b9YObHEUtHyQk9ah1OAGdupUGGI5H9fd+Dcj1JvxiyBjc8BZXI4P0Y6oh
         Ov0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB+PwgYgRJc4eDk3sW6RBxqO7/Z7y12xT61f3fA/XCtL679yScig+hxUvGH2et+EsFybRCMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YziML1D18PhBpn7DWcR4yffwKpY9fAOxMt5K6ipugdOA0GPWL/r
	lxgJ7xDp2nnDUyf979IcDPigjjQ1lHHrYDRV8RAIkhNUtZo5P4j5zlamXWeD6EEkPrcopyoo3CK
	u6216tNYKPC2/nczsCS1RpxVDBz9idCkReAYfBgulukIx4F5SEPJDGvisKUiuyQ==
X-Gm-Gg: ATEYQzxXrAY//w7X2y9z8HJZff7kxmVBaKpe41ukI1Lnz6ri9AVmVzSKwF3DYjunoSX
	2lF26iz9h9h8uleBAXdXPX/P6u3Hzs3MGibKpzErmB6Pj/UYAJxsLVyjkdOq8YhwBD8kndG+AMM
	x4z/zSjUAxowYpvsfWQOhldwmPz96yyP5TEG9WJwKpXyrYQ5UWQM04Y1R5SLyfq0+PSJZbUfUCz
	xD/ep/4BoYnYULPnYvdqSRdAN32jxIQopPYY/xTI3mCa+Z6dNLl27DnaKCOWp8SEtXi7960O7f/
	tciENCnaI02A5joMH67vGvQiKi+6JR6FY1x8qNb8iPnJg+tppB+uGjsXvvIpzdshddiUaWq/LMZ
	mSJOfwwMp3LulSsKh6xD0WFyTrXekxmc5JQ==
X-Received: by 2002:aa7:88d3:0:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-82a198d0ac7mr15001217b3a.32.1773760140441;
        Tue, 17 Mar 2026 08:09:00 -0700 (PDT)
X-Received: by 2002:aa7:88d3:0:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-82a198d0ac7mr15001185b3a.32.1773760139930;
        Tue, 17 Mar 2026 08:08:59 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340417sm16993404b3a.39.2026.03.17.08.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:08:59 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v4][makedumpfile 2/7] Implement kernel kallsyms resolving
Date: Wed, 18 Mar 2026 04:07:38 +1300
Message-ID: <20260317150743.69590-3-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260317150743.69590-1-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jBxYSTV_j8jnZbryw-gUP7h9JZSGOG4Z8GtfG5bPfXY_1773760141
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_081029_213176_E232D4A9 
X-CRM114-Status: GOOD (  26.84  )
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

Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile       |   2 +-
 kallsyms.c     | 350 +++++++++++++++++++++++++++++++++++++++++++++++++
 kallsyms.h     |  91 +++++++++++++
 makedumpfile.c |   3 +
 makedumpfile.h |  11 ++
 5 files changed, 456 insertions(+), 1 deletion(-)
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h

diff --git a/Makefile b/Makefile
index 15a4ba0..a57185e 100644
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
index 0000000..f7737cb
--- /dev/null
+++ b/kallsyms.c
@@ -0,0 +1,350 @@
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
+INIT_KERN_SYM(_stext);
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
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
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
+#define BUFLEN 1024
+static bool parse_kernel_kallsyms(void)
+{
+	char buf[BUFLEN];
+	int index = 0, i, j;
+	uint8_t *compressd_data;
+	uint8_t *uncompressd_data;
+	uint8_t len, len_old;
+	struct ksym_info **p;
+	uint64_t (*calc_addr)(struct ksym_info *);
+	struct ksym_info *stext_p;
+
+	for (i = 0; i < kallsyms_num_syms; i++) {
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
+				goto next_symbol;
+			}
+			strcat(buf, (char *)uncompressd_data);
+			compressd_data++;
+		}
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
+next_symbol:
+	}
+
+	/* Check the approach for calc absolute kallsyms address
+	 *
+	 * A complete comment of each approaches please refer to:
+	 * https://github.com/osandov/drgn/commit/744f36ec3c3f64d7e1323a0037898158698585c4
+	 */
+	if (!KERN_SYM_EXIST(_stext)) {
+		fprintf(stderr, "%s: symbol _stext not found!\n", __func__);
+		goto out;
+	}
+
+	stext_p = GET_KERN_SYM_PTR(_stext);
+
+	if (SYMBOL(_stext) == calc_addr_absolute_percpu(stext_p)) {
+		calc_addr = calc_addr_absolute_percpu;
+	} else if (SYMBOL(_stext) == calc_addr_relative_base(stext_p)) {
+		calc_addr = calc_addr_relative_base;
+	} else if (SYMBOL(_stext) == calc_addr_place_relative(stext_p)) {
+		calc_addr = calc_addr_place_relative;
+	} else {
+		fprintf(stderr, "%s: Wrong calculate kallsyms symbol value!\n", __func__);
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
+	vmcore_info_ready = true;
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
+		fprintf(stderr, "%s: vmcoreinfo not ready for kallsyms!\n",
+			__func__);
+		return ret;
+	}
+
+	if (!register_ksym_section((char *)__start_init_ksyms,
+				   (char *)__stop_init_ksyms))
+		return ret;
+
+	readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms,
+		sizeof(kallsyms_num_syms));
+	if (SYMBOL(kallsyms_relative_base) != NOT_FOUND_SYMBOL)
+		readmem(VADDR, SYMBOL(kallsyms_relative_base),
+			&kallsyms_relative_base, sizeof(kallsyms_relative_base));
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
+		/*
+		 * The 2-byte representation was added in commit 73bbb94466fd3
+		 * ("kallsyms: support "big" kernel symbols") in v6.1, thus for
+		 * v6.1+, they indicate a long symbol, but for kernel versions
+		 * prior to v6.1, they might be ambiguous.
+		 */
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
\ No newline at end of file
diff --git a/kallsyms.h b/kallsyms.h
new file mode 100644
index 0000000..3791284
--- /dev/null
+++ b/kallsyms.h
@@ -0,0 +1,91 @@
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
+#define QUATE(x) #x
+#define INIT_MOD_SYM_RQD(MOD, SYM, R)			\
+	struct ksym_info _##MOD##_##SYM = {		\
+		QUATE(MOD), QUATE(SYM), R, 0, -1	\
+	};						\
+	__attribute__((section(".init_ksyms"), used))	\
+	struct ksym_info * _ptr_##MOD##_##SYM = &_##MOD##_##SYM
+
+#define GET_MOD_SYM(MOD, SYM) (_##MOD##_##SYM.value)
+#define GET_MOD_SYM_PTR(MOD, SYM) (&_##MOD##_##SYM)
+#define MOD_SYM_EXIST(MOD, SYM) (_##MOD##_##SYM.index >= 0)
+#define SYM_EXIST(p) ((p)->index >= 0)
+
+#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
+#define GET_KERN_SYM_PTR(SYM) GET_MOD_SYM_PTR(vmlinux, SYM)
+#define KERN_SYM_EXIST(SYM) MOD_SYM_EXIST(vmlinux, SYM)
+
+/*
+ * Required syms will be checked automatically before extension running.
+ * Optinal syms should be checked manually at extension runtime.
+ */
+#define INIT_MOD_SYM(MOD, SYM) INIT_MOD_SYM_RQD(MOD, SYM, 1)
+#define INIT_OPT_MOD_SYM(MOD, SYM) INIT_MOD_SYM_RQD(MOD, SYM, 0)
+
+#define INIT_KERN_SYM(SYM) INIT_MOD_SYM(vmlinux, SYM)
+#define INIT_OPT_KERN_SYM(SYM) INIT_OPT_MOD_SYM(vmlinux, SYM)
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
+		fprintf(stderr, "%s: Invalid section start/stop\n",	\
+			__func__);					\
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
+		fprintf(stderr, "%s: Not enough memory!\n", __func__);	\
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
index 134eb7a..0f13743 100644
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
2.47.0


