Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4C1C7EE32
	for <kexec@archiver.kernel.org>; Thu, 26 Jun 2025 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GIHnuWzAuB7iidqOmn/auSSxfkFEe2rs4WYhjCCuEB8=; b=FoaZdusZAaG2POU3jbeMiAYKL0
	AJUVOW9vpcTd05iHaatVG2Cqwwi6utEL2BvFRy6GcjH81pEOevUdM1H9H7oFTKlFB9/yCyfqGYYPL
	uy5gXMakwb2ezmTI7TQffInajHyNziRGi0XZ51Hta1stxSDNOKfHMtbyDrK8cmfR8noajwyDA+U+0
	/UhK2233KqUSCvntSOItvq3j2/DRSZRF+NxQtGArWXFGnt8RuDIAuegbc3SQ+4R6AxGkUpZr8gfGp
	g2e1xi+1Z63kTA/t278JWFT7E3OWlZ5pXdkHkbrJEHJMlCIWXxzEOBqYciZ92AfT5e+TuQ22GsG47
	8IXygm6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUlHV-0000000BUGT-2axR;
	Thu, 26 Jun 2025 12:00:41 +0000
Received: from [42.101.60.213] (helo=mail.nfschina.com)
	by bombadil.infradead.org with smtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUkFs-0000000BL7I-2Q5B
	for kexec@lists.infradead.org;
	Thu, 26 Jun 2025 10:54:58 +0000
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 2E0E1604F1A67;
	Thu, 26 Jun 2025 18:54:47 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	dan.carpenter@linaro.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Date: Thu, 26 Jun 2025 18:54:41 +0800
Message-Id: <20250626105440.1053139-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_035456_783757_02D5B553 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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

There are two cleanups for vmcore_add_device_dump(). Return -ENOMEM
directly rather than goto the label to simplify the code. Using
scoped_guard() to simplify the lock/unlock code.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - Remove the wrong change of 'data_size'.
 - Move 'Return 0;' out of the scoped_guard.

v1:
 - https://lore.kernel.org/all/20250623104704.3489471-1-suhui@nfschina.com/

 fs/proc/vmcore.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 10d01eb09c43..f188bd900eb2 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
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
@@ -1519,22 +1517,19 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->size = data_size;
 
 	/* Add the dump to driver sysfs list and update the elfcore hdr */
-	mutex_lock(&vmcore_mutex);
-	if (vmcore_opened)
-		pr_warn_once("Unexpected adding of device dump\n");
-	if (vmcore_open) {
-		ret = -EBUSY;
-		goto unlock;
-	}
+	scoped_guard(mutex, &vmcore_mutex) {
+		if (vmcore_opened)
+			pr_warn_once("Unexpected adding of device dump\n");
+		if (vmcore_open) {
+			ret = -EBUSY;
+			goto out_err;
+		}
 
-	list_add_tail(&dump->list, &vmcoredd_list);
-	vmcoredd_update_size(data_size);
-	mutex_unlock(&vmcore_mutex);
+		list_add_tail(&dump->list, &vmcoredd_list);
+		vmcoredd_update_size(data_size);
+	}
 	return 0;
 
-unlock:
-	mutex_unlock(&vmcore_mutex);
-
 out_err:
 	vfree(buf);
 	vfree(dump);
-- 
2.30.2


