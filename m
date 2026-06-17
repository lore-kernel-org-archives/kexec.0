Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D720CD98F0
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 05:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pn2awrjlWr1kArl6zUYCc1oGIgKCVJEglApimp24rXo=; b=Gj36QID0M8RbGa64QbqlgIk3xk
	bmqN8ccghCFAmgkvzav7rX/LEi9IU1vnwLFVPtjTOfUiMKS3a+iFk37tvQdmjDWRuVJoANc/owTm1
	m6Wv90wOZOSlIiTQ6174mJwZiTjN1OBK42DfpOByKmevaKAwnopEdAtCIZ6sgT2YuopfJjBTYv6xa
	Be+0BbD4k5bnyfsVq6bVhlmOAOEHUap/6nXfMs6BJerjAjaMkAMJCpNsUBcS+nhpmoSKPe0Q5oIhZ
	E0bPQQFMnNLG0y4akEuriBn5Mt41s0tie7Bpvyrq/P3ABznsXPxU7h1Q2/USB0hUniaT061ZVAK0X
	2CuvLdoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihT-0000000Ge3T-1GZF;
	Wed, 17 Jun 2026 05:20:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihR-0000000Ge2I-1eZN
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 05:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781673628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pn2awrjlWr1kArl6zUYCc1oGIgKCVJEglApimp24rXo=;
	b=AxhXgkXSXdUbE3gJqmLqt5CRPdZaesW2W0BDCrbZXXJAeHJuBn4GrbeuyDAR5B+Ka+D+Eg
	a7qcTBxIm1g91YTC4Rc6DZmysDSRs3BqfXvPY1UOrDEIkDt+mabeUdSoGnNnMiExuw1rq7
	jbW3FjB9vTxwJ5NQA0dn3yTdrAyOJ4Q=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-o-yurdLCPViDbqXBvCC65g-1; Wed, 17 Jun 2026 01:20:27 -0400
X-MC-Unique: o-yurdLCPViDbqXBvCC65g-1
X-Mimecast-MFC-AGG-ID: o-yurdLCPViDbqXBvCC65g_1781673626
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-842211d6e48so6365870b3a.0
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 22:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781673626; x=1782278426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pn2awrjlWr1kArl6zUYCc1oGIgKCVJEglApimp24rXo=;
        b=iPvYClMh5Uund4wXUBLePKHKRlBfTBF2Ljl9nGt7s1RYXNkXyw4jRIWPnbUXkaU7aW
         3d/aFqvRcozRI9NR3F76pJOAMLi5IsimlDJ7joCwrqqYQ2Zc4sY7DBLlfL6nP0FzmG4R
         X+WWcvso62JZpfEZRaEB6rtz+gyqZz5hB5t05OEqAH6uCQTedzmbpiDVEYO0KM00LIqO
         d4R24YGk97UvfZSMDSsmVmXBfH9OzCtogp2DgB+rcCzQatpOImdXWhnuVxBwvJguv2i0
         tCzaOx6UWW5p0Ej6zULRd8ktXJDJ4ZgmjJGyrjyhYthUIb2gIJIrs7taklI315rM34s/
         L5Gw==
X-Forwarded-Encrypted: i=1; AFNElJ+KhTDIzDgSDfjnInqzPf8Q7YpYyQ/ZbHcosun9AMPu2nYkhqBhDeHWDoif8GyR4kpewanBDw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwLP/8JcGQz4MEE4ROLXPX2luGzjzXD7voHVdwlLbOqC9k05jlh
	kXYBaqxQtTTr3pdwz4vN9B/pHJs32jRyNd/5DMvRTKN1d2YgxXhLS1ItXjb+r+DCN8l9XLkTFTx
	m5VJf8J3cd3LCL5YNM5FyUK8vC3SBzxPg4Gk/nrh4h7KgtTsDBXO83MsKnKTeig==
X-Gm-Gg: Acq92OFhWiT08nKcsOimru/jFgqDrnJWJYpX0Js2EKnB5TruMIyRRNY2MxBn2oTRizB
	kf/hWqrPMFQcqNEDii0Hoi2K59EPcPHlLrJmfh0nKHANPSTSQPRzDIg1Z9rgBDp632eKSBRUFMG
	njREmaWZyuQtHsXg6SAVwAi329atPWab52peI3AI2LR2HchebWGW9gtPWwHSOdZ6i2OSajnnsPI
	C5YTjX6gDJQ0qNN7uNc5mijLevVbHgGqPjMUi+EQQ3pt6c4CnuUznGqCbgx8rcvmvCcHA+4JWQq
	eH8ok6V7ZaauT5ZA/s4HDJ8vbe4gDoV6di9H1xGUcnXSuyTwhbC6Y2vOKARWSkK2MOF8lXSc1zb
	NXlrkgPKkG1lR3veRakFqj12C/OzujRwDg2XznUGYhpNvMPTjYQ==
X-Received: by 2002:a05:6a00:301c:b0:842:7e71:ba2 with SMTP id d2e1a72fcca58-8452452b3f6mr2357668b3a.27.1781673625950;
        Tue, 16 Jun 2026 22:20:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:301c:b0:842:7e71:ba2 with SMTP id d2e1a72fcca58-8452452b3f6mr2357637b3a.27.1781673625516;
        Tue, 16 Jun 2026 22:20:25 -0700 (PDT)
Received: from localhost.localdomain (122-63-72-97.mobile.spark.co.nz. [122.63.72.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm17234894b3a.38.2026.06.16.22.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:20:25 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v6][makedumpfile 04/10] Implement kernel module's kallsyms resolving
Date: Wed, 17 Jun 2026 17:18:28 +1200
Message-ID: <20260617051834.95404-5-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617051834.95404-1-ltao@redhat.com>
References: <20260617051834.95404-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b98gxAidPF5393SE4bm0MvsrP-Kt9IrKf7_Zxf8Kohs_1781673626
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_222029_516362_E4B42F14 
X-CRM114-Status: GOOD (  15.11  )
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

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 kallsyms.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 kallsyms.h |   3 +
 2 files changed, 161 insertions(+)

diff --git a/kallsyms.c b/kallsyms.c
index a55dcc6..0037600 100644
--- a/kallsyms.c
+++ b/kallsyms.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include "makedumpfile.h"
 #include "kallsyms.h"
+#include "btf_info.h"
 
 static uint32_t *kallsyms_offsets = NULL;
 static uint16_t *kallsyms_token_index = NULL;
@@ -381,6 +382,163 @@ out:
 	}
 	return ret;
 }
+
+INIT_MOD_SYM(vmlinux, modules);
+
+INIT_MOD_STRUCT_MEMBER(vmlinux, list_head, next);
+INIT_MOD_STRUCT_MEMBER(vmlinux, module, list);
+INIT_MOD_STRUCT_MEMBER(vmlinux, module, name);
+INIT_MOD_STRUCT_MEMBER(vmlinux, module, core_kallsyms);
+INIT_MOD_STRUCT_MEMBER(vmlinux, mod_kallsyms, symtab);
+INIT_MOD_STRUCT_MEMBER(vmlinux, mod_kallsyms, num_symtab);
+INIT_MOD_STRUCT_MEMBER(vmlinux, mod_kallsyms, strtab);
+INIT_MOD_STRUCT_MEMBER(vmlinux, elf64_sym, st_name);
+INIT_MOD_STRUCT_MEMBER(vmlinux, elf64_sym, st_value);
+
+#define MEMBER_OFF(S, M) \
+	GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8
+#define GET_KERN_STRUCT_MEMBER_MSIZE(S, M) \
+	GET_MOD_STRUCT_MEMBER_MSIZE(vmlinux, S, M)
+#define KERN_STRUCT_MEMBER_EXIST(S, M) \
+	MOD_STRUCT_MEMBER_EXIST(vmlinux, S, M)
+#define GET_KERN_STRUCT_MEMBER_SSIZE(S, M) \
+	GET_MOD_STRUCT_MEMBER_SSIZE(vmlinux, S, M)
+#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
+#define KERN_SYM_EXIST(SYM) MOD_SYM_EXIST(vmlinux, SYM)
+
+uint64_t next_list(uint64_t list)
+{
+	uint64_t next = 0;
+
+	if (!readmem(VADDR, list + MEMBER_OFF(list_head, next),
+		&next, GET_KERN_STRUCT_MEMBER_MSIZE(list_head, next))) {
+		ERRMSG("Can't get next list!\n");
+	}
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
+		ERRMSG("Missing required module syms/types!\n");
+		goto out;
+	}
+
+	modname = (char *)malloc(GET_KERN_STRUCT_MEMBER_MSIZE(module, name));
+	if (!modname)
+		goto no_mem;
+
+	for (list = next_list(modules); list != modules; list = next_list(list)) {
+		if (!readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, name),
+			modname, GET_KERN_STRUCT_MEMBER_MSIZE(module, name))) {
+			ERRMSG("Can't get module modname!\n");
+			goto out;
+		}
+		if (!check_ksyms_require_modname(modname, NULL))
+			continue;
+		if (!readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, core_kallsyms) +
+				MEMBER_OFF(mod_kallsyms, num_symtab),
+			&num_symtab, GET_KERN_STRUCT_MEMBER_MSIZE(mod_kallsyms, num_symtab))) {
+			ERRMSG("Can't get module num_symtab!\n");
+			goto out;
+		}
+		if (!readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, core_kallsyms) +
+				MEMBER_OFF(mod_kallsyms, symtab),
+			&symtab, GET_KERN_STRUCT_MEMBER_MSIZE(mod_kallsyms, symtab))) {
+			ERRMSG("Can't get module symtab!\n");
+			goto out;
+		}
+		if (!readmem(VADDR, list - MEMBER_OFF(module, list) +
+				MEMBER_OFF(module, core_kallsyms) +
+				MEMBER_OFF(mod_kallsyms, strtab),
+			&strtab, GET_KERN_STRUCT_MEMBER_MSIZE(mod_kallsyms, strtab))) {
+			ERRMSG("Can't get module strtab!\n");
+			goto out;
+		}
+		for (i = 0; i < num_symtab; i++) {
+			j = 0;
+			if (!readmem(VADDR, symtab + i * GET_KERN_STRUCT_MEMBER_SSIZE(elf64_sym, st_value) +
+					MEMBER_OFF(elf64_sym, st_value),
+				&value, GET_KERN_STRUCT_MEMBER_MSIZE(elf64_sym, st_value))) {
+				ERRMSG("Can't get module st_value!\n");
+				goto out;
+			}
+			if (!readmem(VADDR, symtab + i * GET_KERN_STRUCT_MEMBER_SSIZE(elf64_sym, st_name) +
+					MEMBER_OFF(elf64_sym, st_name),
+				&st_name, GET_KERN_STRUCT_MEMBER_MSIZE(elf64_sym, st_name))) {
+				ERRMSG("Can't get module st_name!\n");
+				goto out;
+			}
+			do {
+				if (!readmem(VADDR, strtab + st_name + j++, &ch, 1)) {
+					ERRMSG("Can't get module symname's next char!\n");
+					goto out;
+				}
+			} while (ch != '\0');
+			if (j == 1 || j > sizeof(symname))
+				/* Skip empty or too long string */
+				continue;
+			if (!readmem(VADDR, strtab + st_name, symname, j)) {
+				ERRMSG("Can't get module symname!\n");
+				goto out;
+			}
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
+	ERRMSG("Not enough memory!\n");
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
+
 #else /* EXTENSION */
 
 bool read_vmcoreinfo_kallsyms(void)
diff --git a/kallsyms.h b/kallsyms.h
index 5d605ce..a69af15 100644
--- a/kallsyms.h
+++ b/kallsyms.h
@@ -79,5 +79,8 @@ bool check_ksyms_require_modname(char *modname, int *total);
 bool register_ksym_section(char *start, char *stop);
 bool read_vmcoreinfo_kallsyms(void);
 bool init_kernel_kallsyms(void);
+uint64_t next_list(uint64_t list);
+bool init_module_kallsyms(void);
+void cleanup_kallsyms(void);
 #endif /* _KALLSYMS_H */
 
-- 
2.54.0


