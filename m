Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A9606CEF4
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dX2wtwS8;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GoGsSxCf;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yt3w9dOo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DylHlhnLbbJiaHnChZ4MNuIpkseXw4m+y/UR6vnlJ4E=; b=dX2wtwS8j7AfWFJ8N8o3azrfDJ
	WTXez8mmXMJFnbSgWauULbHB8R1PBkKV0QhhYqdWVjw2fBlx3xL98RomE9pY4zNBZneQ2RoIXDE/O
	1PXokjTIfZEdIOaMXF3ENh8x6IFDcvTFjPN18UsjCRIOkmNAraZlmrIdCiYGtyvqL//1RSogrL+uD
	JtZSlc7PmxDezL8m/kteReR/gYLocpqZP7exoibMVoTu3DwhQYm82YOiWVldHkoYca6BtmKe+uPhx
	8FzNE4SdF4k2yUvlUEmxzzO4kh1JzOiYM28tdrzismtpoXUjdwgrgfFoeMY7vI+x/GtX/GSGyTWjm
	rNCpxDtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6W-0000000HAOE-0tHH;
	Mon, 02 Nov 2026 15:37:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6L-0000000HAAJ-1OIg
	for kexec@bombadil.infradead.org;
	Mon, 02 Nov 2026 15:37:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DylHlhnLbbJiaHnChZ4MNuIpkseXw4m+y/UR6vnlJ4E=; b=GoGsSxCf+OJh16kvqtDekbA8lP
	fNi7yHpcLVxJbbXwgU5+QXN0wgwjea2i1YQutCWB4D3pq0DfU6T3GqV3DoIUxtcRa5gtnvKMIr+Ni
	2Avl8DSmZ08FyMPd7QaZt1wr+YWnkUW7jMxQ+P18K2Y2fn/9jue/D4aOTVdYsgehP0alvRjmMa5sk
	YCl8yZ8k54guua9wt51n24dlzKE4ZGIIz/dYxYRhQ59LieDEQFOjxv427PvhdPPNy9TLlGICLdf/U
	Lbfi14j815Wanp0dQ5sBCK+ds25jwmgU8WSvyuWWfPhuOSGLP51c7z8dLSM7lBqKAujYGY95bPZJC
	EWMrO6xw==;
Received: from mail-pj1-x1048.google.com ([2607:f8b0:4864:20::1048])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6E-00000003ZO5-1Mfa
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:36 +0000
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so4308054a91.3
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633847; x=1794238647; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DylHlhnLbbJiaHnChZ4MNuIpkseXw4m+y/UR6vnlJ4E=;
        b=Yt3w9dOoCxs7ngu6hoNq/GlH5h0DT4u2jvPpR0h6jI4ZLRoRqisRbnU/Zd5LNZK8pm
         8fU0VJ3vasZM1WN+ZTReWOIJCG4TBwl70i+Hq7nQ49OYbW+9GABiSD4YXMUk139OJz6X
         MonwE291T6RYiiJalWchcI4J9GIFpRsLel6sGKzTNxCIimnJPPvqQ7YbBOBeJst3OCnZ
         MxR5KZdDVwD/FN3rl3vlq/umGRPpi88En8sKl2o7ktpq9PNLNk9TjVZVGC4bmLreArQi
         BA1T7hsYStArXS/o/enaCbhu4djth8FGJ74oXlTkkdJq1P+AXhUuF1H5MHQ2nwFQzwNn
         Lu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633847; x=1794238647;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DylHlhnLbbJiaHnChZ4MNuIpkseXw4m+y/UR6vnlJ4E=;
        b=KjoXK911wM4qr5oVufqoT6h1f3pN1dHHtuLoGKttjncFcvowHgRHhJhnhTvslMmr4O
         KZvCOPfr3kfql7FO74AgeBtzU5NMfYq+FhFkARXzoj1Lnq5TVn/SKukEzDx0dilJIoEu
         TEJMVMuxoYlhSszzdWD6UrFwSrOZv/0/4n8pZWH1oIh6vlDoMeBRIyG6fM/Ton4vdz4M
         NX6Ss2oWPd7ZiTGdCBqSHHf60U321NSrwWt5da7W0hEQfSIyJrx6aS1IiFAx2d63eCE2
         HVThQVkEtvDopVZHjM3402EqTAI4KqCXf9grhMtCIjDGwNG8gyp1eBV7rs9JIYpo0BR1
         Gm1A==
X-Gm-Message-State: APuU4Z9WIgjz4F9ecKTLcSgLQl6EaaKX4Ru1/9/va+Va+d34jdDnMvV5
	q/Tl1jWFcjoAnUfwumIFIoG5qm2zucwKSGCPha91t0ji5LLekJoVgiFhcIJuZW1NgXi0UOGOY88
	n041rxjQxe1C5DORbpNXiqaegN3G9o0Z+6xnaO7k2ijBZOthwQ88V4N6eiBEIUL7X3KQy0IbasP
	RoBdaqC2sKVOyeT8Iq29MOEp99ZcqUYrNreQBzj+d6IHgoMA==
X-Received: from pjsa21.prod.google.com ([2002:a17:90a:be15:b0:3a8:cbf9:5e52])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b02:b0:3ac:929d:ba5c
 with SMTP id 98e67ed59e1d1-3ae89847b50mr8027654a91.45.1793633846630; Mon, 02
 Nov 2026 07:37:26 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:54 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-26-vipinsh@google.com>
Subject: [PATCH v6 25/27] vfio: selftests: Add vfio_pci_liveupdate_kexec_test
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
X-CRM114-CacheID: sfid-20261102_153730_553003_64CE9123 
X-CRM114-Status: GOOD (  20.11  )
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

Add a selftest to exercise preserving a vfio-pci device in noiommu mode
across a Live Update. For now the test is simple and verifies that the
device file can be preserved, retrieved, and bound to iommufd in the new
kernel. Subsequent commits extend this test to verify that the device
cannot be opened through VFIO during the Live Update and that DMA
continues across it.

This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
manually along with a kexec.

The kernel must be booted with vfio.enable_unsafe_noiommu_mode=1 and the
target device must be bound to vfio-pci in both kernels. In the new
kernel, the preserved device must be bound to vfio-pci without first
being bound to or unbound from any other driver. This can be done during
boot, e.g. with vfio-pci.ids=<vid>:<did> on the kernel command line, or
manually before running stage 2:

 $ echo vfio-pci > /sys/bus/pci/devices/0000:00:04.0/driver_override
 $ echo 0000:00:04.0 > /sys/bus/pci/drivers/vfio-pci/bind

To run this test manually:

 $ ./vfio_pci_liveupdate_kexec_test -s 1 0000:00:04.0

 $ kexec ...   # NOTE: Exact method will be distro-dependent

 $ ./vfio_pci_liveupdate_kexec_test -s 2 0000:00:04.0

Do not unbind the device from vfio-pci after kexec (e.g. by running
setup.sh on a device that is already bound to vfio-pci), as unbinding it
would reset it.

This test is considered passing if all commands exit with 0.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   4 +
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 102 ++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index ece2a3618f2b..7010a243a0b7 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -15,6 +15,10 @@ TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
 TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
 
+# This test must be run manually since it requires the user/automation to
+# perform a kexec during the test.
+TEST_GEN_PROGS_EXTENDED += vfio_pci_liveupdate_kexec_test
+
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
 TEST_FILES += scripts/run.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
new file mode 100644
index 000000000000..4919175c1173
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <fcntl.h>
+#include <libliveupdate.h>
+#include <libvfio.h>
+
+static const char *device_bdf;
+
+static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+static char device_session[LIVEUPDATE_SESSION_NAME_LENGTH];
+
+enum {
+	STATE_TOKEN,
+	DEVICE_TOKEN,
+};
+
+static void check_noiommu(const char *bdf)
+{
+	const char *cdev_path = __vfio_pci_get_cdev_path(bdf, true);
+	int fd;
+
+	if (!cdev_path)
+		ksft_exit_skip("Device %s is not bound to vfio-pci in noiommu mode\n",
+			       bdf);
+
+	fd = open(cdev_path, O_RDWR);
+	if (fd < 0)
+		ksft_exit_skip("open(%s) failed: %s\n", cdev_path,
+			       strerror(errno));
+
+	close(fd);
+	free((void *)cdev_path);
+}
+
+static void before_kexec(int luo_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int ret;
+
+	check_noiommu(device_bdf);
+
+	iommu = iommu_init(MODE_IOMMUFD_NOIOMMU);
+	device = vfio_pci_device_init(device_bdf, iommu);
+
+	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
+
+	session_fd = luo_create_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static void after_kexec(int luo_fd, int state_session_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int device_fd;
+	int stage;
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	VFIO_ASSERT_EQ(stage, 2);
+
+	session_fd = luo_retrieve_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	device_fd = luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);
+	VFIO_ASSERT_GE(device_fd, 0);
+
+	iommu = iommu_init(MODE_IOMMUFD_NOIOMMU);
+
+	/*
+	 * This will invoke various ioctls on device_fd such as
+	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
+	 * that LUO actually handed us back a valid VFIO device
+	 * file and not something else.
+	 */
+	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
+
+	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
+
+	vfio_pci_device_cleanup(device);
+	iommu_cleanup(iommu);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	snprintf_assert(device_session, sizeof(device_session),
+			"vfio-lu-device-%s", device_bdf);
+	snprintf_assert(state_session, sizeof(state_session),
+			"vfio-lu-state-%s", device_bdf);
+
+	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
+}
-- 
2.56.0.317.g454f8302e1-goog


