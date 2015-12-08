Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6QHl-0001cW-QZ
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 21:59:02 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 08/14] crashdump/m68k: Add print_crashkernel_region_size()
 function
Date: Tue,  8 Dec 2015 22:57:41 +0100
Message-Id: <1449611867-15672-9-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
References: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, keir@xen.org, david.vrabel@citrix.com, konrad.wilk@oracle.com

Provide just print_crashkernel_region_size() stub. This way
we can properly build kexec utility on m68k arch even
if the functionality is not available on it.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/m68k/kexec-m68k.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kexec/arch/m68k/kexec-m68k.c b/kexec/arch/m68k/kexec-m68k.c
index 372aa37..a9915a0 100644
--- a/kexec/arch/m68k/kexec-m68k.c
+++ b/kexec/arch/m68k/kexec-m68k.c
@@ -89,6 +89,11 @@ int is_crashkernel_mem_reserved(void)
 	return 0;
 }
 
+void print_crashkernel_region_size(void)
+{
+	printf("-1\n");
+}
+
 unsigned long virt_to_phys(unsigned long addr)
 {
 	return addr + m68k_memoffset;
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
