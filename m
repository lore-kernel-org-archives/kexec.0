Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67B3C5B552
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fcOOHxuavlIDuomuutSpL+1SGGYkMwYXMsF12LpSTWw=; b=pUKIv7DMzu51MLFH1kts6XNg1K
	qDNBc6rc7c65TzNyf6OWL4Ao9J0IMOkiz/fXxjBznWNtA3oBMQ9L3LYtWxXU01r+sWGUM6JhisOfr
	llWuAlx6t2bYX67Y4WmkPb8xaUQLHluXRbeOdWiVlFtUvm1DB/zz0OwHTMVXktXj0X2SJ5lzPiHLk
	w5YScRZRZFgHdx2OIaSmn3WkUN+LngOlSkjOBWJf6zxt+m2Q6lE5ok4hg4Ytr4GPnaoHhMGRcttF6
	yhnlo2yYWV/6i/BBpRaQLpMdWRg+Qq6HAGGHkkXMVGKTJZoxnjtFBCfyLoINdcZ98dD/AJefdkiQ+
	8JcCoZBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwf0-00000006Y8d-0sXM;
	Tue, 10 Jun 2025 10:56:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvlZ-00000006Qch-3TCe
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 09:59:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcOOHxuavlIDuomuutSpL+1SGGYkMwYXMsF12LpSTWw=;
	b=NJPAFsCEWUIDzm5qvO6t1LImLwrSY9zJXb90iE4gBxfqhBhOqO/NREmLkBPRdWibdfIFkE
	8JEyaN0g4HNY0CURD54MxvzP6muiKUzDLHXi85LKkHhwgtjTjOYtEGimViBkDIUpUperJZ
	vTq+5BWOcAFHYEBetWih84ONRzptjfQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-dcbRyml4Pf6ICcF4-wMZMQ-1; Tue, 10 Jun 2025 05:58:05 -0400
X-MC-Unique: dcbRyml4Pf6ICcF4-wMZMQ-1
X-Mimecast-MFC-AGG-ID: dcbRyml4Pf6ICcF4-wMZMQ_1749549485
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30a39fa0765so7770150a91.3
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549485; x=1750154285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcOOHxuavlIDuomuutSpL+1SGGYkMwYXMsF12LpSTWw=;
        b=ZsOiESg+qdSMVdKVkrlZaJcq35m6Q34Ra22sZG8qfNOs0y5w803iuoVpTBtyR2H2Gi
         W+B5kHhL4mHaASa3HyqygAhu53TV3FNLqGYF+S3ONTkZytINGTwONwUUtXXYQyZZPN5X
         M8dsUWA2e0PwX1GMRJiwQuU6N4dl5BJmC7KT9a81lK9CY1PlT/wY8cGZNX5FHxQCMQO4
         OvG3vJJf65VdoptDzCHqHTtukhC6zi9h2cx5vLpa4Gjn0mq/l0i9M6ZBbgB4XvTnl90a
         n5VwEFSo7nCnZvmoY1/uGDJCzo+Jcgac5KtLn1YcpzVWNV5cQO5urvKLrOaYtbq79HAM
         lCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFkhWLVjRNClB2E6jikrniyn4Nts/zXXHgpfrFosbjGPEZE4ZOUt4pGbl8rToMuoF30Zsdkw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxecq/XjG8GkQs9eO4beF0WfqswuTS+SbAEmynhb3zKSzggX2I6
	BJbADwX0onKCKW84g6OiqyQvu4ZguNkIfhUQFd3ZrRdUFwnl3n5rDT6kPHxd1DX9n4LKCvUEOlc
	685UwXdc+XgalZKfknzpMfQEVW4LtaYscMo7ID3TsKIPrZlZHi9aih4qcpU06RA==
X-Gm-Gg: ASbGnctvPLNQo1/cqABBj+1e8oD5/a1JFJY71/QYOQ667J5tV4aG2Lrv/KzW8XhlJfW
	SCemRUhy8L5WOliBKZfk26zaMhDQyMPaB+I1H1maDFZJa8mFiFommeG4lKKYmaSl484ybh5Hv5j
	6e0COn1HNKJ6ZL1qlWfcLn7cj1yFaAJDZUbFT0xHQqiysPdGD6y/mWvFy/4m1B9wjqedrtEiE8u
	ERYI0oTx4W/YM7QNX1lW2Jmsq4Rnwo4i4wbDdNn0r7AKJqbjmY2fl9RfgaAtvcJwbuZtMbRZLri
	12VF9Ku81iudXW0KqKrn5bGVrv3bzNc=
X-Received: by 2002:a17:90b:5825:b0:312:959:dc3f with SMTP id 98e67ed59e1d1-313a151f895mr2603048a91.3.1749549484553;
        Tue, 10 Jun 2025 02:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK52HcqKcLKXtnSNa1oroypkmEgSyQe+YN2AggNI0MKCTYJFDpFe3F8uCKxkHV/dMV5ANEVA==
X-Received: by 2002:a17:90b:5825:b0:312:959:dc3f with SMTP id 98e67ed59e1d1-313a151f895mr2603031a91.3.1749549484199;
        Tue, 10 Jun 2025 02:58:04 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:58:03 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 03/10] Add page filtering function
Date: Tue, 10 Jun 2025 21:57:36 +1200
Message-ID: <20250610095743.18073-4-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xSpffy0yHupjYAuR4kkxAjHkDvsFjEeZZs4EgIyZ_Ok_1749549485
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_025937_943266_8159BE43 
X-CRM114-Status: GOOD (  22.72  )
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

pfn and num is the data which eppic scritps give to makedumpfile for mm page
filtering, so any page within [pfn ~ pfn + num) can be filtered. Since
makedumpfile will iterate the pfn in an ascending order, the pfn & num
linked lists are also organized in a ascending order by pfn, so if one pfn
is hit by one list, the following pfn is more likely to be hit either by
this list again, or the one after, and a cur variable is used for saving
the current list to speedup the checking process.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 erase_info.c   | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 erase_info.h   |  8 ++++++
 makedumpfile.c | 18 ++++++++++---
 3 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index b67d1d0..d68e1a2 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -2466,3 +2466,72 @@ get_size_eraseinfo(void)
 	return size_eraseinfo;
 }
 
+static struct ft_page_info *ft_head = NULL;
+
+/*
+ * Insert the ft_page_info blocks into ft_head by ascending pfn.
+ */
+int
+update_filter_pages_info(unsigned long pfn, unsigned long num)
+{
+	struct ft_page_info *p;
+	struct ft_page_info *new_p = malloc(sizeof(struct ft_page_info));
+
+	if (!new_p) {
+		ERRMSG("Can't allocate memory for ft_page_info at %lx\n", pfn);
+		return 1;
+	}
+	new_p->pfn = pfn;
+	new_p->num = num;
+	new_p->next = NULL;
+
+	if (!ft_head || ft_head->pfn > new_p->pfn) {
+		new_p->next = ft_head;
+		ft_head = new_p;
+		return 0;
+	}
+
+	p = ft_head;
+	while (p->next != NULL && p->next->pfn < new_p->pfn) {
+		p = p->next;
+	}
+
+	new_p->next = p->next;
+	p->next = new_p;
+	return 0;
+}
+
+/*
+ * Check if the pfn page should be filtered.
+ *
+ * pfn and ft_head are in ascending order, so save the current ft_page_info
+ * block into **p because it is likely to hit again next time.
+ */
+int
+filter_page(unsigned long pfn, struct ft_page_info **p)
+{
+	if (ft_head == NULL)
+		return 0;
+
+	if (*p == NULL)
+		*p = ft_head;
+
+	/* Handle the 1st gap */
+	if (pfn >= 0 && pfn < ft_head->pfn)
+		return 0;
+
+	/* Handle ft_page_info blocks and following gaps */
+	while ((*p)->next) {
+		if (pfn >= (*p)->pfn && pfn < (*p)->pfn + (*p)->num)
+			return 1; // filter this page
+		if (pfn >= (*p)->pfn + (*p)->num && pfn < (*p)->next->pfn)
+			return 0; // save this page
+		*p = (*p)->next;
+	}
+
+	/* Handle the last gap */
+	if (pfn >= (*p)->pfn + (*p)->num)
+		return 0;
+	else
+		return 1;
+}
\ No newline at end of file
diff --git a/erase_info.h b/erase_info.h
index b363a40..4552dfc 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -64,6 +64,14 @@ void filter_data_buffer_parallel(unsigned char *buf, unsigned long long paddr,
 					size_t size, pthread_mutex_t *mutex);
 unsigned long get_size_eraseinfo(void);
 int update_filter_info_raw(unsigned long long, int, int);
+int update_filter_pages_info(unsigned long, unsigned long);
+
+struct ft_page_info {
+	unsigned long pfn;
+	unsigned long num;
+	struct ft_page_info *next;
+};
+int filter_page(unsigned long, struct ft_page_info **p);
 
 #endif /* _ERASE_INFO_H */
 
diff --git a/makedumpfile.c b/makedumpfile.c
index 2d3b08b..33fad32 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -100,6 +100,7 @@ mdf_pfn_t pfn_user;
 mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
 mdf_pfn_t pfn_offline;
+mdf_pfn_t pfn_eppic;
 mdf_pfn_t pfn_elf_excluded;
 
 mdf_pfn_t num_dumped;
@@ -6453,6 +6454,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned int order_offset, dtor_offset;
 	unsigned long flags, mapping, private = 0;
 	unsigned long compound_dtor, compound_head = 0;
+	struct ft_page_info *cur = NULL;
 
 	/*
 	 * If a multi-page exclusion is pending, do it first
@@ -6670,6 +6672,13 @@ check_order:
 		else if (isOffline(flags, _mapcount)) {
 			pfn_counter = &pfn_offline;
 		}
+		/*
+		 * Exclude pages that specified by eppic script
+		 */
+		else if (filter_page(pfn, &cur)) {
+			nr_pages = 1;
+			pfn_counter = &pfn_eppic;
+		}
 		/*
 		 * Unexcludable page
 		 */
@@ -8217,7 +8226,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 */
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_eppic = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -9555,7 +9564,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 * Reset counter for debug message.
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_eppic = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -10504,7 +10513,7 @@ print_report(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_eppic;
 
 	REPORT_MSG("\n");
 	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
@@ -10520,6 +10529,7 @@ print_report(void)
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
+	REPORT_MSG("    Eppic filtered pages    : 0x%016llx\n", pfn_eppic);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
 
@@ -10560,7 +10570,7 @@ print_mem_usage(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_eppic;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 	total_size = info->page_size * pfn_original;
-- 
2.47.0


