Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RW2RF-00025z-3D
 for kexec@lists.infradead.org; Thu, 01 Dec 2011 08:56:18 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: kexec skips some load segments on ia64
Date: Thu, 1 Dec 2011 09:56:11 +0100
MIME-Version: 1.0
Message-Id: <201112010956.11733.ptesarik@suse.cz>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

There is a bug in add_loaded_segments_info, which causes that some LOAD 
segments may be skipped on ia64. For two consecutive segments which cannot be 
combined, the 'i' counter is incremented twice, effectively skipping over the 
second segment. 

For example, these are the program header of my vmlinux:

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000010000 0xa000000100000000 0x0000000004000000
                 0x0000000000ee0e90 0x0000000000ee0e90  RWE    10000
  LOAD           0x0000000000f00000 0xfffffffffffc0000 0x0000000004f00000
                 0x0000000000006d80 0x0000000000006d80  RW     10000
  LOAD           0x0000000000f10000 0xa000000100f40000 0x0000000004f40000
                 0x00000000005e3028 0x0000000000dc9198  RW     10000
  NOTE           0x000000000098dc60 0xa00000010097dc60 0x000000000497dc60
                 0x0000000000000024 0x0000000000000024  R      4
  IA_64_UNWIND   0x00000000009edd58 0xa0000001009ddd58 0x00000000049ddd58
                 0x000000000005d468 0x000000000005d468  R      8

And these are the resulting load segments:

  0x6004000000 - 0x6004ef0000  (LOAD 1)
  0x6004f40000 - 0x6005d10000  (LOAD 3)
  0x6023fc0000 - 0x6023fc1000  (elfcorehdr)

Note: The crash kernel is loaded at 0x6004000000 on this machine.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 kexec/arch/ia64/crashdump-ia64.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/kexec/arch/ia64/crashdump-ia64.c
+++ b/kexec/arch/ia64/crashdump-ia64.c
@@ -74,12 +74,14 @@ static int seg_comp(const void *a, const
 static void add_loaded_segments_info(struct kexec_info *info,
 	struct mem_ehdr *ehdr, unsigned long max_addr)
 {
-	 int i;
-         for(i = 0; i < ehdr->e_phnum; i++) {
+	 int i = 0;
+         while(i < ehdr->e_phnum) {
                 struct mem_phdr *phdr;
                 phdr = &ehdr->e_phdr[i];
-                if (phdr->p_type != PT_LOAD)
+                if (phdr->p_type != PT_LOAD) {
+                        i++;
                         continue;
+		}
 
 		loaded_segments[loaded_segments_num].start =
 			phdr->p_paddr & ~(ELF_PAGE_SIZE-1);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
