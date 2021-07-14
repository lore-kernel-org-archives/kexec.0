Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from leibniz.telenet-ops.be ([195.130.137.77])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3eLr-00HUCb-VB
 for kexec@lists.infradead.org; Wed, 14 Jul 2021 12:51:05 +0000
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4GPy6M3Mv1zMqdpK
 for <kexec@lists.infradead.org>; Wed, 14 Jul 2021 14:50:51 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 01/10] crash_dump: Make elfcorehdr_{addr,
 size} always visible
Date: Wed, 14 Jul 2021 14:50:11 +0200
Message-Id: <0721f629d5e75b7b7e655458a63cbd767baaa409.1626266516.git.geert+renesas@glider.be>
In-Reply-To: <cover.1626266516.git.geert+renesas@glider.be>
References: <cover.1626266516.git.geert+renesas@glider.be>
MIME-Version: 1.0
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
To: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, linux-mm@kvack.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Make the forward declarations of elfcorehdr_addr and elfcorehdr_size
always available, like is done for phys_initrd_start and
phys_initrd_size.  Code referring to these symbols can then just check
for IS_ENABLED(CONFIG_CRASH_DUMP), instead of requiring conditional
compilation using an #ifdef, thus preparing to increase compile
coverage.

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 include/linux/crash_dump.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index a5192b718dbe4f9a..ad31893d13d634de 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -10,13 +10,14 @@
 
 #include <linux/pgtable.h> /* for pgprot_t */
 
+/* For IS_ENABLED(CONFIG_CRASH_DUMP) */
+extern unsigned long long elfcorehdr_addr;
+extern unsigned long long elfcorehdr_size;
+
 #ifdef CONFIG_CRASH_DUMP
 #define ELFCORE_ADDR_MAX	(-1ULL)
 #define ELFCORE_ADDR_ERR	(-2ULL)
 
-extern unsigned long long elfcorehdr_addr;
-extern unsigned long long elfcorehdr_size;
-
 extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
 extern ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos);
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
