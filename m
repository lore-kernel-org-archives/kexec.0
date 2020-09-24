Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLQfG-0006XF-4V
 for kexec@lists.infradead.org; Thu, 24 Sep 2020 12:47:59 +0000
From: Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH v2 1/1] kdump: append uts_namespace.name offset to VMCOREINFO
Date: Thu, 24 Sep 2020 14:46:47 +0200
Message-Id: <20200924124647.300080-1-egorenar@linux.ibm.com>
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
To: dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Egorenkov <egorenar@linux.ibm.com>, ktkhai@virtuozzo.com, ebiederm@xmission.com, akpm@linux-foundation.org, christian.brauner@ubuntu.com

The offset of the field 'init_uts_ns.name' has changed
since

commit 9a56493f6942c0e2df1579986128721da96e00d8
Author: Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Mon Aug 3 13:16:21 2020 +0300

    uts: Use generic ns_common::count

Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain

Make the offset of the field 'uts_namespace.name' available
in VMCOREINFO because tools like 'crash-utility' and
'makedumpfile' must be able to read it from crash dumps.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 106e4500fd53..173fdc261882 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_PAGESIZE(PAGE_SIZE);
 
 	VMCOREINFO_SYMBOL(init_uts_ns);
+	VMCOREINFO_OFFSET(uts_namespace, name);
 	VMCOREINFO_SYMBOL(node_online_map);
 #ifdef CONFIG_MMU
 	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
