Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06D606B931
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Rj2R7TDI;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nkjbEbYg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KAmKs654GCi6VXGTIXtG/L5qz01wzAI854D1tv9w8Xg=; b=Rj2R7TDIrGaQ0jmGRS/EwPE5F1
	n3FGmSaER4Gq0KI55lBN1y7DOIDuBUTH81u9vjM8MGRjz6zA09YhWehRcCoP5YeYKyDA4KJTV3XJd
	9v9qsbNeCrabxUk/zQPjgOLNd2zMmvjz4T0yyTfcQvPxunQe8kWqI8CO5zArr/ZQEyp84ds1f3LId
	vL/K8ZIDuo4yIYPevh+XXHUeW8zoKu6VN3bvuVGvML9luzoRpxgWmdtWtRe/nWpZjxBxUPGQ5xkRS
	kjQqOkIUCRpmt7snyXLItG2Uq4pYwKHMhNoVW62vVaQI35oRquIwXYJT0VcwGwnG/ktr2zpO3bK/Y
	Gzk6hJ+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNuBZ-0000000HBio-39ta;
	Mon, 02 Nov 2026 15:43:01 +0000
Received: from mail-qt1-x846.google.com ([2607:f8b0:4864:20::846])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNuBX-0000000HBiJ-3ZkH
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:43:01 +0000
Received: by mail-qt1-x846.google.com with SMTP id d75a77b69052e-532f343a55bso55123001cf.3
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793634177; x=1794238977; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAmKs654GCi6VXGTIXtG/L5qz01wzAI854D1tv9w8Xg=;
        b=nkjbEbYg/L4OrXVNI+ZZyyJ7yzS6+k0u9HyOyiPETs5HeJC+u10PsWfCgmeYbEKj0s
         OgyzrOMPkrZgPy3eRqiBXU9cEshZC06oF4vgyre9BacfwTZYro6W1ii/7RfCvnpVe7u4
         RDsom/7DtNHYCHrDxwRwy3XquekxpPxQiTxmoxzIMdQT5fAV5iNjQ3yaTfaBM9g0AscV
         a5a4fixwpXmRO5NaqBnj1sH4I5S9c4wCJdnGSkNLx7Xxea/MrHq447YIFA5JhInMWD70
         Y7lH7a3S+cxax/uTdSwlV39dfUeXRwF9Q+/oJMpVUSharFrN6Qpma7qwC94/xAbCX4D4
         O5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634177; x=1794238977;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KAmKs654GCi6VXGTIXtG/L5qz01wzAI854D1tv9w8Xg=;
        b=lNtAqKQLXjHoq5U8B8bnkbUq1mFi+6AGR/wmuXJdX4wExMXtbcuYruayGFg2mw0sVz
         7RC5zAFPz4p8V/XfeXdsIajxfZXh5T1GG6fnfdTgjocJjKFBr59M9CTsBE7wTQOXvu2E
         DRojf/2XzJmRVPDTJAeFtb04gwS1+hOsWmoa5Q11IvPotiPgarMa4bAlHWhGb2jKcO7J
         V82Qn7jtGVpsPqKHJjAP3FdLE6og5LxoWJCYBZTsQUfJiVBg7hBocH7NDqfadMWtpd4m
         Z5jADmLXNPTUXVub4ZiGEKeSWtoR1+H16M3YpksHGueuqbQJx179qrYGc5sRUkdBMKm4
         Wkzg==
X-Gm-Message-State: APuU4Z9LnH3vh673Y+Tja38/32ucNbXMod+5sEmMgwJVuKTFuhZgIRcz
	5cJf0OIWF0lKsQr7phEYZ05Jpc3NyRO9cXnHdX/b+KX8xd/PyMcJORLbpqo52zcyS1FYKx0JdTP
	+b0cDVjJSHziYF7crxLu/s7iW2Lb96exgZHFatnbE0STNbbCGyNGspe+TMn7LiJBvgOev9fSZfU
	DIjIpObCqNKWGoPpWoBHK89MPQXqCpjRmQUmyQkGszPw0CHQ==
X-Received: from pjqc8.prod.google.com ([2002:a17:90a:a608:b0:3ae:5572:c4d3])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e88:b0:3ac:85be:cd52
 with SMTP id 98e67ed59e1d1-3ae89867829mr8253650a91.59.1793633841328; Mon, 02
 Nov 2026 07:37:21 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:49 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-21-vipinsh@google.com>
Subject: [PATCH v6 20/27] vfio: selftests: Add iommufd noiommu mode
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
X-CRM114-CacheID: sfid-20261102_074259_912724_E65DCB3F 
X-CRM114-Status: GOOD (  20.71  )
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
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an opt-in iommufd_noiommu mode (MODE_IOMMUFD_NOIOMMU) for devices
bound to vfio-pci in noiommu mode. When a device is in noiommu mode, its
VFIO character device is named /dev/vfio/devices/noiommu-vfioX (opening
it requires CAP_SYS_RAWIO), and binding and attaching to an iommufd IOAS
use a software page table.

Add __vfio_pci_get_cdev_path(bdf, noiommu) to look up either the regular
or the noiommu cdev path and return NULL when none is present, and make
vfio_pci_cdev_open() select the cdev based on mode->noiommu.

Because a device in noiommu mode DMAs directly to physical addresses,
tests that program arbitrary or unmapped IOVAs would corrupt memory.
Keep MODE_IOMMUFD_NOIOMMU out of FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES()
so that only noiommu-aware tests opt into it.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          | 17 ++++++++++
 .../lib/include/libvfio/vfio_pci_device.h     |  7 +++++
 tools/testing/selftests/vfio/lib/iommu.c      |  9 +++++-
 .../selftests/vfio/lib/vfio_pci_device.c      | 31 +++++++++++++------
 4 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..e652b8caf5bb 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -13,6 +13,12 @@ struct iommu_mode {
 	const char *name;
 	const char *container_path;
 	unsigned long iommu_type;
+	/*
+	 * For devices bound to vfio-pci in noiommu mode, i.e. not behind an
+	 * IOMMU. Such devices DMA to the addresses programmed into them as
+	 * physical addresses.
+	 */
+	bool noiommu;
 };
 
 extern const char *default_iommu_mode;
@@ -67,6 +73,17 @@ struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
 #define MODE_IOMMUFD_COMPAT_TYPE1V2 "iommufd_compat_type1v2"
 #define MODE_IOMMUFD "iommufd"
 
+/*
+ * iommufd with a device bound to vfio-pci in noiommu mode
+ * (vfio.enable_unsafe_noiommu_mode=1 and CONFIG_IOMMUFD_NOIOMMU), whose cdev
+ * is /dev/vfio/devices/noiommu-vfioX. Opening it requires CAP_SYS_RAWIO.
+ *
+ * Not part of FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(): tests must opt in, since
+ * the device DMAs to IOVAs as physical addresses, and tests that DMA to
+ * arbitrary or unmapped IOVAs would corrupt memory.
+ */
+#define MODE_IOMMUFD_NOIOMMU "iommufd_noiommu"
+
 /*
  * Generator for VFIO selftests fixture variants that replicate across all
  * possible IOMMU modes. Tests must define FIXTURE_VARIANT_ADD_IOMMU_MODE()
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 9a62bfb6b440..bfadeb362723 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -154,6 +154,13 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 		(device_id == vfio_pci_config_readw(device, PCI_DEVICE_ID));
 }
 
+/*
+ * Return the path of the VFIO cdev of @bdf, or NULL if there is none. The cdev
+ * of a device bound to vfio-pci in noiommu mode is named noiommu-vfioX rather
+ * than vfioX, and @noiommu selects which of the two to look for. Free with
+ * free().
+ */
+const char *__vfio_pci_get_cdev_path(const char *bdf, bool noiommu);
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
 void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf);
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..0df49646d016 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -22,7 +22,10 @@
 
 const char *default_iommu_mode = MODE_IOMMUFD;
 
-/* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
+/*
+ * Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(), which
+ * deliberately leaves out the noiommu modes.
+ */
 static const struct iommu_mode iommu_modes[] = {
 	{
 		.name = MODE_VFIO_TYPE1_IOMMU,
@@ -47,6 +50,10 @@ static const struct iommu_mode iommu_modes[] = {
 	{
 		.name = MODE_IOMMUFD,
 	},
+	{
+		.name = MODE_IOMMUFD_NOIOMMU,
+		.noiommu = true,
+	},
 };
 
 static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index af789c859586..b0deef2b0e3f 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -380,35 +380,42 @@ static void vfio_pci_device_setup(struct vfio_pci_device *device)
 		device->msi_eventfds[i] = -1;
 }
 
-const char *vfio_pci_get_cdev_path(const char *bdf)
+const char *__vfio_pci_get_cdev_path(const char *bdf, bool noiommu)
 {
+	const char *prefix = noiommu ? "noiommu-vfio" : "vfio";
 	char dir_path[PATH_MAX];
 	struct dirent *entry;
-	char *cdev_path;
+	char *cdev_path = NULL;
 	DIR *dir;
 
-	cdev_path = calloc_assert(PATH_MAX, 1);
-
 	snprintf_assert(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
 
 	dir = opendir(dir_path);
-	VFIO_ASSERT_NOT_NULL(dir, "Failed to open directory %s\n", dir_path);
+	if (!dir)
+		return NULL;
 
 	while ((entry = readdir(dir)) != NULL) {
-		/* Find the file that starts with "vfio" */
-		if (strncmp("vfio", entry->d_name, 4))
+		if (strncmp(prefix, entry->d_name, strlen(prefix)))
 			continue;
 
+		cdev_path = calloc_assert(PATH_MAX, 1);
 		snprintf_assert(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
 		break;
 	}
 
-	VFIO_ASSERT_NE(cdev_path[0], 0, "Failed to find vfio cdev file.\n");
 	VFIO_ASSERT_EQ(closedir(dir), 0);
 
 	return cdev_path;
 }
 
+const char *vfio_pci_get_cdev_path(const char *bdf)
+{
+	const char *cdev_path = __vfio_pci_get_cdev_path(bdf, false);
+
+	VFIO_ASSERT_NOT_NULL(cdev_path, "Failed to find vfio cdev file for %s\n", bdf);
+	return cdev_path;
+}
+
 int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
 {
 	struct vfio_device_bind_iommufd args = {
@@ -449,10 +456,14 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 
 void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf)
 {
-	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
+	bool noiommu = device->iommu->mode->noiommu;
+	const char *cdev_path = __vfio_pci_get_cdev_path(bdf, noiommu);
+
+	VFIO_ASSERT_NOT_NULL(cdev_path, "Failed to find %svfio cdev file for %s\n",
+			     noiommu ? "noiommu-" : "", bdf);
 
 	device->fd = open(cdev_path, O_RDWR);
-	VFIO_ASSERT_GE(device->fd, 0);
+	VFIO_ASSERT_GE(device->fd, 0, "open(%s) failed\n", cdev_path);
 	free((void *)cdev_path);
 }
 
-- 
2.56.0.317.g454f8302e1-goog


