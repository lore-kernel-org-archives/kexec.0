Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59005C61DB2
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GeWmpAQa4/VfpxBdOZWIGC6T6F5NP0NhtqiaRrxp2YE=; b=D9OKwyXx+ovPq24nxGsEtwd/4a
	FRTd6HbHWWVeCKfx7wV/BCYAozgtIPqlNW4zkuDMKw/bHMi+x1o4TbvxQnq7Is5GP6eZ85hDhmuFA
	VXfcV0Et0Vvd8Kc8lcJttQoOCulY2ybOcr+uW49KP7iYrZq0HlaQo3cH9cZgQkA2ZrDIYtr3MD5s/
	XMpqcXlSQGEYlEkDsrQYFlsbeJtE/oIPMpH4DwWysZ2z6rONurMg5E7WhstcAC3xmGbW6ZPSEAGjX
	PtSjcXAK1z7bFCn+qJuHJfytYCSiAK5ERH6QrpEXSwbM5/NUHis4o3iMUKD2Th0eGflc/ZZw1LrQK
	qzuJNv+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwf2-00000006YDL-3PNZ;
	Tue, 10 Jun 2025 10:56:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvll-00000006Qhw-2Nlr
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 09:59:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeWmpAQa4/VfpxBdOZWIGC6T6F5NP0NhtqiaRrxp2YE=;
	b=P6hzzeuCk4XKfZd/xE6LP05FBwfRG0EnuKMRH5IfuarjeuMlxkpB95jAFN4S4nB6HZ/BR6
	JupC+MSEgVm+eI51FbFZorLrBchC/8rwn9oLowf511Fzyk3IEqxhOx03xEyo83oC+E9fH2
	4oT9vDCwou3LgqjAYGETIl4cNEDsAN8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-0YhqNqaIPlKXjRi8ACyGig-1; Tue, 10 Jun 2025 05:58:24 -0400
X-MC-Unique: 0YhqNqaIPlKXjRi8ACyGig-1
X-Mimecast-MFC-AGG-ID: 0YhqNqaIPlKXjRi8ACyGig_1749549504
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235e7550f7bso50969415ad.3
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549504; x=1750154304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeWmpAQa4/VfpxBdOZWIGC6T6F5NP0NhtqiaRrxp2YE=;
        b=izxpd+0ahRDIPccoNtCfZM5z73iKtCanOdsZMZvUMRYVKwfOLUEQzDtdUNCrTtv2H2
         yQd90QKcW0gOZBaPEHPz8gM+eHWe3VQ5FxXJ23Ddiv3Qj6tOSTzW7GqtbBpcr9cnbfSP
         HT/a7OjYqIN39k0d/mC4KPKca8zg+ZEvAyWtW8JyGLo073Hj5WrccVOZAwulyICC8Hux
         t1ibQd1i3w3J7Gvq8k6bB7tp6rvNIZz/zQQtceZI37eZHniNjkuUesULDo+3R6Eiolh5
         LJ58Oi+fhi1RjnsDqoQ0XudwO2m755ZELLKE+EWu3VmBEn0nZZylg8FNgO9Y2I4Ky5Ud
         mQpw==
X-Forwarded-Encrypted: i=1; AJvYcCXPImK9prRKV4JRZ8zYPNaetPwFi3H6PKX+w/dX790yQBurxSGAFyWFss+9mTZR1zYAbO/++g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkTzeVoGkvABECXPSRwVqJAo6K0hO7u5q6FYcVY7s8fK4aFA63
	pjA5WL/LAuCngAk48OUckizoWxwnJQl3DyaVH8SStr48H4yB/Gs1RyrUpEhi1r8oT9AhNfKqDRO
	0E92CqGHMCgyFbbTjIYAqvgAWzbOF5+mKVwo7bhDpXXg24Z1bbRQ3QziUWiYbNw==
X-Gm-Gg: ASbGnctuiV7B758Fzcr3E7vrzC8ijy5Ac9UsEXylTH4//FrnriDaKNNZfjalpheL4QP
	CXKa3xy//74AWcmfRLeAWotLu2WkiOaLrhg1bIWEh6gPYkm2zei0B6nRiMKR79wc4JLLn8RNMEG
	Bl3h9Z5bImeubJ9zdBHdAHkIcL030o7Y3cWqI1O4Y/ZPp4LsY8ACv3n15jcXFh31jkbtURjyH7U
	AilhUCZoWDsSB5BHcgGQy63OvwP/umuZg+5dACnJVw0NUjWKFIsNqYzaJbVmAbCXqKnLYtstGsn
	BuNftrqkR9EfDuqRqun4DGiuvP/faek=
X-Received: by 2002:a17:903:1a0b:b0:234:ef42:5d75 with SMTP id d9443c01a7336-23601d24704mr213033495ad.20.1749549503908;
        Tue, 10 Jun 2025 02:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRmQzZJUKClSIb9BG7S1rj038u41m4kOFMJwb7zY4oh1IHcVX1nLmYOvP2Yjo21IiqsDloFw==
X-Received: by 2002:a17:903:1a0b:b0:234:ef42:5d75 with SMTP id d9443c01a7336-23601d24704mr213033245ad.20.1749549503563;
        Tue, 10 Jun 2025 02:58:23 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:58:23 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 08/10] Enable page filtering for dwarf eppic
Date: Tue, 10 Jun 2025 21:57:41 +1200
Message-ID: <20250610095743.18073-9-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UDVw-uRUCwFaAOfZjE6xCP-ojIiF-t2NZ46-Obj-oJw_1749549504
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_025949_702051_2EA08B9F 
X-CRM114-Status: GOOD (  16.23  )
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

Since dwarf and btf have different apiops, so making it as parameter to
eppic_init, and initialized respectively.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 erase_info.c      |  8 +++++---
 extension_eppic.c | 34 +++++++++++++++++++++++++++++++---
 extension_eppic.h |  6 ++++--
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index 9ec1813..eeb2c3b 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -2202,7 +2202,7 @@ get_die_member_all(unsigned long long die_off, int index, long *offset,
 
 /* Process the eppic macro using eppic library */
 static int
-process_eppic_file(char *name_config)
+process_eppic_file(char *name_config, bool is_btf)
 {
 	void *handle;
 	void (*eppic_load)(char *), (*eppic_unload)(char *);
@@ -2221,7 +2221,9 @@ process_eppic_file(char *name_config)
 	 * Support specifying eppic macros in makedumpfile.conf file
 	 */
 
-	eppic_init = dlsym(handle, "eppic_init");
+	if (!is_btf) {
+		eppic_init = dlsym(handle, "eppic_dwarf_init");
+	}
 	if (!eppic_init) {
 		ERRMSG("Could not find eppic_init function\n");
 		return FALSE;
@@ -2368,7 +2370,7 @@ gather_filter_info(void)
 		ret = process_config_file(info->name_filterconfig);
 
 	if (info->name_eppic_config)
-		ret &= process_eppic_file(info->name_eppic_config);
+		ret &= process_eppic_file(info->name_eppic_config, false);
 
 	/*
 	 * Remove modules symbol information, we dont need now.
diff --git a/extension_eppic.c b/extension_eppic.c
index c4a13b9..59178e5 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -23,8 +23,10 @@
 
 #include "makedumpfile.h"
 #include "extension_eppic.h"
+#include "eppic_maple.h"
 
 static int apigetctype(int, char *, type_t *);
+struct call_back *cb;
 
 /*
  * Most of the functions included in this file performs similar
@@ -416,7 +418,7 @@ apifindsym(char *p)
 	return NULL;
 }
 
-apiops icops = {
+apiops dwarf_icops = {
 	apigetmem,
 	apiputmem,
 	apimember,
@@ -449,17 +451,27 @@ eppic_memset(VALUE_S *vaddr, VALUE_S *vch, VALUE_S *vlen)
 	return eppic_makebtype(1);
 }
 
+VALUE_S *
+eppic_filter_pages(VALUE_S *p, VALUE_S *n)
+{
+	unsigned long pfn = eppic_getval(p);
+	unsigned long num = eppic_getval(n);
+
+	UPDATE_FILTER_PAGE_INFO(pfn, num);
+	return eppic_makebtype(1);
+}
+
 
 /* Initialize eppic */
 int
-eppic_init(void *fun_ptr)
+eppic_init(void *fun_ptr, apiops *ops, bool is_btf)
 {
 	cb = (struct call_back *)fun_ptr;
 
 	if (eppic_open() >= 0) {
 
 		/* Register call back functions */
-		eppic_apiset(&icops, 3, sizeof(long), 0);
+		eppic_apiset(ops, 3, sizeof(long), 0);
 
 		/* set the new function callback */
 		eppic_setcallback(reg_callback);
@@ -468,8 +480,24 @@ eppic_init(void *fun_ptr)
 		eppic_builtin("int memset(char *, int, int)",
 				(bf_t *)eppic_memset);
 
+		if (maple_init(is_btf) == FALSE)
+			return 1;
+
+		eppic_builtin("int maple_count(char *)",
+				(bf_t *)maple_count);
+
+		eppic_builtin("unsigned long maple_elem(char *, int)",
+				(bf_t *)maple_elem);
+
+		eppic_builtin("unsigned long filter_pages(unsigned long, unsigned long)",
+				(bf_t *)eppic_filter_pages);
+
 		return 0;
 	}
 	return 1;
 }
 
+int eppic_dwarf_init(void *fun_ptr)
+{
+	return eppic_init(fun_ptr, &dwarf_icops, false);
+}
diff --git a/extension_eppic.h b/extension_eppic.h
index 08f1db0..ff92f01 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -79,8 +79,7 @@ do { \
 		fprintf(stderr, x); \
 } while (0)
 
-
-struct call_back *cb;
+extern struct call_back *cb;
 
 #define GET_DOMAIN_ALL cb->get_domain_all
 #define READMEM cb->readmem
@@ -92,5 +91,8 @@ struct call_back *cb;
 #define GET_DIE_NFIELDS_ALL cb->get_die_nfields_all
 #define GET_SYMBOL_ADDR_ALL cb->get_symbol_addr_all
 #define UPDATE_FILTER_INFO_RAW cb->update_filter_info_raw
+#define UPDATE_FILTER_PAGE_INFO cb->update_filter_pages_info
+
+int eppic_init(void *, apiops *, bool);
 
 #endif /* _EXTENSION_EPPIC_H */
-- 
2.47.0


