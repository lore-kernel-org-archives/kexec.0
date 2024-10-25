Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62402D10399
	for <kexec@archiver.kernel.org>; Fri, 25 Oct 2024 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o2WsInUwYp2wblsTkxMX+ZSecik0itgN2Rql0fl5FlY=; b=nDjzUUef+QVBoT
	OZsxB9emAgUZ/q8gCs7U3vjXy/6x+KtC0wNvbD1b/VNQMYEw/JAntTi3k8XgNmS19ajXbBlolLaXx
	rz1Uqzpu4imIdhbJ6wrang55pOySpfvaqage34zgit1dYqUjnXD2ZehWUTx0Pn5DT4hr0nG6seYGU
	aElGKxl0v/l1UxEGodbmAtuMkxFfxfcDP6XYcbiKPeXF1T+4FsF4FrDFsKC72BlwZRnNVy/fuOx50
	aS5BZeMAUUd3zt4LU7v0Ge5YvWj4/n9dMehuVqs4RwCriW2/GxnotwiVUNE/LmGm1BmYMpsLROD6A
	MHYiUukfUj0XgbVyv0Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MLQ-00000004GQG-3FJf;
	Fri, 25 Oct 2024 15:35:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Lys-00000004AeK-4021
	for kexec@lists.infradead.org;
	Fri, 25 Oct 2024 15:12:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrMChLaTWQQV1P3cCXF0g4Mb1STd5YPEt4ibYFFJxW4=;
	b=fgJhnSnEQSTql4I4+FerEDjUXmI19VK+NxbhKXl3Hq6GJ/HQv1ipTufu8pTDSZv2RyjO2B
	WctAAgGWqxj+/xDsNihW+2AwG5llF5XDzMQS+8l8jTskh8afRSaXlhu0eUowl7xRdruy6a
	o2epJmpChMRnBbUAjXp/xWUjtESmFg0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-oROdk647PWOwfbs1qWmB5g-1; Fri,
 25 Oct 2024 11:11:58 -0400
X-MC-Unique: oROdk647PWOwfbs1qWmB5g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D5A8193585B;
	Fri, 25 Oct 2024 15:11:53 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F17D3000198;
	Fri, 25 Oct 2024 15:11:44 +0000 (UTC)
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
Subject: [PATCH v1 01/11] fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
Date: Fri, 25 Oct 2024 17:11:23 +0200
Message-ID: <20241025151134.1275575-2-david@redhat.com>
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
References: <20241025151134.1275575-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_081203_197154_D4DB444A 
X-CRM114-Status: UNSURE (   9.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

We want to protect vmcore modifications from concurrent opening of
the vmcore, and also serialize vmcore modiciations. Let's convert the
spinlock into a mutex, because some of the operations we'll be
protecting might sleep (e.g., memory allocations) and might take a bit
longer.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b52d85f8ad59..110ce193d20f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -62,7 +62,8 @@ core_param(novmcoredd, vmcoredd_disabled, bool, 0);
 /* Device Dump Size */
 static size_t vmcoredd_orig_sz;
 
-static DEFINE_SPINLOCK(vmcore_cb_lock);
+static DEFINE_MUTEX(vmcore_mutex);
+
 DEFINE_STATIC_SRCU(vmcore_cb_srcu);
 /* List of registered vmcore callbacks. */
 static LIST_HEAD(vmcore_cb_list);
@@ -72,7 +73,7 @@ static bool vmcore_opened;
 void register_vmcore_cb(struct vmcore_cb *cb)
 {
 	INIT_LIST_HEAD(&cb->next);
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	list_add_tail(&cb->next, &vmcore_cb_list);
 	/*
 	 * Registering a vmcore callback after the vmcore was opened is
@@ -80,13 +81,13 @@ void register_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback registration\n");
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 }
 EXPORT_SYMBOL_GPL(register_vmcore_cb);
 
 void unregister_vmcore_cb(struct vmcore_cb *cb)
 {
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	list_del_rcu(&cb->next);
 	/*
 	 * Unregistering a vmcore callback after the vmcore was opened is
@@ -95,7 +96,7 @@ void unregister_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback unregistration\n");
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 
 	synchronize_srcu(&vmcore_cb_srcu);
 }
@@ -120,9 +121,9 @@ static bool pfn_is_ram(unsigned long pfn)
 
 static int open_vmcore(struct inode *inode, struct file *file)
 {
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	vmcore_opened = true;
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 
 	return 0;
 }
-- 
2.46.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
