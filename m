Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61653C43458
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YRpX/gFLnZEEqF0UusNAsTB0VI4hO2m7E7PNpCTesP4=; b=TndtgNFNRhQqPUQK5PK4+mtVnN
	qeICjCn85vvqQkhGxqOlWRB4dzWwff0mBhFrayrIpUEiu/ZU9DAcz3okNzAUB1wZRO9+isv88NPb2
	WYakYwSgFaAcwQgM7VRkkhb2+w5pKaZCc3rJ5gflzhbU7+VMMo/sSrHTNc6/z2KTRjd6hUjiKLbft
	pCwgj2l9QCjJ/KBL8X4ay7FNOa8hXXSjNBxEtVHJu+gTKsSaGLwzjuAq23M7GhM40ixjTaiZJOYAp
	aYUhhyhNDH45/LBxKqjVWeNxipoLhHKoPZ063I1SeDFlS76NQ+5dePa2J1dEr5WrOe6e2CJYf6kX1
	gMotZruA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLbX-00000005BZq-2Woo;
	Thu, 02 Jul 2026 17:53:39 +0000
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.42.203.116])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLbU-00000005BYy-26Na
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 17:53:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783014816; x=1814550816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YRpX/gFLnZEEqF0UusNAsTB0VI4hO2m7E7PNpCTesP4=;
  b=EYAVZfQJqkofcKZrsydxFQRmMWW1v46dDrmuNNp0BlRyo42JhD75tPz6
   HRcN88tXuMBXDmUBPKv1HxitFFJ4R4Mpv/7oEX5HpQF5PWtWArP7ZPIZo
   q4bwXmOYXXVlfl0N1/CCKYz+U8sTRkt1zc9n2k/+d9gxapR+GAuLbLXZ1
   wxPEEo+JajDI0ZORH+STwDGZWDxUOUafMkU5b+5NOoh3/DdOtwrxmcYph
   A7DWy46hmrBQlZn0zySswsOLnJQbD+J0ox/X0RLoH3DYw2QHeTv6RkD6e
   O8IZafCYryZuEDBYYw3GZcl/41IgPKAq0aiCUJN8dzB94zc10VBcoJ59R
   g==;
X-CSE-ConnectionGUID: j4bOgIWfRyi74UZM0kS6RQ==
X-CSE-MsgGUID: 2vZoHb/STCSR9QGYYJjDAw==
X-IronPort-AV: E=Sophos;i="6.25,144,1779148800"; 
   d="scan'208";a="22965770"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 17:53:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:5839]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.18:2525] with esmtp (Farcaster)
 id f5b15eb2-309e-43c4-88e7-579e7a4f8061; Thu, 2 Jul 2026 17:53:35 +0000 (UTC)
X-Farcaster-Flow-ID: f5b15eb2-309e-43c4-88e7-579e7a4f8061
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 17:53:35 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 2 Jul 2026
 17:53:32 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tejun Heo
	<tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, "David
 Matlack" <dmatlack@google.com>, Samiullah Khawaja <skhawaja@google.com>,
	Alexander Graf <graf@amazon.com>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 10/14] PCI/IOV: opt SR-IOV VFs into sysfs_lazy
Date: Thu, 2 Jul 2026 19:51:10 +0200
Message-ID: <20260702175114.24659-6-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702175114.24659-1-sakacpav@amazon.de>
References: <20260702174033.32116-1-sakacpav@amazon.de>
 <20260702175114.24659-1-sakacpav@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_105337_354033_27EC7D35 
X-CRM114-Status: GOOD (  15.06  )
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

First behaviour change in the lazy-sysfs series. Call
device_set_sysfs_lazy() on every SR-IOV Virtual Function before
pci_device_add() so the VF kobj directory is marked KERNFS_LAZY and
attribute files materialise on first userspace access.

Place the opt-in in pci_iov_scan_device() (immediately after
pci_setup_device()), which is the single allocation/cleanup site
for a VF struct (Shay Drory, commit 04d50d953ab4 ("PCI: Fix NULL
dereference in SR-IOV VF creation error path")). Any -ENOMEM from
device_set_sysfs_lazy() rolls back through that one site rather
than leaking the VF struct, the physfn ref, and the bus ref.

Add an early-return guard at the top of pci_create_sysfs_dev_files()
so lazy VFs skip eager resource-file creation; the guard covers
both pci_bus_add and the late pci_sysfs_init iterator.
pci_remove_sysfs_dev_files() stays unguarded - its per-entry remove
callbacks are idempotent.

Marking VFs lazy defers the bulk of each VF's sysfs population to
first access.  The cost avoided is per VF and scales with the number
of VFs, so on hosts that create a large number of VFs it removes a
correspondingly large amount of up-front kernfs node allocation at
probe.  The nodes are deferred, not dropped: reading a VF's
attributes materialises the same tree as before.  Quantified results
are deferred to the cover letter.

No userspace ABI change: all files eventually materialize.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: linux-api@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/iov.c       | 19 +++++++++++++------
 drivers/pci/pci-sysfs.c |  9 +++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ec2fca8209593..5537c3df6f45b 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -328,14 +328,21 @@ static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
 		pci_read_vf_config_common(virtfn);
 
 	rc = pci_setup_device(virtfn);
-	if (rc) {
-		pci_dev_put(dev);
-		pci_bus_put(virtfn->bus);
-		kfree(virtfn);
-		return ERR_PTR(rc);
-	}
+	if (rc)
+		goto err_free;
+
+	/* Single-site -ENOMEM rollback (kfree + pci_dev_put/pci_bus_put). */
+	rc = device_set_sysfs_lazy(&virtfn->dev);
+	if (rc)
+		goto err_free;
 
 	return virtfn;
+
+err_free:
+	pci_dev_put(dev);
+	pci_bus_put(virtfn->bus);
+	kfree(virtfn);
+	return ERR_PTR(rc);
 }
 
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5a779ebaee326..8bf3837204693 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1777,6 +1777,9 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return -EACCES;
 
+	if (device_is_sysfs_lazy(&pdev->dev))
+		return 0;	/* lazy: entries materialize on first access */
+
 	return device_sysfs_apply(&pdev->dev, pci_sysfs_entries,
 				 DEV_SYSFS_ADD_ALL, NULL);
 }
@@ -1790,6 +1793,12 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return;
 
+	/*
+	 * No sysfs_lazy early-return here: populate_one/populate_all may
+	 * have materialized resource files on first access, so the
+	 * per-entry remove() callbacks must run unconditionally.  They
+	 * are idempotent either way.
+	 */
 	device_sysfs_apply(&pdev->dev, pci_sysfs_entries,
 			  DEV_SYSFS_REMOVE_ALL, NULL);
 }
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


