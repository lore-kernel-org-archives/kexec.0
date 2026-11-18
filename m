Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8C60A2637
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ThXijx1V;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GnGDP4uC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vtujdpaU40al4T5ZdD8VivFKSuVoB9aJ5CGlvJ4l578=; b=ThXijx1VL4J0rR65dfXZM44kLM
	zdbA0wNRqwB8/BT5haa/tP2rDCW7IprF9JmZSI0j9MgNVnMRZM1GRsZA6Jxyv9BVQGRtnK0nr0cL0
	wbsneWleDXIrzW6JORCTyD1SeWmeqDRnXMolJ03eV7ygEw0v3GUBXQHHhaiCojU/eosOHvAcC3k2K
	sIa/K7/MtImSuOPC2mPlPfGKf6SEEqjfja10VhFWb8TKrONh2wg/DUQkkwW1C9ABlXemaVsnLrePB
	/QUOYo4mBe1R/IWbiASVJeAUKvAwPVuDafsU+CGf4j/4kj5FxaRT1CG+rvli6suH38G3o9aZV5/UF
	0UboEeqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHZ-0000000AQMB-3wg6;
	Wed, 18 Nov 2026 22:37:37 +0000
Received: from mail-ot1-x345.google.com ([2607:f8b0:4864:20::345])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHP-0000000AQBv-3xvq
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:30 +0000
Received: by mail-ot1-x345.google.com with SMTP id 46e09a7af769-860e65f42a5so1653567a34.3
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041446; x=1795646246; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtujdpaU40al4T5ZdD8VivFKSuVoB9aJ5CGlvJ4l578=;
        b=GnGDP4uC7ltaWj3K4X92lHlJe9E3SvJYtBbS9uslcAHbIc4dYTuhneR9oWnOD0w3Fj
         ixsK0P7+MqJ3YL7zeKzvrDswTA4n5WUd2zLNX3kcouB/9EGEQ0GzCys6wD0/WASkypzq
         hAMTkfyOj6HPKt4xtRfxr1odYMy9cN6hyXCwHC3uaZE6Bu7g1zx3IpPcSVn1k2DyvFzp
         zruy6iBY82Hbqofbwfo++5/Q80Rn7RGn73TPaz2W3/Z506r5zH7i+IeG2pyO+e0rFNyu
         r3oMIZqj4v1gbnGvy8D2oXJoh4qvENx7iJqGI3FPlxl/jyQB8xjHtHOgNprfrKDETPOn
         K7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041446; x=1795646246;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtujdpaU40al4T5ZdD8VivFKSuVoB9aJ5CGlvJ4l578=;
        b=Nw+pWT461b0uDeZzBKT1WBFo4VXX9SczFetSpqC5BZzELPhbpPYol8bOPDLQIcwjCK
         aQZzvRh5eWSzm0143+EzUhMKIO0+PfK7GgVixlr4QPtneAg6CDUXlr1pKwvuHO0NLe8Y
         iaNnz8Mg8sT/EgE6/YuUJTpKPiTFCT9TrQBJC/eZ5fF3P2V440ZJrjNKadpsf0Z4s0Q5
         SCbYekNBjGZv32+q390rjhScLJ9tsoEzDTPyE3KEJLFuvtDlGtYDJxjDRCecfJDELvx2
         iUig0zpumi4LlYOLoPv/o+LSpabHP/SZV3ukrl1sdZ2ytuNdGchUtCsJHuAZGGnnBukS
         rVtg==
X-Gm-Message-State: APuU4Z9ZP9AS8jBFwnQ759agHsF0r3MvjDRLy5sGMpWS3O502EeaGPwS
	x+qo+LkdR4I1hccYXnDi/+VXsSZy/Vi/S5KeihQwRGRHub9mYg78GU0cOHiVJQlRt85YjTqzVX5
	bZYLNWIftFlmhUrbtYO7iXVGj9Y85uwLrql8E79I/FTbu5inzfIWcJZdBrRSn0gIENmzql6ZeQy
	zLgSsXTmC5IUrrBYIyO3H6bjBqxcyy/rZmrg57jnR8qWTHrjBqii4=
X-Received: from iocre7-n1.prod.google.com ([2002:a05:6602:87c7:10b0:9e8:de6c:a5a3])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1925:b0:55c:888:30ff with SMTP id 5614622812f47-5774240c0a2mr4971244b6e.45.1795041445551;
 Wed, 18 Nov 2026 14:37:25 -0800 (PST)
Date: Wed, 18 Nov 2026 22:37:04 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-14-dmatlack@google.com>
Subject: [PATCH v11 13/13] Documentation: PCI: Add documentation for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
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
X-CRM114-CacheID: sfid-20261118_143728_051501_79E1266A 
X-CRM114-Status: GOOD (  13.11  )
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
X-Spam-Status: No, score=-31.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add Documentation/PCI/liveupdate.rst, which pulls in the kernel-doc from
drivers/pci/liveupdate.c and include/linux/kho/abi/pci.h, and link it
from the PCI index and the Live Update Orchestrator documentation.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/index.rst           |  1 +
 Documentation/PCI/liveupdate.rst      | 35 +++++++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 38 insertions(+)
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
index 000000000000..96b1d7f5df3a
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,35 @@
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
+Internal API
+============
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :internal:
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
index b3c689e633c1..2bce2644eba2 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -74,3 +74,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
diff --git a/MAINTAINERS b/MAINTAINERS
index 6b7c5f3a64d3..1572f6c905aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21554,6 +21554,7 @@ L:	kexec@lists.infradead.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
-- 
2.56.1.703.gf848ed807c-goog


