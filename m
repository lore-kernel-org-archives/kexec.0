Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F5EC61DD6
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxOEy23CdjWO+tWUfg0nkvoqJt9R/kFtS/CvH38ECoU=; b=RDmqYOq9LCfQH/MvE7vx7qxf0A
	8Yd00H8INdcmAg/aHSi+fFWoUYiOD4wdhbJtc4/THkk1itcqQ2wH/JniLQmvzGmFe8nkmbXmBi3TL
	MXBwjdcXH4LklPUpm5FzyHOgGcHNRHrPva8QlLD7TM+6y9cX4R4SbAYaUN7L0fTGYoIUfT+YRSimh
	PYFtK+c8n5A6cf0DqA0guysirODfDbduj2VQGuLbBt+tHCegZugdOt7/5m/zoEl5iD6Zay2qTrqfe
	FSgmpMVtgSCsSmeSD5sSC+bKepInLjWt2XOUEDsV8jA0IHA3MwlxG08ekxCbjzUg+m69ayFW7ZItU
	lppiWt1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oSP-0000000FORL-1R1C;
	Wed, 02 Sep 2026 17:09:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oSM-0000000FOPY-3MKl
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 17:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788368942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxOEy23CdjWO+tWUfg0nkvoqJt9R/kFtS/CvH38ECoU=;
	b=aMZt5kHfJOlHQ4ftNblKBb0gQ8HZyiZ+FsLsES6UneDdXRFq0If49uEr03G1xcQ5xbX5z6
	aTCseWwJw8dTfq6zjSd2EmmgN0rvm7tfGuqejT6JCfqx/J2boQ+wygArEuCEty868ZQ/SP
	0ck8/f1KNC8m9tPE0iOdY4dC2LzcikI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-BT5SXAruNeqn80UTKMXMYQ-1; Wed,
 02 Sep 2026 13:08:58 -0400
X-MC-Unique: BT5SXAruNeqn80UTKMXMYQ-1
X-Mimecast-MFC-AGG-ID: BT5SXAruNeqn80UTKMXMYQ_1788368936
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05CC31954223;
	Wed,  2 Sep 2026 17:08:56 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.rmtusga.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B49031955D8D;
	Wed,  2 Sep 2026 17:08:52 +0000 (UTC)
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
	"Ewan Milne" <emilne@redhat.com>,
	"John Meneghini" <jmeneghi@redhat.com>,
	"Lombardi, Maurizio" <mlombard@redhat.com>,
	"Bart Van Assche" <bvanassche@acm.org>,
	"John Garry" <john.g.garry@oracle.com>,
	"Jeremy Allison" <jallison@ciq.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"Pasha Tatashin" <tatashin@google.com>,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 2/9] driver core: prevent device_add() during system shutdown
Date: Wed,  2 Sep 2026 13:07:27 -0400
Message-ID: <20260902170734.95504-3-djeffery@redhat.com>
In-Reply-To: <20260902170734.95504-1-djeffery@redhat.com>
References: <20260902170734.95504-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 5FYcxUZ5kmRGLD0sfJhmAInbgQWlGN4IDVNqnrtKUtE_1788368936
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_100902_927525_05CA0794 
X-CRM114-Status: GOOD (  18.20  )
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
device_add incase of these states of the system. And use srcu so the
device shutdown operation can synchronize device_add and ensure any
device_add in progress is finished.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/base/core.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 83263e3fa5d4..bce555dd74f6 100644
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
@@ -3614,6 +3630,9 @@ static int device_private_init(struct device *dev)
 	return 0;
 }
 
+
+DEFINE_STATIC_SRCU(device_add_srcu);
+
 /**
  * device_add - add device to device hierarchy.
  * @dev: device.
@@ -3647,13 +3666,20 @@ int device_add(struct device *dev)
 	struct device *parent;
 	struct kobject *kobj;
 	struct class_interface *class_intf;
-	int error = -EINVAL;
+	int idx, error = -EINVAL;
 	struct kobject *glue_dir = NULL;
 
+	idx = srcu_read_lock(&device_add_srcu);
+
 	dev = get_device(dev);
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
@@ -3803,6 +3829,7 @@ int device_add(struct device *dev)
 	}
 done:
 	put_device(dev);
+	srcu_read_unlock(&device_add_srcu, idx);
 	return error;
  SysEntryError:
 	if (MAJOR(dev->devt))
@@ -4877,6 +4904,7 @@ void device_shutdown(void)
 
 	wait_for_device_probe();
 	device_block_probing();
+	synchronize_srcu(&device_add_srcu);
 
 	cpufreq_suspend();
 
-- 
2.55.0


