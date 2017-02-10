Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ccJMa-0004i5-P7
 for kexec@lists.infradead.org; Fri, 10 Feb 2017 22:08:30 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v3 10/11] crashdump/sh: Add get_crash_kernel_load_range()
 function
Date: Fri, 10 Feb 2017 16:07:41 -0600
Message-Id: <1486764462-14176-11-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1486764462-14176-1-git-send-email-eric.devolder@oracle.com>
References: <1486764462-14176-1-git-send-email-eric.devolder@oracle.com>
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
