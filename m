Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B17BCCD1A2
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wFW72m2okvCj1P9Gez5/ELzk/bywa9J3nDUtEkQEtwI=; b=Rm161sBUiJkQY6m/AP2/uIBd7Q
	RASFY7IlIXvimuBUxhMknM+War4IYYV5Q9veY18QFgorfQVNZHU+IXrq6bwzhB4mFpeN4mPQrZw3/
	JvNa4NUiqAxMlMmEBuVG8TjCc6+it/q6tVkkzQjFPnCJ4HuRs9OgsM9dQlhbeDCu7czP6Viif5hPI
	4pi+lDt0nnCRW1KSs7cV0LaOxB0LhoObFKLc31wfxGczg2kf9RorjjZwbfWaQfq+w9nxzmGJ3L0Va
	s6L29riLtiEJSOAnf2o76NJyljKIecDQcPe/SYbWOQo/3dQbKJ5C5O0x7dalF5PvLCNkddR+CpMhh
	/nAiGubA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyL3-0000000FBNE-3BPh;
	Mon, 20 Oct 2025 22:26:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyL0-0000000FBMo-3fTo
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:26:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFW72m2okvCj1P9Gez5/ELzk/bywa9J3nDUtEkQEtwI=;
	b=KnFC9L3glPI/H2pm6BAvgFmrv0SWrZxPEYVsathPeM5ZJhN3yls2Kjl/r7ZnbHmc19o2RU
	qBeKCEE9U8KUIRvwQkMTgYRq3awDvI3MK1QCI/heJicbaX5nyD8dx7/nfuOe5CPTwMsx1h
	4AglXMuot07SGI01LqTBuZazHdzk0Io=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-VQhQFJSRO5y1tMWUfLME7w-1; Mon, 20 Oct 2025 18:24:41 -0400
X-MC-Unique: VQhQFJSRO5y1tMWUfLME7w-1
X-Mimecast-MFC-AGG-ID: VQhQFJSRO5y1tMWUfLME7w_1760999081
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810912fc31so4491055b3a.3
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999080; x=1761603880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFW72m2okvCj1P9Gez5/ELzk/bywa9J3nDUtEkQEtwI=;
        b=pLzD+Ro2J+MASxR6HQD5lmBx4+lZGmiu3y5hlzRM0lcS1okNOc8Y4seFXViHzDKVs/
         c12dvQjWEBO38MtEAoWjza5zee1ms2cgtUfiDRC0eNC//MptIbv/QeCKwmLlZU+H5nlE
         kXuu5I9PqTal1CKNQ26qrb0hWWzlzDrjIPN+/qSwPAxL8lBYACuwD4QeMz5u+7oBD/az
         WammlyO3OaBQRs2yLIM9wgcYkYl88gjDKkkwTOIbFKiIyS3B0kkbPlxPf6USUiSeIqe5
         gqqlyJyHWx05J+zkkRS3aCxnyY9D/7KIyyJziLf4R5zYaqaSKZluzYGcyeIn1FiMx21L
         Tjqw==
X-Forwarded-Encrypted: i=1; AJvYcCUg/ayYCgpLuz78N4jHSrrNJen1JDYOmaF+BDGgsrWjqsY5RtprKo7D/ebvKjqRQI0tTvSWKg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxjGo1Q3SiO8wABvHgO2c09pNYQ4SFAlf3AwGEn906z/dd3A3GF
	NA26bzWTICPqxCVgBQtT2jLy0YjLHcWWndAru8eLaN0+O8Ii5wJF3L044zc0w1nt9NqRcjRcV4l
	L7ljiFLNF4nlqYQSHTysftyAGtOoFLZi00wX9jCUlQbn8y7lePM3s2X202DJUsjheJXhNcA==
X-Gm-Gg: ASbGncs215a1+MY5YLiBzl31Aaw1PvYqOl0jHd97TnjMUuOw/90v2VOqZ2WdrilKpDW
	MRmZtjkhOnmioq5pbh/zCT6yJhI1IXTgJ38avcPC+DRAwjt16LWniSsw5k3yZNu+MPo1H9emrFc
	QvlrkgHcWbw3/SPp/3NrSl/fsx+aGKYUK1LBzOu2MKrk8ljBTJg8/ttoR0F237J63/wBzeg8W5M
	QWZCTeu92762QK4zPGcPDuz3zVlrMRx9KQ3+FdD2Kxck3iKQoAnPKUI5HGpUG7Gv7nCTr/fQfrb
	qm5kffZRh9LolVHoqO0E8r+DUT6K3WL+nA7Voa1nCv8+tt6R/fFr6LUjMEcjmpt7vs9LCv+UTJN
	Hs/boPhSu8LEIDZzEvNf578+wTMSitFf1rNVqf9yEsqs=
X-Received: by 2002:a05:6a00:2d8d:b0:781:187f:48d1 with SMTP id d2e1a72fcca58-7a220a58497mr16307120b3a.1.1760999080424;
        Mon, 20 Oct 2025 15:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpbNQk+Y9UKhYPiWSZYvO2XHWZI5c73onHo02zlMbbFDSa0t4PyYEhA6/XnWL8aCgTE2cmZw==
X-Received: by 2002:a05:6a00:2d8d:b0:781:187f:48d1 with SMTP id d2e1a72fcca58-7a220a58497mr16307100b3a.1.1760999080030;
        Mon, 20 Oct 2025 15:24:40 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:39 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 06/14] Enable page filtering for dwarf eppic
Date: Tue, 21 Oct 2025 11:24:02 +1300
Message-ID: <20251020222410.8235-7-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KCRa-Sy-Wq2MUT8iUME9sz2eRP30dp5pdTgosPKT2i0_1760999081
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152646_982353_9653A622 
X-CRM114-Status: GOOD (  15.49  )
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
 extension_eppic.c | 24 +++++++++++++++++++++---
 extension_eppic.h |  6 ++++--
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index d68e1a2..e903eeb 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -2188,7 +2188,7 @@ get_die_member_all(unsigned long long die_off, int index, long *offset,
 
 /* Process the eppic macro using eppic library */
 static int
-process_eppic_file(char *name_config)
+process_eppic_file(char *name_config, bool is_btf)
 {
 	void *handle;
 	void (*eppic_load)(char *), (*eppic_unload)(char *);
@@ -2207,7 +2207,9 @@ process_eppic_file(char *name_config)
 	 * Support specifying eppic macros in makedumpfile.conf file
 	 */
 
-	eppic_init = dlsym(handle, "eppic_init");
+	if (!is_btf) {
+		eppic_init = dlsym(handle, "eppic_dwarf_init");
+	}
 	if (!eppic_init) {
 		ERRMSG("Could not find eppic_init function\n");
 		return FALSE;
@@ -2354,7 +2356,7 @@ gather_filter_info(void)
 		ret = process_config_file(info->name_filterconfig);
 
 	if (info->name_eppic_config)
-		ret &= process_eppic_file(info->name_eppic_config);
+		ret &= process_eppic_file(info->name_eppic_config, false);
 
 	/*
 	 * Remove modules symbol information, we dont need now.
diff --git a/extension_eppic.c b/extension_eppic.c
index ebace25..00d19fa 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -25,6 +25,7 @@
 #include "extension_eppic.h"
 
 static int apigetctype(int, char *, type_t *);
+struct call_back *cb;
 
 /*
  * Most of the functions included in this file performs similar
@@ -437,7 +438,7 @@ apifindsym(char *p)
 	return NULL;
 }
 
-apiops icops = {
+apiops dwarf_icops = {
 	apigetmem,
 	apiputmem,
 	apimember,
@@ -470,17 +471,27 @@ eppic_memset(VALUE_S *vaddr, VALUE_S *vch, VALUE_S *vlen)
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
@@ -489,8 +500,15 @@ eppic_init(void *fun_ptr)
 		eppic_builtin("int memset(char *, int, int)",
 				(bf_t *)eppic_memset);
 
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


