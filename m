Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6QHl-0001bq-IA
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 21:59:02 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 07/14] crashdump/ia64: Add print_crashkernel_region_size()
 function
Date: Tue,  8 Dec 2015 22:57:40 +0100
Message-Id: <1449611867-15672-8-git-send-email-daniel.kiper@oracle.com>
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

Follow similar x86 patch.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/ia64/crashdump-ia64.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kexec/arch/ia64/crashdump-ia64.c b/kexec/arch/ia64/crashdump-ia64.c
index 726c9f4..07de42a 100644
--- a/kexec/arch/ia64/crashdump-ia64.c
+++ b/kexec/arch/ia64/crashdump-ia64.c
@@ -286,3 +286,13 @@ int is_crashkernel_mem_reserved(void)
 	return parse_iomem_single("Crash kernel\n", &start,
 				  &end) == 0 ?  (start != end) : 0;
 }
+
+void print_crashkernel_region_size(void)
+{
+	uint64_t start, end;
+
+	if (!parse_iomem_single("Crash kernel\n", &start, &end) && start != end)
+		printf("%lu\n", end - start + 1);
+	else
+		printf("0\n");
+}
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
