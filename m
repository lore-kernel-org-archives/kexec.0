Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7112606CEEE
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SiC4glYe;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=PuIyXt09;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O1R/rpCR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nvnsa/W44mPMiR0xmzXgygBXbMEl9kAu534qF23MUJo=; b=SiC4glYeUelKuoMpQHPGh/yBwf
	5qyQ11yzFCntB4Vzwm/nx6a8FmlK/g18cc/3iwu4O9qpd6utdgSNhjx2Vk6eTvRJK/XralJysAC1i
	ruDfsh2k+gt5i+nvHKwZbGz7B/ANzPXFe1/yY3CEy7lqUrO9bkJbD0BKKk6pGi/AnTxC9LreFVHk4
	lqm1fA1FO6veYHMSHCtbtgCSbMzIdyHDA4qvWK1WCWmXzfyonunAESno1I714S2T2mmrXLm+Bn8ro
	UFg0+0BlitErOtwptZaajp//sTbVATi1sxwhnWJwg9liMizc3PXQDONjceGeyknl2Nar3PTkEVdpr
	53W6pWSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6W-0000000HAOU-1S9q;
	Mon, 02 Nov 2026 15:37:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6M-0000000HAB3-26ni
	for kexec@bombadil.infradead.org;
	Mon, 02 Nov 2026 15:37:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nvnsa/W44mPMiR0xmzXgygBXbMEl9kAu534qF23MUJo=; b=PuIyXt09KK81sy3a3Nrp2tSXzE
	nZKe1VaLTaTB6Sk6g93nQGAWvcjSAS0b+bdl1Gfmnny00Ug/YldlW7kS9QgWj7IPMliKWS9xXkYE3
	MNXz873AV9aaDQWa6Grv9l9/xzX8xYEKEGISF4+1D6jQ88AAMznZMuEUajKUzgWmySapSVEdF12/R
	631uo7bO5XDcWkhzsjJFIa2KTCBRwd7MU0jDxYPr0rg+PNdD4+FuDLPOIe5LkX26MHqKy4y/1nVtB
	kFasnyyBvaVl3LaFtVtrgXiTvKxcBXYW+i9qHyVCYTqUyVdkRXMEvqs5rO6tsmWXh2EHvdN/abXNf
	v6bi+ZxQ==;
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6F-00000003ZOm-0Bg0
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:37 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2e954d87b48so48280875ad.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633848; x=1794238648; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvnsa/W44mPMiR0xmzXgygBXbMEl9kAu534qF23MUJo=;
        b=O1R/rpCRzdoSMWsMZxSw53xcbjGgeQOEeZo/sZo+vyObWZik/s9YCnWNFatatIcdiz
         0XvuvDUVIcUt2WjZRbc8XY3yK9cY4rcwBX/rA2C3FxuQ1VACHeCul6Gy341j4PaHIX5f
         LBcFgCAerXzwRLaHXQlXGkKyGsiAIF3zg38gwNFIJOoNVNG6coeTc2MLrQl1bRfLu4XV
         HIvR86Hy/xS22A6laaKuFEUccOxx0zokc5/o4PqTGgp0pDggX3qGdOhq6NvMRUI7R/Lf
         bv6CU4pfvlg17KJbDvmKPeKAda+IMfoqp4+sTPXVOzpaoYIlcBCZ7kYh6Q1Q1fUybVBj
         jf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633848; x=1794238648;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvnsa/W44mPMiR0xmzXgygBXbMEl9kAu534qF23MUJo=;
        b=Sf0h8Dw9LZew/sqKio6mF9hmLc7EYmnvSj665a4W1EmKcnmncv4l3kYO8YZueP/kUk
         51nvTJIhdnsiUSO0A+Gf5VYN1JYMBhbKQUUwd+Q2wvtq8MMpWunvnyyYK3TeK6d04jbq
         ueaNDjLYTjxjrpAvuEXAxX+LvbDUH3Mh6q98dJ+HSaMgV0Oh7tsJCtCh8oV55/YN0Sr/
         xfRj7by53HlSwFWZCZDrMch2SEqRjdV9y/PlQFQ+diOGEKAFOx7iiJExhqWyLVwHbBSM
         ebhAqXEsJEHteNUsRigZSF5UddFCD3n6xB3C1DDXSvqUcpQ6uAE6tRiHFZ1DbXgFI4pS
         2zIQ==
X-Gm-Message-State: APuU4Z+tLqk2F/F3bw0VR4bnFSTcR3StWw/ta4JXIHPSH2aSFxwbDtNr
	FOz5LVHi8tirRksSuSCQqJEKsNcAAI/VSVaI/cgHfG3ueoLjCfZ90JthjPvAzOdFiWrQFIsg3SZ
	o+4qKCSKHslytDMSb/6dA86nQxn2is+Kf7QERSqcblm54QBaEvZtwuDBe492Ohihk9AFH/Av2xu
	ki/5T1Mtu/H9mbMxbEepOeGq7NDH+BnqWHaKEFZop8/fcf6w==
X-Received: from plbkl7.prod.google.com ([2002:a17:903:747:b0:2e9:dea5:138])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db01:b0:2d9:599e:df95
 with SMTP id d9443c01a7336-2eb3640503dmr101937705ad.3.1793633847651; Mon, 02
 Nov 2026 07:37:27 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:55 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-27-vipinsh@google.com>
Subject: [PATCH v6 26/27] vfio: selftests: Verify that opening VFIO device
 fails during Live Update
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
X-CRM114-CacheID: sfid-20261102_153731_226790_E4A95EED 
X-CRM114-Status: GOOD (  10.32  )
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

Verify that opening a VFIO device through its cdev file and via
VFIO_GROUP_GET_DEVICE_FD both fail with -EBUSY if the device was
preserved across a Live Update. When a device file is preserved across a
Live Update, the file must be retrieved from /dev/liveupdate, not from
VFIO directly.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 4919175c1173..9610fe593cf6 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <fcntl.h>
+#include <limits.h>
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
 #include <libliveupdate.h>
 #include <libvfio.h>
 
@@ -56,6 +59,39 @@ static void before_kexec(int luo_fd)
 	daemonize_and_wait();
 }
 
+static void check_open_vfio_device_fails(void)
+{
+	const char *cdev_path = __vfio_pci_get_cdev_path(device_bdf, true);
+	char group_path[PATH_MAX];
+	int group_fd;
+	int group;
+	int ret;
+
+	VFIO_ASSERT_NOT_NULL(cdev_path);
+
+	ret = open(cdev_path, O_RDWR);
+	VFIO_ASSERT_EQ(ret, -1);
+	VFIO_ASSERT_EQ(errno, EBUSY);
+	free((void *)cdev_path);
+
+	if (__sysfs_iommu_group_get(device_bdf, &group))
+		return;
+
+	snprintf_assert(group_path, sizeof(group_path), "/dev/vfio/noiommu-%d",
+			group);
+	group_fd = open(group_path, O_RDWR);
+	if (group_fd < 0) {
+		VFIO_ASSERT_EQ(errno, ENOENT);
+		return;
+	}
+
+	ret = ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, device_bdf);
+	VFIO_ASSERT_EQ(ret, -1);
+	VFIO_ASSERT_EQ(errno, EBUSY);
+
+	VFIO_ASSERT_EQ(close(group_fd), 0);
+}
+
 static void after_kexec(int luo_fd, int state_session_fd)
 {
 	struct vfio_pci_device *device;
@@ -64,6 +100,8 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	int device_fd;
 	int stage;
 
+	check_open_vfio_device_fails();
+
 	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
 	VFIO_ASSERT_EQ(stage, 2);
 
-- 
2.56.0.317.g454f8302e1-goog


