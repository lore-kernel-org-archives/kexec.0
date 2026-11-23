Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE26606A687
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dy5cyDMF;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ioUv6tOt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2BPu+oA30t3CvvayfJGBtOo4KEcsTgY7xbV9OZz0KkY=; b=Dy5cyDMFdMIcLHjmupSFBoozls
	+FZpubSGD/YJZceGgbg6JNmZgPh3M7W1DQlVIpexyFitQalkYkbLHg0vMq7ceUYllgDw71ktIAbdq
	U1Vb6l53tR3ZfAdAg3tYxe0QGLnJJi9EpJxH8y3Ny/fvzWnmJxd9eU/xvqRZMYxg4jzhpsjj3nB3/
	o5HSYVe/Zb78I+c095qJBai51glIDKyNgT4is5N62IaaMmDZvd33+I9keh98pOXP8MGz5usNzpV1S
	LrQ43Sc3WjC5RxvXi4D8pjuvwOy6riJVtZsuQCqGF6d5k5DJS1vxVaF1zIbUb5jeVPq2XHHRvGhPu
	wMrq4Pdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZHv-00000004bGS-06so;
	Mon, 23 Nov 2026 19:01:15 +0000
Received: from mail-oi1-x246.google.com ([2607:f8b0:4864:20::246])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZHl-00000004bAw-3nvh
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 19:01:13 +0000
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-57e3f40cc16so423905b6e.3
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 11:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795460463; x=1796065263; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2BPu+oA30t3CvvayfJGBtOo4KEcsTgY7xbV9OZz0KkY=;
        b=ioUv6tOtcMVzmEWuyJG3D/XdMVy+OhOqMduKLrv7kyc2e2Y//Gwwo4SbzXuAx6h+mM
         Kcp4+d9ByvRTOSazNpG2XHcfztscXUh9oC2Aj4NgIwl8mvbBiVUJl69wcePclWVGKsfs
         7s3O/f+Onu+6z4bvHRYiZTBk4zl3rxDvUnLlruQ7lh6dDnzIydDVW1Cb8WPdAYyDL1rn
         qe27TiVVyAHkD6Nm4LqIanlX6BSA40r4rrm35Z2A4wHvVw4v8qq6lnGNlWirCppe3K0M
         NXvHEZL8yKsm1zKd9LjBzS9Bmvt6EhCbJQPqa08tJjhfzcdro8dAqHhjBdCRYnfyeCjm
         dopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460463; x=1796065263;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2BPu+oA30t3CvvayfJGBtOo4KEcsTgY7xbV9OZz0KkY=;
        b=FHreXVze3ehJN/7ggp8OZMBm0huP6LKSxpl04zLY+peAf/RrRuEowrYt02U+lNt/FV
         iyDHIMpAd2VzqEKYaoPlETlRQC2adp+omSjv/183SrM84w6tXynO1xbRVz1rifxWfXFH
         I8pZX3/LveBul6wzdg87Mfx7YG6AfvbSd87We6lX805ij4+58CDOwn7HVlO1KHlIAq++
         pxQdXTDOEgAffhjC0NUZIAOvNe8I/QvXvlE6LUiSZoyoVeMfe0U6qEP2gc3d+sNxdvcs
         TYZW+HMyrphAasQvEZaCwDymapMMFlTH3MKh2ScFk68DEYIyvugXEkNpSMHh6AFxfLK4
         ixZA==
X-Gm-Message-State: APuU4Z9nC61GbJG6wbqbhms1WuO+XrIiZXP3T4gp5y88ez6qa1X4UiJy
	0lnnehKlyBx/h5JKirG9dxELDmYf4e/sNbpcCxzlGRdO7n5q+ZVJQuJK25aMZw5EVcZC/DMKQqG
	0cqrjbKF0BpFlWMJS16y0aYXQGlIcHl/qKEz220fCdIvTMMztBy4N7bwG8xIhYw6vp40eSujLUF
	PJul/oa0OI9SZMqiPBwgwfsyntA9TcMcjZsLYibhmdl2jKVkbViZ4=
X-Received: from iobhj14.prod.google.com ([2002:a05:6602:1d8e:b0:9c7:4d20:1320])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3514:b0:571:a186:d6b9 with SMTP id 5614622812f47-57a0a30a106mr14736384b6e.13.1795460462155;
 Mon, 23 Nov 2026 11:01:02 -0800 (PST)
Date: Mon, 23 Nov 2026 19:00:45 +0000
In-Reply-To: <20261118223704.3286085-12-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-12-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123190045.2166865-4-dmatlack@google.com>
Subject: [PATCH] amend! PCI: liveupdate: Freeze preservation status during shutdown
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Williamson <alex.williamson@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_110105_968558_12FAF7C3 
X-CRM114-Status: GOOD (  13.65  )
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

PCI: liveupdate: Freeze preservation status during shutdown

Freeze a device's outgoing preservation status (preserved or not
preserved) during shutdown for kexec. This enables the PCI core and
drivers to safely make decisions based on the device's preservation
status during shutdown.

The PCI core freezes every device in pci_device_shutdown(), not just
preserved ones, so that no device can be preserved or unpreserved after
its shutdown starts.

Only freeze devices during kexec. Other shutdowns do not depend on the
preservation status, and they do not serialize Live Update sessions
first, so a session can still be torn down after its devices are shut
down. Refusing to unpreserve those devices would make pci_flb_unpreserve()
panic because they were never released.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20261118223704.3286085-12-dmatlack@google.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---

Notes:
    This amend! also replaces the commit message when squashed with
    git rebase --autosquash, to explain why devices are only frozen during
    kexec. The message already includes your Link: and Signed-off-by:
    trailers from lu-pci-preservation.

 drivers/pci/liveupdate.c | 2 +-
 drivers/pci/pci-driver.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 08451452fa54..76e939ea52eb 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -127,7 +127,7 @@
  *    Control Services (ACS).
  *
  * In addition, a device cannot be preserved or unpreserved once the PCI core
- * has started shutting it down (pci_device_shutdown()).
+ * has started shutting it down for kexec (pci_device_shutdown()).
  *
  * Driver Binding
  * ==============
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 08b768b9e905..2748ca22e9cf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -560,7 +560,8 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
-	pci_liveupdate_freeze(pci_dev);
+	if (kexec_in_progress)
+		pci_liveupdate_freeze(pci_dev);
 	pm_runtime_resume(dev);
 
 	if (drv && drv->shutdown)

base-commit: fd54e32f7903199e8acb2762dd2debfffe4501c4
prerequisite-patch-id: ac616bdf67b652da754c7b00a368613d345ae384
prerequisite-patch-id: 9c324eb4a47b659efcf7c0c8bb14acfcbf5d615c
prerequisite-patch-id: a1ec7135c2c0c8f90b12743df9e4620ab2ee2f2a
-- 
2.56.1.809.ga0b61035b5-goog


