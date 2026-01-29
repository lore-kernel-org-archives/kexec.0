Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FD0D73E8D
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cEITHmxK+p0fg2PKlGTWLUl48Yr7XTXbjGIRUwhwM+A=; b=TOBbN7TvOPmcvnX3ERICZg45pN
	16LY0vX7/FD/KB7sPKKWfc1DDL/T2MWXlmOjVGM5DT9BayrI+sR3P76aZm3lyb6+qIWHwdJC5XJlQ
	X1SM0IChveTtOXVjAso6BsRkgx3yLxnFzaOLjZq8GCQKLyA+TorqdwDBsJmetGvSVS2NxNqK+ustb
	+RE+XY6/r0R2aztXSPRTvnThuFsCeb/euUEhp1nApNqhEjiBmp2pNqQTOTyim+zKPb9k+03QoGelK
	67Tfci4Rh9ZzlwJrdkeAvZh5Whi12fBCRwXaWTuBBf3yLvS+dJkm70Wk9bh6hfKHQLN0xSlPk4pGL
	yy6gAjTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWd-00000000fR9-1put;
	Thu, 29 Jan 2026 21:26:03 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWX-00000000fIr-1JCo
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:25:59 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-34e5a9f0d6aso1508861a91.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721952; x=1770326752; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEITHmxK+p0fg2PKlGTWLUl48Yr7XTXbjGIRUwhwM+A=;
        b=01fPH2kKDt92X8AU7cHdUWaxXuLiEzs+yZhTwx0v94gTWswkLRhGmOFJ5Vmz9U2Xgi
         hHRz841fd/g+u6CoJhFBrqFvxxDZT2tRLTb7qLN0aa02z3SrKu94I5YsVb2HSvIeOaZL
         M61CU1+OMEoAWct9QBBQi29vrF6bojgyLSsUj3FWL7U43thGz6U/N/XRJrQI0yLf2/Z4
         uufnqQUUtUA/2hCBD1+qPvOABM6yHVr0uqnSVzw59cHLsqW62vtOonPDxmezL/h9y7nC
         RlAiGmjorqoT2s48lDnH2c59NqrrwYbKOvUIV+UPzDd3+SfHVSMTqVHoIQYby9YKE/XS
         yCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721952; x=1770326752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEITHmxK+p0fg2PKlGTWLUl48Yr7XTXbjGIRUwhwM+A=;
        b=xIU+1+fAcPKHvFFCV6TQKh//5hnV6sKB9/JNigwvokbQGLm/z8titiXJp7gNjAvHVK
         zuJ8AE5GGa6JAnr9KwMg7ww6dqObMSs2lRncfRT5pIYSmWfrCZqobN2wXBw0m6hcWO8l
         JraZCt41DoD8UugIVE0AWxk9QR6z/iBYYXAxqyvV5t7CpK2hGzcPj6NqptlifEh9Rq02
         aVUW9e7nko48MVNT6BuaFFVNkXbvt4vPJK7ixpJ+uIvig1HW4QYyh7IeZnVRFL1E5CPE
         eYup4xLiQg0B5GRfFpKHpL71XS3pRoZYACPTWSeK/En8Od9NPmJm2rMwan49oXdOYnLU
         DwBA==
X-Forwarded-Encrypted: i=1; AJvYcCXCYk77zUoQbeSYkcCxgpE/SVXgGTHTRy8zdDGplvi4qSHNl8gDtwNG0Hfik5BlAH+Ol6JgVA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxPlPc42LP6ASMmiSnEuD5fpIQUJNmuSc+vywtRBremtpZi1fed
	D6MMb8UYkf5LpOuseiG1oLiib7l89alOEeKkv+nf7uwes+jA0XsK8iT82CpxH+vPFw1Kp//GBUK
	XYhDEoIFXv7T0Pw==
X-Received: from pjk11.prod.google.com ([2002:a17:90b:558b:b0:34c:489a:f4c9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c10:b0:353:2972:74a4 with SMTP id 98e67ed59e1d1-35429af8f7amr3444629a91.13.1769721952367;
 Thu, 29 Jan 2026 13:25:52 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:56 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-10-dmatlack@google.com>
Subject: [PATCH v2 09/22] vfio/pci: Store incoming Live Update state in struct vfio_pci_core_device
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_132557_927376_22F9CF3B 
X-CRM114-Status: GOOD (  15.75  )
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

Stash a pointer to a device's incoming Live Updated state in struct
vfio_pci_core_device. This will enable subsequent commits to use the
preserved state when initializing the device.

To enable VFIO to safely access this pointer during device enablement,
require that the device is fully enabled before returning true from
can_finish(). This is synchronized by vfio_pci_core.c setting
vdev->liveupdate_incoming_state to NULL under dev_set lock once it's
done using it.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       |  2 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 17 ++++++++++++++++-
 include/linux/vfio_pci_core.h          |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3a11e6f450f7..b01b94d81e28 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -569,7 +569,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
-
+	vdev->liveupdate_incoming_state = NULL;
 	return 0;
 
 out_free_zdev:
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index ad915352303f..1ad7379c70c4 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -131,6 +131,7 @@ static int match_device(struct device *dev, const void *arg)
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
 	struct vfio_device *device;
 	struct file *file;
 	int ret;
@@ -160,6 +161,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 		goto out;
 	}
 
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	vdev->liveupdate_incoming_state = ser;
+
 	args->file = file;
 
 out:
@@ -171,7 +175,18 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 
 static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 {
-	return args->retrieved;
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
+
+	if (!args->retrieved)
+		return false;
+
+	device = vfio_device_from_file(args->file);
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+
+	/* Check that vdev->liveupdate_incoming_state is no longer in use. */
+	guard(mutex)(&device->dev_set->lock);
+	return !vdev->liveupdate_incoming_state;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 1ac86896875c..350c30f84a13 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -143,6 +143,7 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	struct vfio_pci_core_device_ser *liveupdate_incoming_state;
 };
 
 enum vfio_pci_io_width {
-- 
2.53.0.rc1.225.gd81095ad13-goog


