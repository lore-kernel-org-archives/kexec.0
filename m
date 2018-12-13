Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXJT8-0005fk-Ej
 for kexec@lists.infradead.org; Thu, 13 Dec 2018 05:23:32 +0000
Received: by mail-qt1-x843.google.com with SMTP id d19so845584qtq.9
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 21:23:19 -0800 (PST)
From: Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64: invalidate TLB before turning MMU on
Date: Thu, 13 Dec 2018 00:22:59 -0500
Message-Id: <20181213052259.56352-1-cai@lca.pw>
In-Reply-To: <1544654224.18411.11.camel@lca.pw>
References: <1544654224.18411.11.camel@lca.pw>
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
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: ard.biesheuvel@linaro.org, marc.zyngier@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, james.morse@arm.com, Qian Cai <cai@lca.pw>, linux-arm-kernel@lists.infradead.org

On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
dump just hung. It has 4 threads on each core. Each 2-core share a same
L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
L3 cache.

It turned out that this was due to the TLB contained stale entries (or
uninitialized junk which just happened to look valid) from the first
kernel before turning the MMU on in the second kernel which caused this
instruction hung,

msr	sctlr_el1, x0

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kernel/head.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..5196f3d729de 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
 	msr	ttbr0_el1, x2			// load TTBR0
 	msr	ttbr1_el1, x1			// load TTBR1
 	isb
+	dsb	nshst
+	tlbi	vmalle1				// invalidate TLB
+	dsb	nsh
+	isb
 	msr	sctlr_el1, x0
 	isb
 	/*
-- 
2.17.2 (Apple Git-113)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
