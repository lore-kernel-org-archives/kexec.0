Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by casper.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1b8kpJ-0002nM-Nx
 for kexec@lists.infradead.org; Fri, 03 Jun 2016 08:51:34 +0000
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 7/8] ARM: keystone: dts: add psci command definition
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b8koV-0004Hf-2j@rmk-PC.armlinux.org.uk>
Date: Fri, 03 Jun 2016 09:50:43 +0100
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, kexec@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com>

This commit adds definition for cpu_on, cpu_off and cpu_suspend commands.
These definitions must match the corresponding PSCI definitions in
boot monitor.

Having those command and corresponding PSCI support in boot monitor allows
run time CPU hot plugin.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/keystone.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 3f272826f537..007648971744 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -59,6 +59,14 @@
 			     <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
 	};
 
+	psci {
+		compatible	= "arm,psci";
+		method		= "smc";
+		cpu_suspend	= <0x84000001>;
+		cpu_off		= <0x84000002>;
+		cpu_on		= <0x84000003>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
