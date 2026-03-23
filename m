Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BCAF532C0
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uoPb6rPvbQAZiMMCvtGaLSKACFZ3kOlM4xYp0I2xeaE=; b=prXufXhlkqxPpHtKnHtNACLSvJ
	MslML8IxfZfAxDqp/yeGzPgwllR6J4MSzmiXmOqdoZRfW1/FX+qDBNbG5Pw9n+5/t9Ir+72spcvAF
	Nx53zBTIGSd0MNwzxDg3E32LFE8goq0FhjIjb6WedcXIR079w1+MehLZzkc/DMXbIDlouXKPylOiN
	miKDWwCF2P6mW0k+KocWF3FACNFS/5UeMWR/MO4tZSrZV3P3yND/J5RWtovjjkPje0vWViUoFnwiv
	3JIUgSIvm4w67Tw2UaMkftdYzZ5Sf3Zg6W7YImV0e/VJuAx5MkAKAWXgwRziNrltvPhNG6B5IOmy6
	Wgafzclw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pB0-00000000BsB-0wND;
	Mon, 23 Mar 2026 23:59:18 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAu-00000000BmX-2bCK
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:17 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2aed1beaa73so62839215ad.2
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310351; x=1774915151; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoPb6rPvbQAZiMMCvtGaLSKACFZ3kOlM4xYp0I2xeaE=;
        b=wAryloiGUaA8vWKF2eE3katHvTNn0Fn0Iy+2jgSo6NVc+fPANt6vlB2CUHGpR2OSa2
         1lui3zES6otLfV3KZR9VJRuZ88muJomX7ypEYJQhiu+dM1SXyO9K2w0/KtjKYgGSXCB6
         YZ7BzTNujPliU9QxmJ7cvZql74bM0yRH3NYgzMXrRMoQBLywNYqdE+WRA8PAnrqIzaGQ
         7abzjfhxnST0atmnoAQMwo12ebqjEnPOD0bgEulxFcrsKnoZc1ePQ2HpeTwmx7Hd0QM0
         q0YO7KtLN6oLuG1RQlRvNmpKhU26l8rAOX+SGgKnC2Aj5HfkotC2GjIhw6Wb1NZQaG/d
         Vw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310351; x=1774915151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoPb6rPvbQAZiMMCvtGaLSKACFZ3kOlM4xYp0I2xeaE=;
        b=mESMsv61FQAQ45ak++dn8qPF+yVOmrsrqhg3iHRa4+uqr4Bp0zVkgK/J88VtJBXhkT
         72iw1vDwE/0n3px4Vb9r44+GqiprWj7Sh/0ns+kTW7kGqex5FhjK/1KLDsQMw5fwXLhP
         CkFKjUaa68UtnStKLUP5XC35V5AeetPkffPVMevWFbSr3HKJuSrqpODLJSxc3/QbpE84
         zUQsrXmIDXq7/RroJyFp0hC6J+2py6RCxlgTGilcI5PGWm+vFPnoR0OLbwGpteI//Ola
         naHr2ahz71dhdX+t3ldk92TvWMUWqMi9G6os6sJNkV4KtXam+YO+Rs1pV+ZDw28MNF2c
         nfWg==
X-Forwarded-Encrypted: i=1; AJvYcCVEBerRxXAf9/0gm1U9DoX9nLtao1NcXSBJ5F/YMtxTw0sGaIM/t2/D/h33yFfPGa42xA0b2w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxCxsE9H7oKyH+4O1fr86KWnd4IZFanaLqdjjok0XctplboOmiP
	CPU/0hf5gqBNsPtX9vJCcy+7Cmz1vqBWe2sgII+VDjgOhM7vrjvm++OR1dlBScIw1T0163BdA57
	bMBDpw701iRzfrQ==
X-Received: from pga26.prod.google.com ([2002:a05:6a02:4f9a:b0:c6e:28c3:dd5c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:218a:b0:39b:81bf:15e3 with SMTP id adf61e73a8af0-39bcec29166mr12126845637.66.1774310351170;
 Mon, 23 Mar 2026 16:59:11 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:11 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-20-dmatlack@google.com>
Subject: [PATCH v3 19/24] vfio: selftests: Initialize vfio_pci_device using a
 VFIO cdev FD
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_165912_680573_39F9F026 
X-CRM114-Status: GOOD (  15.41  )
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

From: Vipin Sharma <vipinsh@google.com>

Use the given VFIO cdev FD to initialize vfio_pci_device in VFIO
selftests. Add the assertion to make sure that passed cdev FD is not
used with legacy VFIO APIs. If VFIO cdev FD is provided then do not open
the device instead use the FD for any interaction with the device.

This API will allow to write selftests where VFIO device FD is preserved
using liveupdate and retrieved later using liveupdate ioctl after kexec.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  3 ++
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 ++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..896dfde88118 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -38,6 +38,9 @@ struct vfio_pci_device {
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd);
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4e5871f1ebc3..e9215c712cda 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -340,19 +340,27 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
 }
 
-static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
+static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
+				   const char *bdf, int device_fd)
 {
-	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
+	const char *cdev_path;
 
-	device->fd = open(cdev_path, O_RDWR);
-	VFIO_ASSERT_GE(device->fd, 0);
-	free((void *)cdev_path);
+	if (device_fd >= 0) {
+		device->fd = device_fd;
+	} else {
+		cdev_path = vfio_pci_get_cdev_path(bdf);
+		device->fd = open(cdev_path, O_RDWR);
+		VFIO_ASSERT_GE(device->fd, 0);
+		free((void *)cdev_path);
+	}
 
 	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd)
 {
 	struct vfio_pci_device *device;
 
@@ -363,10 +371,12 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
 	device->iommu = iommu;
 	device->bdf = bdf;
 
-	if (iommu->mode->container_path)
+	if (iommu->mode->container_path) {
+		VFIO_ASSERT_EQ(device_fd, -1);
 		vfio_pci_container_setup(device, bdf);
-	else
-		vfio_pci_iommufd_setup(device, bdf);
+	} else {
+		vfio_pci_iommufd_setup(device, bdf, device_fd);
+	}
 
 	vfio_pci_device_setup(device);
 	vfio_pci_driver_probe(device);
@@ -374,6 +384,11 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
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
2.53.0.983.g0bb29b3bc5-goog


