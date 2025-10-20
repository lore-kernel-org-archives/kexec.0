Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24049CCD19F
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m9Dd7N4hN84q9gu6pgmJj45N6rTxzj0xxFrsbbTuShE=; b=ZOb4BGl50AcTvoRckw+nud2jyF
	5MYrTAiHR/Qq95/OxgGMb7ZmtDFv+ku9q5lpsOdL6tNuZj0FIIrsdL73JsE/UiJidoWvM0ZypwMLq
	iKSbCju9kAFw0pOoMDzlN5TIftEqdg06iHjukpDIelPQnKnDxiicnuPvl+n4xWSeMATbJVLtd5EjW
	X/HG4QEVHDmAxpSwneHcUg4xLqgRSr0ovi898WEl2UzzzBwnwxOTLFZI1FPWhjcmDEf/pFi1OCSk8
	4ZQRmhEACvjT+gdrbJJfMnYBgh6LRFIzdhl7d/e6LHAiLniXMnH7EKhkdweT3bDHJ22Onr/MsooNR
	xyHWLU9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyKc-0000000FBIG-0kSf;
	Mon, 20 Oct 2025 22:26:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyKZ-0000000FBHK-3GT4
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:26:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9Dd7N4hN84q9gu6pgmJj45N6rTxzj0xxFrsbbTuShE=;
	b=Sbmr0UGUx0VleuoWYXEYIlKf5LQta7rbkh4IYJ1885tD6ZzbpmVMMj3jck04Q7bq9f5Nkc
	7mCYhQ82XmleWqucoo8dG9j+1u6irr8zop5bB1nSo4musCBhi2OV/g7nDToWAvZqQSTTKn
	TFMD44cIayUNXzvcZDuutS/37tC9Jc8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-8eFMEYbdNTmf46W7IGkQ6A-1; Mon, 20 Oct 2025 18:24:58 -0400
X-MC-Unique: 8eFMEYbdNTmf46W7IGkQ6A-1
X-Mimecast-MFC-AGG-ID: 8eFMEYbdNTmf46W7IGkQ6A_1760999098
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so3847227a91.3
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999098; x=1761603898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9Dd7N4hN84q9gu6pgmJj45N6rTxzj0xxFrsbbTuShE=;
        b=O9BZ7z97ZG52oaNhJDhO31WBbaBIHirM0BkOVm3IRTiTwgxequK/gjoGo+oggPjWB8
         0ozkxDtsQi4NhypfkPJajPouXlBBCzYqyipT1YasTgGP2KVPFUnkqeuzLugU0p+pw1ZN
         XB0l82fFTHdebhHcu3R3cLkOejf0T9QYHsLptjCdSMIzbti0V3C7fKIOwIU8O2QF8GKZ
         WOpe/YssgJG3Hzd0c+l3kQROcS/A5IAzXGf1vVlkM6e75sL8k6DPuuCtZ58HbYoT51gx
         MLGb1qi1Ydq/2FCwKTQ2DDjDvtQ3v/NRcXRYqSqrN9ep9BkOjyeXhlJWiu94IaHQKUNQ
         7Haw==
X-Forwarded-Encrypted: i=1; AJvYcCXWeYVSjG631Nf2xwmd5mB5oKd85Ex0qL/n1NXH6RiiHV7TFyz4LwuUtCt6ovHiiBJT+n2C6A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHYh8TaXPqAeqrBNqfiWh/Hu3vatj8N4RXvJT5mMtYiRTWvjrd
	cEsSqlsGFQDGFwZFLs2jyp+vPHk6gdDDlgFkoTyml9Zk1kkhCwjudxTgdtSg2iz3kDYEJRyeuNs
	Dqad/IFPIIFTgcu/gmG404+yMyj80vzq9Wr0FWpebALujkCfrxPl4f+7+fE4Yag==
X-Gm-Gg: ASbGncuPrfjFFLgDuvHPJoRkVXgzPlQPPqPc4e9Z+x717v8ImlElNyl9BXda+5HJtcv
	dVSvY4k2jWu7kRoeakhZVaj01snAa3yi40xPUlUvZBbiTJbkz+iagFRZxT/39SGfM7udMj2jpld
	SVrDfSiYcHpcTMdZQeqEW7I2VjUCRvKKjr6dY/BvNBJgpFNzRSc6nfcGE1iQ/aOgRbEjKj5a8Cs
	UnL/FZwMOFIGTkzAIIfUe3WXaJd6bSFJKVvDIKFwkrrMnX7Uc8kj6B7tHFWsiiSScI+WPJkYBY3
	PZU+Cxu2LLH8dv43TO/mlL0u/xtcrad55xbddU1+4mqBCF9MEnl4/sS3Ph/vm0w2w1dVX+6kSJ7
	7b1AKGGBxZBYTtZw7kZIm2g+mvLRHvj+AEALqtASVDMU=
X-Received: by 2002:a17:90a:d60f:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-33bcf9528eamr21065051a91.35.1760999097693;
        Mon, 20 Oct 2025 15:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzLVoxhA5/i2pp8RL9HP6IE7JKM8EnIh9NouY39aCOhqVEvusQzjOzBVNhTSkzYcfRb0cYBg==
X-Received: by 2002:a17:90a:d60f:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-33bcf9528eamr21065033a91.35.1760999097325;
        Mon, 20 Oct 2025 15:24:57 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:57 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 11/14] Export necessary btf/kallsyms functions to eppic extension
Date: Tue, 21 Oct 2025 11:24:07 +1300
Message-ID: <20251020222410.8235-12-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KX7mw4WSAETVj_JDmsJBoU8bFRDw2Hd_UvA2uj3-n-g_1760999098
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152619_911696_AC5A56AD 
X-CRM114-Status: GOOD (  11.79  )
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

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 erase_info.c | 13 ++++++++++++-
 erase_info.h | 11 +++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/erase_info.c b/erase_info.c
index e903eeb..7c637c2 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -20,6 +20,8 @@
 #include "print_info.h"
 #include "dwarf_info.h"
 #include "erase_info.h"
+#include "kallsyms.h"
+#include "btf.h"
 
 #include <dlfcn.h>
 
@@ -36,7 +38,16 @@ struct call_back eppic_cb = {
 	&get_die_member_all,
 	&get_die_nfields_all,
 	&get_symbol_addr_all,
-	&update_filter_info_raw
+	&update_filter_info_raw,
+	/**********************/
+	&update_filter_pages_info,
+	&get_kallsyms_value_by_name,
+	&get_type_member_by_index,
+	&get_type_size_by_name,
+	&get_en_by_uniq_id,
+	&get_btf_type_by_type_id,
+	&id_to_uniq_id,
+	&read_file_at_offset,
 };
 
 
diff --git a/erase_info.h b/erase_info.h
index 4552dfc..bf466e8 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -19,6 +19,7 @@
 #ifndef _ERASE_INFO_H
 #define _ERASE_INFO_H
 
+#include "btf.h"
 #define MAX_SIZE_STR_LEN (26)
 
 /*
@@ -52,6 +53,16 @@ struct call_back {
 	int (*get_die_nfields_all)(unsigned long long die_off);
 	unsigned long long (*get_symbol_addr_all)(char *symname);
 	int (*update_filter_info_raw)(unsigned long long, int, int);
+	/********************************/
+	int (*update_filter_pages_info)(unsigned long, unsigned long);
+	uint64_t (*get_kallsyms_value_by_name)(char *);
+	bool (*get_type_member_by_index)(uint64_t, int, struct member_info *);
+	uint32_t (*get_type_size_by_name)(char *, int, uint32_t *);
+	struct name_entry *(*get_en_by_uniq_id)(uint32_t, struct btf_type *);
+	int (*get_btf_type_by_type_id)(struct btf_file *, uint32_t,
+				   struct btf_type *, struct name_entry **);
+	uint32_t (*id_to_uniq_id)(uint32_t, struct btf_file *);
+	int (*read_file_at_offset)(char *, int, int, void *);
 };
 
 extern struct erase_info	*erase_info;
-- 
2.47.0


