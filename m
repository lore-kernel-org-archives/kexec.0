Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cap8x-0000Ij-BB
 for kexec@lists.infradead.org; Mon, 06 Feb 2017 19:40:09 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v2 05/12] crashdump/m68k: Add print_crashkernel_region_size()
 function
Date: Mon,  6 Feb 2017 13:42:17 -0600
Message-Id: <1486410144-28595-6-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
References: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

From: Daniel Kiper <daniel.kiper@oracle.com>

Provide just print_crashkernel_region_size() stub. This way
we can properly build kexec utility on m68k arch even
if the functionality is not available on it.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/arch/m68k/kexec-m68k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kexec/arch/m68k/kexec-m68k.c b/kexec/arch/m68k/kexec-m68k.c
index 372aa37..0cbf18e 100644
--- a/kexec/arch/m68k/kexec-m68k.c
+++ b/kexec/arch/m68k/kexec-m68k.c
@@ -89,6 +89,11 @@ int is_crashkernel_mem_reserved(void)
 	return 0;
 }
 
+void print_crashkernel_region_size(void)
+{
+	printf("Crashkernel functionality is not available.\n");
+}
+
 unsigned long virt_to_phys(unsigned long addr)
 {
 	return addr + m68k_memoffset;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
