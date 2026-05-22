Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF667CD5BB7
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 20:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jD8Dp8WjVDfBtyvW+7yZYOtj2UMzN2TZIRigqz140zs=; b=cTQR/M8vxiVjZu2BK5Bp/04/kD
	aJHJrxqZdgIDxz/7BSDzIVgX1gvRelC9bGrermtlF8nWOPKPWn7hxpBZ9CstY9f4USeuggZy+RpaH
	anXstXRhT1apMrYOhMAhBGbgtIwA9QxmyQ3/wcDgRtWq4F87jM9Li78g5ftVEQTJl4qM9/gOrqKod
	p1uwGOBHzUQigazbPUZtZgEuXukiVc5nTlfpb81OsPq/pXFq8P592gR+ba7GbFLWFLZ0BSfUIRcY2
	4m7s4oD28E3PiOlJKgNRV6EpP0lLopUCr24p+z6yrmd6spgZ6hg7ceHqpMnTrhSX1qsHG65Nq7clz
	EqGt6yMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWQ1-0000000Bs4G-09YH;
	Fri, 22 May 2026 20:24:29 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPw-0000000Bry2-33jX
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 20:24:25 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso4504526b3a.1
        for <kexec@lists.infradead.org>; Fri, 22 May 2026 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481463; x=1780086263; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jD8Dp8WjVDfBtyvW+7yZYOtj2UMzN2TZIRigqz140zs=;
        b=hGZsUgfziiEDikQmL+i0KCPiGRsvjC+qF+BkRZEniBLmxkV7dCrsIl1qq3e5iLAnzc
         9ZjZbsJjSSFx/Qef8grWz0Dfgwb7gZvH7KGcXC7ilGnpBObN0CA4Kyqv/a1j4EhF6T0+
         QfeBvq5JFLIJhvZVBL0lgieIsDu5vKTQgOqQTO9R8cbJN0i394mGxrhzWEXm6S7PRrVg
         kW4+DIEFhdeb6HPdPanzqGA8p5PeThLeLYc+BWyFLpnO0LJZ6VSSaSf5/vbzeOV28OAi
         PWqlYhru9FGZ1mPhjNjMrw/0m/6t48OEIsHTkH07f9AKqKlAucd0tGAMT3cRUfYEDHsC
         UA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481463; x=1780086263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD8Dp8WjVDfBtyvW+7yZYOtj2UMzN2TZIRigqz140zs=;
        b=mcLoA2QBTOH5jmSm0rxYYnSqRe1KpGuIMhhpwOnupmNQB2gh3iQDKUhL9gOXNaJvM7
         nqy4KB65OtGaKuUl7NEDWpIIN8JTrtwsuEifbPuUb70/cy9VXYgEZqAxCLQd1dZdEJH9
         v/oRIh31iVFPyJs3A7+WYK00hyxEQfTguOn63XXiaz0QeTU6aeAkC7Hn6/Vtv1qH00eA
         tLJCJ7pZiWdwxqO4FESx2YYX1FjqdauiUnPokYBd+TpRB6Zy9BotW0WJWSCXGwszd18z
         CUFcLF+RZmVU2iIk1+tkfZ21COyRNA8Yd52WOewoQfO3pN1WOXF4zXNn0NARw00UR4Wr
         puPg==
X-Gm-Message-State: AOJu0YxnWoLhFHjK6HneiuS5T4IvDsFKrofColIRcm8rPW3YrqJmcLkv
	r2MniyTZ6NoH2eatQO06gX779k4hsOBe1889WINfn8rJGt5DMOK5+yR5W+cYNK4+gI3fmpeHOIj
	FCsQZFqeDHiHn7XkzpSDtckcb/Zpse4xdZVrPRlOMyRV5yMaDaSs7RwTh93h2hBHFs70tvHE5+o
	AXjm4MicpsbHYqAKsPP0BB/TtKXwvJQv64plB6ZsdkeIvDTP6SkCA=
X-Received: from pfcs23.prod.google.com ([2002:a05:6a00:6fd7:b0:82f:6a57:a9aa])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c8b:b0:82c:7f08:8826 with SMTP id d2e1a72fcca58-8415f15b50emr4877330b3a.17.1779481462682;
 Fri, 22 May 2026 13:24:22 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:10 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-13-dmatlack@google.com>
Subject: [PATCH v6 12/12] Documentation: PCI: Add documentation for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_132424_813846_82FD2899 
X-CRM114-Status: GOOD (  14.02  )
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

Add documentation files for the PCI subsystem's participation in Live
Update.

These documentation files are generated from the kernel-doc comments
in the PCI Live Update source code. They describe the File-Lifecycle
Bound (FLB) API, the device tracking API, and the specific policies
applied to preserved devices (such as bus number inheritance and bus
mastering preservation).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/index.rst           |  1 +
 Documentation/PCI/liveupdate.rst      | 29 +++++++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 32 insertions(+)
 create mode 100644 Documentation/PCI/liveupdate.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..23fb737ac969 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -20,3 +20,4 @@ PCI Bus Subsystem
    controller/index
    boot-interrupts
    tph
+   liveupdate
diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
new file mode 100644
index 000000000000..eba55f8a92ae
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================
+PCI Support for Live Update
+===========================
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :doc: PCI Live Update
+
+Driver API
+==========
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :export:
+
+Live Update ABI
+===============
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :internal:
+
+See Also
+========
+
+ * :doc:`/core-api/liveupdate`
+ * :doc:`/core-api/kho/index`
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0f3706..d56a7760978a 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -70,3 +70,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e262c0ceb43..6f0b0ebf67cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20536,6 +20536,7 @@ L:	kexec@lists.infradead.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
-- 
2.54.0.746.g67dd491aae-goog


