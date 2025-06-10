Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E465C71136
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aNPj02dVY1xB+zciNiRCIU1FWBg//bUySFYFRA2kMAo=; b=02f5/S1qrxES7w3aUH+HdAmosn
	HAJHpBvIe3mbEVfDUCcBWONotZZDko43fkSnVgtyCHOJda18z1oXKVfOZmjrstmkFgBtFCeu1BPyv
	vij66AoEEwZVj2kHIC/lukeMXhbGajaiYP68Cpk5mPHnwX/h34dLDvq6g17HI2yqilphVU1S6Pn0V
	dwqfmBU9VYuHKJy2KKqQNsX+Jjrx1qVN4jerkNsEtjg7LHT/f9ODmK5FbnnuiDbtmTwRMpLX6v6bP
	85s5EHhWqltXs8e8S+Ekk1ygs8TuFbX0EY4KSUdMDDwV9KXaEIBWsdLyetChTf1nDmCC0SxzLRhYK
	11xy8vbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwf0-00000006Y9N-2xnu;
	Tue, 10 Jun 2025 10:56:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvlc-00000006QdC-19ji
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 09:59:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNPj02dVY1xB+zciNiRCIU1FWBg//bUySFYFRA2kMAo=;
	b=dC+X6Pbf29A7oHw/43julu1Vic4j2XA2hdNjis2KEUtc1gLQlymdiD0I70pNlk+0PlO73Z
	McZFFp1GRT8aJOKmdk38jlyi0OxGMP9nNBRT+aLPbqSL2keN4gI6AMC256SrekKjv0C2YV
	SI/OQ2hbiUaV8uGhJ7b5P+Ftna9mDtQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ZSLG7znEMT-DVGJQeQyjDA-1; Tue, 10 Jun 2025 05:58:13 -0400
X-MC-Unique: ZSLG7znEMT-DVGJQeQyjDA-1
X-Mimecast-MFC-AGG-ID: ZSLG7znEMT-DVGJQeQyjDA_1749549492
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b26eec6da92so4967994a12.1
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549492; x=1750154292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNPj02dVY1xB+zciNiRCIU1FWBg//bUySFYFRA2kMAo=;
        b=GvUdn3FTCxNcbD8/HU3XwFRopNWxjzA39vKQ4mBd7xBepeglg9gINesjo0wjf7E3NA
         iwR1ZU/qitVl55MFVGptTlnXahYI5O3x55CJ+7P1YsfG78GOfcVsm2DnxE5NuIs53t1M
         5XZSpHzeB4MJweov3cvOYBXKLlw5HFQ+JlxLd3xWNM7FW4tc9RjLi3G08974dAWHXD2N
         75gGDis4dLg65CCUVb3BmbrsMSL3pRBAL+CI/leJdhNDO61D6p09+F5jX7AN3vSqUQxf
         CXgC+nrRAPFxnUkq/quG2jcEPfJdv2RQTcmzVvFEDXMJzKYUj/ogVNgPw4AwPrJKwabW
         GkUw==
X-Forwarded-Encrypted: i=1; AJvYcCVq2hKQIBGrAW25eIT2otrVMS/s1a8Mtt91ZAkb0nKcOhmh+B4wF5zLtVQJWLsLfF7jmP+NaQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzhBvs0BNbRTgWlX+WfiHI9IkLFcEDUWRhvrv74ErfbOpCZWUrY
	0CRq+2+MgSlngcyRDOO5HCmcShYjzsuldHuFDn5QX0qwleqPkR1xeObEWwbWuqFD6ru0zF/eJFN
	WToJwRl22AvQbmiFyq9wngydefwqo55uQMuzkHocTuO6EH7Atskm+4DwIdHXRQw==
X-Gm-Gg: ASbGncsX3U57ZF89SQesDS5ZkTux3ofnX4Q1AJWuHqFSRNSGk56tBqHW+2sR3SQcufl
	7k299M7QnGde3Fg/MHID5v9yatVdofo9K28TCp2qvS7bRxSbbWUN4RlCc45vWnmFpND7T73gISh
	05xPYYq6ibE4HcMnSvBME+JIaCTmxNplcFPraEmdFxuhc1YeXwk45QizYcQRQBJO4uFuRk5Z3lK
	QS74Z/PIae07VcUOeOy+/Ypiz99F2pYWu5fXhFPaRRd8iQYEgMicghXz1aAtWC4AUjmrAGN4M3L
	3sLD7XdIifRGiSs2GBDg/tltWKMBz3g=
X-Received: by 2002:a17:902:f54e:b0:234:7837:91de with SMTP id d9443c01a7336-23635c9d9abmr37337255ad.26.1749549492274;
        Tue, 10 Jun 2025 02:58:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsNci/01TruAXRHV4E+9mlTlhmEapO7UMAGJwnohjb8LbIDfR7gZ3ssNcC6uS+/c2sJu2AeA==
X-Received: by 2002:a17:902:f54e:b0:234:7837:91de with SMTP id d9443c01a7336-23635c9d9abmr37337055ad.26.1749549491911;
        Tue, 10 Jun 2025 02:58:11 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:58:11 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 05/10] Export necessary btf/kallsyms functions to eppic extension
Date: Tue, 10 Jun 2025 21:57:38 +1200
Message-ID: <20250610095743.18073-6-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rUgN0_0kdrluVVWAtBNBhnnd6K_Mq0ixTLjKLG5FE9I_1749549492
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_025940_380674_8B0739E3 
X-CRM114-Status: GOOD (  11.71  )
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
 erase_info.c | 16 +++++++++++++++-
 erase_info.h | 14 ++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/erase_info.c b/erase_info.c
index d68e1a2..9ec1813 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -20,6 +20,8 @@
 #include "print_info.h"
 #include "dwarf_info.h"
 #include "erase_info.h"
+#include "kallsyms.h"
+#include "btf.h"
 
 #include <dlfcn.h>
 
@@ -36,7 +38,19 @@ struct call_back eppic_cb = {
 	&get_die_member_all,
 	&get_die_nfields_all,
 	&get_symbol_addr_all,
-	&update_filter_info_raw
+	&update_filter_info_raw,
+	&get_structure_size,
+	&get_member_offset,
+	/**********************/
+	&update_filter_pages_info,
+	&get_kallsyms_value_by_name,
+	&get_struct_member_by_name,
+	&get_type_member_by_index,
+	&get_type_size_by_name,
+	&get_en_by_uniq_id,
+	&resolve_typedef,
+	&get_btf_type_by_type_id,
+	&id_to_uniq_id,
 };
 
 
diff --git a/erase_info.h b/erase_info.h
index 4552dfc..6797ed1 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -19,6 +19,7 @@
 #ifndef _ERASE_INFO_H
 #define _ERASE_INFO_H
 
+#include "btf.h"
 #define MAX_SIZE_STR_LEN (26)
 
 /*
@@ -52,6 +53,19 @@ struct call_back {
 	int (*get_die_nfields_all)(unsigned long long die_off);
 	unsigned long long (*get_symbol_addr_all)(char *symname);
 	int (*update_filter_info_raw)(unsigned long long, int, int);
+	long (*get_structure_size)(char *, int);
+	long (*get_member_offset)(char *, char *, int);
+	/********************************/
+	int (*update_filter_pages_info)(unsigned long, unsigned long);
+	uint64_t (*get_kallsyms_value_by_name)(char *);
+	uint32_t (*get_struct_member_by_name)(char *, char *, struct member_info *);
+	bool (*get_type_member_by_index)(uint64_t, int, struct member_info *);
+	uint32_t (*get_type_size_by_name)(char *, int, uint32_t *);
+	struct name_entry *(*get_en_by_uniq_id)(uint32_t, struct btf_type *);
+	void (*resolve_typedef)(struct name_entry *, struct name_entry **, struct btf_type *);
+	int (*get_btf_type_by_type_id)(struct btf_file *, uint32_t,
+				   struct btf_type *, struct name_entry **);
+	uint32_t (*id_to_uniq_id)(uint32_t, struct btf_file *);
 };
 
 extern struct erase_info	*erase_info;
-- 
2.47.0


