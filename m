Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 3/7] uImage: Add new IH_ARCH_xxx definitions
Date: Wed,  8 Mar 2017 22:41:10 +0000
Message-Id: <20170308224114.49729-3-dwmw2@infradead.org>
In-Reply-To: <20170308224114.49729-1-dwmw2@infradead.org>
References: <20170308224114.49729-1-dwmw2@infradead.org>
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
To: kexec@lists.infradead.org
Cc: David Woodhouse <dwmw@amazon.co.uk>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/image.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/image.h b/include/image.h
index e742aae..8e9d81e 100644
--- a/include/image.h
+++ b/include/image.h
@@ -79,6 +79,13 @@
 #define IH_ARCH_BLACKFIN	16	/* Blackfin	*/
 #define IH_ARCH_AVR32		17	/* AVR32	*/
 #define IH_ARCH_ST200	        18	/* STMicroelectronics ST200  */
+#define IH_ARCH_SANDBOX		19	/* Sandbox architecture (test only) */
+#define IH_ARCH_NDS32		20	/* ANDES Technology - NDS32  */
+#define IH_ARCH_OPENRISC	21	/* OpenRISC 1000  */
+#define IH_ARCH_ARM64		22	/* ARM64        */
+#define IH_ARCH_ARC		23	/* Synopsys DesignWare ARC */
+#define IH_ARCH_X86_64		24	/* AMD x86_64, Intel and Via */
+#define IH_ARCH_XTENSA		25	/* Xtensa       */
 
 /*
  * Image Types
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
