Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83D7C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0FSpVVDso32KQePcWS3Cq/14rZsUfEwQH2nRl5z2o2g=; b=SPDz8W4oa6KwBpCdT5vwsCQ71D
	y1APNWzDNefy9Wue8W6ryF1VhwGUMPfqmrye8wnXb90R7fUDVIxGYGiTrgipuI4tfLqlGi9kDwZMV
	Rw1xLRx41KfWboBKxWffbN6UXvRuiTGSdBMDl+lVvuQ4DpEHjSLLmQCh5qUPjz9aqopuKX15cf5J9
	qqcLsPUOloQSxIhVlwSkQj2rbMC+ovFcRndQd7grkfhYWuTjMXhMvT9Bg1Szvd+gQOwyVZV1w2BI7
	hs+h9KyEktzhxY5QH+lh0Jdy02R/6aJriByUTc4EjR96nv8jjUp106mlhy9VFincLiCKa16nsJXlU
	IVcABWVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wevMF-00000002DXU-3NiQ;
	Wed, 01 Jul 2026 13:52:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wevMC-00000002DWC-2QOY
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 13:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782913923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FSpVVDso32KQePcWS3Cq/14rZsUfEwQH2nRl5z2o2g=;
	b=Gkes3zabu8bCSYYzIhbBi/DNh+c3ZKvtrVnTO4KMoZUVehRWagb0kRtnx9tM3sqfGh/h4U
	ieo63QsZNfe6sWD6uxeuJUe6e7xkajZ3feMAYvO0IhLUmVhplfJkRMGrDUY3mlwwtUZuRE
	3JgDlcPqwzxaguCb7a2T3bQYiKOkCaw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-Mhlr-Z8tMI-QGJDZ5f7hNw-1; Wed,
 01 Jul 2026 09:50:37 -0400
X-MC-Unique: Mhlr-Z8tMI-QGJDZ5f7hNw-1
X-Mimecast-MFC-AGG-ID: Mhlr-Z8tMI-QGJDZ5f7hNw_1782913835
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09CDB1933FBA;
	Wed,  1 Jul 2026 13:50:35 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.rmtusga.csb (unknown [10.22.81.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01679180076D;
	Wed,  1 Jul 2026 13:50:29 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Tarun Sahu <tarunsahu@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	=?UTF-8?q?Micha=C5=82=20C=C5=82api=C5=84ski?= <mclapinski@google.com>,
	Jordan Richards <jordanrichards@google.com>,
	Ewan Milne <emilne@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"Lombardi, Maurizio" <mlombard@redhat.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	kexec@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 1/5] driver core: separate function to shutdown one device
Date: Wed,  1 Jul 2026 09:50:11 -0400
Message-ID: <20260701135015.81937-2-djeffery@redhat.com>
In-Reply-To: <20260701135015.81937-1-djeffery@redhat.com>
References: <20260701135015.81937-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: gQWsIJF4E8QFJbYMfXTMP5Kgx6ZKM0uJomN0O618nvI_1782913835
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_065204_699431_0E633FB4 
X-CRM114-Status: GOOD (  17.85  )
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

Make a separate function for the part of device_shutdown() that does the
shutown for a single device.  This is in preparation for making device
shutdown asynchronous.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/base/core.c | 71 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d026682944f..74c693cd19cf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4865,12 +4865,48 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 	return error;
 }
 
+static void shutdown_one_device(struct device *dev)
+{
+	struct device *parent = dev->parent;
+
+	/* hold lock to avoid race with probe/release */
+	if (parent)
+		device_lock(parent);
+	device_lock(dev);
+
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	device_unlock(dev);
+	if (parent)
+		device_unlock(parent);
+
+	put_device(parent);
+	put_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct device *dev;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4892,7 +4928,7 @@ void device_shutdown(void)
 		 * prevent it from being freed because parent's
 		 * lock is to be held
 		 */
-		parent = get_device(dev->parent);
+		get_device(dev->parent);
 		get_device(dev);
 		/*
 		 * Make sure the device is off the kset list, in the
@@ -4901,36 +4937,7 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
+		shutdown_one_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
-- 
2.54.0


