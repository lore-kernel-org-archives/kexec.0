Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781F8C7EE2A
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NoS4uS0WjT8s4quR+livwyFWK5OcaT64RQX23AsJyig=; b=N+qgAEIYNGuBy/C+v4PSmVTbqg
	yfQoaZt4jfuGjeeDdq007K7/z8bRncHi1w+AG4uKEcGtaFl9MQgwSFljYZ7RsWiQLUd8wNwJY6WMe
	GfNHMrl4O2zyVW6/Cbh6ENoLyNrDWf9lDDgMcBvTtEQxiqbyQ4cW1PtRlkA5+OElg5DosN6WpG5Y2
	aHYGQ+wcdSemGN30RDCio/FJgsEqGuPYAIKfJlMP7w0b4eYpCYl03DTa2aIO8RFsOSkm5OLXV/jUi
	J1a3uV3MrkbWA4aXdri9pvDUzYRzX29DXN04qPfTtarcb83tGwb+CNeRWmjeKX3RxwnMZdhDwn9ex
	zhzdItbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTgQa-00000002idO-1e4H;
	Mon, 23 Jun 2025 12:37:36 +0000
Received: from [42.101.60.213] (helo=mail.nfschina.com)
	by bombadil.infradead.org with smtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTeiA-00000002Pxx-2pi4
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 10:47:40 +0000
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 75C08602FE8D8;
	Mon, 23 Jun 2025 18:47:29 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Date: Mon, 23 Jun 2025 18:47:05 +0800
Message-Id: <20250623104704.3489471-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_034738_881157_4E5727EC 
X-CRM114-Status: GOOD (  10.31  )
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

There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
type from 'size_t' to 'unsigned int' for the consistency of data->size.
Return -ENOMEM directly rather than goto the label to simplify the code.
Using scoped_guard() to simplify the lock/unlock code.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/proc/vmcore.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 10d01eb09c43..9ac2863c68d8 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1477,7 +1477,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 {
 	struct vmcoredd_node *dump;
 	void *buf = NULL;
-	size_t data_size;
+	unsigned int data_size;
 	int ret;
 
 	if (vmcoredd_disabled) {
@@ -1490,10 +1490,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 		return -EINVAL;
 
 	dump = vzalloc(sizeof(*dump));
-	if (!dump) {
-		ret = -ENOMEM;
-		goto out_err;
-	}
+	if (!dump)
+		return -ENOMEM;
 
 	/* Keep size of the buffer page aligned so that it can be mmaped */
 	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
@@ -1519,21 +1517,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->size = data_size;
 
 	/* Add the dump to driver sysfs list and update the elfcore hdr */
-	mutex_lock(&vmcore_mutex);
-	if (vmcore_opened)
-		pr_warn_once("Unexpected adding of device dump\n");
-	if (vmcore_open) {
-		ret = -EBUSY;
-		goto unlock;
-	}
-
-	list_add_tail(&dump->list, &vmcoredd_list);
-	vmcoredd_update_size(data_size);
-	mutex_unlock(&vmcore_mutex);
-	return 0;
+	scoped_guard(mutex, &vmcore_mutex) {
+		if (vmcore_opened)
+			pr_warn_once("Unexpected adding of device dump\n");
+		if (vmcore_open) {
+			ret = -EBUSY;
+			goto out_err;
+		}
 
-unlock:
-	mutex_unlock(&vmcore_mutex);
+		list_add_tail(&dump->list, &vmcoredd_list);
+		vmcoredd_update_size(data_size);
+		return 0;
+	}
 
 out_err:
 	vfree(buf);
-- 
2.30.2


