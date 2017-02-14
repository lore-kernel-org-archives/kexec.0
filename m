Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdkMb-0002v5-Po
 for kexec@lists.infradead.org; Tue, 14 Feb 2017 21:10:20 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v4 03/11] crashdump/cris: Add get_crash_kernel_load_range()
 function
Date: Tue, 14 Feb 2017 15:09:15 -0600
Message-Id: <1487106563-722-4-git-send-email-eric.devolder@oracle.com>
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

Provide stub get_crash_kernel_load_range() in support of
print crash kernel region size option.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
---
v4: Incorporated feedback:
    - Changed commit description to make it clear that
      get_crash_kernel_load_range() is a stub
v3: Incorporated feedback:
    - changes for coding convention and formatting
    - restructured to introduce get_crash_kernel_load_range() for each
      architecture, and then a single function in kexec/kexec.c to call
      the per-architecture get_crash_kernel_load_range() and print the
      result.
v2: Incorporated feedback:
    - unsupported architectures, print appropriate message
v1: Posted to kexec-tools mailing list
---
 kexec/arch/cris/kexec-cris.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
index 4ac2f89..3b69709 100644
--- a/kexec/arch/cris/kexec-cris.c
+++ b/kexec/arch/cris/kexec-cris.c
@@ -77,6 +77,12 @@ int is_crashkernel_mem_reserved(void)
 	return 0;
 }
 
+int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
+{
+	/* Crash kernel region size is not exposed by the system */
+	return -1;
+}
+
 unsigned long virt_to_phys(unsigned long addr)
 {
 	return (addr) & 0x7fffffff;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
