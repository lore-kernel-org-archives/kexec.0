Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B560E40BE
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0dFli+Rb;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NSgMztlK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Vop91WdATuHzNe6oB2d844wTZCMgIxCkWovun1wskQ4=; b=0dFli+RbvRgTDDa1SRkRqYQ+LU
	/2plwwg5ZGzhGyVgLhDVuovIOoGJg0TuVXtxpFePuUVuSOPJNHPYEOS5e4lgTnds/Ni6827KNPcN4
	7pKLR/1dWuLMXgigR5ZkUKYURHOKyhfWtsD25D/UGqfo2QbX/cn5uY2o5p1IUpirGZ1jV4akek/yA
	Qck+uFA9r0Zd9szbYwEyHRpmR31OWYs/mVKDTsPt3oVQrX+NeYjt9/YQXg5DUKwUwqVdgxo56hDYA
	ss0SN1xVL77uDZlffxwyxaV1fQDSdybxJ4nkPwYqsxoTXYwsY6VVqx4RP2+a0vlYgz5+/kf8ebNhf
	SMQTbHiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5s-0000000H9US-0Tna;
	Mon, 02 Nov 2026 15:37:08 +0000
Received: from mail-pj1-x1048.google.com ([2607:f8b0:4864:20::1048])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5n-0000000H9Pf-3lnk
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:05 +0000
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-3ab67ff8ec3so2145450a91.0
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633822; x=1794238622; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vop91WdATuHzNe6oB2d844wTZCMgIxCkWovun1wskQ4=;
        b=NSgMztlKwRXKL/qo+FUMPJvfjVwEVFjo09h/bZ5sdJSU2PuSufhATtAzBZt/zA4Gif
         NfjmkWYycLh77vgo2ftEqtrvD3MpJAnEtot36D1YRI9GqbHD+zCCJsEQZbc+8pP4fFFJ
         PfxLI/7gDkAl5ek4kwOwsFt7CLDg6O2tAwF4D8MeSpR3bBoUcjMQ82DV9d+xMbAfFR+/
         +qReyZohjH9rt0d5AcCYNeIsSiMVWDRuYqe6haszlWGHW63QtG5JW/chUWpH+8n2o+gs
         NyS9T9Vbw0D6mPMJlqzn8A0P05S08wVbCOaDoT0X0XW+XuxkZ0IsYIBe6YFog12sSGkR
         kL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633822; x=1794238622;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vop91WdATuHzNe6oB2d844wTZCMgIxCkWovun1wskQ4=;
        b=LL2B2RlLfYKEWwc8dik6lbtU2i/ck37dWNTzWeBvneRw+NNYbGE9FfhFOVsE3444dw
         uZQOLTeP/SkoOn9zkLo94y+oD9dWEcbInW0eDWLPf91jFrXT8yeXXmIoJX8Eewc7/miF
         p+UdX+K4/sqpmKmj6JgmkUM7v0qKDRGdJGCzBqSQowaMIl31ta1wlo9ViFHXRzKztH/j
         y2JiQIeHGHYFberN1Lt9nl2XnFzoJ9qjPHxo3dWmHdjTIG2hhOPLX2RgmVNwFBOriiQk
         eypvv3SuKLh7g0la2DSSCA/am5b7ZFqzd8QdodS/zqGI1xJMTm9Ndewzbi77YXLW9AXv
         k1ug==
X-Gm-Message-State: APuU4Z9Gnh9cuoFqUf5QeKBZcWVPM0BscuU3VTEP2vRsMgE3UIrAiiMA
	YdkHuuml/UQge96sN1iYFrkJHQnY/Ye/p2LEouZ1Sokidmd7R4n+DAwIc+d/tRfsxU8LRKs0671
	pfVcqCYKZeOVqxYMYDveEt+kyityt9GK9ECrUs5ComKCc+X/8GlS3x5AicnLML4ylcDsKdRr1ht
	BCrtmw5L0nr+YRLaXRvgI9mTX8aFkAbLJGQXtZlVTjh9wrXA==
X-Received: from pgr20.prod.google.com ([2002:a63:1154:0:b0:cd8:c6e9:7c0a])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a4d:b0:3ac:9e5e:d19c
 with SMTP id 98e67ed59e1d1-3ae897ccc1emr8773759a91.17.1793633822052; Mon, 02
 Nov 2026 07:37:02 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:31 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-3-vipinsh@google.com>
Subject: [PATCH v6 02/27] vfio: Export various helpers from VFIO
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
X-CRM114-CacheID: sfid-20261102_073703_973276_5723BD6E 
X-CRM114-Status: GOOD (  14.02  )
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

The upcoming VFIO live update feature needs to access various helper
functions for its logic which are not exported by default.

Export vfio_device_from_file() for other modules to use it, and make
vfio_pci_ops non-static so it can be accessed within the vfio-pci
module. Remove static from their declarations and add them in
include/linux/vfio.h and drivers/vfio/pci/vfio_pci_priv.h header files.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci.c      | 2 +-
 drivers/vfio/pci/vfio_pci_priv.h | 2 ++
 drivers/vfio/vfio_main.c         | 3 ++-
 include/linux/vfio.h             | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..2ec600768007 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -146,7 +146,7 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 	return vfio_pci_core_init_dev(core_vdev);
 }
 
-static const struct vfio_device_ops vfio_pci_ops = {
+const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
 	.init		= vfio_pci_init_dev,
 	.release	= vfio_pci_core_release_dev,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..1634135de3f8 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -11,6 +11,8 @@
 /* Cap maximum number of ioeventfds per device (arbitrary) */
 #define VFIO_PCI_IOEVENTFD_MAX		1000
 
+extern const struct vfio_device_ops vfio_pci_ops;
+
 struct vfio_pci_ioeventfd {
 	struct list_head	next;
 	struct vfio_pci_core_device	*vdev;
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 423ead48aafe..73a5c4f3751c 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1497,7 +1497,7 @@ const struct file_operations vfio_device_fops = {
 #endif
 };
 
-static struct vfio_device *vfio_device_from_file(struct file *file)
+struct vfio_device *vfio_device_from_file(struct file *file)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1505,6 +1505,7 @@ static struct vfio_device *vfio_device_from_file(struct file *file)
 		return NULL;
 	return df->device;
 }
+EXPORT_SYMBOL_GPL(vfio_device_from_file);
 
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 45f08986359e..de3fa6e6bf2a 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -379,6 +379,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+struct vfio_device *vfio_device_from_file(struct file *file);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
-- 
2.56.0.317.g454f8302e1-goog


