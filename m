Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail1.windriver.com ([147.11.146.13])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcqK3-0000Qp-1c
 for kexec@lists.infradead.org; Fri, 18 Sep 2015 07:43:07 +0000
From: <yanjiang.jin@windriver.com>
Subject: [PATCH] mips: vmcore: forced convert 'hdr' in elf_check_arch()
Date: Fri, 18 Sep 2015 15:42:51 +0800
Message-ID: <1442562171-21307-2-git-send-email-yanjiang.jin@windriver.com>
In-Reply-To: <1442562171-21307-1-git-send-email-yanjiang.jin@windriver.com>
References: <1442562171-21307-1-git-send-email-yanjiang.jin@windriver.com>
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
To: akpm@linux-foundation.org, mhuang@redhat.com
Cc: jinyanjiang@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, chaowang@redhat.com, yanjiang.jin@windriver.com

From: Yanjiang Jin <yanjiang.jin@windriver.com>

elf_check_arch() will be called both in parse_crash_elf64_headers()
and parse_crash_elf32_headers(). But in these two functions, the type of
the parameter ehdr is different: Elf32_Ehdr and Elf64_Ehdr.

Function parse_crash_elf_headers() reads e_ident[EI_CLASS] then decides to
call parse_crash_elf64_headers() or parse_crash_elf32_headers().
This happens in run time, not compile time. So compiler will report
the below warning:

In file included from include/linux/elf.h:4:0,
                 from fs/proc/vmcore.c:13:
fs/proc/vmcore.c: In function 'parse_crash_elf32_headers':
arch/mips/include/asm/elf.h:258:23: warning: initializatio
n from incompatible pointer type
  struct elfhdr *__h = (hdr);     \
                       ^
fs/proc/vmcore.c:1071:4: note: in expansion of macro 'elf_
check_arch'
   !elf_check_arch(&ehdr) ||
    ^

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/mips/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index f19e890..ece490d 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -224,7 +224,7 @@ struct mips_elf_abiflags_v0 {
 #define elf_check_arch(hdr)						\
 ({									\
 	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
+	struct elfhdr *__h = (struct elfhdr *)(hdr);			\
 									\
 	if (__h->e_machine != EM_MIPS)					\
 		__res = 0;						\
@@ -255,7 +255,7 @@ struct mips_elf_abiflags_v0 {
 #define elf_check_arch(hdr)						\
 ({									\
 	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
+	struct elfhdr *__h = (struct elfhdr *)(hdr);			\
 									\
 	if (__h->e_machine != EM_MIPS)					\
 		__res = 0;						\
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
