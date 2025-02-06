Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED480C02194
	for <kexec@archiver.kernel.org>; Thu,  6 Feb 2025 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HRU1eY8lQWE+WdlV3otZw/7J3jFpvj6dJXq20rk8Gjo=; b=ujtWwDuN9JZz5nlt8RkEf03bpE
	5Qyj0DJmRabwB7vU0ea5DHggRRRN+fmDlgC3hNtZoUTGAsrPj4H8KOxq0KxULtgOwuF45cyX4/xaG
	65LWvAbmuofHbGQUAVJYelfTOSoHXl0A8cSDvoUie7OMbP7S9ZNWyghNaFnaA15qwgFSlW3Zska75
	BvNoL2KCgcQoYqTKcPE3KTP26r/Km//2MR5L2+4z3V73G5oTzjSubo/em3U6agKbja1Dn/SJO/yRo
	KZXOHdHhKpKOsExn0Ddx1ZnuTOA6Y1XIwWXQPOaiY5aaldDawWU52WundUzWsL7h24oVOTYayQIwx
	nM2Syq3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tg2IT-00000006UNL-1tQZ;
	Thu, 06 Feb 2025 13:52:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tg1xK-00000006RBl-1kFW;
	Thu, 06 Feb 2025 13:30:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8FC82A4426C;
	Thu,  6 Feb 2025 13:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5DAC4CEE7;
	Thu,  6 Feb 2025 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738848609;
	bh=DoJEW5UPWLB+Obb+G1lnBQtqt27Wrp5AJwpwp06AFOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlLGwm05L5QcpmJWTDfel287vfdneKikF+X9x1PLxloCZkQFYSTdwfZk67H4CbACf
	 SjpGYMrBglL1eCrzUUZK57n5/M23b+qmEwIJqInUyuIAYnn+TmqNQ3nPdRbyYMKuNl
	 ZByOBYnqMEy5lY8CmeFvD9vgr6at+lROV7TfunAKx2CDVXwvh1AKBfFFfGVYMSC8vi
	 EMegz5keLq3kHnLZZhSOtnzyesXeNk71x3PhY+aFp5TEzIu3szzKS+tzHxI8Radxu8
	 EOITqVt3uvy9poaB8XIXos09+EVWO6TlgoFm05ynd9PhrdVKy6VE0uZZJFIrSgxsnl
	 do126iSCoB9zQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v4 13/14] memblock: Add KHO support for reserve_mem
Date: Thu,  6 Feb 2025 15:27:53 +0200
Message-ID: <20250206132754.2596694-14-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206132754.2596694-1-rppt@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_053010_600734_9A9B09AF 
X-CRM114-Status: GOOD (  24.26  )
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

From: Alexander Graf <graf@amazon.com>

Linux has recently gained support for "reserve_mem": A mechanism to
allocate a region of memory early enough in boot that we can cross our
fingers and hope it stays at the same location during most boots, so we
can store for example ftrace buffers into it.

Thanks to KASLR, we can never be really sure that "reserve_mem"
allocations are static across kexec. Let's teach it KHO awareness so
that it serializes its reservations on kexec exit and deserializes them
again on boot, preserving the exact same mapping across kexec.

This is an example user for KHO in the KHO patch set to ensure we have
at least one (not very controversial) user in the tree before extending
KHO's use to more subsystems.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/memblock.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 84df96efca62..fdb08b60efc1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,9 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/kexec_handover.h>
+#include <linux/kexec.h>
+#include <linux/libfdt.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -2423,6 +2426,70 @@ int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *
 }
 EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
 
+static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
+					  phys_addr_t align)
+{
+	const void *fdt = kho_get_fdt();
+	const char *path = "/reserve_mem";
+	int node, child, err;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
+		return false;
+
+	if (!fdt)
+		return false;
+
+	node = fdt_path_offset(fdt, "/reserve_mem");
+	if (node < 0)
+		return false;
+
+	err = fdt_node_check_compatible(fdt, node, "reserve_mem-v1");
+	if (err) {
+		pr_warn("Node '%s' has unknown compatible", path);
+		return false;
+	}
+
+	fdt_for_each_subnode(child, fdt, node) {
+		const struct kho_mem *mem;
+		const char *child_name;
+		int len;
+
+		/* Search for old kernel's reserved_mem with the same name */
+		child_name = fdt_get_name(fdt, child, NULL);
+		if (strcmp(name, child_name))
+			continue;
+
+		err = fdt_node_check_compatible(fdt, child, "reserve_mem_map-v1");
+		if (err) {
+			pr_warn("Node '%s/%s' has unknown compatible", path, name);
+			continue;
+		}
+
+		mem = fdt_getprop(fdt, child, "mem", &len);
+		if (!mem || len != sizeof(*mem))
+			continue;
+
+		if (mem->addr & (align - 1)) {
+			pr_warn("KHO reserved_mem '%s' has wrong alignment (0x%lx, 0x%lx)",
+				name, (long)align, (long)mem->addr);
+			continue;
+		}
+
+		if (mem->size != size) {
+			pr_warn("KHO reserved_mem '%s' has wrong size (0x%lx != 0x%lx)",
+				name, (long)mem->size, (long)size);
+			continue;
+		}
+
+		reserved_mem_add(mem->addr, mem->size, name);
+		pr_info("Revived memory reservation '%s' from KHO", name);
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Parse reserve_mem=nn:align:name
  */
@@ -2478,6 +2545,11 @@ static int __init reserve_mem(char *p)
 	if (reserve_mem_find_by_name(name, &start, &tmp))
 		return -EBUSY;
 
+	/* Pick previous allocations up from KHO if available */
+	if (reserve_mem_kho_revive(name, size, align))
+		return 1;
+
+	/* TODO: Allocation must be outside of scratch region */
 	start = memblock_phys_alloc(size, align);
 	if (!start)
 		return -ENOMEM;
@@ -2488,6 +2560,65 @@ static int __init reserve_mem(char *p)
 }
 __setup("reserve_mem=", reserve_mem);
 
+static int reserve_mem_kho_write_map(void *fdt, struct reserve_mem_table *map)
+{
+	int err = 0;
+	const char compatible[] = "reserve_mem_map-v1";
+	struct kho_mem mem = {
+		.addr = map->start,
+		.size = map->size,
+	};
+
+	err |= fdt_begin_node(fdt, map->name);
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_property(fdt, "mem", &mem, sizeof(mem));
+	err |= fdt_end_node(fdt);
+
+	return err;
+}
+
+static int reserve_mem_kho_notifier(struct notifier_block *self,
+				    unsigned long cmd, void *v)
+{
+	const char compatible[] = "reserve_mem-v1";
+	void *fdt = v;
+	int err = 0;
+	int i;
+
+	switch (cmd) {
+	case KEXEC_KHO_ABORT:
+		return NOTIFY_DONE;
+	case KEXEC_KHO_DUMP:
+		/* Handled below */
+		break;
+	default:
+		return NOTIFY_BAD;
+	}
+
+	if (!reserved_mem_count)
+		return NOTIFY_DONE;
+
+	err |= fdt_begin_node(fdt, "reserve_mem");
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	for (i = 0; i < reserved_mem_count; i++)
+		err |= reserve_mem_kho_write_map(fdt, &reserved_mem_table[i]);
+	err |= fdt_end_node(fdt);
+
+	return err ? NOTIFY_BAD : NOTIFY_DONE;
+}
+
+static struct notifier_block reserve_mem_kho_nb = {
+	.notifier_call = reserve_mem_kho_notifier,
+};
+
+static int __init reserve_mem_init(void)
+{
+	register_kho_notifier(&reserve_mem_kho_nb);
+
+	return 0;
+}
+core_initcall(reserve_mem_init);
+
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
 static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
-- 
2.47.2


