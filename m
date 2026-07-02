Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4351C43602
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 17:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmK2zooHqLvAHzbEI5SDeIhxEVgl5YiYD7Pep1MMb4k=; b=cU7vwqXGhbNDjJ9flsdq9nxtr2
	olCjuffxwkdGp7zouby65k+VCiYU/p2xK3Uu7A940+3010e/oQVentZLLjJO+MTXy99jWvKThumzr
	aUHB9JoEvnOft8kufQyX5YNdvMOCYtYlKjZ0+YPzeWCCY8GJP/r5YT81M5/mmO765MoZgEKzzbocb
	2AgF9iMDX1CFLq7P3LwIMSRuKBcDZOwUcgaMqJKUq6tgHSoFJXF3VLn78azZsHwYFZHdelUjMpafy
	2JzR0D8HcVZ0qz+g0cQRC7SBlUuDGDtQiYmsQDiIActzRzs6Wi4l0GPkuLbnNTl1IDCz+ewgga0ZY
	xiYZxX1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLZQ-00000005BDQ-227V;
	Thu, 02 Jul 2026 17:51:28 +0000
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.68.102])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLZK-00000005BBI-3aSs
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 17:51:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783014682; x=1814550682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmK2zooHqLvAHzbEI5SDeIhxEVgl5YiYD7Pep1MMb4k=;
  b=pHyHOJb3mRCEV9/GeGPVYshGc56y5t5gC+7o+pi4wR5enhIV8orFVzyI
   TwpsYjuKxrrjH8GhIpXDD2eo0ICoImtwyCYyrWI0bKSLCi6V7NpeN/YRt
   DRTzinmDsdOoWj3pC4CMwgBuqivSeZRdsJJJYcovLu/IjDKlwmXxtrOAk
   pZiOmxBkzq0OK+aOzVgEbeGnQ9sCAaTXynLROQ0msk9/ZUtvgBZsVN6Ib
   3uO0n5+TJaxQOFAcCTvOOixknAgKm3Cznf74wZjDGnsYzVFJM7I+Gsn1U
   wUW1odhpFCMfiV5GMEHsE3J67/lUuk/7iqJ8ussikvhwozaYbxu0u4hze
   g==;
X-CSE-ConnectionGUID: HKUz4EBzTdic+O93pqepGA==
X-CSE-MsgGUID: DNQoA3ZdT9yO4I8VAgOujg==
X-IronPort-AV: E=Sophos;i="6.25,144,1779148800"; 
   d="scan'208";a="22963757"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 17:51:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:4473]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.112:2525] with esmtp (Farcaster)
 id cd19b220-fdcd-4ca3-8e48-99625866b657; Thu, 2 Jul 2026 17:51:22 +0000 (UTC)
X-Farcaster-Flow-ID: cd19b220-fdcd-4ca3-8e48-99625866b657
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 17:51:21 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 2 Jul 2026
 17:51:19 +0000
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
Subject: [RFC PATCH 06/14] driver core: wire device_ktype populate to walker
Date: Thu, 2 Jul 2026 19:51:06 +0200
Message-ID: <20260702175114.24659-2-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702175114.24659-1-sakacpav@amazon.de>
References: <20260702174033.32116-1-sakacpav@amazon.de>
 <20260702175114.24659-1-sakacpav@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_105123_599849_F1238725 
X-CRM114-Status: GOOD (  15.83  )
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

Wire the kernfs syscall callback shape (kobject *, const char *)
to the device-level walker. Add device_ktype_populate_one() and
device_ktype_populate_all() adapters that dispatch through
device_sysfs_apply() over dev->kobj.ktype->entries (currently
NULL; the migration commit installs driver_core_sysfs_entries[]).

The adapters early-return when dev->p->dead is set so a populate
racing with device_del() is a no-op.

No behaviour change: the table is empty until the migration commit.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: driver-core@lists.linux.dev
Cc: linux-api@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/base/core.c | 50 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index aeb4985eb8838..975b6e0c4dabd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -33,6 +33,7 @@
 #include <linux/swiotlb.h>
 #include <linux/sysfs.h>
 
+
 #include "base.h"
 #include "physical_location.h"
 #include "power/power.h"
@@ -2841,10 +2842,9 @@ device_sysfs_entries_end(const struct device_sysfs_entry *entries)
 	return e;
 }
 
-static __maybe_unused int
-device_sysfs_apply(struct device *dev,
-		  const struct device_sysfs_entry *entries,
-		  enum dev_sysfs_action action, const char *name)
+static int device_sysfs_apply(struct device *dev,
+			     const struct device_sysfs_entry *entries,
+			     enum dev_sysfs_action action, const char *name)
 {
 	const struct device_sysfs_entry *e;
 
@@ -2972,11 +2972,53 @@ int device_set_sysfs_lazy(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_set_sysfs_lazy);
 
+/*
+ * kobj_type populate adapters - thin wrappers from the kobject
+ * callback shape (kobject *, const char *) to the device-level
+ * walker. Both read dev->kobj.ktype->entries (which is currently
+ * NULL until driver_core_sysfs_entries[] is populated below) and
+ * call device_sysfs_apply() with the matching action.
+ *
+ * The walker traverses an empty table today, so these adapters are
+ * no-ops in behavioural terms. They are wired now so that the
+ * ktype plumbing lands as one reviewable unit; subsequent commits
+ * flip rows on without touching dispatch wiring.
+ */
+static int device_ktype_populate_one(struct kobject *kobj, const char *name)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	const struct kobj_type *ktype = dev->kobj.ktype;
+	int ret;
+
+	/* Device is being torn down; do not populate. */
+	if (dev->p->dead)
+		return -ENOENT;
+
+	ret = device_sysfs_apply(dev, ktype ? ktype->entries : NULL,
+				DEV_SYSFS_ADD_ONE, name);
+	return ret;
+}
+
+static void device_ktype_populate_all(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	const struct kobj_type *ktype = dev->kobj.ktype;
+
+	/* Device is being torn down; do not populate. */
+	if (dev->p->dead)
+		return;
+
+	device_sysfs_apply(dev, ktype ? ktype->entries : NULL,
+			  DEV_SYSFS_ADD_ALL, NULL);
+}
+
 static const struct kobj_type device_ktype = {
 	.release	= device_release,
 	.sysfs_ops	= &dev_sysfs_ops,
 	.namespace	= device_namespace,
 	.get_ownership	= device_get_ownership,
+	.populate	= device_ktype_populate_one,
+	.populate_all	= device_ktype_populate_all,
 };
 
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


