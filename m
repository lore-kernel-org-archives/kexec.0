Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A2AF532C3
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gw5NKF4E66vyohb8n/pa3diZrC0/+CJM8Skon/TvWYk=; b=hZjUoLoW1b74z4ztisdghGSEGo
	NwsVy2+mMyxU0DlSxJKnEEZOAdrP0w/Jmp7hf4SKdqFhoosfdx8aBMwxEJO9W9YecFT3cMEoZLVHZ
	oQUQ07GtGIcTiMlszIfH3ZyUhuCfAosx4E/sNLk/2B7KPT5bCVqi+Pm0trTTE64Hnvc6wbQheCOrr
	Q7ks8TfCHXB15S41iiDTNYDf+0gkHucoxFJt8xC2BL0D+jQ23480/6CQ9MUsFcIym9PWr2+LGR/fP
	7jm1glj9GHq27TluoG+zgfKMbdBjG8WU/wv6W2O/H5i3ObFhwaSHnXopQAFmuvhbEghbmBH3pYqHF
	HZ3tlmHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAU-00000000BHc-0uHt;
	Mon, 23 Mar 2026 23:58:46 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAR-00000000BFf-3CUk
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:58:44 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2b056b2f0cfso8989575ad.0
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310323; x=1774915123; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw5NKF4E66vyohb8n/pa3diZrC0/+CJM8Skon/TvWYk=;
        b=BBdz0qitbFRZfH/UNqcHcAO6ZVV4+cUbBag0CMnvyoni2GI+l1hrfkr2iKd0cZYbou
         AkiyWAEfxIuxUdFBfdaSvLet8ho1dHaN0TjGZSMTqu2n15B/Vfs1Ucj/sETs4TdILlYn
         eXNYbDjDijAchJY/AdwttUYJTEqNxqlaresEGF0eIkTnomQdG/k/ct3gDA0yNIhUVJWc
         OIhp/4gBSJfHFw22mpwr0WoEyI/DJjcjKnFRxyEI1zh12n2gChz0EdZmeOjwJ0S39176
         weybm/kzxHalT6zQU0Lw/Dxrwspvk5HpaKU+lNnjxGJPz+irONaw/PMkzl3gNp3HFtBa
         1Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310323; x=1774915123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw5NKF4E66vyohb8n/pa3diZrC0/+CJM8Skon/TvWYk=;
        b=YyBbylftfF03FMD4yTr2eJzOwyJielen93pG9hiYDBJerpFvH2xTOZG9ZtDsEZEHtf
         BDPSwWErL4ujvMFd/Tv1nPpkkpL3nz0xRCsqWnnjBf1zZ7qlebB/clKyhD3VGy57vgkd
         2fcUImLF4jPcWvlBnC53waqlMBSqB+aJCSSKXop/sdbPmQyUmV8k9Y6TcgX+3K4EMqpL
         rabikVsCy+ANRVLgBCvtpWfvU/n/XPNgDPAROWJS0S5AB1wg+/fuaovgfJ8rr2EdzqAu
         qmEewojGhUkgnZpZ1msO+U4K9ZyBlNcZyR9ne3FN0T59PKJ4vTacY4FFNIaGTHj1v1cZ
         Cztg==
X-Forwarded-Encrypted: i=1; AJvYcCXCr/5EiB/hSc12+TB/pC8TcvOLKIM58U6fXkfGwAXYzEv0HETcYNU+FG+ftF/kg7NngGNJVA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5fmC331ThxCsy/DrY8Wac3XyyAq72KpLJ81259SWjww7/twlO
	9UopZcgCctWFVxxtuaiQlGB+ShAozJl85fIvaym/v9D9L0bEdvxm3sqyfugmyryoftgmmfQuIor
	ck1JFQT/bC0TYTQ==
X-Received: from plar5.prod.google.com ([2002:a17:902:c7c5:b0:2b0:5a1f:4fdf])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d507:b0:2b0:5795:9ead with SMTP id d9443c01a7336-2b0825e35e3mr130027435ad.0.1774310322445;
 Mon, 23 Mar 2026 16:58:42 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:55 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-4-dmatlack@google.com>
Subject: [PATCH v3 03/24] PCI: Require Live Update preserved devices are in
 singleton iommu_groups
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
X-CRM114-CacheID: sfid-20260323_165843_803591_F1E5758D 
X-CRM114-Status: GOOD (  17.14  )
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

Require that Live Update preserved devices are in singleton iommu_groups
during preservation (outgoing kernel) and retrieval (incoming kernel).

PCI devices preserved across Live Update will be allowed to perform
memory transactions throughout the Live Update. Thus IOMMU groups for
preserved devices must remain fixed. Since all current use cases for
Live Update are for PCI devices in singleton iommu_groups, require that
as a starting point. This avoids the complexity of needing to enforce
arbitrary iommu_group topologies while still allowing all current use
cases.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index bec7b3500057..a3dbe06650ff 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -75,6 +75,8 @@
  *
  *  * The device must not be a Physical Function (PF).
  *
+ *  * The device must be the only device in its IOMMU group.
+ *
  * Preservation Behavior
  * =====================
  *
@@ -105,6 +107,7 @@
 
 #include <linux/bsearch.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
@@ -222,6 +225,31 @@ static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
 	ser->nr_devices--;
 }
 
+static int count_devices(struct device *dev, void *__nr_devices)
+{
+	(*(int *)__nr_devices)++;
+	return 0;
+}
+
+static int pci_liveupdate_validate_iommu_group(struct pci_dev *dev)
+{
+	struct iommu_group *group;
+	int nr_devices = 0;
+
+	group = iommu_group_get(&dev->dev);
+	if (group) {
+		iommu_group_for_each_dev(group, &nr_devices, count_devices);
+		iommu_group_put(group);
+	}
+
+	if (nr_devices != 1) {
+		pci_warn(dev, "Live Update preserved devices must be in singleton iommu groups!");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int pci_liveupdate_preserve(struct pci_dev *dev)
 {
 	struct pci_dev_ser new = INIT_PCI_DEV_SER(dev);
@@ -232,6 +260,10 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (dev->is_virtfn || dev->is_physfn)
 		return -EINVAL;
 
+	ret = pci_liveupdate_validate_iommu_group(dev);
+	if (ret)
+		return ret;
+
 	guard(mutex)(&pci_flb_outgoing_lock);
 
 	if (dev->liveupdate_outgoing)
@@ -357,7 +389,7 @@ int pci_liveupdate_retrieve(struct pci_dev *dev)
 	if (!dev->liveupdate_incoming)
 		return -EINVAL;
 
-	return 0;
+	return pci_liveupdate_validate_iommu_group(dev);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_retrieve);
 
-- 
2.53.0.983.g0bb29b3bc5-goog


