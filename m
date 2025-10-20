Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED9BCCD1A2
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h2HSeUVdqi7/WGfMavy3xSEwJmzlm2vwAUH+Jfa8S34=; b=XIYpzO0l28hAUI9eWVyaQ6UDLZ
	xSpP8tv1vqAvQpfay/JdN7YMYwfb6w1lrgitnDdCK+PV3IE1GnZVX+W6Ev8e9IiJgkRpSbN4C93kZ
	6flotO2g8pGPqz+tJHRikeL+VfJLzr5nqPN+4bCqbxbwAVOBvGriw1Cke0m9bhfbPwFKrvnmRXpOe
	5MmIgaqP0BN77f+b9UeZ6D1Uvf6PjPySv0J55B9nEzQG+L73aDv1+z7pjf/CosotC2yQRoD3VAO5v
	QzQsh2Gpk/x4YVZSfqqgPnWNjLjdv5BExAVj/L0koW25mKXmWPjplNrpm51F2a+s+8Ib4iDvvxmdQ
	MSG1J9PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyLI-0000000FBR1-2Tkv;
	Mon, 20 Oct 2025 22:27:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyLG-0000000FBQR-1oNZ
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:27:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2HSeUVdqi7/WGfMavy3xSEwJmzlm2vwAUH+Jfa8S34=;
	b=G6xiz+4iYsxwi3Y8aj+Lou23aS3g/f3294dyu+F4yqdKJb4HVwZHSwRsVPD/bUc6fRUoy8
	ni2VzRp7H2phElDvE+ngMpGwyx0nJLiy28jhHMkAkF0rsIH3zEdbTngMB2DzqalPj8Qa+6
	ui9Dq5THpiWD7R19A1jTIzMb2KUQ27I=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-B113nSbwPUerVAT9Yt81Rg-1; Mon, 20 Oct 2025 18:24:52 -0400
X-MC-Unique: B113nSbwPUerVAT9Yt81Rg-1
X-Mimecast-MFC-AGG-ID: B113nSbwPUerVAT9Yt81Rg_1760999091
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-792722e4ebeso4475160b3a.3
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999091; x=1761603891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2HSeUVdqi7/WGfMavy3xSEwJmzlm2vwAUH+Jfa8S34=;
        b=pdYnzQPcxDmXpna9UznEJdhCFKf24ynCB4cxS84jfzJz0ZSuGv/f4kskohMfxvWPp2
         NLOAfuMpJ35P8DcZILDTDIbpEb75Q9GvOqzS0JCMK7b9DCjnQ0couoOJty1dT3/UGja3
         AzJ4msL9JH+S4IkkKRKACc0I2XPmSZOdVT1A9k3Rojre5vxiz06/6jCxiLtO1nmORASY
         CUjH8yqV5zAVegDZdUwKHfcf0RPRCMmfrjW2IqddQqkHDvQ35CGSPNcrU5lB2xfYPb5s
         PPUR7yamOzg+79obHzYwSZKglq/+bNGXskKC9ReEdMQgI/uYy1nR020ComXc7+YVF7r3
         p0JA==
X-Forwarded-Encrypted: i=1; AJvYcCXcaX14XAw/ohl9UvRenzI1H93gI6EAZbPLciIF+Fo/RuACQLCyPAmeKOnB8HDn7c6cQUzP0w==@lists.infradead.org
X-Gm-Message-State: AOJu0YztZgFI56siLlmHotOdGkvGFhGkfWLADE8ahZsZMXg94kvg161C
	lmXFZ4GQVQfH520sEL1xSkCp65AHYOjo4K+oYntvWQcEvV01ENc+l2WK346vd2mx9OM8DpUoGbe
	oDq2l+MYtJIYGgGyx9D1ok6PIIVf6t+MIBgCxY+5xrxnRJ+fszoNsl6ZjtPMRsrWfuzLSZw==
X-Gm-Gg: ASbGnct19jvj6+kCwgllE/j+j+ORk0jz0zxUORe0zhsovPAjuCwSIw+pFgH5daOjyW4
	io3FKcPFSqZb6iOkCwaz8UtEpTXXOTVUHjk3gHkqC+ajFUJ4f4VYc9G6P9m4JGRMpVjKHaO+55c
	TvJmctiIiItg/Ltup5pL0tFL8sgfpgW/zVaLN77JLEfAUuT+blKPeV8xv+REacxPlbGyj6yKpqf
	um0MthdZ+VrfFiNgYWGyr2OSCtkNQapDPj3aXky+EBEE9ALs9jx9jKvXRJeeeb0iA7jPqBRrK6C
	i9/CsJfo7yBjb1U8Nmy79H3k7AuBKbcbYnL0lyRq89hqIruhxYaT7ufwNhc3HCqTItmDvDAmu17
	qTGwqR06AARG9p4+qD9NV0i/TQtOAwuPzj0uXBpookiw=
X-Received: by 2002:a05:6a00:9518:b0:79a:bf97:7895 with SMTP id d2e1a72fcca58-7a220a08d3fmr17294614b3a.4.1760999091088;
        Mon, 20 Oct 2025 15:24:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgpwor7lVgAd/w1sKcVMk2kKsyFxwaRQuWzpMIRqKY+ojWY6mK9Gn1T97AeSm5KuqLEs8x3A==
X-Received: by 2002:a05:6a00:9518:b0:79a:bf97:7895 with SMTP id d2e1a72fcca58-7a220a08d3fmr17294593b3a.4.1760999090701;
        Mon, 20 Oct 2025 15:24:50 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:50 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 09/14] Implement kernel module's kallsyms resolving
Date: Tue, 21 Oct 2025 11:24:05 +1300
Message-ID: <20251020222410.8235-10-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DN9u6GYoEBp3PCJL8zD_53jXZ3LRO0dm3kWrITy9lfc_1760999091
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152702_541288_AD5356BC 
X-CRM114-Status: GOOD (  17.95  )
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

With kernel's kallsyms and btf ready, we can get any kernel types and
symbol addresses. So we can iterate kernel modules' linked list, and
parse & install each one of kernel module's structure to get its kallsyms
data.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 kallsyms.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 kallsyms.h |  19 ++++++++
 2 files changed, 145 insertions(+)

diff --git a/kallsyms.c b/kallsyms.c
index 116f857..f5859e9 100644
--- a/kallsyms.c
+++ b/kallsyms.c
@@ -4,6 +4,7 @@
 #include <assert.h>
 #include "makedumpfile.h"
 #include "kallsyms.h"
+#include "btf.h"
 
 static uint32_t *kallsyms_offsets = NULL;
 static uint16_t *kallsyms_token_index = NULL;
@@ -231,6 +232,131 @@ out:
 	return ret;
 }
 
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
+				en_tmp >= &symtable[0])
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
 /* Hash table utils */
 unsigned int hash_index(const char *name, unsigned int hash_size)
 {
diff --git a/kallsyms.h b/kallsyms.h
index 35bf89e..bc8f58b 100644
--- a/kallsyms.h
+++ b/kallsyms.h
@@ -13,7 +13,26 @@ struct syment {
 int init_kernel_kallsyms(void);
 int read_vmcoreinfo_kallsyms(void);
 struct syment *search_kallsyms_by_name(char *);
+uint64_t next_list(uint64_t);
 uint64_t get_kallsyms_value_by_name(char *);
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
 
 unsigned int hash_index(const char *, unsigned int);
 void hash_install(void **, unsigned int, void *, const char *,
-- 
2.47.0


