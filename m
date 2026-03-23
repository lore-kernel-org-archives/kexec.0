Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B8DF532C4
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sR2QH2u4Z2w+nCWLa7H/5qSEeXCYEvILvD5RlzuPkZI=; b=V01OX10sCZlepTBXB8BGxhDR3k
	MjnXCobJjeCOGu/v0NweUs1wNMlveSN3SawE4pv7KB5D4xAzeV3B981SLCmOHvruL7Q/RFZWkDX5F
	EKOszQ/CUaF1yxM4BlqRrMZN2691K8JY3bIapy0A3/bX+kEExSJzHyr0qcY88JWSVKwde5nChiteU
	37JasDgGuPi2zHIAd7rmQtBxWrXaQBu90SDMx2QpiC/36STOKyeCdAG8IUnQ8B/aFvdPyqw8X69xw
	y+CRzqVS5TOgSCT9MRFVgueEvkA0xAiOJqJUKFR0LxEPfAZqHrx7BoMw8LFfXHVdqrXN8hkgAj0+S
	Y7szqb8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pB6-00000000C0N-0fBI;
	Mon, 23 Mar 2026 23:59:24 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pB1-00000000BtS-2M59
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:23 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-359fe4e9ea7so4337662a91.0
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310358; x=1774915158; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sR2QH2u4Z2w+nCWLa7H/5qSEeXCYEvILvD5RlzuPkZI=;
        b=cH2Oax+b4uzNgRY9HXG1vlkbGnKzU4G8jX3Kx1H/o7VsjQpbufenJdVYnoqankK3tq
         4Uc/+P9QQGUE26UdsM0jMUU6b5rkjkpSf8AX3G7/7SmaD3/L07EA/qKmKNG9g7ITsqbh
         ZfGid5J+T5/EV2z8WRTtUngh3DVcCRNbl3SoE1Ca1rb8hxQrr08N7lEqViuusfFGuG+Z
         uYbqIL2/D5ieBq0Br3WbCZ0uUZeY0fzBc9Sh4wdHwWEV+Mih+8g/uzJXZMv3W8M8QTnR
         47fSCGdEpFLfoKyrS0TC9TDkruaNOinGKuWoacEtQBbNDxAaI1J/HI+/D8WPS2Noxr7y
         tZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310358; x=1774915158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sR2QH2u4Z2w+nCWLa7H/5qSEeXCYEvILvD5RlzuPkZI=;
        b=ji+w4FMnd5w1+48YNRFfniEi6MFVfM7k7W8Km2P/WtY84vu+FCx7IVWIE4ZZg5RYqE
         zqJlm8zIcpgGk8VHcl/3qOOf4o/l+hsGRNSrVxgDOwoJWLtx0t0EmGQUiuhahiGnAMf2
         K1pGBghQ0s7CpgLbvkU2HWQWFY+1+WyMCGNyW81q+/lQI4BB9PlcOhGA3fMnH0XysqrE
         3hgEyofpyx/1lsOdyzuFF0t3QCRt8ATIOvyY0e0fXHq5ydM4SxMPEVGOB9FCT7NFqkco
         88LQmMIstsMBtkAhCSITDMHp4x4p9hYo2DhuHXCoCTWehMwfis8gTmvLiaN/ZGPOq0DR
         g97g==
X-Forwarded-Encrypted: i=1; AJvYcCVnZ5crL94AqET+GheDIsbjsCHXJReEyWO4BBzcg7a9M5hdq02SpwWNgMqYGEVC/c/X/W0YBg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxzSBG9lc+43V5stxBPAkEqPIu+Bo+3+3KUx9qrXQTkCTiHo3I3
	Kv32pwzCT2aSDS7B36nELWlNDoJfG8vBS9fA+EgGxO2wrGPJlVGtLMfrS2HQCvlVsANu97e3he8
	6ZevS8phbHoVBSA==
X-Received: from plge5.prod.google.com ([2002:a17:902:cf45:b0:2a3:1bf9:d25])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e84f:b0:2b0:7114:23cf with SMTP id d9443c01a7336-2b0827dbc37mr127246635ad.36.1774310358090;
 Mon, 23 Mar 2026 16:59:18 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:15 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-24-dmatlack@google.com>
Subject: [PATCH v3 23/24] vfio: selftests: Verify that opening VFIO device
 fails during Live Update
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
X-CRM114-CacheID: sfid-20260323_165919_627353_8748DB6C 
X-CRM114-Status: GOOD (  13.57  )
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

Verify that opening a VFIO device through its cdev file and via
VFIO_GROUP_GET_DEVICE_FD both fail with -EBUSY if the device was
preserved across a Live Update. When a device file is preserve across a
Live Update, the file must be retrieved from /dev/liveupdate, not from
VFIO directly.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 15b3e3af91d1..65c48196e44e 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -36,6 +36,42 @@ static void before_kexec(int luo_fd)
 	daemonize_and_wait();
 }
 
+static void check_open_vfio_device_fails(void)
+{
+	const char *cdev_path = vfio_pci_get_cdev_path(device_bdf);
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int ret, i;
+
+	printf("Checking open(%s) fails\n", cdev_path);
+	ret = open(cdev_path, O_RDWR);
+	VFIO_ASSERT_EQ(ret, -1);
+	VFIO_ASSERT_EQ(errno, EBUSY);
+	free((void *)cdev_path);
+
+	for (i = 0; i < nr_iommu_modes; i++) {
+		if (!iommu_modes[i].container_path)
+			continue;
+
+		iommu = iommu_init(iommu_modes[i].name);
+
+		device = vfio_pci_device_alloc(device_bdf, iommu);
+		vfio_pci_group_setup(device);
+		vfio_pci_iommu_setup(device);
+
+		printf("Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, \"%s\") fails (%s)\n",
+		       device_bdf, iommu_modes[i].name);
+
+		ret = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, device->bdf);
+		VFIO_ASSERT_EQ(ret, -1);
+		VFIO_ASSERT_EQ(errno, EBUSY);
+
+		close(device->group_fd);
+		free(device);
+		iommu_cleanup(iommu);
+	}
+}
+
 static void after_kexec(int luo_fd, int state_session_fd)
 {
 	struct vfio_pci_device *device;
@@ -44,6 +80,8 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	int device_fd;
 	int stage;
 
+	check_open_vfio_device_fails();
+
 	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
 	VFIO_ASSERT_EQ(stage, 2);
 
-- 
2.53.0.983.g0bb29b3bc5-goog


