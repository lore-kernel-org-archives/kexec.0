Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB265C5DF93
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3QMD3k9RzE+xvFDxxs5UwrRSerQjrcJtmAMSaBUs0Kg=; b=QTJTA+Pxphg+/DDBfdkJAuhVci
	twNcTRwOLkbOB2BrpG+AM/AgTo01utorMSkKfb7k6oX8E8OI/+ehCMrgNgkhZfv45UMkwF6QotY8C
	2KNpfdwD+ke4Q+gNgutw8+bhMIPXavrHZfhGvPFo5vWhobJFUlwUz5CdpB142Pv6vQWkKOmICid0z
	VE59/ZvpfIXl7G4WbrMt2UidzRFX1l3/SNEGuCSaF4VJJHO8zwIfX/IKIhW0vnzAEOKEbjc+L9qv+
	2rQCrdx5BaTiOAL2e3tbCdfIHltnwJcYlacUyaHGtsIjfhyBDX/SScpw3XucY0pM6blYc6v91Q/pW
	VaucJ1GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQCn-0000000DYAB-3Eri;
	Fri, 21 Aug 2026 14:26:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQCm-0000000DY9L-0e4T
	for kexec@bombadil.infradead.org;
	Fri, 21 Aug 2026 14:26:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3QMD3k9RzE+xvFDxxs5UwrRSerQjrcJtmAMSaBUs0Kg=; b=Xtw3SPTLXhsu4nxJzPcOYOUUIQ
	MbHdGxvGnJgUypOTcocxoFOZDMLZTMTTFXJ//7grT4mXOrGsh6MY54JMzQ+WyBrecJzAXvBnkitaT
	6a9FaSTMYapS4989BBrdm7E/BF10+GN0/xMjG7WuzB9eT/t+F/BfL6Ya6gc/QK0kxHdW13UdBVtdn
	6P+ancrdJa1xvmSh6+RoxYDD88W+LHsYoDiDD0GIH+sGV+GQ3cyB6TIbM94sgrLaSqHqKlcd6rW/M
	3INfuOXtDwvhLC9chzhHKo/pMjb7X0hKmHkHBY/PK1yBAZ7KrdkAgwjEt8+DmIu5rooTpjbxYkRsv
	dSIUEcxQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wxQCg-00000003pvm-2OuV
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 14:26:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787322400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QMD3k9RzE+xvFDxxs5UwrRSerQjrcJtmAMSaBUs0Kg=;
	b=g+Zue7PiP06dbpG2ULaMDa1+LRaKy1wcoS55FIWdPT+Mw2M5s9Vak+XhyPzeMgEKVl0Pob
	bBX+Kc1dAlrPEM9CSPPiskeTRCO6a2n7ECunbH2H6JoMeCoMBQ5fqefjihMqnpTOocZL9j
	Z61PU3KRUB8Q3yJG14ay3m9+8Z4sC7Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787322400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QMD3k9RzE+xvFDxxs5UwrRSerQjrcJtmAMSaBUs0Kg=;
	b=g+Zue7PiP06dbpG2ULaMDa1+LRaKy1wcoS55FIWdPT+Mw2M5s9Vak+XhyPzeMgEKVl0Pob
	bBX+Kc1dAlrPEM9CSPPiskeTRCO6a2n7ECunbH2H6JoMeCoMBQ5fqefjihMqnpTOocZL9j
	Z61PU3KRUB8Q3yJG14ay3m9+8Z4sC7Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-BZNRm3BfODCEh5x4I07Yqg-1; Fri,
 21 Aug 2026 10:25:13 -0400
X-MC-Unique: BZNRm3BfODCEh5x4I07Yqg-1
X-Mimecast-MFC-AGG-ID: BZNRm3BfODCEh5x4I07Yqg_1787322310
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59FBC1955BC7;
	Fri, 21 Aug 2026 14:25:10 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA565180034F;
	Fri, 21 Aug 2026 14:25:07 +0000 (UTC)
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
	David Jeffery <djeffery@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH 9/9] scsi: Enable async shutdown support
Date: Fri, 21 Aug 2026 10:24:14 -0400
Message-ID: <20260821142414.150892-10-djeffery@redhat.com>
In-Reply-To: <20260821142414.150892-1-djeffery@redhat.com>
References: <20260821142414.150892-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: -tXWykAur2XhYZ4vyZojK8fPmcqB9442ZJvJziX-P2I_1787322310
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_152642_848376_F707010C 
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
index e047747d4ecf..bf691acc7a67 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -273,6 +273,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	pm_runtime_set_active(&shost->shost_gendev);
 	pm_runtime_enable(&shost->shost_gendev);
 	device_enable_async_suspend(&shost->shost_gendev);
+	dev_set_async_shutdown(&shost->shost_gendev);
 
 	error = device_add(&shost->shost_gendev);
 	if (error)
@@ -282,6 +283,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	get_device(shost->shost_gendev.parent);
 
 	device_enable_async_suspend(&shost->shost_dev);
+	dev_set_async_shutdown(&shost->shost_dev);
 
 	get_device(&shost->shost_gendev);
 	error = device_add(&shost->shost_dev);
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index dfc3559e7e04..8fd317aef37b 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1386,6 +1386,7 @@ static int scsi_target_add(struct scsi_target *starget)
 	pm_runtime_set_active(&starget->dev);
 	pm_runtime_enable(&starget->dev);
 	device_enable_async_suspend(&starget->dev);
+	dev_set_async_shutdown(&starget->dev);
 
 	return 0;
 }
@@ -1412,6 +1413,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	transport_configure_device(&starget->dev);
 
 	device_enable_async_suspend(&sdev->sdev_gendev);
+	dev_set_async_shutdown(&sdev->sdev_gendev);
 	scsi_autopm_get_target(starget);
 	pm_runtime_set_active(&sdev->sdev_gendev);
 	if (!sdev->rpm_autosuspend)
@@ -1431,6 +1433,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	}
 
 	device_enable_async_suspend(&sdev->sdev_dev);
+	dev_set_async_shutdown(&sdev->sdev_dev);
 	error = device_add(&sdev->sdev_dev);
 	if (error) {
 		sdev_printk(KERN_INFO, sdev,
-- 
2.55.0


