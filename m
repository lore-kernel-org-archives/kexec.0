Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81363F532C3
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=emXTkfduCARpReH/0NkUqCqksAosTTU4j/dciIvOyCs=; b=gl/jVmf5MrILxVd7WBNDJ7xGRi
	tjbjOP5BBiC+DTNDDX0WjPJcHXr+7hatyOgs9BQf0LvUTePSxsPm3Ij+IE06cOcM931p/UCcS21pV
	1T1i/7FUVpTMfjaZo8IZ4i4q/I1OJlFhiTNG6T86RwQsh1QnsRfPjdjxEqBkSdw87UWkaVjDpfl/H
	+IOlrIKSkwnb5+ybAuTy/WW5PT9qSTa6/h7XtTob9vPDuGMN0VS4syj5UnXiWV/G0izrILS4wUlVN
	C3xL4O4QZnZLGLv3XesH47xdXHwIAu4jU/TAhm4hCz3LvxyEogVNuxYGLidV1JTGnE3XAZjmDGLpI
	ozLFcFWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pB8-00000000C3X-2L0R;
	Mon, 23 Mar 2026 23:59:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pB7-00000000C14-1PaW
	for kexec@bombadil.infradead.org;
	Mon, 23 Mar 2026 23:59:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=emXTkfduCARpReH/0NkUqCqksAosTTU4j/dciIvOyCs=; b=WBCr45BDSW29EcDsHfjEqceEsl
	SyBfuTPK2GcU7RP1gxU0DDIYP8FbQHAkgcW4u9jS0QoPrzMUsJjzB/jHjb6EOz80YBnXKvw8FzwR+
	NYlZcHS+QekMbc5D9itqaPjyEM2Eyfw+VwlAxszV7ppkGw8YjOGknYche3OkJ7qzGX4tgZfIKyZ6d
	JEOFUBE4+PncE3uA1yPL3XI7mJ2UUCkZkxpu6hqESxlHxVflZ+T5IDXD7YlWu98y5F5gpLefKWI/f
	s/QsXaD+93yfBm0M2n8XheH/CRk9WlJHDxEWZLOeRi9AklXw+kanj0CjUHAvmKS/W4eQ9QQRCpEAq
	XpntxlEA==;
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pB4-0000000D55Y-1dhl
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:24 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2b056b2f0cfso8992455ad.0
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310360; x=1774915160; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=emXTkfduCARpReH/0NkUqCqksAosTTU4j/dciIvOyCs=;
        b=rgUNmClKTf5WFHt3xACN1GKb+tNi5ffHYITq6wDZZd+FPS8yL2JRsEFrWHW7OFAohi
         NR02VOAPUpwl/0pS5UqN5KHECn3wdebCoUAf/h5R5+oGW/v9Azw34XsrR63GtYQI0ENq
         qYPQU1op8edVHvey1/UAunzdx8etfUFnu5YoSFMbXaWBD0q+DUsirEMk5vsSNQilfoui
         5hbvoQ2Gmj92VA1XWl3Lj94wrAUDnkmBwy5r/qRmUaf3us0FKRbXVfjxWFG4qgu14vmQ
         +K6ys5Npaw5fPlgjaU71FHKgdYLvxxM9zUxnhe25iSq8ZjxZu/hpK2w2rCxRfk7J5Ui9
         e07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310360; x=1774915160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emXTkfduCARpReH/0NkUqCqksAosTTU4j/dciIvOyCs=;
        b=DgUwXlxuR39sd4Y+XyUVDPqY8BtbyntLhKveiOSPcdlE1FVC4YICczHSYqsTorVYmP
         d1G1utRaKDZlZhtMozSCnx7iJn2RejtqGjlXh/UaFvNibZCyTodcBMNrC3pEJ8O4H0xL
         hLSYTA9Jyis5AQ2w2D386Ng/B9JlgORQM5loQbQ+JAhr2SYqvRuG5ZaRE7Yf0Wbztodw
         McfHi7jHOe6t5+3L7k6kLutpE37+szqhYaaw3BaXngqnmw7oU0/iDrJMzzt7A7WRp4V7
         QGweAv+fItRETHjClknr/1lJSoKtLeTjjVFQ9BHAD83BqI69r/+6PXMDg60ypChVZ1cF
         yZiw==
X-Forwarded-Encrypted: i=1; AJvYcCU5oxJmGCN4m/Hx/p46Dcu01WIcAH1Rmg7pLGuxqpDfAFvUSKRtwY3AE7Mrj+EAuBN8+K5mWQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyf59v4VuuTJ9bEx7Q9aVPJtUESPcyKDh2Br5JzcAwCrXj2aOWE
	yFkHef5IcXa5TxE44TIOY6Xu9xIs+qL4yCMKO9wloQBOFydJOJFYSFuQVHVk2kHWJQflxmvSM6T
	EI3ySYU34Bwk3Iw==
X-Received: from plcp2.prod.google.com ([2002:a17:902:e342:b0:2b0:6c44:fc55])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d54a:b0:2ae:c9be:5f2c with SMTP id d9443c01a7336-2b08271d042mr130329495ad.21.1774310359658;
 Mon, 23 Mar 2026 16:59:19 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:16 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-25-dmatlack@google.com>
Subject: [PATCH v3 24/24] vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test
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
X-CRM114-CacheID: sfid-20260323_235922_457233_DBDDDF4E 
X-CRM114-Status: GOOD (  18.60  )
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

Add a long-running DMA memcpy operation to
vfio_pci_liveupdate_kexec_test so that the device attempts to perform
DMAs continuously during the Live Update.

At this point iommufd preservation is not supported and bus mastering is
not kept enabled on the device during across the kexec, so most of these
DMAs will be dropped. However this test ensures that the current device
preservation support does not lead to system instability or crashes if
the device is active. And once iommufd and bus mastering are preserved,
this test can be relaxed to check that the DMA operations completed
successfully.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 65c48196e44e..36bddfbb88ed 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -1,8 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/sizes.h>
+#include <sys/mman.h>
+
 #include <libliveupdate.h>
 #include <libvfio.h>
 
+#define MEMCPY_SIZE SZ_1G
+#define DRIVER_SIZE SZ_1M
+#define MEMFD_SIZE (MEMCPY_SIZE + DRIVER_SIZE)
+
+static struct dma_region memcpy_region;
 static const char *device_bdf;
 
 static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
@@ -11,8 +19,89 @@ static char device_session[LIVEUPDATE_SESSION_NAME_LENGTH];
 enum {
 	STATE_TOKEN,
 	DEVICE_TOKEN,
+	MEMFD_TOKEN,
 };
 
+static void dma_memcpy_one(struct vfio_pci_device *device)
+{
+	void *src = memcpy_region.vaddr, *dst;
+	u64 size;
+
+	size = min_t(u64, memcpy_region.size / 2, device->driver.max_memcpy_size);
+	dst = src + size;
+
+	memset(src, 1, size);
+	memset(dst, 0, size);
+
+	printf("Kicking off 1 DMA memcpy operations of size 0x%lx...\n", size);
+	vfio_pci_driver_memcpy(device,
+			       to_iova(device, src),
+			       to_iova(device, dst),
+			       size);
+
+	VFIO_ASSERT_EQ(memcmp(src, dst, size), 0);
+}
+
+static void dma_memcpy_start(struct vfio_pci_device *device)
+{
+	void *src = memcpy_region.vaddr, *dst;
+	u64 count, size;
+
+	size = min_t(u64, memcpy_region.size / 2, device->driver.max_memcpy_size);
+	dst = src + size;
+
+	/*
+	 * Rough Math: If we assume the device will perform memcpy at a rate of
+	 * 30GB/s then 7200GB of transfers will run for about 4 minutes.
+	 */
+	count = (u64)7200 * SZ_1G / size;
+	count = min_t(u64, count, device->driver.max_memcpy_count);
+
+	memset(src, 1, size / 2);
+	memset(dst, 0, size / 2);
+
+	printf("Kicking off %lu DMA memcpy operations of size 0x%lx...\n", count, size);
+	vfio_pci_driver_memcpy_start(device,
+				     to_iova(device, src),
+				     to_iova(device, dst),
+				     size, count);
+}
+
+static void dma_memfd_map(struct vfio_pci_device *device, int fd)
+{
+	void *vaddr;
+
+	vaddr = mmap(NULL, MEMFD_SIZE, PROT_WRITE, MAP_SHARED, fd, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	memcpy_region.iova = SZ_4G;
+	memcpy_region.size = MEMCPY_SIZE;
+	memcpy_region.vaddr = vaddr;
+	iommu_map(device->iommu, &memcpy_region);
+
+	device->driver.region.iova = memcpy_region.iova + memcpy_region.size;
+	device->driver.region.size = DRIVER_SIZE;
+	device->driver.region.vaddr = vaddr + memcpy_region.size;
+	iommu_map(device->iommu, &device->driver.region);
+}
+
+static void dma_memfd_setup(struct vfio_pci_device *device, int session_fd)
+{
+	int fd, ret;
+
+	fd = memfd_create("dma-buffer", 0);
+	VFIO_ASSERT_GE(fd, 0);
+
+	ret = fallocate(fd, 0, 0, MEMFD_SIZE);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	printf("Preserving memfd of size 0x%x in session\n", MEMFD_SIZE);
+	ret = luo_session_preserve_fd(session_fd, fd, MEMFD_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	dma_memfd_map(device, fd);
+}
+
 static void before_kexec(int luo_fd)
 {
 	struct vfio_pci_device *device;
@@ -32,6 +121,27 @@ static void before_kexec(int luo_fd)
 	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
 	VFIO_ASSERT_EQ(ret, 0);
 
+	dma_memfd_setup(device, session_fd);
+
+	/*
+	 * If the device has a selftests driver, kick off a long-running DMA
+	 * operation to exercise the device trying to DMA during a Live Update.
+	 * Since iommufd preservation is not supported yet, these DMAs should be
+	 * dropped. So this is just looking to verify that the system does not
+	 * fall over and crash as a result of a busy device being preserved.
+	 */
+	if (device->driver.ops) {
+		vfio_pci_driver_init(device);
+		dma_memcpy_start(device);
+
+		/*
+		 * Disable interrupts on the device or freeze() will fail.
+		 * Unfortunately there isn't a way to easily have a test for
+		 * that here since the check happens during shutdown.
+		 */
+		vfio_pci_msix_disable(device);
+	}
+
 	close(luo_fd);
 	daemonize_and_wait();
 }
@@ -78,6 +188,7 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	struct iommu *iommu;
 	int session_fd;
 	int device_fd;
+	int memfd;
 	int stage;
 
 	check_open_vfio_device_fails();
@@ -88,6 +199,10 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	session_fd = luo_retrieve_session(luo_fd, device_session);
 	VFIO_ASSERT_GE(session_fd, 0);
 
+	printf("Retrieving memfd from LUO\n");
+	memfd = luo_session_retrieve_fd(session_fd, MEMFD_TOKEN);
+	VFIO_ASSERT_GE(memfd, 0);
+
 	printf("Finishing the session before retrieving the device (should fail)\n");
 	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
 
@@ -109,9 +224,23 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	 */
 	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
 
+	dma_memfd_map(device, memfd);
+
 	printf("Finishing the session\n");
 	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
 
+	/*
+	 * Once iommufd preservation is supported and the device is kept fully
+	 * running across the Live Update, this should wait for the long-
+	 * running DMA memcpy operation kicked off in before_kexec() to
+	 * complete. But for now we expect the device to be reset so just
+	 * trigger a single memcpy to make sure it's still functional.
+	 */
+	if (device->driver.ops) {
+		vfio_pci_driver_init(device);
+		dma_memcpy_one(device);
+	}
+
 	vfio_pci_device_cleanup(device);
 	iommu_cleanup(iommu);
 }
-- 
2.53.0.983.g0bb29b3bc5-goog


