Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9006CC7115A
	for <kexec@archiver.kernel.org>; Wed, 18 Jun 2025 23:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x9qjMJUsurH/IxVcO0jFdI9JhX/uu0M1NvVuua8q1OI=; b=gits8WPtGhhKotNXRIgeG2DaI5
	CL7LjCibx+7YIUyzj9s+eHWTpbJNcNQOXdz5gzRBLB3GQvInYvIgGyRxqU26zSQ+zh/ss6QIUL+XD
	sCAxjUuGFcHzhxNMrkKRqhx0uQ6U9yruH0PT/dsz9PB3ydpA4M5uNg4bTqHx15aOGkS9LSsmmjpBi
	uqk6OyahbkMcrxgWi2sGrHrXaL6cmT+53QCHNjpKDKzfzrn1/2Vk7KLc6lo7depff+LgUk9KTZHWg
	LaXofhlKUceruzklUxlA9+fnpmEEYYkdI61HoVIWOOnKlxdQTRec2OiEZAH7GCovMD9R132B1ez7d
	XjNA/mbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS2er-0000000BbxD-1CGf;
	Wed, 18 Jun 2025 23:57:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS2ep-0000000Bbwr-1M37
	for kexec@lists.infradead.org;
	Wed, 18 Jun 2025 23:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750291050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x9qjMJUsurH/IxVcO0jFdI9JhX/uu0M1NvVuua8q1OI=;
	b=ZERc7qtNoLmHnpGlRhREkwkV+eIbKFY/qamrDQhYsEitNwmuq48D5tKpshw/kXDt+hQaB5
	WIsyx+2DhmcVu4CfDFTyMGjEH/t+bLZaoULsGdKwGHBlZUOgrxnceSW8fVua6SSQubI84r
	SGVzdnTZNmENGbB6MVmAug5ayA9dhhM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Uf5Xc4lHN7SrXf0_L6qjLQ-1; Wed, 18 Jun 2025 19:57:29 -0400
X-MC-Unique: Uf5Xc4lHN7SrXf0_L6qjLQ-1
X-Mimecast-MFC-AGG-ID: Uf5Xc4lHN7SrXf0_L6qjLQ_1750291048
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31c38d4063so142232a12.3
        for <kexec@lists.infradead.org>; Wed, 18 Jun 2025 16:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750291048; x=1750895848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9qjMJUsurH/IxVcO0jFdI9JhX/uu0M1NvVuua8q1OI=;
        b=wn7bELJ5NhZW/gKHu6Iwxq3tck7h2dNJqOI812HEQRT3ypZxaascmeiMmwrh+oBhwP
         04AaXQ1PkZrNKtkKrM8ehg/hTLIPhLw0+la232K1U217VnyDFKItEPqDgLtTHPuaMo4M
         qqABZqM1vo5yjNbvJinplmW1+nH/bKqjkf0hSvAakqDSaDBwVfyCQHoWj8XXcTqTI8dg
         E6MiLdr1hWqbLSWx3kh61yOms1GSNx1hR36AlcNeVJzcSTvY95IfgsmdBg9fqTnWJ1bn
         7PGRY/bAcdjmY7rM5FXtL2/eFwjg0KEa1c3Yagxxrdv4Tma9yP/q7E+NBA9IoRx2GY/5
         y70Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7x3PNh0RoF+n1866j6vbDErvshMcTKrWnidoKEjpRNYLLWrXxQE3sjXoXkGKS6IAJORfK1Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxf0qpzaelAxDGjbe4kYtyKPeSvgdIHaL2cc2xlTh7spCO8HWjd
	u/lF6Vsk1gHasyZ51+bH3u99iqjGT/qf4yVdC1XUG0ekwm6lWcDqyVhTsR30hFrH54kddmk1TXk
	K4XIw5DKZE0kcqViSjLATWvSImmdkfKjspYN6pA29ZS/jYGkoC2d9202hVQx10Q==
X-Gm-Gg: ASbGncuFURbDgGqb4hC437bplkAuAAzuscxiGA1KjWG67f5381MK+MV2r2HtXRL3D9C
	pCckA990W47brNS37MAVambizzJNG2fj8qMLENVGk6WPMmBGg4oahQj662LGwQtLnRiMmOXHHpR
	AguCV5G09LV6W1tlQXJy9xFVPF0AIzydQWnwF72gNP9yHm0q9o64aeAQYY4cuo6AtDsg7DLVDtm
	MtX2LuIPclarC0nTYZK8sHmgtuTochJQCvMBpGMWqa/WFmvY12Ss7ue9O2ZNcfhDVHL32xoSyO+
	MSgQ1r0CanDupG3AtFJ2gSMBo0BK9ms=
X-Received: by 2002:a05:6a20:5491:b0:1f5:8cdb:2777 with SMTP id adf61e73a8af0-21fbd48c508mr28309676637.3.1750291048092;
        Wed, 18 Jun 2025 16:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGz9YUy/A1O4GX/ZZ3nwN/csV4529BNDPXcH+XWYux4ro+962zUoWXjTuyKcvGVe3UK6425w==
X-Received: by 2002:a05:6a20:5491:b0:1f5:8cdb:2777 with SMTP id adf61e73a8af0-21fbd48c508mr28309652637.3.1750291047571;
        Wed, 18 Jun 2025 16:57:27 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecfbasm12209422b3a.15.2025.06.18.16.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 16:57:27 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org,
	sourabhjain@linux.ibm.com
Cc: Tao Liu <ltao@redhat.com>
Subject: [PATCH][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
Date: Thu, 19 Jun 2025 11:56:45 +1200
Message-ID: <20250618235644.22589-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sFjLTPqTl4NHZuV_WD_3ShGLUHO9YX6hGk5q-gljxSM_1750291048
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_165731_431891_47D8C74D 
X-CRM114-Status: GOOD (  17.70  )
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

A vmcore corrupt issue has been noticed in powerpc arch [1]. Although the
original issue was closed, but it still can be reproduced with upstream
makedumpfile.

With --num-threads=N enabled, there will be N sub-threads created. All
sub-threads are producers which responsible for mm page processing, e.g.
compression. The main thread is the consumer which responsible for
writing the compressed data into file. page_flag_buf->ready is used to
sync main and sub-threads. When a sub-thread finishes page processing,
it will set ready flag to be FLAG_READY. In the meantime, main thread
looply check all threads of the ready flags, and break the loop when
find FLAG_READY.

page_flag_buf->ready is read/write by main/sub-threads simultaneously,
but it is unprotected and unsafe. I have tested both mutex and atomic_rw
can fix this issue. This patch takes atomic_rw for its simplicity.

[1]: https://github.com/makedumpfile/makedumpfile/issues/15

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 makedumpfile.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 2d3b08b..bac45c2 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8621,7 +8621,8 @@ kdump_thread_function_cyclic(void *arg) {
 
 		while (buf_ready == FALSE) {
 			pthread_testcancel();
-			if (page_flag_buf->ready == FLAG_READY)
+			if (__atomic_load_n(&page_flag_buf->ready,
+					__ATOMIC_SEQ_CST) == FLAG_READY)
 				continue;
 
 			/* get next dumpable pfn */
@@ -8637,7 +8638,8 @@ kdump_thread_function_cyclic(void *arg) {
 			info->current_pfn = pfn + 1;
 
 			page_flag_buf->pfn = pfn;
-			page_flag_buf->ready = FLAG_FILLING;
+			__atomic_store_n(&page_flag_buf->ready, FLAG_FILLING,
+					__ATOMIC_SEQ_CST);
 			pthread_mutex_unlock(&info->current_pfn_mutex);
 			sem_post(&info->page_flag_buf_sem);
 
@@ -8726,7 +8728,8 @@ kdump_thread_function_cyclic(void *arg) {
 			page_flag_buf->index = index;
 			buf_ready = TRUE;
 next:
-			page_flag_buf->ready = FLAG_READY;
+			__atomic_store_n(&page_flag_buf->ready, FLAG_READY,
+					__ATOMIC_SEQ_CST);
 			page_flag_buf = page_flag_buf->next;
 
 		}
@@ -8855,7 +8858,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 			 * current_pfn is used for recording the value of pfn when checking the pfn.
 			 */
 			for (i = 0; i < info->num_threads; i++) {
-				if (info->page_flag_buf[i]->ready == FLAG_UNUSED)
+				if (__atomic_load_n(&info->page_flag_buf[i]->ready,
+						__ATOMIC_SEQ_CST) == FLAG_UNUSED)
 					continue;
 				temp_pfn = info->page_flag_buf[i]->pfn;
 
@@ -8863,7 +8867,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 				 * count how many threads have reached the end.
 				 */
 				if (temp_pfn >= end_pfn) {
-					info->page_flag_buf[i]->ready = FLAG_UNUSED;
+					__atomic_store_n(&info->page_flag_buf[i]->ready,
+						FLAG_UNUSED, __ATOMIC_SEQ_CST);
 					end_count++;
 					continue;
 				}
@@ -8885,7 +8890,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 			 * If the page_flag_buf is not ready, the pfn recorded may be changed.
 			 * So we should recheck.
 			 */
-			if (info->page_flag_buf[consuming]->ready != FLAG_READY) {
+			if (__atomic_load_n(&info->page_flag_buf[consuming]->ready,
+					__ATOMIC_SEQ_CST) != FLAG_READY) {
 				clock_gettime(CLOCK_MONOTONIC, &new);
 				if (new.tv_sec - last.tv_sec > WAIT_TIME) {
 					ERRMSG("Can't get data of pfn.\n");
@@ -8927,7 +8933,8 @@ write_kdump_pages_parallel_cyclic(struct cache_data *cd_header,
 				goto out;
 			page_data_buf[index].used = FALSE;
 		}
-		info->page_flag_buf[consuming]->ready = FLAG_UNUSED;
+		__atomic_store_n(&info->page_flag_buf[consuming]->ready,
+				FLAG_UNUSED, __ATOMIC_SEQ_CST);
 		info->page_flag_buf[consuming] = info->page_flag_buf[consuming]->next;
 	}
 finish:
-- 
2.47.0


