Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD275D2ED11
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 03:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dbrSCcYSU1a7stMpMZJw0pLijIgo95hYfq1R86mhC5k=; b=W0PVFbHibN0TCx+ngOre47EWJJ
	HVdnuJD/F26dIed1nHTPkKRwpx8RHstSL1+GerB+TyI/yFdhG/DcQo1vMHzaEr4e8GH8eCfQiq7Pm
	kbMHJ2LTKP27OR8Y5KxodqzBwP0xjQ9Bq7AzlAY3AGek7oHJD7rst+A7OhQ/nFFfJmwwzc42kxjlZ
	b5Y9aSfkqqobY8/zkG/jJBjoeG8lJRv4K5IaHrorgULafprWNb69Yo99ZKsRoVBBLbZ3Qa0WwD7eQ
	TOO65I3b+UjOxI7Lu8SBGIgFpo4wdJhiEDnbq7dNMbILFRlJe5SmNGGrnaYeWLuNoixQS7v+He9hl
	O/bQDCcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aZ-0000000383g-2QTk;
	Tue, 20 Jan 2026 03:39:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aU-0000000381y-48V3
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 03:39:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768880366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbrSCcYSU1a7stMpMZJw0pLijIgo95hYfq1R86mhC5k=;
	b=UqkWWsYGSOUKLjhVuarc6Ev6PjjefQany24vi3qj8q+njgZzLQ6Bd7+wJPH+k3jWrmB7LQ
	Kz1NkgUVQeDq6Dcu6mVU2vKYLks6F+5Kk/MyFsHP3pi1IZDKY9LlpsktE5iJzdp6Phwoec
	8E7V6N6rYRC5I/rakYECRMM1rL95Vwg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-i2VnqhhyP3-srufuO9ppjw-1; Mon, 19 Jan 2026 22:39:24 -0500
X-MC-Unique: i2VnqhhyP3-srufuO9ppjw-1
X-Mimecast-MFC-AGG-ID: i2VnqhhyP3-srufuO9ppjw_1768880364
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352b6ad49ddso274889a91.0
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 19:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880363; x=1769485163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dbrSCcYSU1a7stMpMZJw0pLijIgo95hYfq1R86mhC5k=;
        b=a9UH3LPVqBZMXnlVoizJ0/R3EjC/TZVLmg8/vJSlb2DxrchnuWJKhoOYVionNM3SgB
         KMKTy7NTVgPr3iaeBFVx+46MdBWF4SIyBbJMlYmjLO8tZL0TLUU5Z7/uqK02FC3dm+le
         E0KtpIARYJQERBa4sdwZa42SWRszok/KDbSdrYa+PkiomcpRwpu0SXJhRLzeeoOgXiyu
         gcbDnwxlZbA3cnb47B45vlwOPmcLSd4rPOdBaVoJ5NANICgQ2ErNeT1jT5jrlT0/A9Rp
         0lc9S5Fd4ih9NtjgecQuMnsfAS1hKITQtdFVn02G7uHpg4aGSV4c6azH/cIYfsCueBSa
         c5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUYsWX6tsG52Xp+hRyqtJUhJ/vT5HyuK2QiUfAvSMLGYxyUeEEu1lF2H3IUj3TwbsoqS91edA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnRZ1ZFwID2ftZmEFNwcD+PF0lLWKqsc8QWHktAQmiFDhixDLp
	aw7XDDFa9axv9R5qJkbTHrJud6QM+rj4miTFobKZ9yQEdSD0Y+L37zVdTKSuCvjNo00D19cUhVp
	H1NR+TbFDSTMNpjOAYQktEG93jha7L1fDuhfSsyc514SC7xJzWm+CKPlF8027aw==
X-Gm-Gg: AZuq6aJBCZ7Xh2nSFAgMRl1MVzBhUQrctx4Y5bX14HpaMEe7mY6PEnzzzCxqWJE05qA
	EROVr7n12Z0aXiR6WZXbevOM0sk5gG9IeHVPinPcgcdfjQYFeR4xj6xSqZBoJju3FIDYJfvfs3C
	KvuCVBIcfRgdQeKAwKUMZynIRQNgW1/Ed41I2DXCf9lvKudLq7XtsyTjlftnqmQtsBqG/jjN8Ww
	/doq1uCMhDr5gjxX4HFY/qj1Doj0RrMpOBX1Gj/3TxHiqko5ZXyvsF7s0e0ZzORm7UFSX96qtMl
	Y9/GX7r7QOYJeHKuAjvcm7iGc/32CeScU8+A5x8s5xKuYA37CFH6qQi5v8XP2Jyh+ZGZNmmJ3TA
	A4V6lTZt1d/tQ8lOQAA==
X-Received: by 2002:a17:90b:164c:b0:34f:62e7:4cec with SMTP id 98e67ed59e1d1-3527313c3f3mr8685272a91.5.1768880363611;
        Mon, 19 Jan 2026 19:39:23 -0800 (PST)
X-Received: by 2002:a17:90b:164c:b0:34f:62e7:4cec with SMTP id 98e67ed59e1d1-3527313c3f3mr8685265a91.5.1768880363257;
        Mon, 19 Jan 2026 19:39:23 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm13375935a91.13.2026.01.19.19.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:39:22 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3 3/8] Implement kernel modules' kallsyms resolving
Date: Tue, 20 Jan 2026 15:54:55 +1300
Message-ID: <20260120025500.25095-4-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260120025500.25095-1-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IE0xpLU77BP49eV5ANsgMNW2vSaWrRBoe7Q4U4qU4vs_1768880364
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_193927_096616_45FE6504 
X-CRM114-Status: GOOD (  16.74  )
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
parse each one of kernel module's structure to get its kallsyms data.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 kallsyms.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 kallsyms.h |   3 ++
 2 files changed, 114 insertions(+)

diff --git a/kallsyms.c b/kallsyms.c
index ecf64e0..9069c88 100644
--- a/kallsyms.c
+++ b/kallsyms.c
@@ -3,6 +3,7 @@
 #include <string.h>
 #include "makedumpfile.h"
 #include "kallsyms.h"
+#include "btf_info.h"
 
 static uint32_t *kallsyms_offsets = NULL;
 static uint16_t *kallsyms_token_index = NULL;
@@ -263,3 +264,113 @@ out:
 		free(kallsyms_names);
 	return ret;
 }
+
+#define MEMBER_OFF(S, M) \
+	GET_STRUCT_MEMBER_MOFF(S, M) / 8
+
+uint64_t next_list(uint64_t list)
+{
+	static int list_head_next_offset = 0;
+	static int list_head_next_size = 0;
+
+	struct struct_member_info smi;
+	uint64_t next = 0;
+
+	if (!list_head_next_size) {
+		INIT_STRUCT_MEMBER(list_head, next);
+		list_head_next_size = GET_STRUCT_MEMBER_MSIZE(list_head, next);
+		list_head_next_offset = MEMBER_OFF(list_head, next);
+	}
+	readmem(VADDR, list + list_head_next_offset, &next, list_head_next_size);
+	return next;
+}
+
+bool init_module_kallsyms(void)
+{
+	struct struct_member_info smi;
+	uint64_t modules, list, value = 0, symtab = 0, strtab = 0;
+	uint32_t st_name = 0;
+	int num_symtab, i, j;
+	struct syment *mod_syment;
+	char symname[512], ch;
+	bool ret = false;
+
+	modules = get_kallsyms_value_by_name("modules");
+	if (!modules) {
+		/* Not a failure if no module enabled */
+		ret = true;
+		goto out;
+	}
+
+	INIT_STRUCT_MEMBER(module, list);
+	INIT_STRUCT_MEMBER(module, core_kallsyms);
+	INIT_STRUCT_MEMBER(mod_kallsyms, symtab);
+	INIT_STRUCT_MEMBER(mod_kallsyms, num_symtab);
+	INIT_STRUCT_MEMBER(mod_kallsyms, strtab);
+	INIT_STRUCT_MEMBER(elf64_sym, st_name);
+	INIT_STRUCT_MEMBER(elf64_sym, st_value);
+
+	for (list = next_list(modules); list != modules; list = next_list(list)) {
+		readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, core_kallsyms) +
+				MEMBER_OFF(mod_kallsyms, num_symtab),
+			&num_symtab, GET_STRUCT_MEMBER_MSIZE(mod_kallsyms, num_symtab));
+		readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, core_kallsyms) +
+				MEMBER_OFF(mod_kallsyms, symtab),
+			&symtab, GET_STRUCT_MEMBER_MSIZE(mod_kallsyms, symtab));
+		readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, core_kallsyms) +
+				MEMBER_OFF(mod_kallsyms, strtab),
+			&strtab, GET_STRUCT_MEMBER_MSIZE(mod_kallsyms, strtab));
+		for (i = 0; i < num_symtab; i++) {
+			j = 0;
+			readmem(VADDR, symtab + i * GET_STRUCT_MEMBER_SSIZE(elf64_sym, st_value) +
+					MEMBER_OFF(elf64_sym, st_value),
+				&value, GET_STRUCT_MEMBER_MSIZE(elf64_sym, st_value));
+			readmem(VADDR, symtab + i * GET_STRUCT_MEMBER_SSIZE(elf64_sym, st_name) +
+					MEMBER_OFF(elf64_sym, st_name),
+				&st_name, GET_STRUCT_MEMBER_MSIZE(elf64_sym, st_name));
+			do {
+				readmem(VADDR, strtab + st_name + j++, &ch, 1);
+			} while (ch != '\0');
+			if (j == 1 || j > sizeof(symname))
+				/* Skip empty or too long string */
+				continue;
+			readmem(VADDR, strtab + st_name, symname, j);
+			if (is_unwanted_symbol(symname))
+				continue;
+			mod_syment = (struct syment *)calloc(1, sizeof(struct syment));
+			if (!mod_syment)
+				goto no_mem;
+			mod_syment->name = strdup(symname);
+			if (!mod_syment->name) {
+				free(mod_syment);
+				goto no_mem;
+			}
+			mod_syment->value = value;
+			name_hash_install(mod_syment);
+		}
+	}
+	ret = true;
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
+
+	for (int i = 0; i < NAME_HASH; i++) {
+		for (en = name_hash_table[i]; en;) {
+			en_tmp = en;
+			en = en->name_hash_next;
+			free(en_tmp->name);
+			free(en_tmp);
+		}
+	}
+}
diff --git a/kallsyms.h b/kallsyms.h
index a4fbe10..78af4ef 100644
--- a/kallsyms.h
+++ b/kallsyms.h
@@ -12,6 +12,9 @@ struct __attribute__((packed)) syment {
 
 bool read_vmcoreinfo_kallsyms(void);
 bool init_kernel_kallsyms(void);
+bool init_module_kallsyms(void);
+void cleanup_kallsyms(void);
+uint64_t next_list(uint64_t);
 uint64_t get_kallsyms_value_by_name(char *);
 
 #endif /* _KALLSYMS_H */
\ No newline at end of file
-- 
2.47.0


