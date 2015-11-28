Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a2lwP-0003yL-ON
 for kexec@lists.infradead.org; Sat, 28 Nov 2015 20:17:54 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH] x86/xen: Build memory type conversion code conditionally
Date: Sat, 28 Nov 2015 21:17:18 +0100
Message-Id: <1448741838-958-1-git-send-email-daniel.kiper@oracle.com>
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
To: xen-devel@lists.xenproject.org, kexec@lists.infradead.org
Cc: keir@xen.org, bhe@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, horms@verge.net.au, david.vrabel@citrix.com, jbeulich@suse.com, toshi.kani@hp.com

Xen is not aware of E820_PMEM and E820_PRAM memory types, so, build
simply fails. Hence, build code referencing them conditionally.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/kexec-x86-common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index b308e47..21f8543 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -156,10 +156,14 @@ unsigned xen_e820_to_kexec_type(uint32_t type)
 			return RANGE_ACPI;
 		case E820_NVS:
 			return RANGE_ACPI_NVS;
+#ifdef E820_PMEM
 		case E820_PMEM:
 			return RANGE_PMEM;
+#endif
+#ifdef E820_PRAM
 		case E820_PRAM:
 			return RANGE_PRAM;
+#endif
 		case E820_RESERVED:
 		default:
 			return RANGE_RESERVED;
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
