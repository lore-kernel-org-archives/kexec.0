Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-ID: <1386877889.1002.6.camel@smoke>
Subject: [PATCH v2 4/4] sh/kexec: Fix kexec build warning
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 12 Dec 2013 11:51:29 -0800
In-Reply-To: <cover.1386807069.git.geoff@infradead.org>
References: <cover.1386807069.git.geoff@infradead.org>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Eric Biederman <ebiederm@xmission.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Paul Mundt <lethal@linux-sh.org>, kexec@lists.infradead.org, linux-sh@vger.kernel.org

Change the format specifiers in the kexec_info routine to match the data
types.  Eliminates the need for type casts and fixes a type mismatch
compiler warning.  Also replace indenting spaces with a tab character.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---

V2:
  Change from type cast fix to format specifier fix.
  
 arch/sh/kernel/machine_kexec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 9fea49f..8195c35 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -53,17 +53,17 @@ void machine_kexec_cleanup(struct kimage *image)
 
 static void kexec_info(struct kimage *image)
 {
-        int i;
+	int i;
 	printk("kexec information\n");
 	for (i = 0; i < image->nr_segments; i++) {
-	        printk("  segment[%d]: 0x%08x - 0x%08x (0x%08x)\n",
+	        printk("  segment[%d]: 0x%08lx - 0x%08lx (0x%08zx)\n",
 		       i,
-		       (unsigned int)image->segment[i].mem,
-		       (unsigned int)image->segment[i].mem +
-				     image->segment[i].memsz,
-		       (unsigned int)image->segment[i].memsz);
+		       image->segment[i].mem,
+		       image->segment[i].mem +
+		       image->segment[i].memsz,
+		       image->segment[i].memsz);
 	}
-	printk("  start     : 0x%08x\n\n", (unsigned int)image->start);
+	printk("  start     : 0x%08lx\n\n", image->start);
 }
 
 /*
-- 
1.8.1.2




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
