Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5943BC624D4
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S4w5b49VFjE4E0AFoA0Qcj7jylDcxSilk3hvFC5nqKA=; b=OvzVSUGNlBDCQwnmi3pcROz0/2
	rlvKJV9g2km8Jhm3NXU9/K4Z1sBX/3O78gVA1gqs6URjtTTi7sJxhjLusM9ruDwiuroG7gHhn6VrE
	KoN4XGwjuQ7yUIKtHuXwe2t/k3hHzoYN9iD2v3dLaXGIQbzm1mXDFbkNPAbK6DiTKgSaZ5Qws99X7
	144xfGuuQTHAjcRz8v58+4IYt1bKePHXELVU2cKJ716EpJDyl7NhPrwBPYPTUSSMUxIoOXZcy3/o4
	W4FJLrgYV8+vv38Ei0hrBm+FQJ1GOL/4/xs4x3yLeGujZ75hlsEB34ZjpuuERgeT5ZK2wyUEzZ4lL
	8XREKitA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oSO-0000000FOQn-17Qn;
	Wed, 02 Sep 2026 17:09:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oSL-0000000FOOB-21DR
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 17:09:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788368939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4w5b49VFjE4E0AFoA0Qcj7jylDcxSilk3hvFC5nqKA=;
	b=VwTzf2Giwb2TblI7vSsALve7aiWvk7ezDunjVe31MHUDFwyKa/rbGzSEO4eT3Epd6tLbKP
	uiI3hku+PKxBs3dU5kAc+8QQyQT1VGKFoswVe0KO3FVklTR+saOyS5GjcD2XL5hq/8P/bZ
	G8l6N3viaHMwKETHXWncDtuJWpcktOc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37--k90ol-JP_ebVAxtldOu9g-1; Wed,
 02 Sep 2026 13:08:55 -0400
X-MC-Unique: -k90ol-JP_ebVAxtldOu9g-1
X-Mimecast-MFC-AGG-ID: -k90ol-JP_ebVAxtldOu9g_1788368933
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B1821944D43;
	Wed,  2 Sep 2026 17:08:52 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.rmtusga.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A2201955D69;
	Wed,  2 Sep 2026 17:08:47 +0000 (UTC)
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
Subject: [PATCH 1/9] driver core: rely on put_device to free dev->p
Date: Wed,  2 Sep 2026 13:07:26 -0400
Message-ID: <20260902170734.95504-2-djeffery@redhat.com>
In-Reply-To: <20260902170734.95504-1-djeffery@redhat.com>
References: <20260902170734.95504-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 0e8mBcfiy5Hwu-X_mlCqhBhmAjO8E5epai_-BJF9THc_1788368933
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_100901_600985_1D2BCD56 
X-CRM114-Status: GOOD (  14.60  )
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

device_add allocate private_data for device and assigns to
dev->p. If device_add fails in later steps of the function,
it cleans up this dev->p which is not necessary because In
the next call, put_device free it anyway (if reference to
the device is 0 which will be unless someone concurrently
get the reference to this device).

This avoids unnecessary races introduced in system. After device
is added in device_kset->list by device_add and later steps in the
device_add function failures occur, it will free dev->p manually,
while in between there might be a user of device_kset->list will
take reference to the device just added by device_add. and might
try to access dev->p. So relying on put_device to free dev->p
prevents such problem.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/base/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a1..83263e3fa5d4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2618,6 +2618,7 @@ static void device_release(struct kobject *kobj)
 	struct device *dev = kobj_to_dev(kobj);
 	struct device_private *p = dev->p;
 
+	dev->p = NULL;
 	/*
 	 * Some platform devices are driven without driver attached
 	 * and managed resources may have been acquired.  Make sure
@@ -3828,8 +3829,6 @@ int device_add(struct device *dev)
 parent_error:
 	put_device(parent);
 name_error:
-	kfree(dev->p);
-	dev->p = NULL;
 	goto done;
 }
 EXPORT_SYMBOL_GPL(device_add);
-- 
2.55.0


