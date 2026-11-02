Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32960F17FC
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cmJz3O++;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=aK/nJ59W;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RjMJaNbL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P5Sj6s4WCpHUP3cSZIKUa0LCg/XSbNt4xz/AARSS1Lk=; b=cmJz3O++aX8FKCXKuFZOsw/Awr
	JaxXEaOoz1oaxe9Cdoms47a3qrky0J81wxYroBRq1MWT9RQct9zG0yIb0GagaDwai5kNGDyjNd4Eg
	D2KT165yx22LL3KmwC/ZZ5cupk/QbFU56sFWlnqUBfP/ylW51HxNaLfHs/UQN2S7OqQVfvuq+fNaM
	Qr/CiFr9szpzcOKV7q68AWGSpEukAwr8zuETPCVD/32GZgShi2jR4DOAfx9FXDbj/5HsjVhY+Ck5V
	+Lcn6Pezn0B4fXrjGJ0cvnuS75CJ5NijVrPH/Bt84uFEM2nScWShBofWrjVFBIQNm9h4QdXIsuAvC
	j8qJOZFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6U-0000000HAKq-0HP3;
	Mon, 02 Nov 2026 15:37:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6K-0000000HA7F-0U6a
	for kexec@bombadil.infradead.org;
	Mon, 02 Nov 2026 15:37:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P5Sj6s4WCpHUP3cSZIKUa0LCg/XSbNt4xz/AARSS1Lk=; b=aK/nJ59WnzRpLQOnJp8wBUOUkF
	O4Mc9dLDpcmKh4coYqTn1g9GrBrzAP4r++BfsqZmGGqfRfJ8ztZZdy3f18JGFL6uh1NrjcG0sacIR
	V3IT1Ha/ZODvu4nS6BYZ+c6t5hIvrwsdfkXLGNHpwXE/gqzqFRcEdwclOjktUODtm8XSrdhOra5/A
	B7NGjUfpURyuQG56+4gHjaiTW/0QgfiuVb1B/CAat/WPSHupjaQE+NEb48+ubAogZzRYuS2gZ4O0g
	k1bE6H/dYBU2sJRzTMS+d6aSQqLNyOt8aUcyugokBLuRCrLSQXKEvUQ8nGNaRt/BphmgSJNm+sspj
	OoDilJhg==;
Received: from mail-pg1-f197.google.com ([209.85.215.197])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6D-00000003ZNk-0qLr
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:35 +0000
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so3473300a12.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633846; x=1794238646; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5Sj6s4WCpHUP3cSZIKUa0LCg/XSbNt4xz/AARSS1Lk=;
        b=RjMJaNbLB/lQ7VWlwc+BEzdXwE95nnMFo1zOXzyyBlzpQFt8ffAj3NFiO8jdGPToUl
         v3A07ewdqiJGxINMGu6A4TpQLYIELy3vqhtMWThQHa+l42mCPawk27fAAGhYL8LCnPVh
         2MZXZAoId1eAQy2E6yjHnV1f54hXAJM2ovqli2fJPqm+Kfq4aNT0nIUPhDBbus4eQ7B/
         J3+7IjaF6VPbAeLOVFpNdb5jVHCCJoWq7UgOTWCYnmh7Slmja6rRwcujhUfBfuIFyDVF
         mtTjwO9b4QfkRzasidmLt1g2FX5M8hPhW6tJJTttZqIyPuC9NrPdl2bi88guUeEgAY9S
         KiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633846; x=1794238646;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5Sj6s4WCpHUP3cSZIKUa0LCg/XSbNt4xz/AARSS1Lk=;
        b=ke//X/GQ4v6dsswcRQVCA2+m75fjeBVINdF+vzkf3OEr2Gkx+Wprvf1eTDZ7I2jKdn
         hrDB3RNfRW8asQhpY4AQzUAKYEeCv1blmIH3R5ZlSKoIwrIWg/x1KbPEkgZ2cxiIwA5S
         Y8SXi55/iJRPa7cjKlXJfeXwu6osgUbaFtl1row5ijXmbW/S/e2gR1ilefxodUkTAfhu
         nm//8WvbViyv+7UQkRueLv9NmfauR46m8HPpsGiYc4tRlZYHJ2ytYQnPbQzqrH6ovSxV
         iuW/AHHcmJ0KHC8RIivudULR4lSn0bRD511KZToTqXQJGqiHn4oqNnfCY2RAC7Y+i3+G
         N2Pw==
X-Gm-Message-State: AFq9FYIZzdWALEuoc+JoDqz8MsIeU4X9WPXrLfRzoKgqbP4NA3P9XUCT
	OLLGVA3kbXd6yqsgWsG/mG5OiRohvneKGs4qpEfMYXQCCuj3M4VPsixzr6FHl95ZbTvgQnHk4yX
	Cwh2vkxrtc9/Qy+TaGs08xk2VkQikZ5syQDnEdtc75WlukxtC9prcKoN/bIE0KeHY93BEIXjle4
	MHBe3KDFQLXeTeHJwhw8xotYQ354I1sOqh1W6H1xLeQbAVOg==
X-Received: from pgy32.prod.google.com ([2002:a63:1860:0:b0:cd6:1e1f:43b])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b58b:b0:3e1:9220:9d10
 with SMTP id adf61e73a8af0-3e928986bcemr8116448637.35.1793633845567; Mon, 02
 Nov 2026 07:37:25 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:53 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-25-vipinsh@google.com>
Subject: [PATCH v6 24/27] vfio: selftests: Test preserving noiommu devices in vfio_pci_liveupdate_uapi_test
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
X-CRM114-CacheID: sfid-20261102_153729_288907_48CEFE7B 
X-CRM114-Status: GOOD (  14.78  )
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

Add the iommufd_noiommu fixture variant to vfio_pci_liveupdate_uapi_test
and detect at startup whether the target device is bound to vfio-pci in
noiommu mode so that variants not matching the device cleanly skip, in
addition to skipping iommufd variants when probing
luo_session_preserve_fd() in FIXTURE_SETUP reports -ENOENT (e.g. on an
SR-IOV VF or when CONFIG_VFIO_PCI_LIVEUPDATE=n).

When the device is in noiommu mode, verify that preserving its bound
VFIO cdev FD succeeds, and add tests verifying that:
- preserving an unbound second cdev FD fails with -ENOENT without
  affecting the bound FD (preserve_unbound_fd_fails),
- preserving a cdev FD that was never bound fails with -ENOENT
  (preserve_never_bound_fails), and
- closing the Live Update session unpreserves the device so that it can
  be preserved again in a new session (preserve_after_unpreserve).

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../vfio/vfio_pci_liveupdate_uapi_test.c      | 103 +++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
index da25ea4e2b1e..46e97caf1f54 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <fcntl.h>
+#include <linux/pci_regs.h>
 #include <libliveupdate.h>
 #include <libvfio.h>
 #include <kselftest_harness.h>
 
 static const char *device_bdf;
+static bool device_is_noiommu;
 
 FIXTURE(vfio_pci_liveupdate_uapi_test) {
 	int luo_fd;
@@ -45,10 +48,19 @@ FIXTURE_VARIANT_ADD(vfio_pci_liveupdate_uapi_test, _iommu_mode) {	\
 }
 
 FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_noiommu);
 #undef FIXTURE_VARIANT_ADD_IOMMU_MODE
 
 FIXTURE_SETUP(vfio_pci_liveupdate_uapi_test)
 {
+	bool variant_is_noiommu;
+
+	variant_is_noiommu = !strcmp(variant->iommu_mode, MODE_IOMMUFD_NOIOMMU);
+	if (variant_is_noiommu != device_is_noiommu)
+		SKIP(return, "%s does not apply to a %s device",
+		     variant->iommu_mode,
+		     device_is_noiommu ? "noiommu" : "non-noiommu");
+
 	self->luo_fd = luo_open_device();
 	ASSERT_GT(self->luo_fd, 0);
 
@@ -77,6 +89,7 @@ FIXTURE_TEARDOWN(vfio_pci_liveupdate_uapi_test)
 
 TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
 {
+	int expected;
 	int ret;
 
 	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
@@ -85,7 +98,84 @@ TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
 	 * Only VFIO cdev files of devices in noiommu mode can be preserved;
 	 * device files obtained through a VFIO group never can.
 	 */
-	ASSERT_EQ(ret, self->iommu->iommufd ? -EOPNOTSUPP : -ENOENT);
+	if (device_is_noiommu)
+		expected = 0;
+	else
+		expected = self->iommu->iommufd ? -EOPNOTSUPP : -ENOENT;
+
+	ASSERT_EQ(ret, expected);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_unbound_fd_fails)
+{
+	const char *cdev_path;
+	int unbound_fd;
+	int ret;
+
+	if (!self->iommu->iommufd)
+		SKIP(return, "Only iommufd modes use VFIO cdev files");
+
+	cdev_path = __vfio_pci_get_cdev_path(device_bdf, device_is_noiommu);
+	ASSERT_NE(cdev_path, NULL);
+
+	unbound_fd = open(cdev_path, O_RDWR);
+	ASSERT_GE(unbound_fd, 0);
+	free((void *)cdev_path);
+
+	/*
+	 * A second cdev FD that has not been bound via VFIO_DEVICE_BIND_IOMMUFD
+	 * must be rejected even while another FD for the same device is bound.
+	 */
+	ret = luo_session_preserve_fd(self->session_fd, unbound_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+	ASSERT_EQ(close(unbound_fd), 0);
+
+	/* Verify the failed attempt had no side effects on the bound FD. */
+	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
+	ASSERT_EQ(ret, device_is_noiommu ? 0 : -EOPNOTSUPP);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_never_bound_fails)
+{
+	const char *cdev_path;
+	int unbound_fd;
+	int ret;
+
+	if (!self->iommu->iommufd)
+		SKIP(return, "Only iommufd modes use VFIO cdev files");
+
+	vfio_pci_device_cleanup(self->device);
+	self->device = NULL;
+
+	cdev_path = __vfio_pci_get_cdev_path(device_bdf, device_is_noiommu);
+	ASSERT_NE(cdev_path, NULL);
+
+	unbound_fd = open(cdev_path, O_RDWR);
+	ASSERT_GE(unbound_fd, 0);
+	free((void *)cdev_path);
+
+	ret = luo_session_preserve_fd(self->session_fd, unbound_fd, 0);
+	ASSERT_EQ(ret, -ENOENT);
+	ASSERT_EQ(close(unbound_fd), 0);
+}
+
+TEST_F(vfio_pci_liveupdate_uapi_test, preserve_after_unpreserve)
+{
+	u16 vendor_id;
+
+	if (!device_is_noiommu)
+		SKIP(return, "Only noiommu devices can be preserved");
+
+	ASSERT_EQ(luo_session_preserve_fd(self->session_fd, self->device->fd, 0), 0);
+
+	ASSERT_EQ(close(self->session_fd), 0);
+	self->session_fd = luo_create_session(self->luo_fd, "session2");
+	ASSERT_GT(self->session_fd, 0);
+
+	ASSERT_EQ(luo_session_preserve_fd(self->session_fd, self->device->fd, 0), 0);
+
+	vendor_id = vfio_pci_config_readw(self->device, PCI_VENDOR_ID);
+	ASSERT_NE(vendor_id, 0xffff);
 }
 
 TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
@@ -112,6 +202,7 @@ TEST_F(vfio_pci_liveupdate_uapi_test, preserve_container_fails)
 
 int main(int argc, char *argv[])
 {
+	const char *cdev_path;
 	int fd;
 
 	fd = luo_open_device();
@@ -122,5 +213,15 @@ int main(int argc, char *argv[])
 	close(fd);
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	cdev_path = __vfio_pci_get_cdev_path(device_bdf, true);
+	if (cdev_path) {
+		device_is_noiommu = true;
+	} else {
+		cdev_path = vfio_pci_get_cdev_path(device_bdf);
+		device_is_noiommu = false;
+	}
+	free((void *)cdev_path);
+
 	return test_harness_run(argc, argv);
 }
-- 
2.56.0.317.g454f8302e1-goog


