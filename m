Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E04ED7B9A
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lC2zDo45EqnVrDDNwK926jqZhk/+4O/w5a0+rjrhDdo=; b=STI6iXldAfzQ/vm7PXHmtES/j2
	tXbYS7v0hdRRdjAbapxMs+aShn3VdvlQxNJyeZiZ8lhn4K4gzuciSeqOIC1LW9zi0agiRSjoCM90C
	V+UzE5HjfQd/7sgmGK876zLxtAys6evburUKR66HCWusroluT58JEOZTHKGuEyg/NCAxi95UWC3hZ
	7BhSWNDdm5Io1i0oJpDn4PNj2iWMo2+zGWbKzSMaFARQGFyUG2bEYsSly93Sm55v3TS9qeRrcX7tu
	30XXG/huz4mWM31/sNPXCF4Te5q8doKCYKuCMvPvtAZGsxHU8aEdEUZ6+8qG2h+01pyTbTSvHaAHR
	lmS1Ijfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazb-0000000H8uj-1hxO;
	Tue, 14 Apr 2026 10:27:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazZ-0000000H8tF-0raK
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC2zDo45EqnVrDDNwK926jqZhk/+4O/w5a0+rjrhDdo=;
	b=cjDa01RtDEyCK1yXy6oG1lWolJcav7iWYDn+Wnd0NkDLRuAgmlAmSX61DHouTA1TXeTYo+
	TcuIrqL9opVaSR1cgLVG9J4mDyFQtEPpJ5lvO2gM64nlTaX7WTQr4MUejAp10o2+fhWBi/
	MfTSWs9hTqi/xmwGu4myuZbWvA6RU7Q=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-c_dXeH26PDqaQJEJPMhvYg-1; Tue, 14 Apr 2026 06:27:34 -0400
X-MC-Unique: c_dXeH26PDqaQJEJPMhvYg-1
X-Mimecast-MFC-AGG-ID: c_dXeH26PDqaQJEJPMhvYg_1776162453
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b4678c6171so14805055ad.1
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162453; x=1776767253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lC2zDo45EqnVrDDNwK926jqZhk/+4O/w5a0+rjrhDdo=;
        b=CkCnDjCYdL8DPmkgmn7lOUiarCcHWGnKrbCl0YfgfpM6MVT5k+/Eew/FTOVF8DiIDX
         3bfPKYB2TJ1adt2jRDgi7PR3a3DVEaxLBfyc0XbmbvKjr/HXB7EivRtOz9ax3psPDOKF
         T6LDEB+1zP0tDqPSESqTbEtUGQwRUXbfdECpHt5zjBiFBcW/p6G1KtNrC5MMu3jiD2l9
         +6mS9m4HhnUlDL+NLGHCluEtUJx1d3Ks/QtTzIdzGUo0BACqa29NcGpZhZZ2Jyb+btiV
         oZ1OHClSdfZoWQdEESYVX2LnVyvroQQfmCdlRQUP+EfgYNpLnotErN6OGlT9ytK7Fc62
         738A==
X-Forwarded-Encrypted: i=1; AFNElJ8T21cd6nSnIOtR+hbD1JUKLkhDkF94gN9Ojk4PcGAoKtfDYyze2mhq57TpCTdfNxNiL30zAQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHWlOVEcvKVq7YZ2dACwUtXQs2h1LNCXEedx/KnHSR7JU7jx1P
	NJqYBED7NIBODDPCbLtAPA1NG0RKQzNt0uibIqp8aOnHgT6VIWwuNTpCoB7umSfan3bw6pcxqTK
	JFYBBGFtAv2mYS/HMJ48ehtA7WVPKmaQX7LZVYhncXGRlG8UqzGGbp9bY6dTM3w==
X-Gm-Gg: AeBDietmwBPZbRqIl8sRY3uU0Ez8SEMvJJA4ntOUVmGuidHac8x90ab+8jo/r3rvan2
	WJQATSWGREQSEr5rwDMJBIQ200/l7rWxxFFIgyeOjKpYkAVCaSWZMweAkIP8DhAnxTYOM1hQwlp
	spi8i+KnSDgZm8wlWYTiaR3TR7vyishi6uCDYDdBs6Hq3WgOsQmQBZX0V2i0XEFkhMUpthpnFQ5
	b9DQb2qFAx/w+l0wjkvqHsy2P5fSLbf81j8eipQApjQAO5eUIHAK9QaCT+6rkC61+Ib0xiqAB/t
	3wc2OxLu0+GdaEaz5AtegasdzfQj1enwhgJZQffgH3t3+qwiuJnHtTiqFmkIXY8L/iuGOEJ/nfE
	4B6FuwHUpvhHB3BFFRxB/SYpFHUaCT8WxdwwwS7glSjNl1cTI3GosmtpAFec44iOaEh7D
X-Received: by 2002:a17:902:b698:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2b2d5976d64mr121831535ad.11.1776162452805;
        Tue, 14 Apr 2026 03:27:32 -0700 (PDT)
X-Received: by 2002:a17:902:b698:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2b2d5976d64mr121831315ad.11.1776162452286;
        Tue, 14 Apr 2026 03:27:32 -0700 (PDT)
Received: from localhost.localdomain (122-63-70-7.mobile.spark.co.nz. [122.63.70.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm136809165ad.79.2026.04.14.03.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:27:31 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v5][makedumpfile 4/9] Implement kernel module's kallsyms resolving
Date: Tue, 14 Apr 2026 22:26:51 +1200
Message-ID: <20260414102656.55200-5-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wNc8-mMHc5VZjd4IrTXDHQCyAXBHkLzXlyl5UA3lczs_1776162453
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_032737_315477_4013FF74 
X-CRM114-Status: GOOD (  15.36  )
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
 kallsyms.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 kallsyms.h |   3 +
 2 files changed, 161 insertions(+)

diff --git a/kallsyms.c b/kallsyms.c
index a198de6..f231a06 100644
--- a/kallsyms.c
+++ b/kallsyms.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include "makedumpfile.h"
 #include "kallsyms.h"
+#include "btf_info.h"
 
 static uint32_t *kallsyms_offsets = NULL;
 static uint16_t *kallsyms_token_index = NULL;
@@ -385,6 +386,163 @@ out:
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
index 73e9839..155fa55 100644
--- a/kallsyms.h
+++ b/kallsyms.h
@@ -80,5 +80,8 @@ bool check_ksyms_require_modname(char *modname, int *total);
 bool register_ksym_section(char *start, char *stop);
 bool read_vmcoreinfo_kallsyms(void);
 bool init_kernel_kallsyms(void);
+uint64_t next_list(uint64_t list);
+bool init_module_kallsyms(void);
+void cleanup_kallsyms(void);
 #endif /* _KALLSYMS_H */
 
-- 
2.47.0


