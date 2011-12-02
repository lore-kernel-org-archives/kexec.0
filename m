Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RWHGo-0007jy-Ik
 for kexec@lists.infradead.org; Fri, 02 Dec 2011 00:46:32 +0000
Date: Fri, 2 Dec 2011 09:46:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec skips some load segments on ia64
Message-ID: <20111202004624.GB3083@verge.net.au>
References: <201112010956.11733.ptesarik@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201112010956.11733.ptesarik@suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org

On Thu, Dec 01, 2011 at 09:56:11AM +0100, Petr Tesarik wrote:
> There is a bug in add_loaded_segments_info, which causes that some LOAD 
> segments may be skipped on ia64. For two consecutive segments which cannot be 
> combined, the 'i' counter is incremented twice, effectively skipping over the 
> second segment. 
> 
> For example, these are the program header of my vmlinux:
> 
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   LOAD           0x0000000000010000 0xa000000100000000 0x0000000004000000
>                  0x0000000000ee0e90 0x0000000000ee0e90  RWE    10000
>   LOAD           0x0000000000f00000 0xfffffffffffc0000 0x0000000004f00000
>                  0x0000000000006d80 0x0000000000006d80  RW     10000
>   LOAD           0x0000000000f10000 0xa000000100f40000 0x0000000004f40000
>                  0x00000000005e3028 0x0000000000dc9198  RW     10000
>   NOTE           0x000000000098dc60 0xa00000010097dc60 0x000000000497dc60
>                  0x0000000000000024 0x0000000000000024  R      4
>   IA_64_UNWIND   0x00000000009edd58 0xa0000001009ddd58 0x00000000049ddd58
>                  0x000000000005d468 0x000000000005d468  R      8
> 
> And these are the resulting load segments:
> 
>   0x6004000000 - 0x6004ef0000  (LOAD 1)
>   0x6004f40000 - 0x6005d10000  (LOAD 3)
>   0x6023fc0000 - 0x6023fc1000  (elfcorehdr)
> 
> Note: The crash kernel is loaded at 0x6004000000 on this machine.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

Thanks Petr,

I have applied the following to my tree which is still temporarily
on github git://github.com/horms/kexec-tools.git


commit 4f1ac81354d95a1fa35af67da5bf6cc30d0122dd
Author: Petr Tesarik <ptesarik@suse.cz>
Date:   Thu Dec 1 09:56:11 2011 +0100

    kexec skips some load segments on ia64
    
    There is a bug in add_loaded_segments_info, which causes that some LOAD
    segments may be skipped on ia64. For two consecutive segments which cannot
    be
    combined, the 'i' counter is incremented twice, effectively skipping over
    the
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
    [horms@verge.net.au: Trivial up-port]
    Signed-off-by: Simon Horman <horms@verge.net.au>

diff --git a/kexec/arch/ia64/crashdump-ia64.c b/kexec/arch/ia64/crashdump-ia64.c
index 8932395..782f49e 100644
--- a/kexec/arch/ia64/crashdump-ia64.c
+++ b/kexec/arch/ia64/crashdump-ia64.c
@@ -73,12 +73,14 @@ static int seg_comp(const void *a, const void *b)
  */
 static void add_loaded_segments_info(struct mem_ehdr *ehdr)
 {
-	 unsigned i;
-         for(i = 0; i < ehdr->e_phnum; i++) {
+	unsigned i = 0;
+	while(i < ehdr->e_phnum) {
                 struct mem_phdr *phdr;
                 phdr = &ehdr->e_phdr[i];
-                if (phdr->p_type != PT_LOAD)
+		if (phdr->p_type != PT_LOAD) {
+			i++;
                         continue;
+		}
 
 		loaded_segments[loaded_segments_num].start =
 			phdr->p_paddr & ~(ELF_PAGE_SIZE-1);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
