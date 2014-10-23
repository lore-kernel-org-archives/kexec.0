Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <b56c0def845535b41b6c00bffdd9d91de5ddae5c.1414099246.git.geoff@infradead.org>
In-Reply-To: <cover.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 06/10] arm64: Update booting.txt to reserved-memory nodes
Date: Thu, 23 Oct 2014 23:10:58 +0000
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
Cc: marc.zyngier@arm.com, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

Change any reference of device tree '/memreserve/' entries in the arm64
booting.txt to refer to 'reserved-memory nodes'.  Reserved-memory nodes
are the preferred method of specifying reserved memory.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 Documentation/arm64/booting.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index f3c05b5..7446822 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -196,7 +196,7 @@ following manner:
   naturally-aligned 64-bit zero-initalised memory location.
 
   These CPUs should spin outside of the kernel in a reserved area of
-  memory (communicated to the kernel by a /memreserve/ region in the
+  memory (communicated to the kernel by a reserved-memory node in the
   device tree) polling their cpu-release-addr location, which must be
   contained in the reserved region.  A wfe instruction may be inserted
   to reduce the overhead of the busy-loop and a sev will be issued by
@@ -209,7 +209,7 @@ following manner:
 - CPUs with a "psci" enable method should remain outside of
   the kernel (i.e. outside of the regions of memory described to the
   kernel in the memory node, or in a reserved area of memory described
-  to the kernel by a /memreserve/ region in the device tree).  The
+  to the kernel by a reserved-memory node in the device tree).  The
   kernel will issue CPU_ON calls as described in ARM document number ARM
   DEN 0022A ("Power State Coordination Interface System Software on ARM
   processors") to bring CPUs into the kernel.
-- 
1.9.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
