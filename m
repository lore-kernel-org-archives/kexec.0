Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c1nRe-00053a-3A
 for kexec@lists.infradead.org; Wed, 02 Nov 2016 04:47:02 +0000
Received: by mail-pf0-x233.google.com with SMTP id i88so4254290pfk.2
 for <kexec@lists.infradead.org>; Tue, 01 Nov 2016 21:46:17 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v27 9/9] Documentation: dt: chosen properties for arm64 kdump
Date: Wed,  2 Nov 2016 13:54:25 +0900
Message-Id: <20161102045425.12126-1-takahiro.akashi@linaro.org>
In-Reply-To: <20161102044959.11954-1-takahiro.akashi@linaro.org>
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

From: James Morse <james.morse@arm.com>

Add documentation for
	linux,crashkernel-base and crashkernel-size,
	linux,usable-memory-range
	linux,elfcorehdr
used by arm64 kdump to decribe the kdump reserved area, and
the elfcorehdr's location within it.

Signed-off-by: James Morse <james.morse@arm.com>
[takahiro.akashi@linaro.org: added "linux,crashkernel-base" and "-size" ]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/chosen.txt | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 6ae9d82..7b11516 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -52,3 +52,53 @@ This property is set (currently only on PowerPC, and only needed on
 book3e) by some versions of kexec-tools to tell the new kernel that it
 is being booted by kexec, as the booting environment may differ (e.g.
 a different secondary CPU release mechanism)
+
+linux,crashkernel-base
+linux,crashkernel-size
+----------------------
+
+These properties (currently used on PowerPC and arm64) indicates
+the base address and the size, respectively, of the reserved memory
+range for crash dump kernel.
+e.g.
+
+/ {
+	chosen {
+		linux,crashkernel-base = <0x9 0xf0000000>;
+		linux,crashkernel-size = <0x0 0x10000000>;
+	};
+};
+
+linux,usable-memory-range
+-------------------------
+
+This property (currently used only on arm64) holds the memory range,
+the base address and the size, which can be used as system ram on
+the *current* kernel. Note that, if this property is present, any memory
+regions under "memory" nodes in DT blob or ones marked as "conventional
+memory" in EFI memory map should be ignored.
+e.g.
+
+/ {
+	chosen {
+		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
+	};
+};
+
+The main usage is for crash dump kernel to identify its own usable
+memory and exclude, at its boot time, any other memory areas that are
+part of the panicked kernel's memory.
+
+linux,elfcorehdr
+----------------
+
+This property (currently used only on arm64) holds the memory range,
+the address and the size, of the elf core header which mainly describes
+the panicked kernel's memory layout as PT_LOAD segments of elf format.
+e.g.
+
+/ {
+	chosen {
+		linux,elfcorehdr = <0x9 0xfffff000 0x0 0x800>;
+	};
+};
-- 
2.10.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
