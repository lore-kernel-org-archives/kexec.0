Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNZH4-0006ab-UC
 for kexec@lists.infradead.org; Wed, 30 Sep 2020 10:23:51 +0000
From: Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH v3 1/1] kdump: append uts_namespace.name offset to VMCOREINFO
Date: Wed, 30 Sep 2020 12:23:28 +0200
Message-Id: <20200930102328.396488-1-egorenar@linux.ibm.com>
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
To: dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com, lijiang@redhat.com
Cc: keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Egorenkov <egorenar@linux.ibm.com>, ktkhai@virtuozzo.com, ebiederm@xmission.com, akpm@linux-foundation.org, christian.brauner@ubuntu.com

The offset of the field 'init_uts_ns.name' has changed
since commit 9a56493f6942 ("uts: Use generic ns_common::count").

Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain

Make the offset of the field 'uts_namespace.name' available
in VMCOREINFO because tools like 'crash-utility' and
'makedumpfile' must be able to read it from crash dumps.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---

v2 -> v3:
 * Added documentation to vmcoreinfo.rst
 * Use the short form of the commit reference

v1 -> v2:
 * Improved commit message
 * Added link to the discussion of the uts namespace changes

 Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
 kernel/crash_core.c                            | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index e44a6c01f336..3861a25faae1 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -39,6 +39,12 @@ call.
 User-space tools can get the kernel name, host name, kernel release
 number, kernel version, architecture name and OS type from it.
 
+(uts_namespace, name)
+---------------------
+
+Offset of the name's member. Crash Utility and Makedumpfile get
+the start address of the init_uts_ns.name from this.
+
 node_online_map
 ---------------
 
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
