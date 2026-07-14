Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4B9C4450C
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0/6OkiDA7soDeG3nK/kM6W+DTMONIYlLqtJZ7GmGRw=; b=wqvyc7a5SuH+CnA8SqkdIFoiBQ
	wAqNG0j9ynJ724JfJwi0Vusz227agkrjL642UyO39YbZ9gV+6RSifrPj59xO7A6xj6WdK0i7iEbh9
	0X7CulUTHar43VqPOrUNJzV/bsNvGklAeIjyJlvnA/FJTWDsSeeh/3i5120oXts7dbVOKh0dIs2ve
	kWtl7igrSuyQJTXntZfBPYr7gZ5qMki05ZTjo/nX/jspa3mFeT8BRdX0AO0VU2AMhLd9WM4o1BtEz
	1JGdQJdyembhGN/i/mKH/VfQ1G7D2qg10k1xzeLBKckZLVQZTInqE1m/vftdyo0LKOWDMFIgdzAZb
	zdBXknFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer8-0000000CUVb-0YoA;
	Tue, 14 Jul 2026 15:15:34 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer3-0000000CUKx-37zz
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:32 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2cc640dfde3so13337845ad.1
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042128; x=1784646928; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M0/6OkiDA7soDeG3nK/kM6W+DTMONIYlLqtJZ7GmGRw=;
        b=l9zmHpbMaWrCBxVG+l7pV72HFs2hHHZnhy22E5aJh1vPB66zsicKYbE4FfZUonc3BA
         bJ78cyrsS/5ioIcJyME2GTNd4xWSA+qmV+RoUH4M/yOZe4McbABGqjaGNuLz55SkAxED
         JAQBF2Iqs9Fu8UFyNFqO48lkeYSSy2DMO2pOj1AjgK+KVsL4ri0T7VJLudJzV7/oF+Gr
         aIeEPJbHkoWFQuCaTs7z16IO/xTwNr85DpK0zfkX7j3+DrYipIUCOPSvdgkExB2kCILU
         KhLcE/zJUzK9OJYcAKAi1CGYkpCw5xkkFbpRThbzHZZb+X5COca/Jtds7eruu9lddbiK
         AdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042128; x=1784646928;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M0/6OkiDA7soDeG3nK/kM6W+DTMONIYlLqtJZ7GmGRw=;
        b=Dr6FEwPUZpYNeqf87sv1uzEvfKB+A4RtNp+9I1yFzTjblHq2/qKklhQ20jtD4bAbFV
         Cf7u4x8era9mjKvDbgKadSbfjgKgH/WrTh0Twsojtqrmec3Tnog76SM59OJfxnxlpn1I
         GsETmXGHVISq5ySo1Yd2UrSdRKt6Mmr8Ey/03mxvv5/wYPxjuLtjAPBaq6WyYNdaoObC
         on4AhXP1aJYS+gMCIJHnPqeXGJqZuMQKzLI9qa6tIWOkZRyUn5ipeU+JBrWXdzRf8JI1
         DfQmLescnFDlbrBhRuztKmn4I2QW0pQGVBM5WhPNP2I/VuZh5i6GRmku3Qd1cc4mAFZZ
         /zpg==
X-Gm-Message-State: AOJu0Yxxps8m0tlronvq/3nYuGgUr3cxZYxqBjSmv1IDFmw7leTfALaD
	AgldkYyje6UMLf0J5RBRAOTdCpBvM2AqFbUzOxPxEdrYZrvIyMo1feWxjtWpxcVEOFCubZ16xjP
	GFD5/M3m3SsMnrYU52i6n46kYug/rsU1aVi18iBLJdTTXNiKiTF1iVi5rYd7XihEB81u9OGvkFd
	xBTU21oiRvxYuNe1VmNLcWUcf0ksPR4ENPKxkTpr3vcGFxSQ==
X-Received: from plei5.prod.google.com ([2002:a17:902:e485:b0:2cb:d8fb:3da3])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b08:b0:2ca:17a8:cfce
 with SMTP id d9443c01a7336-2ce9f2852b2mr140988325ad.29.1784042127310; Tue, 14
 Jul 2026 08:15:27 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:15:02 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-18-vipinsh@google.com>
Subject: [PATCH v5 17/20] vfio: selftests: Add vfio_pci_liveupdate_kexec_test
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
X-CRM114-CacheID: sfid-20260714_081529_812758_38B7B44C 
X-CRM114-Status: GOOD (  18.66  )
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

Add a selftest to exercise preserving a vfio-pci device across a Live
Update. For now the test is extremely simple and just verifies that the
device file can be preserved and retrieved. In the future this test will
be extended to verify more parts about device preservation as they are
implemented.

This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
manually along with a kexec.

To run this test manually:

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0

 $ kexec ...   # NOTE: Exact method will be distro-dependent

 $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
 $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0

The second call to setup.sh is necessary because preserved devices are
not bound to a driver after Live Update. Such devices must be manually
bound by userspace after Live Update via driver_override.

This test is considered passing if all commands exit with 0.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  4 +
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 89 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 591f1a52c310..a2f0a459e1f4 100644
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
index 000000000000..15b3e3af91d1
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
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
+static void before_kexec(int luo_fd)
+{
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int session_fd;
+	int ret;
+
+	iommu = iommu_init("iommufd");
+	device = vfio_pci_device_init(device_bdf, iommu);
+
+	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
+
+	session_fd = luo_create_session(luo_fd, device_session);
+	VFIO_ASSERT_GE(session_fd, 0);
+
+	printf("Preserving device in session\n");
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
+	printf("Finishing the session before retrieving the device (should fail)\n");
+	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
+
+	printf("Retrieving the device FD from LUO\n");
+	device_fd = luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);
+	VFIO_ASSERT_GE(device_fd, 0);
+
+	printf("Finishing the session before binding to iommufd (should fail)\n");
+	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
+
+	printf("Binding the device to an iommufd and setting it up\n");
+	iommu = iommu_init("iommufd");
+
+	/*
+	 * This will invoke various ioctls on device_fd such as
+	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
+	 * that LUO actually handed us back a valid VFIO device
+	 * file and not something else.
+	 */
+	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
+
+	printf("Finishing the session\n");
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
+	sprintf(device_session, "device-%s", device_bdf);
+	sprintf(state_session, "state-%s", device_bdf);
+
+	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
+}
-- 
2.55.0.795.g602f6c329a-goog


