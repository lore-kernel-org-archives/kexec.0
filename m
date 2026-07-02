Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ECAC43458
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5y+H67ThXEbUdB02JQVhsVtUDnX/kL/u90pAnPi/57A=; b=bz+tmdarUbBCGDfZ3n2eL5yH8M
	17CswlP398eucKoYZE/WDTy7Cdt/c6/6bq6ElOrMDJoKzNAHN0bpMSnoEm7s0fQc/QW9cPA/cpuPE
	97yi1Yg9kFb+8MkLE5Bt9QkItZWeAark3pWT5HHZk2pIygKV0LhEyzHUZaXqYpgw/pekMSltrH6OL
	j8jC6V6QCkeOP7RbvyWBiWfBr+O55JG9UCG7NihB9DP12Nmv4c2EUgeAmH2hNpbxHvzHjV3klUsO4
	qbr41JVsFQcL4L5uryoDkyOmHOFLa2eXoqo6d6aYhwfCg551YAuLMPM/UA1tq7zQJ9LMTg/K4v+OA
	FWpso8sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLPE-000000059vn-1FsY;
	Thu, 02 Jul 2026 17:40:56 +0000
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com ([35.162.73.231])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLP8-000000059sD-0O1C
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 17:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783014050; x=1814550050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5y+H67ThXEbUdB02JQVhsVtUDnX/kL/u90pAnPi/57A=;
  b=Juop/sbokJGnjbGnBDLaaDl7i0xwdsPQimu/DfSZjAPhUhiwtcEK1rhz
   d6uI2ZhTF6celH7Tbr/UqvAkYGZpsVbVYt7WNmhNpjnoU+a2GYJ2PJZfq
   C8g3WgIxnj+i/Q7rjhLH97dEPQmvUNbr1nvzUxGPodeByKTW+xV+CtYn8
   rv3IydZdT1t3LJdGcWvnCJtOMabI9qpZHu6pf76iZFIqgt/Ku9tEHXSab
   si3hMZtt3QNF6wBtdPm8F6EYQ5+WhiUwTi9kTow1cDRYCmxXKnEJEYg0y
   bNzDSlAqg+k+1OXMxyzjzT/oCH9++TlVWdUFzRgNdcAMf73j6BebVwUzg
   g==;
X-CSE-ConnectionGUID: Z3ST562ISvGKPYlXp7BD5Q==
X-CSE-MsgGUID: i8mNv5wBRKGRhF0eq3+5hA==
X-IronPort-AV: E=Sophos;i="6.25,144,1779148800"; 
   d="scan'208";a="22738367"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 17:40:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:21839]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.129:2525] with esmtp (Farcaster)
 id af6c0e5f-4b77-4570-942d-449df8c7a53e; Thu, 2 Jul 2026 17:40:45 +0000 (UTC)
X-Farcaster-Flow-ID: af6c0e5f-4b77-4570-942d-449df8c7a53e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 17:40:45 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 2 Jul 2026
 17:40:43 +0000
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
Subject: [RFC PATCH 03/14] sysfs: introduce sysfs_kf_syscall_ops dispatching to kobj_type
Date: Thu, 2 Jul 2026 19:40:22 +0200
Message-ID: <20260702174033.32116-4-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702174033.32116-1-sakacpav@amazon.de>
References: <20260702174033.32116-1-sakacpav@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_104050_315184_13CACCF7 
X-CRM114-Status: GOOD (  15.71  )
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

Wire the sysfs side of the lazy populate chain.  sysfs_init()
previously passed NULL as syscall_ops to kernfs_create_root();
install sysfs_kf_syscall_ops with populate and populate_all
that dispatch to the owning kobject's kobj_type.

The kernfs lookup path pins the parent's active reference, so
parent->priv is safe to read; sysfs_populate() additionally
pins the dereferenced kobject with kobject_get_unless_zero()
across the sleeping ktype->populate call.  sysfs_populate_all()
does the same for ktype->populate_all on readdir.

Both callbacks refuse dispatch in namespaced directories: the
initial consumers (PCI, VFIO) are namespace-agnostic, and tag
propagation is out of scope.  Transient errors propagate without
negative-dentry caching so the next lookup retries populate.

No behavior change: no kobj_type sets populate/populate_all yet.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 fs/sysfs/mount.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index b199e8ff79b1f..9e0a37b60d6e7 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/kobject.h>
 #include <linux/magic.h>
 #include <linux/mount.h>
 #include <linux/init.h>
@@ -96,11 +97,68 @@ static struct file_system_type sysfs_fs_type = {
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 
+/*
+ * sysfs_populate - dispatch a lookup miss to the owning kobj_type.
+ *
+ * kernfs pins @parent across the call; we pin @kobj while the
+ * (sleepable) ktype->populate callback runs.
+ */
+static int sysfs_populate(struct kernfs_node *parent, const char *name)
+{
+	struct kobject *kobj;
+	const struct kobj_type *ktype;
+	int ret;
+
+	if (kernfs_ns_enabled(parent))
+		return -ENOENT;
+
+	kobj = parent->priv;
+	ktype = kobj ? kobj->ktype : NULL;
+	if (!ktype || !ktype->populate)
+		return -ENOENT;
+
+	if (!kobject_get_unless_zero(kobj))
+		return -ENOENT;
+
+	ret = ktype->populate(kobj, name);
+
+	kobject_put(kobj);
+	return ret;
+}
+
+/* sysfs_populate_all - readdir-time variant; best-effort, retry-safe. */
+static void sysfs_populate_all(struct kernfs_node *parent)
+{
+	struct kobject *kobj;
+	const struct kobj_type *ktype;
+
+	if (kernfs_ns_enabled(parent))
+		return;
+
+	kobj = parent->priv;
+	ktype = kobj ? kobj->ktype : NULL;
+	if (!ktype || !ktype->populate_all)
+		return;
+
+	if (!kobject_get_unless_zero(kobj))
+		return;
+
+	ktype->populate_all(kobj);
+
+	kobject_put(kobj);
+}
+
+static struct kernfs_syscall_ops sysfs_kf_syscall_ops = {
+	.populate	= sysfs_populate,
+	.populate_all	= sysfs_populate_all,
+};
+
 int __init sysfs_init(void)
 {
 	int err;
 
-	sysfs_root = kernfs_create_root(NULL, KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
+	sysfs_root = kernfs_create_root(&sysfs_kf_syscall_ops,
+					KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
 					NULL);
 	if (IS_ERR(sysfs_root))
 		return PTR_ERR(sysfs_root);
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


