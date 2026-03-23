Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE01F532C0
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7UW0RmcLc1SB8VXNrTH33hzd4ZkDSbd/G4mL4V5lhA=; b=E+43DwMZ1La3SArJXn87ChcXcM
	dkP39NGM+WxZ8G2UQnWLxO527qRYQYrfC2yOtLM7u38NtEW0eRH2GesPHbHlfREGVe0yjY+EWlvit
	XLqDtSVJ5cE4DcD4rOnpeOfwQ79OJNPqOomUpH4+MoPMKGnLum7yynmNldpUxJ9AC/3AnCvI9t1xY
	4IWYUQpf6xBWiI/32BrmVv1RL060vrfeS+rs/D8bAdnUzuvM6QTSN8/Fcx5nAMkMdqqNtiqKTokP9
	EtvnH6XIwD5XnP6R4gBM86aFhq9bJm8RT+tWOy5+6qRQxIEkmFNgdX3BKXiXeg6k3FdWXI8LB1/m4
	gfSNu/jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAV-00000000BJY-3PXX;
	Mon, 23 Mar 2026 23:58:47 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAT-00000000BGX-1nHh
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:58:46 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2b061868724so3401125ad.1
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310324; x=1774915124; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7UW0RmcLc1SB8VXNrTH33hzd4ZkDSbd/G4mL4V5lhA=;
        b=SJ6+6+iRADRcL4sgRoSfKkNR40Z+llpDyIL95AzazI8W5X3gdjGjNc7SBHahyYIMCR
         BUrbQUXGsUbThJwLtecVOGLTl0MU5OJ9iGayHisYKg/GzDE7VzeI5OZwGgt9JuXSyPtX
         3sRoeo7kZEQ7zhYQyUpcX/fz3xlPyvvHCkhFHAovSLiweu8wXJ2oijn1fh59bg/Al/UB
         DOzvoS8ZCyPyTiWU73p8elzbyWtySzwtWDuDQtg+lgtbKOq7HIdaeZFL4CX+QnMAt4VP
         6lKkJK6sf7KJmNE5wKLLTrV2eN3AztVZwVxj2tAt8z+PENQ67y/YMsxKFgXQKhY13MLa
         gSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310324; x=1774915124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7UW0RmcLc1SB8VXNrTH33hzd4ZkDSbd/G4mL4V5lhA=;
        b=rdDUEb2igCcnNh3vvJZYWoRiWK4CIGJ/B8O3c6wUjpLw1PGw85S+iB2Aj6/0SHy9Ux
         2niCU5rVs8BTSwe55+oMuq/gg/YM91SY8+2pyvxvhz8trJw8RhWm87zLr4b4xcc7M/n5
         ZAH/qDAXr2RKWUYHbugSQae+j1djouKZg6PklVgSc3JCdxk6s9F1//LZDphsbYPkI+y6
         ELa79Xn1ii/+pS4ojKPWsWojK1UZ2Vov3xQfA22Mz4UjUCBsQsjVO4iEWFfqvZgluiIc
         uaeOl+yJnNkpxxiBKJOHMDgFKv8JCOihldGZZNMMv3pyT5TdKTqDJSqKjfVr96IIlJNA
         ak3w==
X-Forwarded-Encrypted: i=1; AJvYcCVS5pvOgN5njosowuNOvLFdkoJJPrq5v2IXUa5dL1qLaC8ziQtqnJezWbY74Hk/URWQ6w8LZQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwiRWZDeVmjLBn4UJB2FdsJNOZSUmCCLRglYx7uh874QEREg8+Y
	avHPxCRJMpvnEoo7G1cbSnIsJIOZP4I9Rz66A7N7cjOReMueWLY/V3vcDonM1yJAIZ34ryzd5yI
	FpdlG1z6gMBvGuA==
X-Received: from plbjx15.prod.google.com ([2002:a17:903:138f:b0:2b0:5b78:8e47])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e54a:b0:2b0:9183:ce1e with SMTP id d9443c01a7336-2b09183d6ddmr75835585ad.30.1774310324185;
 Mon, 23 Mar 2026 16:58:44 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:56 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-5-dmatlack@google.com>
Subject: [PATCH v3 04/24] PCI: Inherit bus numbers from previous kernel during
 Live Update
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
X-CRM114-CacheID: sfid-20260323_165845_484393_AC316E0F 
X-CRM114-Status: GOOD (  21.42  )
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

Inherit bus numbers from the previous kernel during a Live Update when
one or more PCI devices are being preserved, even if pci=assign-busses
is enabled.

During a Live Update, preserved devices will be allowed to continue
performing memory transactions. Thus the kernel cannot change the fabric
topology, including changing bus numbers, since that would requiring
disabling and flushing any memory transactions first.

So if pci=assign-busses is enabled, ignore it during the Live Update and
inherit all bus numbers assigned by the previous kernel. This will not
break users that rely on pci=assign-busses for their system to function
correctly since the system can be assumed to be in a functional state
already if a Live Update is underway. In other words, pci=assign-busses
would establish a functional topology during the initial cold boot, and
then that topology would remain fixed across any subsequent Live
Updates.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++-
 drivers/pci/liveupdate.c                      |  5 ++-
 drivers/pci/probe.c                           | 35 ++++++++++++++++---
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630644..beff9f3f8e3b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5156,7 +5156,11 @@ Kernel parameters
 				explicitly which ones they are.
 		assign-busses	[X86] Always assign all PCI bus
 				numbers ourselves, overriding
-				whatever the firmware may have done.
+				whatever the firmware may have done. Ignored
+				during a Live Update, where the kernel must
+				inherit the PCI topology (including bus numbers)
+				to avoid interrupting ongoing memory
+				transactions of preserved devices.
 		usepirqmask	[X86] Honor the possible IRQ mask stored
 				in the BIOS $PIR table. This is needed on
 				some systems with broken BIOSes, notably
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index a3dbe06650ff..c1251f4f8438 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -84,7 +84,10 @@
  * Update:
  *
  *  * The PCI Segment, Bus, Device, and Function numbers assigned to the device
- *    are guaranteed to remain the same across Live Update.
+ *    are guaranteed to remain the same across Live Update. Note that this is
+ *    true even if pci=assign-busses is set on the command line. The kernel will
+ *    always inherit bus numbers assigned by the previous kernel during a Live
+ *    Update.
  *
  * This list will be extended in the future as new support is added.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c60222d45659..165056d71e66 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1369,6 +1369,34 @@ bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 	return true;
 }
 
+static bool pci_assign_all_busses(void)
+{
+	if (!pcibios_assign_all_busses())
+		return false;
+
+	/*
+	 * During a Live Update, preserved devices are are allowed to continue
+	 * performing memory transactions. Thus the kernel cannot change the
+	 * fabric topology, including changing bus numbers, since that would
+	 * requiring disabling and flushing any memory transactions first.
+	 *
+	 * So if pci=assign-busses is enabled, ignore it during the Live Update
+	 * and inherit all bus numbers assigned by the previous kernel. This
+	 * will not break users that rely on pci=assign-busses for their system
+	 * to function correctly since the system can be assumed to be in a
+	 * functional state already if a Live Update is underway. In other
+	 * words, pci=assign-busses should be used to establish working bus
+	 * numbers during the initial cold boot, and then that topology would
+	 * then remain fixed across any subsequent Live Updates.
+	 */
+	if (pci_liveupdate_incoming_nr_devices()) {
+		pr_info_once("Ignoring pci=assign-busses and inheriting bus numbers during Live Update\n");
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
  * @bus: Parent bus the bridge is on
@@ -1396,6 +1424,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	const bool assign_all_busses = pci_assign_all_busses();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1448,8 +1477,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && !assign_all_busses && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1491,8 +1519,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (assign_all_busses || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
-- 
2.53.0.983.g0bb29b3bc5-goog


