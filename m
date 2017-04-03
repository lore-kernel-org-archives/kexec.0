Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cureM-0007O7-7d
 for kexec@lists.infradead.org; Mon, 03 Apr 2017 02:23:26 +0000
Received: by mail-pg0-x232.google.com with SMTP id 21so105687809pgg.1
 for <kexec@lists.infradead.org>; Sun, 02 Apr 2017 19:23:02 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v35 13/14] Documentation: dt: chosen properties for arm64 kdump
Date: Mon,  3 Apr 2017 11:26:06 +0900
Message-Id: <20170403022606.12609-1-takahiro.akashi@linaro.org>
In-Reply-To: <20170403022139.12383-1-takahiro.akashi@linaro.org>
References: <20170403022139.12383-1-takahiro.akashi@linaro.org>
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
Cc: panand@redhat.com, devicetree@vger.kernel.org, ard.biesheuvel@linaro.org, geoff@infradead.org, dwmw2@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

From: James Morse <james.morse@arm.com>

Add documentation for DT properties:
	linux,usable-memory-range
	linux,elfcorehdr
used by arm64 kdump. Those are, respectively, a usable memory range
allocated to crash dump kernel and the elfcorehdr's location within it.

Signed-off-by: James Morse <james.morse@arm.com>
[takahiro.akashi@linaro.org: update the text due to recent changes ]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
---
 Documentation/devicetree/bindings/chosen.txt | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 6ae9d82d4c37..b5e39af4ddc0 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -52,3 +52,48 @@ This property is set (currently only on PowerPC, and only needed on
 book3e) by some versions of kexec-tools to tell the new kernel that it
 is being booted by kexec, as the booting environment may differ (e.g.
 a different secondary CPU release mechanism)
+
+linux,usable-memory-range
+-------------------------
+
+This property (arm64 only) holds a base address and size, describing a
+limited region in which memory may be considered available for use by
+the kernel. Memory outside of this range is not available for use.
+
+This property describes a limitation: memory within this range is only
+valid when also described through another mechanism that the kernel
+would otherwise use to determine available memory (e.g. memory nodes
+or the EFI memory map). Valid memory may be sparse within the range.
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
+While this property does not represent a real hardware, the address
+and the size are expressed in #address-cells and #size-cells,
+respectively, of the root node.
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
+
+While this property does not represent a real hardware, the address
+and the size are expressed in #address-cells and #size-cells,
+respectively, of the root node.
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
