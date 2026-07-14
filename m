Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EF1C4450B
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JgKrbgFKZxbxCBaliRqkNgo/i0ql++Rr7PTW+pok5fM=; b=dzWIv943MJ1gXYDr1+Rxee9vj8
	Zr9Er7QsyzLfudJA50z3SFENnftDiVvtDlf8+O6W3RJBU9BqGrRv7oYLXeWa3XeQGjsMiADRg80e9
	eID0XgnQ2pLBh8Ff7a4Nw4Bbtzwu/M8JkzI4lxs7kvK5tOFXSS12AWLbtFHSZGzew4HGVW8IY7+qK
	Qxd5mSVc2pnZBdjMJOefr3kWZ7h4QmuFvraSU8khvQOdPbX806IvI2fmYP+hSkMMeNKiy53mxey9F
	9lLbrQqpN68GxTiGwfcLxZ7BMWo3gf/i2lOtwWOWf4cfdNv2QypIUTFYD6S99HGkOCe4+SKa09SE7
	/W9g7APg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer7-0000000CUTf-1dK8;
	Tue, 14 Jul 2026 15:15:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer5-0000000CUOg-1KVX
	for kexec@bombadil.infradead.org;
	Tue, 14 Jul 2026 15:15:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JgKrbgFKZxbxCBaliRqkNgo/i0ql++Rr7PTW+pok5fM=; b=h+QllBIzjBYgBGF5HvMjRL4ey8
	oKUh/TEPn3sqY52/X+5r93G7BfMMYVhN3reGv7iqXubRIbVzEDbZvhZy3FmoZMU0dtjNjE1m75e6K
	9UzHXqQNGjQFVcgPHjGVP9WQVzUMX1DcTXObkUphYg3JGlqbs7cTgWtV9RzroiBYrC95/K4tWou/Y
	rNtpCxhmuBYveETP5SjrTs/dCSDSuXmquTt7HKrIqY/I5YKl3lPWJyf+y3LjGK5j2HKjNOPTzHhlX
	qPei3sla290OYg5WkqMw0pKwes6/v1/T8YoC8Kze5KOn0A0pPMxxaaQTeyTzLaZ+Jpd7lk1+TAKx5
	pTseie5A==;
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjer2-0000000Cd67-1RO2
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:30 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-84877b362f6so7350073b3a.2
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042126; x=1784646926; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgKrbgFKZxbxCBaliRqkNgo/i0ql++Rr7PTW+pok5fM=;
        b=slMmm95GN7gyRbM7hqnPRARGul6ASvirldaDIXsqxQ7hJrWalM2KWMBUL+zS0IE6xY
         MGUzgoIrsXUgpTDR/9+/j4TG0R/jtYk3GYfzRa/e1Ywn+CUA+hj2U2tFZl3IblI/rEE1
         KPPVunLIYrF69to0eBgQ9Hg3ID0V4xqhwZvJCfWptNf3TYmsQqUE32W2JtBayuYMbJ7h
         sU8y4AXf7Zi3HAqbMWBfsfSL0QeWwyAhPy0khr2jxUrccwT7nsF4tbb8/NUPnafiui81
         28T/CFcHBg/ptu/tlhKqVxHqxBdGgKGNQzdCJEgWcL0U1aWYSWAHkY9vWgJl6iM5+cWT
         Lg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042126; x=1784646926;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JgKrbgFKZxbxCBaliRqkNgo/i0ql++Rr7PTW+pok5fM=;
        b=Tx9jpZRokl1hcGOJ+7Ut9QD5ANjH1X7IgU7Zbtak+7A/fjjMKX9ku5qCSvWh/jvaPy
         BR9/qQjCe/m0kVfxz7iFCI/FPh6+wU+1trWwdnJHQsz4yrsdExuv68ssJzP1ZnUuXbBC
         wOftYDAG1MBAKrOVZlwFIwzq1KgtUkBgsREvFNyje7E9vx1aqbOBLQf9DnbqYZr+6HF0
         hJFmqZbDRodN4eHEeEysJVgXmdXSoYYhNXMAnvKROys6lY+h3gSonJv4BHZYHT/Oi01f
         ttI5TPR9pindP8l8zLtiyd56HDVMKax7K9cTKpJsFwobsXT58eMq2sErd/UYfxoqLjJn
         hh6g==
X-Gm-Message-State: AOJu0Yxurr0TvP8t4jsVx5Tsx4nZl06f2M++I3PgP70TOpqG/uaky8VS
	fGi4unPXony+jMhg2fQVUqFO7mRWm4Z13Aha/4RHgvRMsn6NX9x9inqMlVB+FtviMb+Ie03HwFo
	TjBduDEaHTkGSPnb1Q1090dD9Faqk4HYKiDQD++Ncl0s/6WL5Pd3hIR68x0qcF17fWymRF3NnrA
	1EaNpVNrIpSVHrh4FXBuqZkrZgZVwQY+ORR4Fhysd48xuhhQ==
X-Received: from pfbll1.prod.google.com ([2002:a05:6a00:7281:b0:845:e386:e036])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f14:b0:845:e9e5:cdec
 with SMTP id d2e1a72fcca58-84a559bb7dfmr2554072b3a.62.1784042125277; Tue, 14
 Jul 2026 08:15:25 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:15:00 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-16-vipinsh@google.com>
Subject: [PATCH v5 15/20] vfio: selftests: Initialize vfio_pci_device using a
 VFIO cdev FD
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_161528_484807_4E81DF46 
X-CRM114-Status: GOOD (  13.50  )
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

Use the given VFIO cdev FD to initialize vfio_pci_device in VFIO
selftests. Add the assertion to make sure that passed cdev FD is not
used with legacy VFIO APIs. If VFIO cdev FD is provided then do not open
the device instead use the FD for any interaction with the device.

This API will allow writing selftests where VFIO device FD is preserved
using liveupdate and retrieved later using liveupdate ioctl after kexec.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  3 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 25 ++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 3eabead717bb..66fc29662daa 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -40,6 +40,9 @@ struct vfio_pci_device {
 
 struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_free(struct vfio_pci_device *device);
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd);
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 94dc5fcecbeb..a6e0e7c6e18e 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -414,9 +414,13 @@ void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf)
 }
 
 static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
-				   const char *bdf, const char *vf_token)
+				   const char *bdf, int device_fd,
+				   const char *vf_token)
 {
-	vfio_pci_cdev_open(device, bdf);
+	if (device_fd >= 0)
+		device->fd = device_fd;
+	else
+		vfio_pci_cdev_open(device, bdf);
 	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
@@ -440,16 +444,20 @@ void vfio_pci_device_free(struct vfio_pci_device *device)
 	free(device);
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd)
 {
 	struct vfio_pci_device *device;
 
 	device = vfio_pci_device_alloc(bdf, iommu);
 
-	if (iommu->mode->container_path)
+	if (iommu->mode->container_path) {
+		VFIO_ASSERT_EQ(device_fd, -1);
 		vfio_pci_container_setup(device, bdf, NULL);
-	else
-		vfio_pci_iommufd_setup(device, bdf, NULL);
+	} else {
+		vfio_pci_iommufd_setup(device, bdf, device_fd, NULL);
+	}
 
 	vfio_pci_device_setup(device);
 	vfio_pci_driver_probe(device);
@@ -457,6 +465,11 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
 	return device;
 }
 
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+{
+	return __vfio_pci_device_init(bdf, iommu, /*device_fd=*/-1);
+}
+
 void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 {
 	int i;
-- 
2.55.0.795.g602f6c329a-goog


