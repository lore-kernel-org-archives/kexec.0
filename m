Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AA8CCD1A2
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rt4aMimZMzfPvCgAGyWcWfzzFK4ASU33RpzUho4to+o=; b=MY7SbJzoHgJqEGFvQg4x3hnOzp
	Y3X42FmyHzkre794jAs9T/Tnzrx7c9rNIkhhqL4qeJmVL49CtLUXtssJIN+waATgz0/xfePRnFKv1
	CguTbiqCwv4mKgaYvZ/3efXqupciKP5FP4G7kAzNL4rj284psWTXgq+VrvwjqdWlhAfvxagavkz68
	c9Q29Tjm2xhVA6LCBT6JlSUomQ/MJjUkbsMt2S+05H6YAYI1nt2L1a42cRFp/F0DG1eXzSYX3qTqw
	ZD7v0zujZhEV026eA+J2F1/fv2ERANDoyNt619WzyhhRzmBIrtXGILplzXjdFHd81xVmUu9SzG/e0
	sCfMAELA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIm-0000000FAqb-3hWx;
	Mon, 20 Oct 2025 22:24:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIk-0000000FApz-3CEm
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:24:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rt4aMimZMzfPvCgAGyWcWfzzFK4ASU33RpzUho4to+o=;
	b=IB0gN+YRio5Om/Rqo1w9tDRF9KFRb8hPx1+2KcphUsKSItlDyfDi4jP26p3H0F2jktRN4t
	eaq0dA9Kho4w2GdSgU7G/f8ikIesom5qcnLW3Vqnqx+hvSpnkr92//AGrNr0cKZZ76QLxF
	U1Kjqo7JxPCr1PKic7ybyBWGnMSazVM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-ivTV4cTIPjKxPjE0rKIPmQ-1; Mon, 20 Oct 2025 18:24:24 -0400
X-MC-Unique: ivTV4cTIPjKxPjE0rKIPmQ-1
X-Mimecast-MFC-AGG-ID: ivTV4cTIPjKxPjE0rKIPmQ_1760999063
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e60221fso8572652b3a.0
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999063; x=1761603863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt4aMimZMzfPvCgAGyWcWfzzFK4ASU33RpzUho4to+o=;
        b=qu9OkWcu9dIEvUnU52OD35XBAveYERf3lcnBsIN7N21H2SAscB5IsjRAUi/CWhjMae
         2TFmf+HeZ60xO8I7UKGQb4V+DCet6G/L9FCx5HQvriGku3A1ut3yoCXaEWE/vrVfzs0I
         b2ZrkgS2kGkSLUZnEzV4YSNqBrLBhC1kk9ga8169Sa+Su4I32686AjYh64dV52kUK7H/
         YEyihOimd/IjiGRW0UbRu9OTuST2Ym927lHZqJ2HemiSxWSK/bDd7I1EJq2/Vz4QEZNo
         JfgMaYnnKskEhF0V7mo5w2KCihgdmvUR6XjnIRQxkEetJMvcltElZdU/rKQ8NbXJiGf3
         WmqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrufYr9zdMcMECjVyzp0y1iDJj3un3CPZ0IhWOEvUc/qzBVAynvRMcnTi5JWrUOB8go1bzRA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzknwk0ffs1JfW+sqfmFtZ+pr9FIqJ1ywzja5gOjVftr4xLitA1
	HfyzdNyqEVbGNOO3QbuPgy74x6AM/Mskk2Ai99TiNeE1UTCwcrx+wum1j4RR3WQux07UOvffFja
	JtOf+fBekTUZ+F+PFOrGPaZLoReAbfBLUesVi3D5z3n1V/ayMxYa4+yN/ag4cVndRjuhBdA==
X-Gm-Gg: ASbGncuealR4TQCwdEfs/s7zjHDykbta1Dv2G4Hoti0ekoPEoaXUGUb0pySlRngvP7f
	/O6eVoTf5+EAtzGRZd/EjbJtotfkQMuWQIryGWa+ovKewhCnsQwHY62bHJjVf7vKn1c8d+2boOT
	ueFJBFprTb55EvEcvIKdLgksKDn1lBusUUetP/+T2nS6W7m7Z4Qh5XQBQh2mx1OIx5d1sK5sdT8
	RyOJJ2Y4p6Gm7f8UD2S7pRc1lZiHl+rc4fne4vTVuth7AzSbIq5ybFjNhBmw+vhqp1ZhKNFCg+w
	/SQsM6lPA7duDnJe26/Ak5hXxTbV90FlKfUxY7oFqWj9U2ePsZuXp24EIMGKQNzke5VCl2+9rnc
	wXCqNQ7Y0Ay+wye35D++3qpwAmCbNjK8OT2/2miJqwq4=
X-Received: by 2002:a05:6a00:acc:b0:781:1b4c:75fb with SMTP id d2e1a72fcca58-7a220b0719cmr20351102b3a.18.1760999063028;
        Mon, 20 Oct 2025 15:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTpRjDVz9jfZvAFkbgresngQrsaEKD/tN8fy7c0ZcKNMwG5mWEh6T7sTe6nADO/+DrPdI3xA==
X-Received: by 2002:a05:6a00:acc:b0:781:1b4c:75fb with SMTP id d2e1a72fcca58-7a220b0719cmr20351074b3a.18.1760999062516;
        Mon, 20 Oct 2025 15:24:22 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:22 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 01/14] Add page filtering function
Date: Tue, 21 Oct 2025 11:23:57 +1300
Message-ID: <20251020222410.8235-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gX_tDNGnuHUUAaxanzv3HKfY547yVEMnCfBdVBRuES4_1760999063
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152426_877681_9DA243F8 
X-CRM114-Status: GOOD (  22.18  )
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
filtering, so any page within (pfn ~ pfn + num) can be filtered. Since
makedumpfile will iterate the pfn in an ascending order in
__exclude_unnecessary_pages(), the linked lists formed by ft_page_info will
also be organized in an ascending order by pfn, so if one pfn
is hit by one list, the following pfn is most likely to be hit either by
this list again, or the one follows, so a cur variable is used for saving
the current list position to speedup the pfn checking process.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 erase_info.c   | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 erase_info.h   |  8 ++++++
 makedumpfile.c | 18 ++++++++++---
 3 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index af6bfae..fd316c1 100644
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


