Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6QHv-0001dt-QE
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 21:59:12 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 11/14] crashdump/ppc64: Add print_crashkernel_region_size()
 function
Date: Tue,  8 Dec 2015 22:57:44 +0100
Message-Id: <1449611867-15672-12-git-send-email-daniel.kiper@oracle.com>
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
we can properly build kexec utility on ppc64 arch even
if the functionality is not available on it.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index b3c8928..49af7a6 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -527,6 +527,11 @@ int is_crashkernel_mem_reserved(void)
 	return 1;
 }
 
+void print_crashkernel_region_size(void)
+{
+	printf("-1\n");
+}
+
 #if 0
 static int sort_regions(mem_rgns_t *rgn)
 {
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
