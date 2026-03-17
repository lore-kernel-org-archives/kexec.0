Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9007EFED9E4
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YjndcD9pOtc6OSVLLlqE3Spn9uDZ87QYKg6XEUrIw04=; b=aSVMUDgndAqQ6kxMBcHTjD4s9O
	MVKWrnvxa4wD6oHLnZKefJoY2fdd+ub8ynVI7iV3ZYcUwj95h3YyX2TgKsks25jei/MejhjzDhwc1
	ooZeN1ASwmYzyIOa5t41EvKLlKUGv47G5SK8qChQdqzPsahyV0AZ474eHlJ2W8zeiSo6VlmRUA2Yk
	7NTCLdD9Tyh3fqKmkCZpSSRx/M4YKzBRmojg35JT9jSjUSfZpq6Ucjn/rc6ofPdfgk/6uomXy7FKJ
	EKscurfFLbFcpj1Snu7Wbgf2yFNhhwrNXsA72/mn/+4FkCePUR94hS5JYfWlo1i+SN4vdRUtBZ2oo
	oXIur7AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2n-00000006gyX-1v3E;
	Tue, 17 Mar 2026 15:09:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2i-00000006gwJ-3BQg
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 15:09:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjndcD9pOtc6OSVLLlqE3Spn9uDZ87QYKg6XEUrIw04=;
	b=NAfTaylg81z2oOo73sZ4waUgGVHBFl6GECbIIN/nzCoyd0d487VrDMoQhXARwuErLgE/e6
	Oe0mHGdnuPULwqsu81uE3WOwsWvr2240FtCV5CqeJRmy59zoIzXCi6avM0elWNObjKYyeR
	enOz62cVyybVRYY6xVesUgjQxz2RQGc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-2Y76edvhPhKWO9H9B2dsdQ-1; Tue, 17 Mar 2026 11:09:10 -0400
X-MC-Unique: 2Y76edvhPhKWO9H9B2dsdQ-1
X-Mimecast-MFC-AGG-ID: 2Y76edvhPhKWO9H9B2dsdQ_1773760149
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829ad972df6so3224915b3a.3
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 08:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760149; x=1774364949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YjndcD9pOtc6OSVLLlqE3Spn9uDZ87QYKg6XEUrIw04=;
        b=TiLbygUk59ngUn+aNoD9ihHIQQHQkTytPpq5tijUJN9h4eGaUUi7DDmwF+BmJOGH7m
         BMBXfKy8LGXfLrgPiIXU1ROWruRES8ONCeN/Dt7f+qqZwDaZ0tyrxm44/oFHJRmu9/T+
         B022H2bC/IWRx0jzzFf3SaIaKvixFVgXuNN1wU969OFYmU0C/a6EcYHZ/hxChz6Io+fh
         O9oHA/fs6451tfxnBywTcCRRdTJhaEsJA+JdtObTEBP3agc9lby1lir6YmtnwSeKlnFY
         XqTwXnlnj0Li8Xeg41PryZbKrY2i4zltkk7nNRh0w6p79pmHR7tfm289AUfl47XxZ0no
         9pBg==
X-Forwarded-Encrypted: i=1; AJvYcCXnMHT174DZ1LdVKnOKtAwKjEwxPiYeCb00MIdvlF3EC+XDHNNuGYy4llnWjQBHEbPMux25qg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzGPKZ7EnLbUlc0oTcqL1Ahew4ZXs0+aWNsOwY5pJGRd37G4y9h
	FwtnDZYIFbDxy2YPAnTMYRElADv6QWf/yDkreq7ed+XKvWsAZW86Wwfo3Gd7R6zT6VltA2V7z2R
	RPpyyzH4/8rH+BWxNWqsPnRike3GlACDKMBmClYQNzPevP6zfIPvypBysLqwbrw==
X-Gm-Gg: ATEYQzzGe4SxmJVCzo+k4Ei7aIRUjEhHEBGyfRzplkLO1Sbxo42UpuBAmWn0j9JSLYN
	U7BjuxwIkHyJY0mXmMYjjdJ22aMh/LER4Q59+bHQCXXniz0LiTYvYP08o3Q9wFll1RuAQeYcg6i
	QDsn/rr5qdfmVYzfj2gk6Q4n343q43fhoOvIEN+7ESh2Tl7G0/NzLmJjDU+4SmYtugRiHnR5LRw
	21INcQrTOUQLXsdav54AoejIV/11HTwpvuKRpkOxM2J6Er+QFXVpKWAz2LuEqcbU5IvJxwf3aeP
	Wh+KgeV0LWHWIc+pKByY3cgbIxMhE1K7qYu+Ien2B0vNpYPcQA1hTngJZhwWRpAw4XDO/k2CsAb
	97miNRrb1L8tJpoiZG5JGeii4n8zWupVq1Q==
X-Received: by 2002:a05:6a00:8018:b0:824:afe1:f7e3 with SMTP id d2e1a72fcca58-82a19722448mr14645721b3a.15.1773760148936;
        Tue, 17 Mar 2026 08:09:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:8018:b0:824:afe1:f7e3 with SMTP id d2e1a72fcca58-82a19722448mr14645697b3a.15.1773760148288;
        Tue, 17 Mar 2026 08:09:08 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340417sm16993404b3a.39.2026.03.17.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:09:07 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v4][makedumpfile 4/7] Implement kernel module's kallsyms resolving
Date: Wed, 18 Mar 2026 04:07:40 +1300
Message-ID: <20260317150743.69590-5-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260317150743.69590-1-ltao@redhat.com>
References: <20260317150743.69590-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: odFLmFtTO1jgmRTd1BTIcHWiFWqwzHJ8aa9lfYKnS9w_1773760149
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_080914_941224_13251CDA 
X-CRM114-Status: GOOD (  15.95  )
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
At this time, kernel modules' kallsyms symbol defined within .init_ksyms
section will be resolved.

Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 kallsyms.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 kallsyms.h |   3 ++
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/kallsyms.c b/kallsyms.c
index f7737cb..f07b0ee 100644
--- a/kallsyms.c
+++ b/kallsyms.c
@@ -3,6 +3,7 @@
 #include <string.h>
 #include "makedumpfile.h"
 #include "kallsyms.h"
+#include "btf_info.h"
 
 static uint32_t *kallsyms_offsets = NULL;
 static uint16_t *kallsyms_token_index = NULL;
@@ -347,4 +348,126 @@ out:
 		kallsyms_names = NULL;
 	}
 	return ret;
-}
\ No newline at end of file
+}
+
+INIT_KERN_SYM(modules);
+
+INIT_KERN_STRUCT_MEMBER(list_head, next);
+INIT_KERN_STRUCT_MEMBER(module, list);
+INIT_KERN_STRUCT_MEMBER(module, name);
+INIT_KERN_STRUCT_MEMBER(module, core_kallsyms);
+INIT_KERN_STRUCT_MEMBER(mod_kallsyms, symtab);
+INIT_KERN_STRUCT_MEMBER(mod_kallsyms, num_symtab);
+INIT_KERN_STRUCT_MEMBER(mod_kallsyms, strtab);
+INIT_KERN_STRUCT_MEMBER(elf64_sym, st_name);
+INIT_KERN_STRUCT_MEMBER(elf64_sym, st_value);
+
+#define MEMBER_OFF(S, M) \
+	GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
+
+uint64_t next_list(uint64_t list)
+{
+	uint64_t next = 0;
+
+	readmem(VADDR, list + MEMBER_OFF(list_head, next),
+		&next, GET_KERN_STRUCT_MEMBER_MSIZE(list_head, next));
+	return next;
+}
+
+bool init_module_kallsyms(void)
+{
+	uint64_t modules, list, value = 0, symtab = 0, strtab = 0;
+	uint32_t st_name = 0;
+	int num_symtab, i, j;
+	struct ksym_info **p;
+	char symname[512], ch;
+	char *modname = NULL;
+	bool ret = false;
+
+	modules = GET_KERN_SYM(modules);
+	if (!KERN_SYM_EXIST(modules)) {
+		/* Not a failure if no module enabled */
+		ret = true;
+		goto out;
+	}
+
+	if (!KERN_STRUCT_MEMBER_EXIST(list_head, next) ||
+	    !KERN_STRUCT_MEMBER_EXIST(module, list) ||
+	    !KERN_STRUCT_MEMBER_EXIST(module, name) ||
+	    !KERN_STRUCT_MEMBER_EXIST(module, core_kallsyms) ||
+	    !KERN_STRUCT_MEMBER_EXIST(mod_kallsyms, symtab) ||
+	    !KERN_STRUCT_MEMBER_EXIST(mod_kallsyms, num_symtab) ||
+	    !KERN_STRUCT_MEMBER_EXIST(mod_kallsyms, strtab) ||
+	    !KERN_STRUCT_MEMBER_EXIST(elf64_sym, st_name) ||
+	    !KERN_STRUCT_MEMBER_EXIST(elf64_sym, st_value)) {
+		/* Fail when module enabled but any required types not found */
+		fprintf(stderr, "%s: Missing required module syms/types!", __func__);
+		goto out;
+	}
+
+	modname = (char *)malloc(GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
+	if (!modname)
+		goto no_mem;
+
+	for (list = next_list(modules); list != modules; list = next_list(list)) {
+		readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, name),
+			modname, GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
+		if (!check_ksyms_require_modname(modname, NULL))
+			continue;
+		readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, core_kallsyms) +
+				MEMBER_OFF(mod_kallsyms, num_symtab),
+			&num_symtab, GET_KERN_STRUCT_MEMBER_MSIZE(mod_kallsyms, num_symtab));
+		readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, core_kallsyms) +
+				MEMBER_OFF(mod_kallsyms, symtab),
+			&symtab, GET_KERN_STRUCT_MEMBER_MSIZE(mod_kallsyms, symtab));
+		readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, core_kallsyms) +
+				MEMBER_OFF(mod_kallsyms, strtab),
+			&strtab, GET_KERN_STRUCT_MEMBER_MSIZE(mod_kallsyms, strtab));
+		for (i = 0; i < num_symtab; i++) {
+			j = 0;
+			readmem(VADDR, symtab + i * GET_KERN_STRUCT_MEMBER_SSIZE(elf64_sym, st_value) +
+					MEMBER_OFF(elf64_sym, st_value),
+				&value, GET_KERN_STRUCT_MEMBER_MSIZE(elf64_sym, st_value));
+			readmem(VADDR, symtab + i * GET_KERN_STRUCT_MEMBER_SSIZE(elf64_sym, st_name) +
+					MEMBER_OFF(elf64_sym, st_name),
+				&st_name, GET_KERN_STRUCT_MEMBER_MSIZE(elf64_sym, st_name));
+			do {
+				readmem(VADDR, strtab + st_name + j++, &ch, 1);
+			} while (ch != '\0');
+			if (j == 1 || j > sizeof(symname))
+				/* Skip empty or too long string */
+				continue;
+			readmem(VADDR, strtab + st_name, symname, j);
+
+			for (j = 0; j < sr_len; j++) {
+				for (p = (struct ksym_info **)(sr[j]->start);
+				     p < (struct ksym_info **)(sr[j]->stop);
+				     p++) {
+					if (!strcmp((*p)->modname, modname) &&
+					    !strcmp((*p)->symname, symname)) {
+						(*p)->value = value;
+						(*p)->index = i;
+					}
+				}
+			}
+		}
+	}
+	ret = true;
+	goto out;
+no_mem:
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+out:
+	if (modname)
+		free(modname);
+	return ret;
+}
+
+void cleanup_kallsyms(void)
+{
+	cleanup_ksyms_section_range();
+	cleanup_ksyms_modname();
+}
diff --git a/kallsyms.h b/kallsyms.h
index 3791284..897bcdd 100644
--- a/kallsyms.h
+++ b/kallsyms.h
@@ -88,4 +88,7 @@ bool check_ksyms_require_modname(char *modname, int *total);
 bool register_ksym_section(char *start, char *stop);
 bool read_vmcoreinfo_kallsyms(void);
 bool init_kernel_kallsyms(void);
+uint64_t next_list(uint64_t list);
+bool init_module_kallsyms(void);
+void cleanup_kallsyms(void);
 #endif /* _KALLSYMS_H */
\ No newline at end of file
-- 
2.47.0


