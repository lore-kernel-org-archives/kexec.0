Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x230.google.com ([2607:f8b0:400e:c03::230])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWwDU-0004OJ-FZ
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 01:52:34 +0000
Received: by mail-pa0-x230.google.com with SMTP id fi15so159365pac.1
 for <kexec@lists.infradead.org>; Mon, 08 Aug 2016 18:52:08 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v24 9/9] Documentation: dt: chosen properties for arm64 kdump
Date: Tue,  9 Aug 2016 10:57:47 +0900
Message-Id: <20160809015747.28591-1-takahiro.akashi@linaro.org>
In-Reply-To: <20160809015248.28414-2-takahiro.akashi@linaro.org>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

From: James Morse <james.morse@arm.com>

Add documentation for
	linux,crashkernel-base and crashkernel-size,
	linux,usable-memory-range, and
	linux,elfcorehdr
used by arm64 kexec/kdump to decribe the kdump reserved area, and
the elfcorehdr's location within it.

Signed-off-by: James Morse <james.morse@arm.com>
[takahiro.akashi@linaro.org:
    renamed "usable-memory" to "usable-memory-range",
    added "linux,crashkernel-base" and "-size" ]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 Documentation/devicetree/bindings/chosen.txt | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 6ae9d82..236188a 100644
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
+the panicked kernel's memory layout in elf format.
+e.g.
+
+/ {
+	chosen {
+		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
+		linux,elfcorehdr = <0x9 0xfffff000 0x0 0x800>;
+	};
+};
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
