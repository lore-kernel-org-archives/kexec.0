Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B21CCF6D3B
	for <kexec@archiver.kernel.org>; Wed,  2 Oct 2024 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+43Nqd2SPYTSQidbuvW9UHnAzxLJJpZ0xIlrmF1WtPY=; b=0K8Gcgc0L5NceN
	dfLMEVW1cKnoXDQKlJ6TXFWAoSPpLw2DU0/3JxZ0YU34ZNHGqR+uu1fmUw81uxrBxsr4F8CLvn/vi
	AIV3LSg91RYjTaaAl61MLNwBB8asRbctPDDu5/L6/8hYAnn7+TWezWX4sX7Kcg1xqIeAsaYS07sav
	OL7AMgBxPBiAzBKnnvkvfoNKmLL2VXOzjGdmnRRtIDutm3fbD3eZozHzNQKBBBuNM+0NdUVa6O55C
	6JXdWh7x5uRoN0MHnswFikeBmzgamOViePKvyiJZcNeme3dAvBadHUub7r5Q/W6yDtuddPmINy3+P
	xMMSiOSw7tfnp0lzxopQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1uZ-00000006rck-3zYb;
	Wed, 02 Oct 2024 16:09:11 +0000
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1uV-00000006rWt-1NGj
	for kexec@lists.infradead.org;
	Wed, 02 Oct 2024 16:09:09 +0000
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E548260A23;
	Wed,  2 Oct 2024 19:09:05 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-nRmmw9QO;
	Wed, 02 Oct 2024 19:09:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885345;
	bh=0gXnv/qrKYuE/cS8ZBx3ikqYeKs1eCUWKuL7cMB0Reg=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=QJ6MOGmC2WXQfZHzJZ1VaR1B8rKzNr7QnMVdzqdp+QQv3P0S3FHMiPewEj2rscP08
	 wpInBKldjvUn90+GV+UmlmIIYMJDqh6JpsBqKYkROXaqaEMgJ2zuIgRq06YpaV+5qL
	 OvdxqE3T7r9VwN+6lIu4k91/bcBG6keVqTB4vvQk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	valesini@yandex-team.com,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [RFC PATCH 6/7] kstate, test: add test module for testing kstate subsystem.
Date: Wed,  2 Oct 2024 18:07:21 +0200
Message-ID: <20241002160722.20025-7-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002160722.20025-1-arbn@yandex-team.com>
References: <20241002160722.20025-1-arbn@yandex-team.com>
MIME-Version: 1.0
X-Yandex-Filter: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_090907_570697_40673C25 
X-CRM114-Status: GOOD (  19.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This is simple test and playground useful kstate subsystem development.
It contains some structure with different kind of data which migrated
across kexec to the new kernel using kstate.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h |  1 +
 lib/Makefile           |  2 +
 lib/test_kstate.c      | 89 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 lib/test_kstate.c

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index 855acb339d5d7..2ddbe41a1f171 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -31,6 +31,7 @@ struct kstate_field {
 enum kstate_ids {
 	KSTATE_PAGE_ID,
 	KSTATE_RSVD_MEM_ID,
+	KSTATE_TEST_ID,
 	KSTATE_LAST_ID = -1,
 };
 
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af416..2432e47664c35 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -354,6 +354,8 @@ obj-$(CONFIG_PARMAN) += parman.o
 
 obj-y += group_cpus.o
 
+obj-$(CONFIG_KSTATE) += test_kstate.o
+
 # GCC library routines
 obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
 obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
diff --git a/lib/test_kstate.c b/lib/test_kstate.c
new file mode 100644
index 0000000000000..e95e3110f8949
--- /dev/null
+++ b/lib/test_kstate.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/io.h>
+#include <linux/kstate.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+unsigned long ulong_val;
+struct kstate_test_data {
+	int i;
+	unsigned long *p_ulong;
+	char s[10];
+	struct page *page;
+};
+
+struct kstate_description test_state = {
+	.name = "test",
+	.version_id = 1,
+	.id = KSTATE_TEST_ID,
+	.state_list = LIST_HEAD_INIT(test_state.state_list),
+	.fields = (const struct kstate_field[]) {
+		KSTATE_SIMPLE(i, struct kstate_test_data),
+		KSTATE_SIMPLE(s, struct kstate_test_data),
+		KSTATE_POINTER(p_ulong, struct kstate_test_data),
+		{
+			.name = "page",
+			.flags = KS_CUSTOM,
+			.offset = offsetof(struct kstate_test_data, page),
+			.save = kstate_page_save,
+		},
+		KSTATE_SIMPLE(page, struct kstate_test_data),
+		KSTATE_END_OF_LIST()
+	},
+};
+
+static struct kstate_test_data test_data;
+
+static int init_test_data(void)
+{
+	struct page *page;
+	int i;
+
+	test_data.i = 10;
+	ulong_val = 20;
+	memcpy(test_data.s, "abcdefghk", sizeof(test_data.s));
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	for (i = 0; i < PAGE_SIZE/4; i += 4)
+		*((u32 *)page_address(page) + i) = 0xdeadbeef;
+	test_data.page = page;
+	return 0;
+}
+
+static void validate_test_data(void)
+{
+	int i;
+
+	WARN_ON(test_data.i != 10);
+	WARN_ON(*test_data.p_ulong != 20);
+	WARN_ON(strcmp(test_data.s, "abcdefghk") != 0);
+
+	for (i = 0; i < PAGE_SIZE/4; i += 4) {
+		u32 val = *((u32 *)page_address(test_data.page) + i);
+
+		WARN_ON(val != 0xdeadbeef);
+	}
+}
+
+static int __init test_kstate_init(void)
+{
+	int ret = 0;
+
+	test_data.p_ulong = &ulong_val;
+
+	if (!is_migrate_kernel()) {
+		ret = init_test_data();
+		if (ret)
+			goto out;
+	}
+
+	kstate_register(&test_state, &test_data);
+
+	validate_test_data();
+
+out:
+	return ret;
+}
+__initcall(test_kstate_init);
-- 
2.45.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
