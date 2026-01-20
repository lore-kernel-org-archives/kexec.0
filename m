Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87D1D2ED0F
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 03:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zrxUvtJ1mU1KOXW0+VgLw63aKlGvv7PCUAv0Dt9EM9I=; b=P7Kp4uVnS4+MPCdemEUqaErrVX
	bY9pxkLk+2TdiZ0Yxuq0jLhiGGng280Orerk82/YweK5udSscORsEy0I8B44ksU1zA17gSWGRI0HT
	nyCPefeDy5jlPTiikbM2gLQlDC7lub6CyhqsXqdKr1S7knh05J2YYxCdUm3a6hupuMFSmPVAcbrQS
	zOBq3GkcqK/8oI3mLFdnwg2ML5O6uaKs43LozPwAFUXmFWVlWpV/bmae2JzkP8wHhK8wqq35ztjBU
	rqnuHy9933o2QeMQpcQTOhi0kKcsKThtN7MUTvSSeoUsEa17uUiz1Iofue703UyBI7MZj9VHrUc2R
	cnjiHRFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2ak-00000003898-0CBG;
	Tue, 20 Jan 2026 03:39:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2ag-0000000387K-10Bm
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 03:39:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768880377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrxUvtJ1mU1KOXW0+VgLw63aKlGvv7PCUAv0Dt9EM9I=;
	b=N2iGh1flvDsf6EqcHpMiF97lbQQeBKjbHi4N4khjeLblcMN7xdASv2h8DbqCU2sRzOOB/w
	H4tInCEQdROAVLgEKXd+FSywDdlXqf3TlSJkZqcPVCJ+kkL8xfnBhsXpNwV7BJz3R2dQo4
	zEJt2l2G28pb3MHArSwIRcu55nUFibk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-_-mOQboKN2aOQ9knylVnpQ-1; Mon, 19 Jan 2026 22:39:35 -0500
X-MC-Unique: _-mOQboKN2aOQ9knylVnpQ-1
X-Mimecast-MFC-AGG-ID: _-mOQboKN2aOQ9knylVnpQ_1768880374
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so4195236a91.0
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 19:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880374; x=1769485174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zrxUvtJ1mU1KOXW0+VgLw63aKlGvv7PCUAv0Dt9EM9I=;
        b=Dm/G1dJqtequbglA2DBqo9lLeNlICo9mODoeGR/qOlBizhrS+rwlRPy91yMktNY1ks
         M3M1a5R4/s+pl877+P7x2KyAE0JFwHpEzqSW9Gx+S/17pvFKIsmBBmKGnIxIlrlDR8DD
         EdWcwFEWfCjjF2RJqdB/2JuVtDC8RW/bMMq37Kn5DbXEQxEUdeJF9y+pktsEy++FV+Fc
         a9hEj2HxREsEz/rBqbqfl9uaaLVoaBPaSaY8fVPgQle7IYoEuj503sO+2FRGLk0iKqgf
         JAu7dY4lvnnz1U6uYH7AUJwD/HHuy60447k6jpgrjbbrqUs+TDYrjGstqAvUc1IK9sUO
         KIxA==
X-Forwarded-Encrypted: i=1; AJvYcCUlp3O76Z71A+9NFw8rIKNVxTNWnPPALZZzy4dX0nZ3KCJ99DSS9ttcdh4L50mEnE0uS7OALw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5AHpcW0xNTS72By4I55bK5yniLek3Omfqqh5/+BQHa7DbiniK
	qyiyjDcdWEGlnFFC2vzH1yDOfBOjIfv8QX7qgd0cG9RSjOc7sBs0GFOUYqE4I5V0k80gJlT682K
	9InuCRvRPtkvh2SUfo+lR68fRT57PueUzWVruvC0G5BwUrm+AWlgxOBE6OlFYAxfswbn4mA==
X-Gm-Gg: AZuq6aJc9pAveJHDdDavsYueoIu7xuHtYQmahObuqucS+Qn6bvW3AvzV1NQ5d2SnWxG
	rIUw9JIE0uVjXV5S/MMIRdeUKTnMtKPT1yWY1IHxVLjZ7Mtt6Ig8Z4JVixds9hiwvR6Ga5PqlY7
	+sLaSWtSaPpkZPZ7tgnYaM4A46cfZT8Scjje0EhmXmZInJs9/uV4NM6gDQwnivFdST2sZpKXtpV
	y7XPT/Rotwxu/kbgdCYuYMApMVLfStlT0gX9L6OlsSO4T28+IZ1JR8+U5OK6hhfxuefasJTiY62
	8UpE87r/f0jeqayxF+dUKn0CDsaWY9UBERf1d41qowhlJ04+7G33EPjgrGuDQqi12kUv/ATcIlP
	d4qtPAD8CYNdh/RzKww==
X-Received: by 2002:a17:90b:2d81:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-352c3e4ac8fmr531295a91.14.1768880374201;
        Mon, 19 Jan 2026 19:39:34 -0800 (PST)
X-Received: by 2002:a17:90b:2d81:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-352c3e4ac8fmr531285a91.14.1768880373788;
        Mon, 19 Jan 2026 19:39:33 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm13375935a91.13.2026.01.19.19.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:39:33 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3 6/8] Add page filtering function
Date: Tue, 20 Jan 2026 15:54:58 +1300
Message-ID: <20260120025500.25095-7-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260120025500.25095-1-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: itffd-H4FMZ3kLmA6pQkbsYur2lUo51FrdijynvXn7M_1768880374
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_193938_363325_C70E855D 
X-CRM114-Status: GOOD (  23.49  )
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

pfn and num is the data which extensions give to makedumpfile for mm page
filtering. Since makedumpfile will iterate the pfn in an ascending order in
__exclude_unnecessary_pages(), pfn and num are stored within ft_page_info linked
lists and organized in an ascending order by pfn, so if one pfn
is hit by one list, the next pfn is most likely to be hit either by
this list again, or the one follows, so a cur variable is used for saving
the current list position to speedup the pfn checking process.

In addition, 2 ft_page_info linked list chains are used, one for mm page
discarding and the other for page keeping.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 erase_info.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 erase_info.h   | 12 +++++++
 makedumpfile.c | 28 ++++++++++++---
 3 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index b67d1d0..8838bea 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -2466,3 +2466,101 @@ get_size_eraseinfo(void)
 	return size_eraseinfo;
 }
 
+/* Pages to be discarded */
+static struct ft_page_info *ft_head_discard = NULL;
+/* Pages to be keeped */
+static struct ft_page_info *ft_head_keep = NULL;
+
+/*
+ * Insert the ft_page_info blocks into ft_head by ascending pfn.
+ */
+bool
+update_filter_pages_info(unsigned long pfn, unsigned long num, bool to_discard)
+{
+	struct ft_page_info *p, **ft_head;
+	struct ft_page_info *new_p = malloc(sizeof(struct ft_page_info));
+
+	ft_head = to_discard ? &ft_head_discard : &ft_head_keep;
+
+	if (!new_p) {
+		ERRMSG("Can't allocate memory for ft_page_info at %lx\n", pfn);
+		return false;
+	}
+	new_p->pfn = pfn;
+	new_p->num = num;
+	new_p->next = NULL;
+
+	if (!(*ft_head) || (*ft_head)->pfn > new_p->pfn) {
+		new_p->next = (*ft_head);
+		(*ft_head) = new_p;
+		return true;
+	}
+
+	p = (*ft_head);
+	while (p->next != NULL && p->next->pfn < new_p->pfn) {
+		p = p->next;
+	}
+
+	new_p->next = p->next;
+	p->next = new_p;
+	return true;
+}
+
+/*
+ * Check if the pfn hit ft_page_info block.
+ *
+ * pfn and ft_head are in ascending order, so save the current ft_page_info
+ * block into **p because it is likely to hit again next time.
+ */
+bool
+filter_page(unsigned long pfn, struct ft_page_info **p, bool handle_discard)
+{
+	struct ft_page_info *ft_head;
+
+	ft_head = handle_discard ? ft_head_discard : ft_head_keep;
+
+	if (ft_head == NULL)
+		return false;
+
+	if (*p == NULL)
+		*p = ft_head;
+
+	/* The gap before 1st block */
+	if (pfn >= 0 && pfn < ft_head->pfn)
+		return false;
+
+	/* Handle 1~(n-1) blocks and following gaps */
+	while ((*p)->next) {
+		if (pfn >= (*p)->pfn && pfn < (*p)->pfn + (*p)->num)
+			return true; // hit the block
+		if (pfn >= (*p)->pfn + (*p)->num && pfn < (*p)->next->pfn)
+			return false; // the gap after the block
+		*p = (*p)->next;
+	}
+
+	/* The last block and gap */
+	if (pfn >= (*p)->pfn + (*p)->num)
+		return false;
+	else
+		return true;
+}
+
+static void
+do_cleanup(struct ft_page_info **ft_head)
+{
+	struct ft_page_info *p, *p_tmp;
+
+	for (p = *ft_head; p;) {
+		p_tmp = p;
+		p = p->next;
+		free(p_tmp);
+	}
+	*ft_head = NULL;
+}
+
+void
+cleanup_filter_pages_info(void)
+{
+	do_cleanup(&ft_head_discard);
+	do_cleanup(&ft_head_keep);
+}
diff --git a/erase_info.h b/erase_info.h
index b363a40..6c60706 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -20,6 +20,7 @@
 #define _ERASE_INFO_H
 
 #define MAX_SIZE_STR_LEN (26)
+#include <stdbool.h>
 
 /*
  * Erase information, original symbol expressions.
@@ -65,5 +66,16 @@ void filter_data_buffer_parallel(unsigned char *buf, unsigned long long paddr,
 unsigned long get_size_eraseinfo(void);
 int update_filter_info_raw(unsigned long long, int, int);
 
+bool update_filter_pages_info(unsigned long, unsigned long, bool);
+
+struct ft_page_info {
+	unsigned long pfn;
+	unsigned long num;
+	struct ft_page_info *next;
+} __attribute__((packed));
+
+bool filter_page(unsigned long, struct ft_page_info **p, bool handle_discard);
+void cleanup_filter_pages_info(void);
+
 #endif /* _ERASE_INFO_H */
 
diff --git a/makedumpfile.c b/makedumpfile.c
index ca8ed8a..ebac8da 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -102,6 +102,7 @@ mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
 mdf_pfn_t pfn_offline;
 mdf_pfn_t pfn_elf_excluded;
+mdf_pfn_t pfn_extension;
 
 mdf_pfn_t num_dumped;
 
@@ -6459,6 +6460,8 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 	unsigned int order_offset, dtor_offset;
 	unsigned long flags, mapping, private = 0;
 	unsigned long compound_dtor, compound_head = 0;
+	struct ft_page_info *cur_discard = NULL;
+	struct ft_page_info *cur_keep = NULL;
 
 	/*
 	 * If a multi-page exclusion is pending, do it first
@@ -6495,6 +6498,13 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		if (info->flag_cyclic && !is_cyclic_region(pfn, cycle))
 			continue;
 
+		/*
+		 * Keep pages that specified by user via
+		 * makedumpfile extensions
+		 */
+		if (filter_page(pfn, &cur_keep, false))
+			continue;
+
 		/*
 		 * Exclude the memory hole.
 		 */
@@ -6687,6 +6697,14 @@ check_order:
 		else if (isOffline(flags, _mapcount)) {
 			pfn_counter = &pfn_offline;
 		}
+		/*
+		 * Exclude pages that specified by user via
+		 * makedumpfile extensions
+		 */
+		else if (filter_page(pfn, &cur_discard, true)) {
+			nr_pages = 1;
+			pfn_counter = &pfn_extension;
+		}
 		/*
 		 * Unexcludable page
 		 */
@@ -6748,6 +6766,7 @@ exclude_unnecessary_pages(struct cycle *cycle)
 		print_progress(PROGRESS_UNN_PAGES, info->num_mem_map, info->num_mem_map, NULL);
 		print_execution_time(PROGRESS_UNN_PAGES, &ts_start);
 	}
+	cleanup_filter_pages_info();
 
 	return TRUE;
 }
@@ -8234,7 +8253,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 */
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -9579,7 +9598,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 * Reset counter for debug message.
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_extension = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -10528,7 +10547,7 @@ print_report(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_extension;
 
 	REPORT_MSG("\n");
 	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
@@ -10544,6 +10563,7 @@ print_report(void)
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
+	REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_extension);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
 
@@ -10584,7 +10604,7 @@ print_mem_usage(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_extension;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 	total_size = info->page_size * pfn_original;
-- 
2.47.0


