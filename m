Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132F6C369DC
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 01:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2neMnZN51HiDqW//ekE5B1aNMq6DXqgdqUvcAEfrC4=; b=L7CuIoJXw2dDhqdpAf0bG1lOxt
	jjUxTHV5mp0Nz9vspknQMlrfvxwoRAf0RNWSMGs0MuxKz6ZWTngoQgFhSTsnLmwWo07VC9f+GhEdN
	UhC19WvlzkzkaXCmh20nHcSDvNwKfosFIBK9QkuRCU7DAKBZ5n6keC4Y/y8jYyC+SFt2dGbXGL6+C
	rAgM+/xFxwlxKcprYqnV8vZnZjlnx7vmm7lqbjN/csV498dGjFpDcXMMD1Y1WmTIQkEgNMHjIuLXN
	eVhYP3xPAogApvmq1vQHxBZZF+z6ChnMcDlpnoJS7bwOkYcVexR/8Vt0uzo4uOwKVxlHgjUCCql6e
	8LtTLo3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAf0M-00000000UG1-2MFS;
	Fri, 02 May 2025 01:15:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAexe-00000000Tbs-17DG
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 01:13:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746148384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2neMnZN51HiDqW//ekE5B1aNMq6DXqgdqUvcAEfrC4=;
	b=iC//+WkeIoN3HCuIZHcPVw2GmggjzI1pUuq+i74w8Uc1yxEkEh57n3m209XvRMUwuspitA
	saJgw7bP2bf90B3luGVynDLdg6gDWV/Q2aYsyiA9xMXXaMRxLfQiEs0+bOiBZbwAHN1fd6
	nZAZg4zL4wTIIJqJqxNk3AW5HR0AYZg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-6kuYnSHaOmiBSJrMWcdmvw-1; Thu, 01 May 2025 21:13:00 -0400
X-MC-Unique: 6kuYnSHaOmiBSJrMWcdmvw-1
X-Mimecast-MFC-AGG-ID: 6kuYnSHaOmiBSJrMWcdmvw_1746148379
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224192ff68bso13747915ad.1
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 18:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148379; x=1746753179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2neMnZN51HiDqW//ekE5B1aNMq6DXqgdqUvcAEfrC4=;
        b=m1GzgqGDRXE4/9t7jJkKLrjxec1lQTe8RGvArmPfe2T+AjM4W8sQEE3NFAYYF64e4B
         2d/xd6y7C+qxU7X+Qj6n73qb53yrjhcbaUqc/8fr+sR/F4d7bFZ8dhobumxMwVHvnBf3
         SWTVCa95LU8mzGKHShpgqFvC/5cnL+Vh2BjMvttOmzepT9RgoCZ09ztQ7d65hCQ/zTc1
         +KfP6hZGqRQEMhTky/Ev7Qa4pkIGDnnPmwMdGka3lpczGKBxSaJ0BWgpOaLp886FzfjS
         J5r8s9UR7X3ALWKDkV+JZXh8hUdUUtC2bRMAoiJnuiTpWMU8hZkiNIw+mpIItaDhel9m
         578Q==
X-Gm-Message-State: AOJu0Yw0GArSoxO0j32u0ahTuidWkFfbpA9gepuo5NnpjyHaxbCS6VH9
	47EsnTmAFLDShuhz6Wso0OV81wcSCf9Vob3K9m1p9Y1WuSwoMyLGRhHsq8L73agZSqWDVXOA/i1
	CqWTNx2/nnDW3r1U7YQ4ptMc7zWzOM0srSEA489XCu0nM2bYscuYp+izS9AuvpgRU8gI/cgq2Pd
	xfuHhyBf8m8nLjcpMqa4kVPmiGoHfJgae+FAEYdcWiFg==
X-Gm-Gg: ASbGncuaex1hjjknaUTRDT8F+bqgRcKSD79+SpEJSMPo9aLPBoj6GCTqszfjD8eB9eS
	JDNmXwGrRzRy52AIk7adZFv90PnVFUnciyn8PqOe2G1Hh11XQlLw5JEgJNcSTsyIJSBnDmz8Caq
	JSaeJA8hWiVqC/Wqu0bMkcmsL3YhWfiZEBsYpZVa/Bf7feiBZVkDMxSB7XF8EOpDHt2cHPydnaH
	h3FJdKUOrq0A9MBpUPIDLIC7Smmil9JlOP+Mfv/pYzkx/DS5WVYhAGCx4qVw4lQFdVXQuoEOf4f
	4/E=
X-Received: by 2002:a17:903:f8b:b0:220:cd9f:a180 with SMTP id d9443c01a7336-22e103891c7mr18287505ad.53.1746148378988;
        Thu, 01 May 2025 18:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS7W4ycz826xBQg/pNwjqNo/5dTFfvPHK3ONMEajh9YlmAw8XidmhLF5f/05azjEItTlWoxg==
X-Received: by 2002:a17:903:f8b:b0:220:cd9f:a180 with SMTP id d9443c01a7336-22e103891c7mr18287085ad.53.1746148378557;
        Thu, 01 May 2025 18:12:58 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1085aeb9sm2895405ad.60.2025.05.01.18.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 18:12:58 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Date: Fri,  2 May 2025 09:12:35 +0800
Message-ID: <20250502011246.99238-2-coxu@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502011246.99238-1-coxu@redhat.com>
References: <20250502011246.99238-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oGzoTJD7iWO1S6KeN7c_OVwKhXyXgINU4-HDNgC0Tpw_1746148379
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_181306_373995_5CF7F234 
X-CRM114-Status: GOOD (  15.73  )
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

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Note this feature is enabled only when CONFIG_CRASH_DUMP is enabled. So
it only takes effect for kdump and won't impact kexec reboot.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h | 30 ++++++++++++++++++++++++++++++
 kernel/kexec_file.c   |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c8971861521a..1871eaa95432 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -25,6 +25,10 @@
 
 extern note_buf_t __percpu *crash_notes;
 
+#ifdef CONFIG_CRASH_DUMP
+#include <linux/prandom.h>
+#endif
+
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
@@ -169,6 +173,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -180,8 +185,33 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+#ifdef CONFIG_CRASH_DUMP
+	bool random;
+#endif
 };
 
+
+#ifdef CONFIG_CRASH_DUMP
+static inline void kexec_random_range_start(unsigned long start,
+					    unsigned long end,
+					    struct kexec_buf *kbuf,
+					    unsigned long *temp_start)
+{
+	unsigned short i;
+
+	if (kbuf->random) {
+		get_random_bytes(&i, sizeof(unsigned short));
+		*temp_start = start + (end - start) / USHRT_MAX * i;
+	}
+}
+#else
+static inline void kexec_random_range_start(unsigned long start,
+					    unsigned long end,
+					    struct kexec_buf *kbuf,
+					    unsigned long *temp_start)
+{}
+#endif
+
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
 int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index fba686487e3b..1180c0aa73f6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -445,6 +445,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+	kexec_random_range_start(temp_start, temp_end, kbuf, &temp_start);
 
 	do {
 		/* align down start */
@@ -489,6 +490,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 
 	temp_start = max(start, kbuf->buf_min);
 
+	kexec_random_range_start(temp_start, end, kbuf, &temp_start);
+
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
 		temp_end = temp_start + kbuf->memsz - 1;
-- 
2.49.0


