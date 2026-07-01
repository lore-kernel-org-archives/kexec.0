Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FB7C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aa6nGP51nt0tYNhBf9QdV8nxeoHFyuLGN8A4syXVg7Q=; b=PNzK4MDTicxbRT8rH5Emxo/MEA
	vgh4gMscWePO0ZusONRvaR/pXGtiui5DaYay/X92Mfa/ZeLzkzh5hevQXC9g7twk9w6aMCQuivVCg
	PBjhzb8vG8EFJdQsC225h1kCjtzjG4xVMZmYXC+OxNVVV+4gUyKD7heWvjWQ+KsohxYIKz1Et2iuP
	TWoz/FU+F2QG/YOWWmD39vhTs+/R1rSOMjGiuamPwwEXc/2x61KyOMj6y08Xfs168cwWwR1tjle/m
	QhomL8ADGdkr++V6oIyKqOXqT2Z9J4kQ08bCb8Dww7u1nISZatfeTIe145aOBztZl4AsDvhGBVkE1
	TQvufoBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wevL7-00000002DQ0-2nOm;
	Wed, 01 Jul 2026 13:50:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wevL5-00000002DPI-0im2
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 13:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782913852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aa6nGP51nt0tYNhBf9QdV8nxeoHFyuLGN8A4syXVg7Q=;
	b=f/xM6rO+Kwak+OdNLEae9CBitDqzeq6UcNcj/AC3kA93qF9tJwux0xscgXo/aUO2d/N+mF
	MXIz6m2JGb3lOjjMvajeWnhdmtjT8TXPYkUmVKAc5xhquvYN+bSXL1Gs1tyQpjYOpmx0+G
	vmmuM61u74p00S9LjF1uE0NmZRVRB2U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-K6KEZhcaNZS5lZ1wIxwDoQ-1; Wed,
 01 Jul 2026 09:50:48 -0400
X-MC-Unique: K6KEZhcaNZS5lZ1wIxwDoQ-1
X-Mimecast-MFC-AGG-ID: K6KEZhcaNZS5lZ1wIxwDoQ_1782913845
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 520D31944E45;
	Wed,  1 Jul 2026 13:50:45 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.rmtusga.csb (unknown [10.22.81.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59ED2180076D;
	Wed,  1 Jul 2026 13:50:40 +0000 (UTC)
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
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 3/5] driver core: async device shutdown infrastructure
Date: Wed,  1 Jul 2026 09:50:13 -0400
Message-ID: <20260701135015.81937-4-djeffery@redhat.com>
In-Reply-To: <20260701135015.81937-1-djeffery@redhat.com>
References: <20260701135015.81937-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 3zs4z5TDfeqw5Iqc6pXotA29r1zd2waP36GEUYsdL0c_1782913845
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_065055_310715_322FBA03 
X-CRM114-Status: GOOD (  29.16  )
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

Patterned after async suspend, allow devices to mark themselves as wanting
to perform async shutdown. Devices using async shutdown wait only for their
dependencies to shutdown before executing their shutdown routine.

Sync shutdown devices are shut down one at a time and will only wait for an
async shutdown device if the async device is a dependency.

Enabled by default, async shutdown can be explicitly enabled or disabled
by using the kernel parameter "core.async_shutdown=<bool>"

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  10 ++
 drivers/base/base.h                           |   2 +
 drivers/base/core.c                           | 134 +++++++++++++++++-
 include/linux/device.h                        |   2 +
 4 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5a51a36a048..7a428479089e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1019,6 +1019,16 @@ Kernel parameters
 			seconds. A value of 0 disables the blank timer.
 			Defaults to 0.
 
+	core.async_shutdown=
+			[KNL]
+			Format: <bool>
+			Enable or disable asynchronous shutdown support. When
+			enabled, on system shutdown unrelated devices flagged
+			as async shutdown compatible may be shut down in
+			parallel and asynchronously. When disabled, device
+			shutdown is performed serially and synchronously.
+			Enabled by default.
+
 	coredump_filter=
 			[KNL] Change the default value for
 			/proc/<pid>/coredump_filter.
diff --git a/drivers/base/base.h b/drivers/base/base.h
index a5b7abc10ff0..40dbf588a5d6 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -103,6 +103,7 @@ struct driver_private {
  *			   dev_err_probe() for later retrieval via debugfs
  * @device: pointer back to the struct device that this structure is
  *	    associated with.
+ * @complete: completion for device shutdown ordering
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
@@ -119,6 +120,7 @@ struct device_private {
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
 	struct device *device;
+	struct completion complete;
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3b3d983b1747..c3c7d9c5cc4b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/cleanup.h>
 #include <linux/cpufreq.h>
@@ -37,6 +38,10 @@
 #include "physical_location.h"
 #include "power/power.h"
 
+static bool async_shutdown = true;
+module_param(async_shutdown, bool, 0644);
+MODULE_PARM_DESC(async_shutdown, "Enable asynchronous device shutdown support");
+
 /* Device links support. */
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
@@ -3606,6 +3611,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	init_completion(&dev->p->complete);
 	return 0;
 }
 
@@ -3895,6 +3901,7 @@ bool kill_device(struct device *dev)
 	if (dev->p->dead)
 		return false;
 	dev->p->dead = true;
+	complete_all(&dev->p->complete);
 	return true;
 }
 EXPORT_SYMBOL_GPL(kill_device);
@@ -4865,6 +4872,37 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 	return error;
 }
 
+static bool wants_async_shutdown(struct device *dev)
+{
+	return async_shutdown && dev_async_shutdown(dev);
+}
+
+static int wait_for_device_shutdown(struct device *dev, void *data)
+{
+	bool async = *(bool *)data;
+
+	if (async || wants_async_shutdown(dev))
+		wait_for_completion(&dev->p->complete);
+
+	return 0;
+}
+
+static void wait_for_shutdown_dependencies(struct device *dev, bool async)
+{
+	struct device_link *link;
+	int idx;
+
+	device_for_each_child(dev, &async, wait_for_device_shutdown);
+
+	idx = device_links_read_lock();
+
+	dev_for_each_link_to_consumer(link, dev)
+		if (!device_link_flag_is_sync_state_only(link->flags))
+			wait_for_device_shutdown(link->consumer, &async);
+
+	device_links_read_unlock(idx);
+}
+
 static void __shutdown_one_device(struct device *dev)
 {
 	if (dev->p->dead)
@@ -4888,6 +4926,8 @@ static void __shutdown_one_device(struct device *dev)
 			dev_info(dev, "shutdown\n");
 		dev->driver->shutdown(dev);
 	}
+
+	complete_all(&dev->p->complete);
 }
 
 static void shutdown_one_device(struct device *dev)
@@ -4917,6 +4957,87 @@ static void shutdown_one_device(struct device *dev)
 	put_device(dev);
 }
 
+static void async_shutdown_handler(void *data, async_cookie_t cookie)
+{
+	struct device *dev = data;
+
+	wait_for_shutdown_dependencies(dev, true);
+	shutdown_one_device(dev);
+}
+
+static bool shutdown_device_async(struct device *dev)
+{
+	if (async_schedule_dev_nocall(async_shutdown_handler, dev))
+		return true;
+
+	dev_clear_async_shutdown(dev);
+	return false;
+}
+
+
+static void start_async_shutdown_devices(void)
+{
+	struct device *dev, *next, *ndev, *needs_put = NULL;
+	bool clear_async = false;
+
+	if (!async_shutdown)
+		return;
+
+	spin_lock(&devices_kset->list_lock);
+restart:
+	list_for_each_entry_safe_reverse(dev, next, &devices_kset->list,
+					 kobj.entry) {
+		if (wants_async_shutdown(dev)) {
+			if (clear_async) {
+				dev_clear_async_shutdown(dev);
+				continue;
+			}
+			/* one device reference for this function */
+			get_device(dev);
+			/* another to pass to the async task */
+			get_device(dev);
+
+			if (!list_entry_is_head(next, &devices_kset->list,
+						kobj.entry))
+				ndev = get_device(next);
+			else
+				ndev = NULL;
+			spin_unlock(&devices_kset->list_lock);
+
+			if (shutdown_device_async(dev)) {
+				spin_lock(&devices_kset->list_lock);
+				list_del_init(&dev->kobj.entry);
+				spin_unlock(&devices_kset->list_lock);
+			} else {
+				/*
+				 * async failed, clean up extra reference
+				 * and run shutdown from the sync shutdown loop
+				 */
+				clear_async = true;
+				put_device(dev);
+			}
+			put_device(dev);
+
+			if (needs_put)
+				put_device(needs_put);
+			needs_put = ndev;
+			spin_lock(&devices_kset->list_lock);
+			/*
+			 * If the next device has been marked dead while the
+			 * spinlock was released, it may no longer be on the
+			 * devices_kset list. Restart the list walk to be safe
+			 */
+			if (ndev && ndev->p->dead)
+				goto restart;
+		}
+	}
+
+	spin_unlock(&devices_kset->list_lock);
+
+	if (needs_put)
+		put_device(needs_put);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
@@ -4929,6 +5050,12 @@ void device_shutdown(void)
 
 	cpufreq_suspend();
 
+	/*
+	 * Start async device threads where possible to maximize potential
+	 * parallelism and minimize false dependency on unrelated sync devices
+	 */
+	start_async_shutdown_devices();
+
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
@@ -4947,11 +5074,16 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		shutdown_one_device(dev);
+		if (!wants_async_shutdown(dev) || !shutdown_device_async(dev)) {
+			wait_for_shutdown_dependencies(dev, false);
+			shutdown_one_device(dev);
+		}
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+
+	async_synchronize_full();
 }
 
 /*
diff --git a/include/linux/device.h b/include/linux/device.h
index 7b2baffdd2f5..f913d72218f8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -610,6 +610,7 @@ enum struct_device_flags {
 	DEV_FLAG_OF_NODE_REUSED = 7,
 	DEV_FLAG_OFFLINE_DISABLED = 8,
 	DEV_FLAG_OFFLINE = 9,
+	DEV_FLAG_ASYNC_SHUTDOWN = 10,
 
 	DEV_FLAG_COUNT
 };
@@ -827,6 +828,7 @@ __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
 __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
 __create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
 __create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
+__create_dev_flag_accessors(async_shutdown, DEV_FLAG_ASYNC_SHUTDOWN);
 
 #undef __create_dev_flag_accessors
 
-- 
2.54.0


