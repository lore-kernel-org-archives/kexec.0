Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0602FC98307
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QWRwGA8IIWGqEmgXFHVo35ysA7ES/LPOJVNWp6AUBps=; b=i7CRHZT4IG3D7WlyxTxyVN+kW5
	3n7qR+OnUpDs5M1fBjJVQfsPZl40TSPyzvmPyxIbiB+hknB2jU7bSNjLb9HSZ6yoOE5vSuV+GAqHD
	Tgo47jmJkG5wrvy9SSn1aCbdI0nTHIfXVCuWJ1JQ5UxXu8NFG5xnhtLQx5mIfX/nGR6sfXnJLe2is
	4vSGZkAa2alkcqx6jzv+0lEVb+C4nO1aDEaJokmjpiTPtFdn8K1fGEAHSusVglToBX+t+LI/+JSjo
	hJnpE0WxnME6wWaYJrjGyfE0oUV1ugoTbbVLeotUHJIQbepFjSm/LPKwGuaMlStNNunSZdnM0l5jL
	okBOw+VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4S-00000000MTz-1E87;
	Sun, 20 Sep 2026 20:23:32 +0000
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VSG-0000000E2N2-1WuY;
	Fri, 18 Sep 2026 10:04:30 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QWRwGA8IIWGqEmgXFHVo35ysA7ES/LPOJVNWp6AUBps=;
	b=zvyDPHtMXrIlKFMijCNSGV93POHhDpPEWLDf6NcDHeY4LQlngXcrut7XT/+zJayfwCPKA+CjB
	rIjWb7CcBTXVBn1eLuOcyP5UPmoRPnG64cslN+lcdwQdBUwDiDN+pGdNJR2HL+wQjqIhN5D0E/5
	lx7RD09w72DQURnUsPZ6Wmk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hmSbS0pcszpSyG;
	Fri, 18 Sep 2026 17:52:36 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 36D4240572;
	Fri, 18 Sep 2026 18:04:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 11/17] crash: Normalize the kexec_load elfcorehdr at load time
Date: Fri, 18 Sep 2026 18:04:36 +0800
Message-ID: <20260918100442.3841135-12-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_030428_778470_7011D1FE 
X-CRM114-Status: GOOD (  20.88  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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

For kexec_load() the kernel does not build the elfcorehdr, so it is only
rewritten by the first crash hotplug event.  CPU hotplug events do not
change the elfcorehdr, but they may run without device_hotplug_lock
(e.g. CPU offlining during suspend), so they cannot perform that rewrite
without racing with memory hotplug.

Normalize the elfcorehdr once when the crash image is installed, while
device_hotplug_lock can still be taken safely, and let the hotplug paths
skip CPU events entirely.

The elfcorehdr segment is located by scanning the segments for the ELF
magic.  Factor that scan out into crash_find_elfcorehdr() and reuse it
from crash_handle_hotplug_event().  Architectures that do not need the
rewrite (e.g. powerpc) treat KEXEC_CRASH_HP_NONE as a no-op.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c |  1 +
 arch/x86/kernel/crash.c    |  5 ++--
 include/linux/crash_core.h |  1 +
 kernel/crash_core.c        | 58 +++++++++++++++++++++++++++-----------
 kernel/kexec.c             |  4 +++
 5 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index 775895f31037..8ede33740fc0 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -638,6 +638,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	struct memory_notify *mn;
 
 	switch (image->hp_action) {
+	case KEXEC_CRASH_HP_NONE:
 	case KEXEC_CRASH_HP_REMOVE_CPU:
 		return;
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 3c9f4fbbe7ff..f34fa8dba028 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -457,9 +457,8 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	 * possible CPUs, there is no need to update the elfcorehdr
 	 * for additional CPU changes.
 	 */
-	if ((image->file_mode || image->elfcorehdr_updated) &&
-		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
-		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+	if (image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+	    image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
 		return;
 
 	/*
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index b1c816e98143..a740757dff35 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -39,6 +39,7 @@ static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *a
 #endif
 
 int crash_check_hotplug_support(void);
+void crash_hotplug_prepare_elfcorehdr(struct kimage *image);
 
 #ifndef arch_crash_hotplug_support
 static inline int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 406b68d2adfd..47a4579eb97e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -647,6 +647,28 @@ int crash_check_hotplug_support(void)
 	return rc;
 }
 
+static void crash_find_elfcorehdr(struct kimage *image)
+{
+	unsigned char *ptr;
+	unsigned long mem;
+	unsigned int n;
+
+	if (image->elfcorehdr_index >= 0)
+		return;
+
+	for (n = 0; n < image->nr_segments; n++) {
+		mem = image->segment[n].mem;
+		ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+		if (!ptr)
+			continue;
+
+		/* The segment containing elfcorehdr */
+		if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+			image->elfcorehdr_index = (int)n;
+		kunmap_local(ptr);
+	}
+}
+
 /*
  * To accurately reflect hot un/plug changes of CPU and Memory resources
  * (including onling and offlining of those resources), the relevant
@@ -702,22 +724,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	 * is allocated. Find the segment containing the elfcorehdr,
 	 * if not already found.
 	 */
-	if (image->elfcorehdr_index < 0) {
-		unsigned long mem;
-		unsigned char *ptr;
-		unsigned int n;
-
-		for (n = 0; n < image->nr_segments; n++) {
-			mem = image->segment[n].mem;
-			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
-			if (ptr) {
-				/* The segment containing elfcorehdr */
-				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
-					image->elfcorehdr_index = (int)n;
-				kunmap_local(ptr);
-			}
-		}
-	}
+	crash_find_elfcorehdr(image);
 
 	if (image->elfcorehdr_index < 0) {
 		pr_err("unable to locate elfcorehdr segment");
@@ -747,6 +754,25 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	crash_hotplug_unlock();
 }
 
+void crash_hotplug_prepare_elfcorehdr(struct kimage *image)
+{
+	if (!image || !image->hotplug_support || image->file_mode)
+		return;
+
+	crash_find_elfcorehdr(image);
+	if (image->elfcorehdr_index < 0)
+		return;
+
+	/*
+	 * kexec_load() images are not normalized at load, so do it here while
+	 * the lock is still free to take.  hp_action is KEXEC_CRASH_HP_NONE,
+	 * which the arch handler treats as "just rebuild the elfcorehdr".
+	 */
+	lock_device_hotplug();
+	arch_crash_handle_hotplug_event(image, NULL);
+	unlock_device_hotplug();
+}
+
 static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *arg)
 {
 	switch (val) {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 90756dc6339b..ea9ba00bc786 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -166,6 +166,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
+		crash_hotplug_prepare_elfcorehdr(kexec_crash_image);
+#endif
 out:
 #ifdef CONFIG_CRASH_DUMP
 	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
-- 
2.34.1


