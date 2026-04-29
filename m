Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0B7FF887E
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EBdaR0NkwnB5xuO+5ZF2TJ2EyUG8XWEvOxuQoPiLdNw=; b=Px2o/rf+afx6tp06r9lyywQxbo
	YUgcnCnExRlS5jXkcqA08OiTNzdq1iR7mZOQCI4MiiVxYemoZdNhbd0qCFGDdc5eaL4TUN3N+sTCe
	HoQ7xIil2iFfOR+dNfddLMOVHICHQ9DUNikwCXRcE1RHuuFa4yP3AGY/xDfXHduIoNt50h62aO45H
	Varjmj9DI+TS64zixJP5yhKWzlFNEG/JkGcrLkuxOZLcaumrJ53me35UxnfGMp7NsAUANxOqxBC90
	4tCtJ/r3Z/F6+Hui35g+XY62mxm5saQgEfMuaQevcZHZqHoCWbyQQY6CZEp0x3MFUQRBwdC9VfUbw
	mZ7G6tdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI95t-0000000405n-1xNl;
	Wed, 29 Apr 2026 17:53:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI95q-0000000404n-2oXU
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 17:53:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777485181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBdaR0NkwnB5xuO+5ZF2TJ2EyUG8XWEvOxuQoPiLdNw=;
	b=LOfRp+3R5u3BtrPodaa5+ivIBv0zxTcaSK5oZZWWbj/rKGMaCRyfdXmTCMoErK2LGQGZh9
	Tx66SFvW86veZM25NGytQR5ff98lK5x2WJq09IDNcWrUeJwPjEQ5IhM96Lyun5aQibmdnd
	SMLgMC7jjsgQ/3w4j3wfCqa+TI41Kkk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-dm3F43fDMaia9pQhJ4kSRw-1; Wed,
 29 Apr 2026 13:51:20 -0400
X-MC-Unique: dm3F43fDMaia9pQhJ4kSRw-1
X-Mimecast-MFC-AGG-ID: dm3F43fDMaia9pQhJ4kSRw_1777485077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D33F19560BB;
	Wed, 29 Apr 2026 17:51:17 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.80.165])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AB0D300019F;
	Wed, 29 Apr 2026 17:51:11 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Tarun Sahu <tarunsahu@google.com>,
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
Subject: [PATCH 5/5] scsi: Enable async shutdown support
Date: Wed, 29 Apr 2026 13:50:16 -0400
Message-ID: <20260429175016.7915-6-djeffery@redhat.com>
In-Reply-To: <20260429175016.7915-1-djeffery@redhat.com>
References: <20260429175016.7915-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: iTEjJSs8bsCwitmFeH5X_zdqCmGhCj0KMIPo5HrTUV4_1777485077
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_105302_774110_2FD8BA51 
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

Like scsi's async suspend support, allow scsi devices to be shut down
asynchronously to reduce system shutdown time.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/hosts.c      | 2 ++
 drivers/scsi/scsi_sysfs.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index e047747d4ecf..471b5ce878b0 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -273,6 +273,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	pm_runtime_set_active(&shost->shost_gendev);
 	pm_runtime_enable(&shost->shost_gendev);
 	device_enable_async_suspend(&shost->shost_gendev);
+	device_enable_async_shutdown(&shost->shost_gendev);
 
 	error = device_add(&shost->shost_gendev);
 	if (error)
@@ -282,6 +283,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	get_device(shost->shost_gendev.parent);
 
 	device_enable_async_suspend(&shost->shost_dev);
+	device_enable_async_shutdown(&shost->shost_dev);
 
 	get_device(&shost->shost_gendev);
 	error = device_add(&shost->shost_dev);
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index dfc3559e7e04..5946ed77b3bd 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1386,6 +1386,7 @@ static int scsi_target_add(struct scsi_target *starget)
 	pm_runtime_set_active(&starget->dev);
 	pm_runtime_enable(&starget->dev);
 	device_enable_async_suspend(&starget->dev);
+	device_enable_async_shutdown(&starget->dev);
 
 	return 0;
 }
@@ -1412,6 +1413,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	transport_configure_device(&starget->dev);
 
 	device_enable_async_suspend(&sdev->sdev_gendev);
+	device_enable_async_shutdown(&sdev->sdev_gendev);
 	scsi_autopm_get_target(starget);
 	pm_runtime_set_active(&sdev->sdev_gendev);
 	if (!sdev->rpm_autosuspend)
@@ -1431,6 +1433,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	}
 
 	device_enable_async_suspend(&sdev->sdev_dev);
+	device_enable_async_shutdown(&sdev->sdev_dev);
 	error = device_add(&sdev->sdev_dev);
 	if (error) {
 		sdev_printk(KERN_INFO, sdev,
-- 
2.53.0


