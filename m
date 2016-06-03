Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <89f1e3dfe16477c732dac8f407300039c0947568.1464974516.git.geoff@infradead.org>
In-Reply-To: <cover.1464974516.git.geoff@infradead.org>
References: <cover.1464974516.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v17 13/13] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
Date: Fri, 03 Jun 2016 18:13:41 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org

From: James Morse <james.morse@arm.com>

Add documentation for linux,usable-memory and linux,elfcorehdr chosen nodes
used by arm64 kexec to decribe the kdump reserved area, and the elfcorehdr's
location within it.

Signed-off-by: James Morse <james.morse@arm.com>
---
 Documentation/devicetree/bindings/chosen.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 6ae9d82..443f88b 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -52,3 +52,31 @@ This property is set (currently only on PowerPC, and only needed on
 book3e) by some versions of kexec-tools to tell the new kernel that it
 is being booted by kexec, as the booting environment may differ (e.g.
 a different secondary CPU release mechanism)
+
+linux,usable-memory
+-------------------
+
+This property is set on PowerPC and arm64 by kexec-tools during kdump
+to tell the crash kernel the base address of its reserved area of memory, and
+the size. e.g.
+
+/ {
+	chosen {
+		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
+	};
+};
+
+linux,elfcorehdr
+----------------
+
+This property is set (currently only on arm64) by kexec-tools during kdump
+to tell the crash kernel the address and size of the elfcorehdr that describes
+the old kernel's memory as an elf file. This memory must reside within the area
+described by 'linux,usable-memory'. e.g.
+
+/ {
+	chosen {
+		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
+		linux,elfcorehdr = <0x9 0xfffff000 0x0 0x800>;
+	};
+};
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
