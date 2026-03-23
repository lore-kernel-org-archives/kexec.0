Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CCAF532C0
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUFryWFBPXxe6T+DTeCmqMtrNHQ62SSe5LgDU16cd+0=; b=RjD6BU95FIqjmlZn9Q0zq0LBqm
	lBeN9AxK85oPHJuH6MEoRyChlVk7ZPskgY+6JyxIC6PrJHkPV9Svs4IVB2s98hRGu5zu7EMv8B2DV
	6aKuasFvwsPTk+X159K89zuzgXEvHB0GYx/lTzRVcQ12mkvN4fGywYyKxLHvqcUUPO8AOgPGXvYed
	zvhvoKAVaYbfT6KdNMDPsRCz1HMFQDSzol+VfTJ4rbAR6zympuvSxrZDEcbS2wQrobTZJqtaLka4n
	NshIhCAJnQNhXc+4iN4AC54mjueV+Vq/GaxMJPrTWB3B7e+kVjRm8NBwBK+USzGMh5JkjY7YAt91O
	gl7pkIrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAu-00000000Bny-3eKH;
	Mon, 23 Mar 2026 23:59:12 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAs-00000000Bkc-3LWv
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:12 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-35a1e725a8fso24245724a91.3
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310349; x=1774915149; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUFryWFBPXxe6T+DTeCmqMtrNHQ62SSe5LgDU16cd+0=;
        b=pl6vVfjzbygHGXKpuFEw/Ns13k6zPXAxFq0XD8j9LqpxnKJzT5YxYaBOa4df2RzqiK
         DLgRoKf2eORl5Pn5ZFmBwFpTridWoJ8dM+jZ3KECItIpXrRuFEBLjKRHvnM+1cIFdzJu
         o5wT7ur0y4sARP1cCydx19RMcrhEzHqW3SA1VciELi9PdnFwOY6i31+BnXa89UVENSb7
         /PM2saTzUUjbx+Y4gljhpERPbvwLdUYBZn9DHqdeChDWP5B0xpNsriQ05Tf1aP2gov83
         f3rp66obSM4jCuCZRe8X9beivQisieHid5+NLoY/O1RKkXmgiG3KgcdcUydnZXpdN+nS
         KFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310349; x=1774915149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUFryWFBPXxe6T+DTeCmqMtrNHQ62SSe5LgDU16cd+0=;
        b=RKdgzWnqs/piFvf4ebPluY4cnO9QenVuf9dyjQ4yAnnHyJev3OsSVBD94HmLfXi1/D
         8n/p2KptVb53WSGc85Yu7MeRwI0E9QsiJpJspBycPRAL4kIcQqVlsnUxhcxuuDscAWM5
         t8daO4QHSnwXsoAktY0YmI4+2rxvPT84ih0jjzRf8BdbBxyPpUxBdOY7NP7GL0AVNUap
         hTor49A8namf6P9er4tvr323EhcDKMle4GheW5h/ypgATiimYRY74n0Qi66e3eTZFM9F
         uaJmcTRxZRi8B11xvEsULqa0MlKyoF/+BNHRWzEM+dd+thYWqMtuurlXNs2tZYI/PTiq
         XBsA==
X-Forwarded-Encrypted: i=1; AJvYcCVGLUW303xmJ2aCYBhcVDzRUEqnrnGAQQoQTjFpNZjLgDtJZuW5GJrHjIekImfUS2BtXXMRHw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRR8UuC/l/QWp+n9eBkxDOIBrxP01QIluPtZFzfQtm3EUgyjan
	GBCAUbPtA4b0zjCh2Ja/6W5VFsmHz13p5D8KFGdYpSQ5CfAcOqdy0UgDyppqkwPt4YeiMEINvBx
	+lW9Em9+P8l68Qg==
X-Received: from pjub5.prod.google.com ([2002:a17:90a:cc05:b0:359:f1f1:7bcb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:1c08:b0:35b:e519:213b with SMTP id 98e67ed59e1d1-35be5192186mr4242377a91.30.1774310349283;
 Mon, 23 Mar 2026 16:59:09 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:10 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-19-dmatlack@google.com>
Subject: [PATCH v3 18/24] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
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
X-CRM114-CacheID: sfid-20260323_165910_875158_D1D5F09E 
X-CRM114-Status: GOOD (  16.14  )
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

Add a selftest to exercise preserving a various VFIO files through
/dev/liveupdate. Ensure that VFIO cdev device files can be preserved and
everything else (group-based device files, group files, and container
files) all fail.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../vfio/vfio_pci_liveupdate_uapi_test.c      | 93 +++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 9d5e390a61b7..5b6e79593555 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
new file mode 100644
index 000000000000..1d89b08ab0a4
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <libliveupdate.h>
+#include <libvfio.h>
+#include <kselftest_harness.h>
+
+static const char *device_bdf;
+
+FIXTURE(vfio_pci_liveupdate_uapi_test) {
+	int luo_fd;
+	int session_fd;
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_VARIANT(vfio_pci_liveupdate_uapi_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			\
+FIXTURE_VARIANT_ADD(vfio_pci_liveupdate_uapi_test, _iommu_mode) {	\
+	.iommu_mode = #_iommu_mode,					\
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_pci_liveupdate_uapi_test)
+{
+	self->luo_fd = luo_open_device();
+	ASSERT_GE(self->luo_fd, 0);
+
+	self->session_fd = luo_create_session(self->luo_fd, "session");
+	ASSERT_GE(self->session_fd, 0);
+
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_liveupdate_uapi_test)
+{
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+	close(self->session_fd);
+	close(self->luo_fd);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
+{
+	int ret;
+
+	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
+
+	/* Preservation should only be supported for VFIO cdev files. */
+	ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
+{
+	int ret;
+
+	if (self->iommu->iommufd)
+		SKIP(return, "iommufd-mode does not have group files");
+
+	ret = luo_session_preserve_fd(self->session_fd, self->device->group_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_container_fails)
+{
+	int ret;
+
+	if (self->iommu->iommufd)
+		SKIP(return, "iommufd-mode does not have container files");
+
+	ret = luo_session_preserve_fd(self->session_fd, self->iommu->container_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd;
+
+	fd = luo_open_device();
+	if (fd < 0)
+		ksft_exit_skip("open(%s) failed: %s, skipping\n",
+			       LUO_DEVICE, strerror(errno));
+
+	close(fd);
+
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.53.0.983.g0bb29b3bc5-goog


