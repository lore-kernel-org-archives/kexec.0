Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsVrF-0008RW-B3
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 11:29:22 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [PATCH 2/2] kexec: ARM: add LPAE support
Date: Thu, 5 Jun 2014 19:20:08 +0800
Message-ID: <1401967208-30948-3-git-send-email-sdu.liu@huawei.com>
In-Reply-To: <1401967208-30948-1-git-send-email-sdu.liu@huawei.com>
References: <1401967208-30948-1-git-send-email-sdu.liu@huawei.com>
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
To: horms@verge.net.au
Cc: wangnan0@huawei.com, Liu Hua <sdu.liu@huawei.com>, liusdu@126.com, kexec@lists.infradead.org, genghui@huawei.com, Wei Jitao <weijitao@huawei.com>

For 32-bit ARM systems with CONFIG_ARM_LPAE=y, when kexec utility
loads the crash kernel. 32-bit elf header is not enough if the
physical address exceeds 4G.

This patch checkes whether the largest physical address of the system
exceeds 4G. If so, kexec creates 64-bit elf header.Otherwise it
creates 32-bit elf header.

Signed-off-by: Wei Jitao <weijitao@huawei.com>
Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 kexec/arch/arm/crashdump-arm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 726c1e9..b523e5f 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -20,6 +20,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
+#include <limits.h>
 #include <elf.h>
 #include <errno.h>
 #include <stdio.h>
@@ -335,6 +336,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	unsigned long bufsz;
 	void *buf;
 	int err;
+	int last_ranges;
 
 	/*
 	 * First fetch all the memory (RAM) ranges that we are going to pass to
@@ -354,10 +356,25 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	if (get_kernel_page_offset(info, &elf_info))
 		return -1;
 
-	err = crash_create_elf32_headers(info, &elf_info,
+	last_ranges = usablemem_rgns.size - 1;
+	if (last_ranges < 0)
+		last_ranges = 0;
+
+	if (crash_memory_ranges[last_ranges].end > ULONG_MAX) {
+
+		/* for support LPAE enabled kernel*/
+		elf_info.class = ELFCLASS64;
+
+		err = crash_create_elf64_headers(info, &elf_info,
 					 usablemem_rgns.ranges,
 					 usablemem_rgns.size, &buf, &bufsz,
 					 ELF_CORE_HEADER_ALIGN);
+	} else {
+		err = crash_create_elf32_headers(info, &elf_info,
+					 usablemem_rgns.ranges,
+					 usablemem_rgns.size, &buf, &bufsz,
+					 ELF_CORE_HEADER_ALIGN);
+	}
 	if (err)
 		return err;
 
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
