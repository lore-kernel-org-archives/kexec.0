Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v2 4/8] arm: kdump: skip indirection page when crashing
Date: Wed,  5 May 2010 09:54:16 +0300
Message-Id: <77df4d5693bd8cf03b47b0d67b32c2dc578fd63f.1273041358.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: kexec@lists.infradead.org, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>

When we are crashing there is no indirection page in place. Only control page is
present.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/relocate_kernel.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index 61930eb..fd26f8d 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -10,6 +10,12 @@ relocate_new_kernel:
 	ldr	r0,kexec_indirection_page
 	ldr	r1,kexec_start_address
 
+	/*
+	 * If there is no indirection page (we are doing crashdumps)
+	 * skip any relocation.
+	 */
+	cmp	r0, #0
+	beq	2f
 
 0:	/* top, read another word for the indirection page */
 	ldr	r3, [r0],#4
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
