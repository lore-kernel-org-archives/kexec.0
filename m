Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48889C44508
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gKj/zyluhYMMwtYKfEtevhbjKc1OLf8e8hVjMJ10va8=; b=WeoU39u785LpSnVSacbn19OZEA
	IF3eYPcoGX8Nj9i96ChBsqMAQd2nvpYrjs0FuSrbpYMwUzVcYtNlWohkMJkths9Ji9fl/k3oEi0zX
	BgKywB0zhOLEaf53BRmXhno8K4lkwJ0Fb4ADD+I6XeUUe/fyYqVktxh0Zf7T303vlGioxgnM5u5cU
	8pb4e2eaAOFIX2tmfqj77Y19nrWeNKjytqXMHPB173pV07BkxThH7p6wIQ1nQ7zOq2zt0iEEH5tLA
	v8CEjaLdN2wSsXCZ4jGO7wTBSxyVBfb55ECA0QINTe2n4dLqXYQgtPVHaIPiFXbsPebt5TcgAFKJY
	NtlOWITQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer7-0000000CUTL-0ytV;
	Tue, 14 Jul 2026 15:15:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer5-0000000CUOB-17AM
	for kexec@bombadil.infradead.org;
	Tue, 14 Jul 2026 15:15:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gKj/zyluhYMMwtYKfEtevhbjKc1OLf8e8hVjMJ10va8=; b=IZJQGbvrWM+QDt9OVxpsyWdAC3
	4BPsuOyUXnOD5YA4JMgbhO5JDvXUHAJktt/25cC+l9/z4I0WrR64JBJ+pIXmim9QFzxYvaS5zEEf3
	Mto4a2NVV235PWQiQjyL7j10kvsYbDVE8kM6aR47yaYZ8cEWdVsj8umokTwnu+iZTmS9O+skDkBsx
	Sn8ij3I+M66ibfi+Ji1aqCWMWd0iot3VwdN7huyRDkQRdHElZW+4rf0dDFziPoD42L62hxNbNSu9y
	wVG9gZ6AM0ZzKNBpCfb2Fy1i6vsxME7A5SIEVh9HqyGWsxuZNEnVJirEvvXAA4MtDAcb6KPEG3LXj
	fJN2OWBw==;
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjer0-0000000Cd5g-2onr
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:30 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so5876639b3a.0
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042125; x=1784646925; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKj/zyluhYMMwtYKfEtevhbjKc1OLf8e8hVjMJ10va8=;
        b=FAW2B6V1BTYZf+cW+ldlkm1b9WeQpzOhAWUxc44VsZa0AXBrZ303/LTRYM7qXN8DXp
         Q5Sn1zIu4R6C7NWbc0dWDUwxO5k25MmlzzDm9krq/fuxrhGg/TYzsWkmwFylZToMXaIW
         IhBybDv5pWalOkJE/XBEJYWa2uHDl1hUnYs0qD19QhUqdeSZ9vSA3VQ8KCBS6TWoJaAK
         7eOOiiNdiFB5yVngN5zxcVrqTpsuSg4JeRHmVdg9wtHmqeXMtnnaNDasPh1xSl927/KO
         dL9zjqM9yFc5bxjL6XP0w13V60zOuMgMCfU2qcCiUCnvHwHCA8L6S3HBF+jZ5m68jnPJ
         IpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042125; x=1784646925;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKj/zyluhYMMwtYKfEtevhbjKc1OLf8e8hVjMJ10va8=;
        b=rfUntg3TUQZ0AcD9zmHOLbOg4wK61WpYMPywx6OMfRhlO932wxjirjBTQkXOmo3h7m
         RFXSTulAaPo18KWzyo6qY8Y8Sp6b5MgTM/y5qn39o7+HV4NN2qbxXfuZABXBY9t27OAr
         d+10ORNNs77r8bQl7svaQHaNgSvA+RmyG86xCcacr9+ze5imkHQFXPOV/z+SuyY4vqUJ
         d/vEKGk75slK9NRGK3iCLnkpv4vVaz2Gg/h5ZwjaGUwYg8qajYgA4XTsutdEZ8lLw7eH
         EUR6anN07J1XCOmxXCqEMu7qaXDSMSY0H677npZXqLtv6GcxQLWdQS+VHF+fXz7FVUkM
         OLPA==
X-Gm-Message-State: AOJu0YwVCsyD8ot31Wkm22Aq5Yw8CHOgE11JNeOxxSzPeq7VDTD1UhN8
	hwX4RsWtPBDjkX4HwRA4ZjGZC5djhqi0512rJX4CfwYr6LEv8Ev3ukPxLRQHzfQ1IJESjpAN+uv
	QfdniWdygWJZizEPz/brxeHTyFNQ4X8EhGnYFK2YH1iKTNR/eUvEVMvdKoBw9mCTxBHkOQQBbO2
	OQtUQNWlQy1X7qgWXokHz1DDGG9QDSk85JUZuz5BhFyhxgOg==
X-Received: from pfbhx15.prod.google.com ([2002:a05:6a00:898f:b0:845:e683:1287])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b50:b0:848:6698:2d5a
 with SMTP id d2e1a72fcca58-84889659202mr12144241b3a.20.1784042124125; Tue, 14
 Jul 2026 08:15:24 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:59 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-15-vipinsh@google.com>
Subject: [PATCH v5 14/20] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
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
X-CRM114-CacheID: sfid-20260714_161526_872279_C2BEECE1 
X-CRM114-Status: GOOD (  15.19  )
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

From: David Matlack <dmatlack@google.com>

Add a selftest to exercise preserving various VFIO files through
/dev/liveupdate. Ensure that VFIO cdev device files can be preserved and
everything else (group-based device files, group files, and container
files) all fail.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../vfio/vfio_pci_liveupdate_uapi_test.c      | 97 +++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 4c8a30f950c4..dc06fddcf855 100644
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
index 000000000000..f81c8ab21db3
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
@@ -0,0 +1,97 @@
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
+	ASSERT_GT(self->luo_fd, 0);
+
+	self->session_fd = luo_create_session(self->luo_fd, "session");
+	ASSERT_GT(self->session_fd, 0);
+
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
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
2.55.0.795.g602f6c329a-goog


