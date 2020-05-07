Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUeM-0008JR-Bh
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:44:33 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 18/43] kexec: PKRAM: avoid clobbering already preserved pages
Date: Wed,  6 May 2020 17:41:44 -0700
Message-Id: <1588812129-8596-19-git-send-email-anthony.yznaga@oracle.com>
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

Ensure destination ranges of the kexec segments do not overlap
with any kernel pages marked to be preserved across kexec.

For kexec_load, return EADDRNOTAVAIL if overlap is detected.

For kexec_file_load, skip ranges containing preserved pages when
seaching for available ranges to use.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/kexec_core.c | 3 +++
 kernel/kexec_file.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0dad1ebe..8c24b546352e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -37,6 +37,7 @@
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
 #include <linux/frame.h>
+#include <linux/pkram.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -176,6 +177,8 @@ int sanity_check_segment_list(struct kimage *image)
 			return -EADDRNOTAVAIL;
 		if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
 			return -EADDRNOTAVAIL;
+		if (pkram_has_preserved_pages(mstart, mend))
+			return -EADDRNOTAVAIL;
 	}
 
 	/* Verify our destination addresses do not overlap.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f57f72237859..7b14e1b1a178 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -498,6 +498,11 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		if (pkram_has_preserved_pages(temp_start, temp_end + 1)) {
+			temp_start = temp_start - PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
