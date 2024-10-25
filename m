Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E97D1039A
	for <kexec@archiver.kernel.org>; Fri, 25 Oct 2024 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pP1ohmB2Tvz61upjWBIfUoe71ngz7SJlD+U9XeR1mGg=; b=LRmpshaRwF0BQF
	2espUs7oNfBJtQxW2iSgwrBsVDMxZYHAtoFWWL/b6+SWH/CcyiZFYHo1XKcH0HIW6fgFVTO5Pn3ZV
	VqodK7Tg13DIskJiQ8+3j0g57ONnDjyglhf4ZYNS59si/bCk+cguK7ZXgR0lRk/I7hY2vc6gXrAyU
	cZ8PE5l/7y7SGgFlUParIshnhP3ums1fqXu7JWgDhC/GYAM5mPyaZyJQX7emOrgmTridGCu6OHy6C
	CmN5DPGKus+pnpndaenmmsfPNjwv2n8JnG+9g83ykXnGTUMAf/kkzHuLj8/ISiP2gPJZLlDAs5YQS
	6utbZS6wPXCpF2s0LkcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MLU-00000004GST-01NW;
	Fri, 25 Oct 2024 15:35:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LzY-00000004AwG-1LCV
	for kexec@lists.infradead.org;
	Fri, 25 Oct 2024 15:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIFNVFgavkgVE76rylQBcYDoA1k/9BPXcVZSMfOlsww=;
	b=EGacU649e30qFoOH91WVI/3VKCftYanFhWzIfUpM1Sew0jANo/VDAIuut52AZlMsWl6A5j
	GizvCviIOxmIbCipkTy+/WC1zhJ583nTL2QSas4imzj+oYs4ZDLcF7sjxc3sZ3+OBL1Yet
	S+IvkmRtCukNE7dHGg97nNfOI9+kATY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-KbkSjjO5MweDNtywRObLgg-1; Fri,
 25 Oct 2024 11:12:38 -0400
X-MC-Unique: KbkSjjO5MweDNtywRObLgg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1FBE1955F25;
	Fri, 25 Oct 2024 15:12:36 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F05A300018D;
	Fri, 25 Oct 2024 15:12:27 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 06/11] fs/proc/vmcore: factor out freeing a list of vmcore ranges
Date: Fri, 25 Oct 2024 17:11:28 +0200
Message-ID: <20241025151134.1275575-7-david@redhat.com>
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
References: <20241025151134.1275575-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_081244_586802_673D698A 
X-CRM114-Status: GOOD (  11.55  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           |  9 +--------
 include/linux/crash_dump.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 76fdc3fb8c0e..3e90416ee54e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1568,14 +1568,7 @@ void vmcore_cleanup(void)
 		proc_vmcore = NULL;
 	}
 
-	/* clear the vmcore list. */
-	while (!list_empty(&vmcore_list)) {
-		struct vmcore_mem_node *m;
-
-		m = list_first_entry(&vmcore_list, struct vmcore_mem_node, list);
-		list_del(&m->list);
-		kfree(m);
-	}
+	vmcore_free_mem_nodes(&vmcore_list);
 	free_elfcorebuf();
 
 	/* clear vmcore device dump list */
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index ae77049fc023..722dbcff7371 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -135,6 +135,17 @@ static inline int vmcore_alloc_add_mem_node(struct list_head *list,
 	return 0;
 }
 
+/* Free a list of vmcore memory nodes. */
+static inline void vmcore_free_mem_nodes(struct list_head *list)
+{
+	struct vmcore_mem_node *m, *tmp;
+
+	list_for_each_entry_safe(m, tmp, list, list) {
+		list_del(&m->list);
+		kfree(m);
+	}
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.46.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
