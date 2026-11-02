Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C5606CEE7
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MtllE0s2;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HH+H34D/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PQb3q6R6QngEoe3ekBduEqXoGdMTuhEwA2ttf4WySgI=; b=MtllE0s27TcQhbuXp6NPuynUOt
	/YMWRlcQMdd9sU2jb30E8/pryctTDVcwvsfLzoP8WrmGvne3bXbMeDrLNUGLWQ+elCjkLMou6BMny
	grdM8iL3DJkPQ2Qd7G8qnWoLYEpfSs4Gbe3Y1+hGM5XSDUse9N/3rIgUKesxgzvf2YYVCdfQWQvJe
	sANKCfj201GyUM+UiBzK0Adm28D1Ue9Ya144Yczbyh6xKiSMeLG1h59/vyjj4C9J3O3WpEp/rF4U0
	bNQcVoIAE20+Rf1Y+mkzjSlIQT+R77uysNVnYdl55I0D5bnu5NVo7Qh/rMMpkElDUHl2t1i57sdny
	bIG4sjGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6P-0000000HAGh-2NG7;
	Mon, 02 Nov 2026 15:37:41 +0000
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6E-0000000H9zf-2yhG
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:35 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e93f67358eso35406375ad.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633849; x=1794238649; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQb3q6R6QngEoe3ekBduEqXoGdMTuhEwA2ttf4WySgI=;
        b=HH+H34D/b21QwOctGcOgkmgqGs/UUzKQazCENa/hN6TW5LoClv9m4LRUFYmqKBKym/
         D/HDH2vq+NLnXxME4BphynFSFEChYFAE4NBNsQBH6V3Hxvdv1kn09w8L9a+a2QYRGdFg
         rg/gEZqYR0m4aYWg83X7QdBfJnb7yqalU3T81EPZNVbMhmIScOloi5hcVpyDy/U6xWGq
         L/sEOiuNGVJwR55Prw7SY6H3h2FoLoY6hMBRtwog/RbPxzlEaX1ysXwlTK9POpD1zG02
         fMwzQS4Qn4qmhfUzLKhyD8SrLpxKZ3qMzPouWq5WMRx8rzQ24p/Z95CEha7kZd4vQ21p
         wdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633849; x=1794238649;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQb3q6R6QngEoe3ekBduEqXoGdMTuhEwA2ttf4WySgI=;
        b=RdQqSeJPgM0jBivv+b2D+WJFtdzL4oCp/bPVwyPI6Jm6aDjDLOwqoLn6T+Bf+6393s
         yV6FBQM2bDjgDKS7L0EL4s+MQ1vGj+IuOyKuzKsmD/sLV5uV8MOrG74hvhhTMmNsKweH
         Is/SO6r/QADser+E20FjyLVuVNYFHwYqHWiwvaEuIbyAyKNz5lFeojLkwIpfU1uM6Q/B
         Ehskfd1Nhc0I0C829dihfvBXbb33gjFyJKDqNbH1U8tGO18Rq1y7aA2EtP2o1PUkGcZx
         anXmJy+EulFI3j/CumsIjdG7Q934iZoMiufJcUcev5WD7BxTGnhJGo1FwnEjJTaR8IXU
         7DJA==
X-Gm-Message-State: APuU4Z+GmHZnnprS5grfdFg8h0gW1D/lF1YCC+e1VZpmfWByv8QR/XVZ
	uQIvCFwwG8d0T+7bZQDMKONgGXxAkRLTFdwxwf96owV17gSNZkw0ievQoZltf2MELk/KwZQJcdT
	+09Prh3/+hTb0lZhEymuU10vUOWMlrut+0oyhpEuvjdgRdMV6esNyiImcKBKJcVb/7WlChFS33l
	Q2C0XIvAlWJB/9inDmalkl2GgmUp2svjPZLwWAyQt5iubI8g==
X-Received: from plbjf11.prod.google.com ([2002:a17:903:268b:b0:2e8:7c73:6eb4])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ecc:b0:2e9:9c65:1aff
 with SMTP id d9443c01a7336-2eb364d70e3mr109468515ad.45.1793633848882; Mon, 02
 Nov 2026 07:37:28 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:56 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-28-vipinsh@google.com>
Subject: [PATCH v6 27/27] vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_073730_796670_28D9B75B 
X-CRM114-Status: GOOD (  23.31  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend vfio_pci_liveupdate_kexec_test to exercise continuous DMA across
a Live Update when the device is in noiommu mode.

Allocate a shmem memfd backed by three 2MB THP folios (for the driver
region, source buffer, and destination buffer), map each folio at
IOVA == PA via iommu_map_identity(), and preserve the memfd in the same
Live Update session before the device so that LUO's LIFO finish order
keeps the memory alive until after the device is finished.

Before kexec, initialize the selftest driver, run a sanity memcpy, kick
off a long-running DMA memcpy, and disable MSI-X so freeze() succeeds.
After kexec, take over the device via __vfio_pci_device_init(), retrieve
and map the preserved memfd verifying that all three 2MB folios stayed
at the exact same physical addresses, attach the driver without resetting
the device, wait for the pre-kexec memcpy to complete, and run another
memcpy without reinitializing the device.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 266 +++++++++++++++++-
 1 file changed, 257 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 9610fe593cf6..c33b62118523 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -1,22 +1,120 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
 #include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
 #include <linux/vfio.h>
+
 #include <libliveupdate.h>
 #include <libvfio.h>
 
+#define DRIVER_REGION_SIZE	SZ_2M
+#define MEMCPY_FOLIO_SIZE	SZ_2M
+#define NR_MEMFD_FOLIOS		3
+#define MEMFD_SIZE		(NR_MEMFD_FOLIOS * SZ_2M)
+
+#define MEMCPY_TIMEOUT_S	(30 * 60)
+
+static struct dma_region src_region;
+static struct dma_region dst_region;
+static void *memfd_vaddr;
+static u64 folio_pa[NR_MEMFD_FOLIOS];
+
 static const char *device_bdf;
 
 static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+static char data_session[LIVEUPDATE_SESSION_NAME_LENGTH];
 static char device_session[LIVEUPDATE_SESSION_NAME_LENGTH];
 
 enum {
 	STATE_TOKEN,
 	DEVICE_TOKEN,
+	MEMFD_TOKEN,
+	DATA_TOKEN,
 };
 
+static u64 memcpy_size(struct vfio_pci_device *device)
+{
+	return min_t(u64, src_region.size, device->driver.max_memcpy_size);
+}
+
+static bool is_filled(const char *buf, u64 size, char c)
+{
+	return buf[0] == c && !memcmp(buf, buf + 1, size - 1);
+}
+
+static void dma_memcpy_one(struct vfio_pci_device *device, char c)
+{
+	u64 size = memcpy_size(device);
+	void *src = src_region.vaddr;
+	void *dst = dst_region.vaddr;
+
+	memset(src, c, size);
+	memset(dst, 0, size);
+
+	VFIO_ASSERT_EQ(vfio_pci_driver_memcpy(device, to_iova(device, src),
+					      to_iova(device, dst), size), 0);
+	VFIO_ASSERT_TRUE(is_filled(dst, size, c));
+}
+
+static void dma_memcpy_start(struct vfio_pci_device *device)
+{
+	u64 size = memcpy_size(device);
+	void *src = src_region.vaddr;
+	void *dst = dst_region.vaddr;
+	u64 count;
+
+	/*
+	 * Rough Math: If we assume the device will perform memcpy at a rate of
+	 * 30GB/s then 7200GB of transfers will run for about 4 minutes.
+	 */
+	count = (u64)7200 * SZ_1G / size;
+	count = min_t(u64, count, device->driver.max_memcpy_count);
+
+	memset(src, 'x', size);
+	memset(dst, 0, size);
+
+	ksft_print_msg("Starting %lu DMA memcpy operations of size 0x%lx\n",
+		       count, size);
+	vfio_pci_driver_memcpy_start(device, to_iova(device, src),
+				     to_iova(device, dst), size, count);
+}
+
+static void dma_memcpy_wait(struct vfio_pci_device *device)
+{
+	u64 size = memcpy_size(device);
+	void *src = src_region.vaddr;
+	void *dst = dst_region.vaddr;
+	struct timespec start, end;
+	long ms;
+
+	VFIO_ASSERT_EQ(clock_gettime(CLOCK_MONOTONIC, &start), 0);
+
+	/* Fail rather than hang if the device stopped, e.g. as it was reset. */
+	alarm(MEMCPY_TIMEOUT_S);
+	VFIO_ASSERT_EQ(vfio_pci_driver_memcpy_wait(device), 0);
+	alarm(0);
+
+	VFIO_ASSERT_EQ(clock_gettime(CLOCK_MONOTONIC, &end), 0);
+	ms = (end.tv_sec - start.tv_sec) * 1000 +
+	     (end.tv_nsec - start.tv_nsec) / 1000000;
+
+	VFIO_ASSERT_TRUE(is_filled(src, size, 'x'));
+	VFIO_ASSERT_TRUE(is_filled(dst, size, 'x'));
+
+	ksft_print_msg("Pre-kexec DMA memcpy operations completed after %ld ms\n",
+		       ms);
+}
+
 static void check_noiommu(const char *bdf)
 {
 	const char *cdev_path = __vfio_pci_get_cdev_path(bdf, true);
@@ -35,26 +133,162 @@ static void check_noiommu(const char *bdf)
 	free((void *)cdev_path);
 }
 
+static void dma_memfd_regions_map(struct vfio_pci_device *device, int fd,
+				  bool before_kexec)
+{
+	struct dma_region *regions[NR_MEMFD_FOLIOS] = {
+		&device->driver.region,
+		&src_region,
+		&dst_region,
+	};
+	int i;
+
+	memfd_vaddr = vfio_memfd_mmap_aligned(fd, MEMFD_SIZE, SZ_2M);
+
+	for (i = 0; i < NR_MEMFD_FOLIOS; i++) {
+		struct dma_region *r = regions[i];
+
+		r->vaddr = memfd_vaddr + (u64)i * SZ_2M;
+		r->size = SZ_2M;
+		iommu_map_identity(device->iommu, r);
+
+		if (before_kexec)
+			folio_pa[i] = r->iova;
+		else
+			VFIO_ASSERT_EQ(r->iova, folio_pa[i],
+				       "Folio %d moved across kexec (0x%lx != 0x%lx)\n",
+				       i, r->iova, folio_pa[i]);
+	}
+}
+
+static void dma_memfd_recheck_pa(struct vfio_pci_device *device)
+{
+	struct dma_region *regions[NR_MEMFD_FOLIOS] = {
+		&device->driver.region,
+		&src_region,
+		&dst_region,
+	};
+	int i;
+
+	for (i = 0; i < NR_MEMFD_FOLIOS; i++) {
+		u64 pa, len;
+
+		VFIO_ASSERT_EQ(__iommu_noiommu_get_pa(device->iommu,
+						      regions[i]->iova, SZ_2M,
+						      &pa, &len), 0);
+		VFIO_ASSERT_EQ(pa, folio_pa[i]);
+		VFIO_ASSERT_EQ(len, (u64)SZ_2M);
+	}
+}
+
+static void dma_memfd_regions_unmap(struct vfio_pci_device *device)
+{
+	iommu_unmap(device->iommu, &dst_region);
+	iommu_unmap(device->iommu, &src_region);
+	iommu_unmap(device->iommu, &device->driver.region);
+	VFIO_ASSERT_EQ(munmap(memfd_vaddr, MEMFD_SIZE), 0);
+	memfd_vaddr = NULL;
+}
+
+static void save_data_session(int luo_fd)
+{
+	char buf[256];
+	int data_fd;
+
+	data_fd = luo_create_session(luo_fd, data_session);
+	VFIO_ASSERT_GE(data_fd, 0);
+
+	snprintf_assert(buf, sizeof(buf), "0x%lx 0x%lx 0x%lx",
+			folio_pa[0], folio_pa[1], folio_pa[2]);
+	VFIO_ASSERT_EQ(create_and_preserve_memfd(data_fd, DATA_TOKEN, buf), 0);
+}
+
+static void load_data_session(int luo_fd)
+{
+	char buf[256] = {};
+	char *end, *cur;
+	int data_fd;
+	int mfd;
+	int i;
+
+	data_fd = luo_retrieve_session(luo_fd, data_session);
+	VFIO_ASSERT_GE(data_fd, 0);
+
+	mfd = luo_session_retrieve_fd(data_fd, DATA_TOKEN);
+	VFIO_ASSERT_GE(mfd, 0);
+	VFIO_ASSERT_GT(pread(mfd, buf, sizeof(buf) - 1, 0), 0);
+	VFIO_ASSERT_EQ(close(mfd), 0);
+
+	cur = buf;
+	for (i = 0; i < NR_MEMFD_FOLIOS; i++) {
+		errno = 0;
+		folio_pa[i] = strtoull(cur, &end, 0);
+		VFIO_ASSERT_EQ(errno, 0);
+		VFIO_ASSERT_NE(end, cur);
+		cur = end;
+	}
+
+	VFIO_ASSERT_EQ(luo_session_finish(data_fd), 0);
+	VFIO_ASSERT_EQ(close(data_fd), 0);
+}
+
 static void before_kexec(int luo_fd)
 {
 	struct vfio_pci_device *device;
 	struct iommu *iommu;
+	void *init_vaddr = NULL;
 	int session_fd;
+	int memfd;
 	int ret;
 
 	check_noiommu(device_bdf);
 
+	memfd = vfio_thp_memfd_alloc(MEMFD_SIZE, &init_vaddr);
+	if (memfd < 0)
+		ksft_exit_skip("Failed to allocate 2MB THP memfd: %s\n",
+			       strerror(-memfd));
+	VFIO_ASSERT_EQ(munmap(init_vaddr, MEMFD_SIZE), 0);
+
 	iommu = iommu_init(MODE_IOMMUFD_NOIOMMU);
 	device = vfio_pci_device_init(device_bdf, iommu);
 
+	if (!device->driver.ops || !device->driver.ops->attach)
+		ksft_exit_skip("No driver that supports attach() found for %s\n",
+			       device_bdf);
+
+	dma_memfd_regions_map(device, memfd, true);
+
 	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
 
 	session_fd = luo_create_session(luo_fd, device_session);
 	VFIO_ASSERT_GE(session_fd, 0);
 
+	/*
+	 * Preserve the DMA memfd in the same session before the device so that
+	 * LUO's LIFO finish order resets an unclaimed device before freeing
+	 * the memfd folios.
+	 */
+	ret = luo_session_preserve_fd(session_fd, memfd, MEMFD_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	dma_memfd_recheck_pa(device);
+
 	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
 	VFIO_ASSERT_EQ(ret, 0);
 
+	vfio_pci_driver_init(device);
+	dma_memcpy_one(device, 'a');
+
+	dma_memcpy_start(device);
+
+	/*
+	 * Disable interrupts on the device or freeze() will fail. The memcpy
+	 * operations do not generate any.
+	 */
+	vfio_pci_msix_disable(device);
+
+	save_data_session(luo_fd);
+
 	close(luo_fd);
 	daemonize_and_wait();
 }
@@ -98,13 +332,16 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	struct iommu *iommu;
 	int session_fd;
 	int device_fd;
+	int memfd;
 	int stage;
 
-	check_open_vfio_device_fails();
-
 	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
 	VFIO_ASSERT_EQ(stage, 2);
 
+	load_data_session(luo_fd);
+
+	check_open_vfio_device_fails();
+
 	session_fd = luo_retrieve_session(luo_fd, device_session);
 	VFIO_ASSERT_GE(session_fd, 0);
 
@@ -112,16 +349,25 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	VFIO_ASSERT_GE(device_fd, 0);
 
 	iommu = iommu_init(MODE_IOMMUFD_NOIOMMU);
-
-	/*
-	 * This will invoke various ioctls on device_fd such as
-	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
-	 * that LUO actually handed us back a valid VFIO device
-	 * file and not something else.
-	 */
 	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
 
+	memfd = luo_session_retrieve_fd(session_fd, MEMFD_TOKEN);
+	VFIO_ASSERT_GE(memfd, 0);
+
+	dma_memfd_regions_map(device, memfd, false);
+
+	vfio_pci_driver_attach(device, /*memcpy_in_progress=*/true);
+	dma_memcpy_wait(device);
+
+	/* The device was not reset, so it can be used without reinitializing it. */
+	dma_memcpy_one(device, 'y');
+
 	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
+	VFIO_ASSERT_EQ(close(session_fd), 0);
+
+	vfio_pci_driver_remove(device);
+	dma_memfd_regions_unmap(device);
+	VFIO_ASSERT_EQ(close(memfd), 0);
 
 	vfio_pci_device_cleanup(device);
 	iommu_cleanup(iommu);
@@ -133,6 +379,8 @@ int main(int argc, char *argv[])
 
 	snprintf_assert(device_session, sizeof(device_session),
 			"vfio-lu-device-%s", device_bdf);
+	snprintf_assert(data_session, sizeof(data_session),
+			"vfio-lu-data-%s", device_bdf);
 	snprintf_assert(state_session, sizeof(state_session),
 			"vfio-lu-state-%s", device_bdf);
 
-- 
2.56.0.317.g454f8302e1-goog


