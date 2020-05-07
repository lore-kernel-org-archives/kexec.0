Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUer-0000dX-7E
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:22 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 28/43] PKRAM: ensure memblocks with preserved pages init'd for
 numa
Date: Wed,  6 May 2020 17:41:54 -0700
Message-Id: <1588812129-8596-29-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

In order to facilitate fast initialization of page structs for
preserved pages, memblocks with preserved pages must not cross
numa node boundaries and must have a node id assigned to them.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index a5e539052af6..97a7dd0a5b7d 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -21,6 +21,7 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
+#include <asm/numa.h>
 #include "internal.h"
 
 
@@ -242,6 +243,15 @@ void __init pkram_reserve(void)
 		return;
 	}
 
+	/*
+	 * Fix up the reserved memblock list to ensure the
+	 * memblock regions are split along node boundaries
+	 * and have a node ID set.  This will allow the page
+	 * structs for the preserved pages to be initialized
+	 * more efficiently.
+	 */
+	numa_isolate_memblocks();
+
 done:
 	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
 }
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
