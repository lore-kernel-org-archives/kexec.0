Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3386AC982F2
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zufRRvpwVHCucp4/a8wU/krIeaWea9Chc2jByLlFL4c=; b=zipkBosTXbG59u0J7S/jerFlfx
	RXgKlY9k+tM1/S2vAAHXAqBGr19k5sEmGikkeCSZE8s+H6HPXhc06BbuXTNgk86sHuy1SJciQUm1j
	QPwvJbfnqVIEfB+XLUC1FYAIbMQMKvGyd/3SDXnbA65D6cNAyvZM6MefSaKyNVm6tr/C234dUzHHq
	Yqvm4RebCnK3grHnktmp3FVoC9GihCl3bLWdLhuj1CxLryEUDFj5f4YZ49z9/cKPBJ2ZQwRu5wQll
	zepQsnWJfCl4t9GZ56FVEpWoq8dSnwH99lu0rwlkzQ/iFBMw34NZ3O5jEK1eZqZ/A9p5Ip/j3AEz1
	dQGHBMFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4V-00000000Mf2-2mzL;
	Sun, 20 Sep 2026 20:23:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VSN-0000000E2Sc-227v;
	Fri, 18 Sep 2026 10:04:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=zufRRvpwVHCucp4/a8wU/krIeaWea9Chc2jByLlFL4c=; b=U4xfvJZj/uC0/iLc+ypm6yVeM/
	f+HL2BD15XkE7wvHRZBTEdPcDZJ5iqhXAJCuQxBskKBQI/AK5dypnSpY88ezWg/6UYvQ1UmTdjanO
	B4Y8ju1u7I93FPfWkkPl+cA/Kz84amXtZov6n9IYigGoTBkjHdV8+KhSskfssvi8LuC6+ltcg5I93
	CZ4HuW8G7tK5+lJ2oqKNHVuxsn5BMBZzF7v8zqrF8XspKulw7pdMeQnltnKTK1ZwDMzSDRZV/s0y/
	h09lgIpniPTc/n/tuxpnFevMqfe0xtI4XjVXYol+xGS2rwpRqY5J0IQ7nssfPwHDBGeYbPftBUMMU
	k5kfGVNw==;
Received: from canpmsgout11.his.huawei.com ([113.46.200.226])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7VSJ-00000009tX5-3RgU;
	Fri, 18 Sep 2026 10:04:34 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zufRRvpwVHCucp4/a8wU/krIeaWea9Chc2jByLlFL4c=;
	b=BckyjycAl3ciFIMoUA4aZPGw9VUPen7PpwqZaxbivk06HsP2G2e1o1OYRpVjCGxZ5ScmXWiON
	VLeKRZcC4u9YJAKQArJ+X4FgbKFWIz3sdq8RcX+POy8ZO6Pxq07qezk90rBm7yrQxrk4UOcJCME
	uqEZBVLJJhWv39vUktkr7hk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hmScN3dtKzKm8V;
	Fri, 18 Sep 2026 17:53:24 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 17A674057C;
	Fri, 18 Sep 2026 18:04:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:26 +0800
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
Subject: [PATCH v5 13/17] crash: Assert device_hotplug_lock in crash_get_memory_ranges_nolock()
Date: Fri, 18 Sep 2026 18:04:38 +0800
Message-ID: <20260918100442.3841135-14-ruanjinjie@huawei.com>
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
X-CRM114-CacheID: sfid-20260918_110432_587109_ED6BAF40 
X-CRM114-Status: UNSURE (   9.64  )
X-CRM114-Notice: Please train this message.
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

crash_get_memory_ranges_nolock() walks memblock, which memory hotplug
modifies under device_hotplug_lock.  A caller that does not hold the lock
can race with memblock_double_array() and iterate a freed regions array.

Add device_hotplug_lock_assert_held() and call it at the top of the
function so that such callers are caught by lockdep.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/base/core.c    | 5 +++++
 include/linux/device.h | 1 +
 kernel/crash_core.c    | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a1..c04adc457a96 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2420,6 +2420,11 @@ void unlock_device_hotplug(void)
 	mutex_unlock(&device_hotplug_lock);
 }
 
+void device_hotplug_lock_assert_held(void)
+{
+	lockdep_assert_held(&device_hotplug_lock);
+}
+
 int lock_device_hotplug_sysfs(void)
 {
 	if (mutex_trylock(&device_hotplug_lock))
diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b..9cca8c8bd372 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1261,6 +1261,7 @@ do { \
 void lock_device_hotplug(void);
 void unlock_device_hotplug(void);
 int lock_device_hotplug_sysfs(void);
+void device_hotplug_lock_assert_held(void);
 int device_offline(struct device *dev);
 int device_online(struct device *dev);
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 760ca9822a13..852a5f51d472 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -338,6 +338,13 @@ int crash_get_memory_ranges_nolock(struct crash_mem **mem_ranges)
 	struct crash_mem *cmem;
 	int ret;
 
+	/*
+	 * Callers must serialize against memory hotplug by holding
+	 * device_hotplug_lock, otherwise the memblock iteration below can
+	 * race with memblock_double_array() and read freed memory.
+	 */
+	device_hotplug_lock_assert_held();
+
 	max_nr_ranges = arch_get_system_nr_ranges();
 	if (!max_nr_ranges)
 		return -ENOMEM;
-- 
2.34.1


