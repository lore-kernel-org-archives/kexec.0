Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9xuZ-0001Wu-2h
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:02:06 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 05/32] arm: fix kdump to work on LPAE systems
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xro-0003rt-BQ@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 17:59:08 +0100
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>

We need to use 64-bit file IO when mapping system memory and the core
dump file as we may be running on a LPAE system, otherwise we risk
mapping memory we shouldn't, and causing a kernel oops:

Unhandled fault: asynchronous external abort (0x211) at 0x00000000
pgd = edd2c740
[00000000] *pgd=82ec98003, *pmd=82dcd2003, *pte=00000000

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 38137d7..60e433a 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -18,6 +18,9 @@ libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
 
 arm_CPPFLAGS = -I$(srcdir)/kexec/libfdt
 
+# We want 64-bit file IO for kdump to work correctly on LPAE systems
+arm_CPPFLAGS += -D_FILE_OFFSET_BITS=64
+
 arm_KEXEC_SRCS += $(libfdt_SRCS)
 
 arm_UIMAGE = kexec/kexec-uImage.c
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
