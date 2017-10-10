Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e1qpU-0005eI-Ls
 for kexec@lists.infradead.org; Tue, 10 Oct 2017 09:28:04 +0000
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 74227AC0132
 for <kexec@lists.infradead.org>; Tue, 10 Oct 2017 18:27:33 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH 1/3] Support symbol __cpu_online_mask
Date: Tue, 10 Oct 2017 18:27:15 +0900
Message-ID: <20171010092717.7392-2-indou.takao@jp.fujitsu.com>
In-Reply-To: <20171010092717.7392-1-indou.takao@jp.fujitsu.com>
References: <20171010092717.7392-1-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com, d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

In the upstream kernel, by commit 5aec01b83 cpu_online_mask was replaced
with macros and new variables __cpu_online_mask was added instead of it.
Sadump uses cpu_online_mask to check the cpu was online or not,
therefore it also need __cpu_online_mask symbol for this in the latest
kernel.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 makedumpfile.c | 9 +++++++--
 makedumpfile.h | 1 +
 sadump_info.c  | 3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 567ac5d..5f2ca7d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1519,8 +1519,13 @@ get_symbol_info(void)
 	SYMBOL_INIT(__per_cpu_load, "__per_cpu_load");
 	SYMBOL_INIT(__per_cpu_offset, "__per_cpu_offset");
 	SYMBOL_INIT(cpu_online_mask, "cpu_online_mask");
-	if (SYMBOL(cpu_online_mask) == NOT_FOUND_SYMBOL)
-		SYMBOL_INIT(cpu_online_mask, "cpu_online_map");
+	SYMBOL_INIT(__cpu_online_mask, "__cpu_online_mask");
+	if (SYMBOL(cpu_online_mask) == NOT_FOUND_SYMBOL) {
+		if (SYMBOL(__cpu_online_mask) == NOT_FOUND_SYMBOL)
+			SYMBOL_INIT(cpu_online_mask, "cpu_online_map");
+		else
+			SYMBOL_INIT(cpu_online_mask, "__cpu_online_mask");
+	}
 	SYMBOL_INIT(kexec_crash_image, "kexec_crash_image");
 	SYMBOL_INIT(node_remap_start_vaddr, "node_remap_start_vaddr");
 	SYMBOL_INIT(node_remap_end_vaddr, "node_remap_end_vaddr");
diff --git a/makedumpfile.h b/makedumpfile.h
index f4ba02d..704a6bc 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1596,6 +1596,7 @@ struct symbol_table {
 	unsigned long long	__per_cpu_offset;
 	unsigned long long	__per_cpu_load;
 	unsigned long long	cpu_online_mask;
+	unsigned long long	__cpu_online_mask;
 	unsigned long long	kexec_crash_image;
 
 	/*
diff --git a/sadump_info.c b/sadump_info.c
index 257f1be..7dd22e7 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -953,7 +953,8 @@ cpu_online_mask_init(void)
 		return FALSE;
 	}
 
-	if (SIZE(cpumask) == NOT_FOUND_STRUCTURE)
+	if ((SIZE(cpumask) == NOT_FOUND_STRUCTURE) ||
+	    (SYMBOL(__cpu_online_mask) != NOT_FOUND_SYMBOL))
 		cpu_online_mask_addr = SYMBOL(cpu_online_mask);
 
 	else {
-- 
2.9.5



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
