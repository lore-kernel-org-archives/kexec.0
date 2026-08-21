Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087B7C5DF95
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BvLQwuQsxkf9F2xZNCYKTp5KyAP5LYYETgZttqdI30g=; b=RtXlUSVf9mQYD/KPip15+1yL+c
	rpZv9IgFFGT7JIWrxcEbOAEgYIysL6l+ZZuqYiXQeoDUkmrKiB4R2NZ2Z44ksV0x9l09dlBq56BJT
	EraVWnDrQ+Jqmaen+ZFJlBHbCus9Gvrvl8zKh6SYJ2XbmSca3RJt9SL1Ggb3pyfs6dhHmKawRPMUP
	6+W+/KuTnXCN8SUe+x7wPcoPsCep1erLYRuytQG5eSrUbg3VmU924BoAlsSY4Izo4RCh4CBC6XwSS
	iU9iOXO+mwAMToT15c1d8VFHZbVLkggYv07RvzukDITjD060cP0eNoqGZS4tx39+H5BCHKJRFxfoA
	FJuNM1pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQCU-0000000DXzk-1azA;
	Fri, 21 Aug 2026 14:26:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQCP-0000000DXwp-40lM
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 14:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787322385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvLQwuQsxkf9F2xZNCYKTp5KyAP5LYYETgZttqdI30g=;
	b=c0SXYuAAxVID38jgirvNWNEWQvKIVvWlibIAjj2Mj/DWO5UEMbk6e6rqEaXrA6jPLJD4vD
	Yzjglu/OonqbQZ8fUNA16FDcFyaLeJYDxDCTJQALuSHMKE2J5Xg992YkzK+mrF+V4D1167
	4ysPwuHBjR/3QIJLve4SJfNi346Y0JA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-RH6zw2N2ODGYKZGfVV-FQg-1; Fri,
 21 Aug 2026 10:24:52 -0400
X-MC-Unique: RH6zw2N2ODGYKZGfVV-FQg-1
X-Mimecast-MFC-AGG-ID: RH6zw2N2ODGYKZGfVV-FQg_1787322290
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3688C1955BFE;
	Fri, 21 Aug 2026 14:24:50 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAF8718005BB;
	Fri, 21 Aug 2026 14:24:47 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Tarun Sahu <tarunsahu@google.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	kexec@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 2/9] driver core: prevent device_add() during system shutdown
Date: Fri, 21 Aug 2026 10:24:07 -0400
Message-ID: <20260821142414.150892-3-djeffery@redhat.com>
In-Reply-To: <20260821142414.150892-1-djeffery@redhat.com>
References: <20260821142414.150892-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: M88pE2Fw8jIAy0mUASmn53sMAkdz2IXtbiDyDDUQz3c_1787322290
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_072626_099023_FCA747E9 
X-CRM114-Status: GOOD (  15.97  )
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

From: Tarun Sahu <tarunsahu@google.com>

In Async device shutdown, device_kset->list lock is released to handle
asynchronisation and hold again to get entry from device_kset->list.
Which will leave window when device_add can try to add the device to
device_kset list and temper with ongoing shutdown process. New added
device can be async type or sync type and might also introduce new
dependency which can cause device_shutdown path to deadlock. S is
waiting C to finish but C is never scheduled as it was added recently
from device_add path. And C can only be scheduled when main loops
continue to reach to C which is waiting on S.

So, When a system enters shutdown (SYSTEM_HALT, SYSTEM_POWER_OFF, or
SYSTEM_RESTART), new devices should not be allowed to be added.
Adding system_state check (system_is_shutting_down()) to avoid
device_add incase of these states of the system.

While device_add() performs an initial check of system_is_shutting_down(),
a race window exists between this initial check and kobject_add(),
during which device_shutdown() may already be scanning devices_kset->list.
If device_shutdown() passes the device after kobject_add() registers it
onto devices_kset->list, device_add() would otherwise complete device
initialization and driver matching, leaving an active device running
after system shutdown finishes.

Fix this TOCTOU race by re-checking system_is_shutting_down() under
devices_kset->list_lock right after kobject_add().

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/base/core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 83263e3fa5d4..bd9c2921e326 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -47,6 +47,22 @@ static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
 static struct workqueue_struct *device_link_wq;
 
+/**
+ * system_is_shutting_down - Check if system state is not active.
+ *
+ * When system state is not active and in shutdown state, new devices
+ * should not be allowed to be added.
+ *
+ * If system_state is SYSTEM_HALT || SYSTEM_POWER_OFF || SYSTEM_RESTART
+ * this function will return true.
+ */
+static inline bool system_is_shutting_down(void)
+{
+	return system_state == SYSTEM_HALT ||
+	       system_state == SYSTEM_POWER_OFF ||
+	       system_state == SYSTEM_RESTART;
+}
+
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
  * @con: Consumer end of the link.
@@ -3654,6 +3670,11 @@ int device_add(struct device *dev)
 	if (!dev)
 		goto done;
 
+	if (unlikely(system_is_shutting_down())) {
+		error = -ESHUTDOWN;
+		goto done;
+	}
+
 	if (!dev->p) {
 		error = device_private_init(dev);
 		if (error)
@@ -3703,6 +3724,18 @@ int device_add(struct device *dev)
 		goto Error;
 	}
 
+	/*
+	 * Check system_state again under list_lock to prevent a TOCTOU race
+	 * where device_shutdown() runs concurrently and misses this device.
+	 */
+	spin_lock(&devices_kset->list_lock);
+	if (unlikely(system_is_shutting_down())) {
+		spin_unlock(&devices_kset->list_lock);
+		error = -ESHUTDOWN;
+		goto ShutdownError;
+	}
+	spin_unlock(&devices_kset->list_lock);
+
 	/* notify platform of device entry */
 	device_platform_notify(dev);
 
@@ -3822,6 +3855,7 @@ int device_add(struct device *dev)
  attrError:
 	device_platform_notify_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
+ ShutdownError:
 	glue_dir = get_glue_dir(dev);
 	kobject_del(&dev->kobj);
  Error:
-- 
2.55.0


