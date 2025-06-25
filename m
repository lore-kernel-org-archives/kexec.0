Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F249C77B7C
	for <kexec@archiver.kernel.org>; Wed, 25 Jun 2025 02:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zJKlHRLULHczskwFlrVOM4SJTi0Jl8rcV6RyjZVMSIY=; b=1AuIZGtq8J908sfb/VmtDpwPot
	IIQ/raoLiZuCsPTWFNw02WBF13hiCSdkyoLokVzOl4LFq3989noePcCo1uI3k4pkwkLsrxbIVunIu
	fIgSz7rsu2Xx/k/8ixZII4vaWQ5nVVLPjHeDRZRX0yrdci+59iHqiaR6RdCNVeKgHIsJ04GnSoXgy
	65ZDUCAX0Zx7CDrcQhGqPt1GCqkNnFoH5KpxAOWxN1qJtc/XUIGw86jlp95m2n5W7tV800XkNsj98
	3B7NSa/NZSR96HLbsk8iw8Qc8FWdURtpqQWfMVUIXueudBJYnmV14VLLzD6RTUWShiH6F8UhdvW0C
	DH0sRiSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUG33-00000007LN2-2wfb;
	Wed, 25 Jun 2025 02:39:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUFpl-00000007KHe-0793
	for kexec@lists.infradead.org;
	Wed, 25 Jun 2025 02:25:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750818354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zJKlHRLULHczskwFlrVOM4SJTi0Jl8rcV6RyjZVMSIY=;
	b=Pl6GNC1Cd/ZX3F0isiB6pfYm+V+aRDZ+5DJm295vkQkLmXmclFcjTQz326H4lUZfKpyk8+
	VeiJ7QRa+eLeiZYgKL0URncMrmC1cwJmrs42Q4aS72qG5bWU4VPXJblopHT4TO5law4JRe
	DrlDId1Bt/3oqeZBfS05Ro/7kRjovAo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-kAhozjOLMOS_z76hRDKZbA-1; Tue, 24 Jun 2025 22:25:52 -0400
X-MC-Unique: kAhozjOLMOS_z76hRDKZbA-1
X-Mimecast-MFC-AGG-ID: kAhozjOLMOS_z76hRDKZbA_1750818352
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23638e1605dso43959095ad.0
        for <kexec@lists.infradead.org>; Tue, 24 Jun 2025 19:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750818351; x=1751423151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJKlHRLULHczskwFlrVOM4SJTi0Jl8rcV6RyjZVMSIY=;
        b=PdGp5PCqn72OuhtRUJUsp5YLwqUUzdA0PtD/se8y1PEjsfUvBBXdnygHYe6hnyvsQK
         xRvdNFjrZeIff7Rv7T7y+jLkh0FMt1iIRWDrKS9CvCSOORMVnXwGJGyboa1u7p3yOk5o
         il5TyZTshANmDu/UXoct+g19Ag9d1mIpCNO5zUscPDbhLKG5qYLyzUynQ0wze2vjoQ5B
         k6FhoFa/WUUMPZqXHYKZJ5zraaZob50pLfKh0dN+9ZNpYz6njDaOL/u7A8JI8yQfCZtF
         gwdsTNqnC1gVbfXRVgCFbiHJtbDRGOJNFJOm+khACQQcdMI9+4HvsKot5+QUCsZRLfI/
         isjA==
X-Forwarded-Encrypted: i=1; AJvYcCUH1BTMN1X2Fioa9n4OsdPTON5Qw1NLzBXJYFpKPQMg39QDjRKj8r/e4Vy1LlPldwadN5XoZA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywq+nk90h5g5cVe1ctdgzd6Vns1d567PgiKeZnQtwwQZhxu2YZJ
	qoW5H1pdKI4ggycFjlmjGfVpW4hzyX9ovsoWcuUGJgE4JlFVUYrmbMvbXgmarp4kJNCrt28L0zh
	qn2tX9VxH7j3FfpRu0mtiAqUQThnlHSf91sgFR4buFPKa6CVpv94rQjSAc5hM3Q==
X-Gm-Gg: ASbGnctC2EYwFhcA3JQiu9hll8NUvE1OwkiAOSPdpEM1kdhzLdSLxdsk6yOQcZZN1FO
	OlRz68IJK+oVJnss0zEwjW/hznipRDOr4YQLdEHqGQfoNiwnV2aTuy/jhFmhp7yNn7YgnnXf6MA
	GTDJqobLFHLOi5NLiW/Rg5LQYCvZX7h5DZ94X7eDiylVOLAT6b0mL/+HJtRafrgQb8MZW4CXSZ1
	ZRAbMeEOBtPSbWhukCXU6RW2F7ER6bUK3z7jB6JsuE+lIrXJVaj00CJKRFghn/bdGG8BNsyPOpR
	mxb17NiSjZca//o6pn6pEfknwiYHv+18R7DOAnTqAbXyMVcGjl+qv6yAHfrJhngp5+J4FKA=
X-Received: by 2002:a17:903:1664:b0:234:e655:a618 with SMTP id d9443c01a7336-2382403e012mr21130315ad.25.1750818351514;
        Tue, 24 Jun 2025 19:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHNzdEoZtqc0yOlDkdoMVT65wYN0yv7oSE7tofjo8yS6HRuySFtc9cnT12ACS543g+YWzoRA==
X-Received: by 2002:a17:903:1664:b0:234:e655:a618 with SMTP id d9443c01a7336-2382403e012mr21130155ad.25.1750818351027;
        Tue, 24 Jun 2025 19:25:51 -0700 (PDT)
Received: from localhost.localdomain.com (122-56-232-175.mobile.spark.co.nz. [122.56.232.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-238072314basm25709135ad.145.2025.06.24.19.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 19:25:50 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org,
	sourabhjain@linux.ibm.com
Cc: Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode (--num-threads=N)
Date: Wed, 25 Jun 2025 14:23:44 +1200
Message-ID: <20250625022343.57529-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FIlheH5XLLPHG_FKK9F7-xtT0T7LvnfndB1FhlomxEA_1750818352
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_192557_138245_B3517311 
X-CRM114-Status: GOOD (  17.50  )
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

A vmcore corrupt issue has been noticed in powerpc arch [1]. It can be
reproduced with upstream makedumpfile.

When analyzing the corrupt vmcore using crash, the following error
message will output:

    crash: compressed kdump: uncompress failed: 0
    crash: read error: kernel virtual address: c0001e2d2fe48000  type:
    "hardirq thread_union"
    crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
    crash: compressed kdump: uncompress failed: 0

If the vmcore is generated without num-threads option, then no such
errors are noticed.

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

Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Tao Liu <ltao@redhat.com>
---

v2 -> v1: Add error message of crash into commit log

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


