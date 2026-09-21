Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00325C982E1
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZIZGRolM7FCO6UO6yMcsvIDaO/72RZY1KyJwAZOdU4=; b=ha+uJbANRbP3mwST8K5C1r/pGB
	/0WO3FE61t14htzZvvSa5z/RG+ATArDhZqiS8rxI/X6P05Vv6oI5pXzU6RDONXzvPWI9ftqA5DtM0
	XIu3ljPEu0iv16kziQtHWKGQUFqMmK7m9sb2CNqFRIL+o0KqEyaVd42F34WeC7kO64nNbvdB8BcBM
	K/xIDefJEXOZAd/mTOUR3PGPnccRVyY2cJ41EdFmbRugq2MGt0XcNoMhouJpMyXSF4e+sYs8ywCvN
	iFIyRXj77A4NOmFXAvrdz4jfbTcosUrQO1s3VVKOzs7jjpGF9HK2wVuh8z9Jug3gbXB7ZkPxOrfbp
	bO9V3Csg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad7-00000001ZVm-2m9W;
	Mon, 21 Sep 2026 09:48:09 +0000
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Zwn-00000001RRN-1GHd;
	Mon, 21 Sep 2026 09:04:30 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VZIZGRolM7FCO6UO6yMcsvIDaO/72RZY1KyJwAZOdU4=;
	b=swlmKcZ4cG/2bdOnxIUkMBXNXy3omsNeGbQIDwff1HvWDlARUorsoyxZCAK//EdS2+2G4ESec
	o0BFV3Vl7vbxgN30Qu1KxnXYPqLm8BCX7wVMkN2NC9zvSlN60p1gEudxr6CEvj9g4E93n8mgBzo
	O82+QYGukKF8XoClAUarmy4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hpH6k2j01z1T4Fq;
	Mon, 21 Sep 2026 16:52:30 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id E2B154057D;
	Mon, 21 Sep 2026 17:04:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:04:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6 12/14] crash: Normalize the kexec_load elfcorehdr at load time
Date: Mon, 21 Sep 2026 17:04:48 +0800
Message-ID: <20260921090450.807575-13-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_020425_681863_C9F8A92D 
X-CRM114-Status: GOOD (  22.74  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 02:47:56 -0700
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

Normalize the elfcorehdr once when the crash image is installed via
crash_hotplug_prepare_elfcorehdr(), while device_hotplug_lock can still
be taken safely, and let the hotplug paths skip CPU events entirely.
Architectures that do not need the rewrite  (e.g. powerpc) treat
KEXEC_CRASH_HP_NONE as a no-op.

The x86 crash hotplug handler now skips CPU hotplug events
unconditionally, so nothing reads image->elfcorehdr_updated anymore.
Drop the field and the code that maintains it.

Slightly tested on x86_64 with kexec_load (--kexec-syscall --hotplug),
it boots successfully into the second kernel.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c |  1 +
 arch/x86/kernel/crash.c    |  5 ++---
 include/linux/crash_core.h |  1 +
 include/linux/kexec.h      |  1 -
 kernel/crash_core.c        | 20 +++++++++++++++++++-
 kernel/kexec.c             |  4 ++++
 kernel/kexec_core.c        |  1 -
 7 files changed, 27 insertions(+), 6 deletions(-)

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
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 72258d813301..f1f218e46db0 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -404,7 +404,6 @@ struct kimage {
 #ifdef CONFIG_CRASH_HOTPLUG
 	int hp_action;
 	int elfcorehdr_index;
-	bool elfcorehdr_updated;
 #endif
 
 #ifdef CONFIG_IMA_KEXEC
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4a990b17b66c..b638ad0e5ba2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -742,7 +742,6 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 
 	/* No longer handling a hotplug event */
 	image->hp_action = KEXEC_CRASH_HP_NONE;
-	image->elfcorehdr_updated = true;
 
 	/* Change back to read-only */
 	arch_kexec_protect_crashkres();
@@ -754,6 +753,25 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
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
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31c8228318a7..c36a5e8b400e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -251,7 +251,6 @@ struct kimage *do_kimage_alloc_init(void)
 #ifdef CONFIG_CRASH_HOTPLUG
 	image->hp_action = KEXEC_CRASH_HP_NONE;
 	image->elfcorehdr_index = -1;
-	image->elfcorehdr_updated = false;
 #endif
 
 	return image;
-- 
2.34.1


