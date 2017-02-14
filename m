Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdkMc-0002vV-0Q
 for kexec@lists.infradead.org; Tue, 14 Feb 2017 21:10:24 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v4 10/11] crashdump/sh: Add get_crash_kernel_load_range()
 function
Date: Tue, 14 Feb 2017 15:09:22 -0600
Message-Id: <1487106563-722-11-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1487106563-722-1-git-send-email-eric.devolder@oracle.com>
References: <1487106563-722-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com, panand@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

From: Daniel Kiper <daniel.kiper@oracle.com>

Implement get_crash_kernel_load_range() in support of
print crash kernel region size option.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
---
v4: Incorporated feedback:
    - no changes for this arch
v3: Incorporated feedback:
    - changes for coding convention and formatting
    - restructured to introduce get_crash_kernel_load_range() for each
      architecture, and then a single function in kexec/kexec.c to call
      the per-architecture get_crash_kernel_load_range() and print the
      result.
    - print_crashkernel_region_size() changed to get_crash_kernel_load_range()
v2: Incorporated feedback:
    - no changes for this arch
v1: Posted to kexec-tools mailing list
---
 kexec/arch/sh/crashdump-sh.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kexec/arch/sh/crashdump-sh.c b/kexec/arch/sh/crashdump-sh.c
index 9e6af6b..aa25dea 100644
--- a/kexec/arch/sh/crashdump-sh.c
+++ b/kexec/arch/sh/crashdump-sh.c
@@ -178,3 +178,8 @@ int is_crashkernel_mem_reserved(void)
 	return parse_iomem_single("Crash kernel\n", &start, &end) == 0 ?
 	  (start != end) : 0;
 }
+
+int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
+{
+	return parse_iomem_single("Crash kernel\n", start, end);
+}
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
