Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697F60F0C08
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Yqg2mfRh;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Prd54Lwe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xs0C+G7zjdZllGuTbQSqQheVXxWPk9ZHdH8YJo8R+C0=; b=Yqg2mfRh9oNAKN4kzWsvDU725K
	rxhwzV/XQtecM1kiinrOrR0GwbHjMXMDf+mcrfJlMo808VSQ3MUexVgUNm9iyb6StEPWeOh/+nUfr
	3w4NJg+MgRdkWTppZ3Gc+cBd5TacujfFaKYETP6BWA8LvQlAXMvdIKNuz128rJ5CxRTBYKqbTha7U
	x+GAcxzxLNV6iaQ9OY7aANM2UE/OqRV497BNIrH5CBa+5wINxYezlanxFQAXLGbddBCHLXN42GY2i
	JTViPNDuf9QjW2Z0zc73XlsJ6zOk24rHS7YQagvwEVlgOkNS03FoAokpnGPzOqcVKH8sqZwPPowZy
	h7PIlghA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6J-0000000HA7M-2KmH;
	Mon, 02 Nov 2026 15:37:35 +0000
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu64-0000000H9m9-13vd
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:24 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2eac6e96bd4so48178795ad.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633838; x=1794238638; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xs0C+G7zjdZllGuTbQSqQheVXxWPk9ZHdH8YJo8R+C0=;
        b=Prd54LwecQaNMzQ8lRrHIWykgQNPqRnsMw9ityy1ZBz+cHIROYfgIgLUt+NedHwbIl
         EBq5EoIjCzJXkGnZKYmp5xOD4KrdL2mBLJ6bo59Ri68Lx68FxN8G7lnGCdMEd4CNR8MK
         hO9wgdpt64EBUnQ7KHV6kZIVE9MafauYSesJxQ2aloYW4PTq+mfAvJ2yoII7R2+rRy7X
         1i/XErtRdSLTIgb7R4GHjbrhIAGQRzfbA3AErkk8uDA7ZExmMNlS5g5uJmXP0/Zh20pD
         JjeJPETcv8fGH0W+PlQqLb1JcZ3v0zK4eY6aFDu9a+DZAe8XHsDwqfVX9ENZM7WC7GH9
         sa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633838; x=1794238638;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xs0C+G7zjdZllGuTbQSqQheVXxWPk9ZHdH8YJo8R+C0=;
        b=pRTePxTir3vEckrkBEkvNfb4NSRUofPV2S6+he20CjKg/ACLX02kxyTBHUuSiSG6ON
         lUgkA8EyKjzRpOqRh9x0Mvsd7jwuh+vfnNfXAiPQkerU3dU79x99tGydhXm/7A/XWwZi
         UpVD8TMTyaan/jdMnqFhiE4Zx3JPTEM8titaS2GQ1FGoP1o8hbRIkfmws9Icuz4l1RJb
         vRVzQiZh5MSucoPz/klgFGIUMzq6rx0JKWzMblqxPB7gg2g2q9X6kWSg/mMhfJzBYtBL
         NRD33lv5NFXRZVcb3XNPrSDgCumnxT8TZNOWXfeChKNjv8Sf34pYKD1Yk6b2+fk96PFX
         mk4w==
X-Gm-Message-State: APuU4Z/Bgaf30Zf7LU0CI7xDbLvD8BjwtDcbKvIBdhm9a6VUse0/zPwJ
	Df7hG6MIPGUj1RkZ/8bL1Y90sdZQ3Cnkq6bB5hcxS+afebDkAOJz1ClXOiAfwUPAhIAwmeSfwdJ
	vjGqnJOYU4UyuS8vnPuOMf7tXqGtOCH/U42pTmfsSvgV59tBOgz3klQYH+pic0P6Umj/QSBmT0m
	tYmwtOBGtpLIy0AkfmyYoYGinupF+MX7BtqRACuOOnEPQxmg==
X-Received: from plko2.prod.google.com ([2002:a17:902:6b02:b0:2e8:bfd5:b889])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f542:b0:2e9:9263:a5f
 with SMTP id d9443c01a7336-2eb36493707mr97418395ad.17.1793633838083; Mon, 02
 Nov 2026 07:37:18 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:46 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-18-vipinsh@google.com>
Subject: [PATCH v6 17/27] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
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
X-CRM114-CacheID: sfid-20261102_073720_414067_C1596857 
X-CRM114-Status: GOOD (  18.88  )
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

From: David Matlack <dmatlack@google.com>

Add a selftest to exercise preserving various VFIO files through
/dev/liveupdate. Only the VFIO cdev files of devices in noiommu mode can
be preserved. Ensure that preserving the cdev file of a device that is
not in noiommu mode fails, and that everything else (group-based device
files, group files, and container files) fails too.

In FIXTURE_SETUP, probe luo_session_preserve_fd() on the bound cdev FD
in a temporary session for iommufd variants and skip if LUO returns
-ENOENT, so the test skips cleanly when CONFIG_VFIO_PCI_LIVEUPDATE=n or
when the target device does not support VFIO PCI Live Update (e.g. an
SR-IOV VF).

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/vfio_pci_liveupdate_uapi_test.c      | 126 ++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 55e1e1843090..c2764fcef31d 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
+TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
new file mode 100644
index 000000000000..da25ea4e2b1e
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
@@ -0,0 +1,126 @@
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
+/*
+ * LUO fails with -ENOENT if no file handler accepts a file. For the bound VFIO
+ * cdev file of a device, that means that the kernel lacks VFIO PCI Live Update
+ * support (CONFIG_VFIO_PCI_LIVEUPDATE=n) or that vfio-pci does not support
+ * preserving the device (e.g. an SR-IOV VF).
+ */
+static bool device_preserve_supported(int luo_fd, int device_fd)
+{
+	int session_fd;
+	int ret;
+
+	session_fd = luo_create_session(luo_fd, "probe");
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	ret = luo_session_preserve_fd(session_fd, device_fd, 0);
+
+	/* Closing the session unpreserves the device. */
+	VFIO_ASSERT_EQ(close(session_fd), 0);
+
+	return ret != -ENOENT;
+}
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
+	ASSERT_GT(self->luo_fd, 0);
+
+	self->session_fd = luo_create_session(self->luo_fd, "session");
+	ASSERT_GT(self->session_fd, 0);
+
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+
+	if (self->iommu->iommufd &&
+	    !device_preserve_supported(self->luo_fd, self->device->fd))
+		SKIP(return, "Live Update of %s is not supported", device_bdf);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_liveupdate_uapi_test)
+{
+	if (self->device)
+		vfio_pci_device_cleanup(self->device);
+	if (self->iommu)
+		iommu_cleanup(self->iommu);
+	if (self->session_fd > 0)
+		close(self->session_fd);
+	if (self->luo_fd > 0)
+		close(self->luo_fd);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
+{
+	int ret;
+
+	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
+
+	/*
+	 * Only VFIO cdev files of devices in noiommu mode can be preserved;
+	 * device files obtained through a VFIO group never can.
+	 */
+	ASSERT_EQ(ret, self->iommu->iommufd ? -EOPNOTSUPP : -ENOENT);
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
2.56.0.317.g454f8302e1-goog


