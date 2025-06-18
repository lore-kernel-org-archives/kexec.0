Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A451C71157
	for <kexec@archiver.kernel.org>; Wed, 18 Jun 2025 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x9qjMJUsurH/IxVcO0jFdI9JhX/uu0M1NvVuua8q1OI=; b=KKb3W9dHaZDRB8ZMk1h08ejW/3
	nwehA+98DrJsViXmG+M3b1OtnspmfAOopX2sIxPdwms8qtk21B4CIhrrpISNUhBBnt5Zu5n0/cpK/
	fO6kqCcm5TPXWUScXpKRW25z1St5ZM1edW7TwAoSDvEz7Pk7MCesquiYf+p10nGo5yaJ6QvhaEjBq
	WMNR4hsVfpVeSrnGWViLp4awRtqCoD4Qef88taYS1uVkKJUGU2doPLDKUik/kks/DPeCroe85KV5S
	POhtkucSYqY8SHfTCXotk/dTLcY5fzc+86qjxuW4IKLxPrXqGnds4c/iyOrfKZ2CbFcAiVx/Tewj+
	YOx19G5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS2dH-0000000Bbqx-3O68;
	Wed, 18 Jun 2025 23:55:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS2dF-0000000Bbpv-08oH
	for kexec@lists.infradead.org;
	Wed, 18 Jun 2025 23:55:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750290951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x9qjMJUsurH/IxVcO0jFdI9JhX/uu0M1NvVuua8q1OI=;
	b=gzRyLfbJgic20ZfjVewUaJ417PKpEzA9xXDrih9NUB0cT0+nNJ3F65o7oQzZhq1dT4AqJu
	eAkV+nsXCrvPUSpUFC8y6FBMEaRiC/YQDDVLM0ziX88dN2lUb7lUdk8Nzmp1B9k1jY13rC
	MsTwyEMFahGmdRYltABTf5sE8NHcc/c=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-ZG3wzafAM8q6zAqUo0iiww-1; Wed, 18 Jun 2025 19:55:49 -0400
X-MC-Unique: ZG3wzafAM8q6zAqUo0iiww-1
X-Mimecast-MFC-AGG-ID: ZG3wzafAM8q6zAqUo0iiww_1750290949
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2fb347b3e6so231936a12.1
        for <kexec@lists.infradead.org>; Wed, 18 Jun 2025 16:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750290948; x=1750895748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9qjMJUsurH/IxVcO0jFdI9JhX/uu0M1NvVuua8q1OI=;
        b=UNUzwczY4dnHNKdrHugqodos0/Otf7Kcuy3+srUNo2niJnZRb0V1Id/igtN+EfULUw
         LjjyqtHLgkVfJb3zIF/sfXQRp8kzmOKhntIzYNYH8Pljok3l/CkWEp0woUWr6fnuLUI4
         GNlq+uAex+Z2Otddlud7PCg9rsz6S58yCL/vbyWu+0qA8/1FFw4XUsZ2GVEWQ7j+4Usd
         oue+btxmlW7+emN7YVdprxMGh8/EgB3tFUISql0zGesFeIXcztYV8jolo/pRRMjKy9+v
         FGl3ZyeHpRU2ZLfTwna+NefBlrEJwmRP6OX5QNM3eWYzATiBeICvbUbrwhjHChkUb7tx
         zvUg==
X-Forwarded-Encrypted: i=1; AJvYcCVcS5QRweoFJBlv9ClLdYaR7xJ52FcXLdIJ6S+WndEGblr9GTif8UxW0Fk/SxKP9RfXP1TCsQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0Y0YYV589BO8LymBcaKclscbxNsdBCUY8qL9YjefZmwQbXipx
	8BJidWnyVHITTJNel1e5/5ACR+9JIipEwST5mgAzHs2aP6St/aMa75p8vHQ6EKxGAwbYttdfPw6
	ZTRW7XDhEyzEyBEatPEEuphBR+S87NNBoA1YOoLHf6OhseUXS26muW0M4+NLvIw==
X-Gm-Gg: ASbGncsRDJjELdfdYsZClg5XfTI1jAHGXoUuYbzX+N08MNdmGjThMZJk7jwGx/0+8Vt
	ohlx6pPCmz8YY0JgWacTPj0uHlFO5DSs/RUfIp5CB9imzOe+aASxKRkdSNxt3/liHal/xDc1B1O
	pWR4ONPWA74Qja/B92keGe9So2VvkEe541LXZ5zLk6D89Er8ViS600NiU5p9mnO/pKjAahXSyko
	LFefDYX1L3Y2iw5nV0voWqxuiV4uMm3meD/z4E9g7FEGocgsPzfTHc2MVMkLpQ1iNlyJc5KPrpU
	fOAQADNbPxTaa2lwgXSgQYJzA//N9Io=
X-Received: by 2002:a05:6a21:3388:b0:203:bb65:995a with SMTP id adf61e73a8af0-21fbd57d314mr34761712637.30.1750290948477;
        Wed, 18 Jun 2025 16:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKmwP2MLka+qPDacqOUeOXRxyX6ig7hRGf4JaCDFYf5G8uX0t1iXXsgkJajJOBV3JK71NDRQ==
X-Received: by 2002:a05:6a21:3388:b0:203:bb65:995a with SMTP id adf61e73a8af0-21fbd57d314mr34761688637.30.1750290948103;
        Wed, 18 Jun 2025 16:55:48 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900ad2absm11754487b3a.110.2025.06.18.16.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 16:55:47 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org,
	sourabhjain@linux.ibm.com
Cc: Tao Liu <ltao@redhat.com>
Subject: [PATCH] Fix a data race in multi-threading mode (--num-threads=N)
Date: Thu, 19 Jun 2025 11:55:23 +1200
Message-ID: <20250618235523.22557-1-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tAqj8AGmOgAMNYpegCPCN2_tQUQdVpap31cCCjKvjCI_1750290949
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_165553_142047_56E4E581 
X-CRM114-Status: GOOD (  18.01  )
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


