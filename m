Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VtHGf-0006Mn-8E
 for kexec@lists.infradead.org; Wed, 18 Dec 2013 13:34:30 +0000
Date: Wed, 18 Dec 2013 21:34:02 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] makedumpfile: memset() in cyclic bitmap initialization
 introduce segment fault
Message-ID: <20131218133402.GA23617@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

We are using memset() to improve performance when creating 1st and 2nd
bitmap. After doing round up the pfn_start and round down pfn_end, it's
possible that pfn_start_roundup is greater than pfn_end_round. A segment
fault could happen in that case because memset is taking roughly the
value of (pfn_end_round << 3 - pfn_start_roundup << 3 ), which is
negative, as its third argument.

So we can skip the memset if start is greater than end. It's safe
because we will set bit for the round up part and also round down part.

Actually this happens on my EFI virtual machine:

cat /proc/iomem:
00000000-00000fff : reserved
00001000-0009ffff : System RAM
000a0000-000bffff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-3d162017 : System RAM
  01000000-015cab9b : Kernel code
  015cab9c-019beb3f : Kernel data
  01b4f000-01da9fff : Kernel bss
  30000000-37ffffff : Crash kernel
3d162018-3d171e57 : System RAM
3d171e58-3d172017 : System RAM
3d172018-3d17ae57 : System RAM
3d17ae58-3dc10fff : System RAM
3dc11000-3dc18fff : reserved
3dc19000-3dc41fff : System RAM
3dc42000-3ddcefff : reserved
3ddcf000-3f7fefff : System RAM
3f7ff000-3f856fff : reserved
[..]

gdb ./makedumpfile core
(gdb) bt full
[..]
 #1  0x000000000042775d in create_1st_bitmap_cyclic () at makedumpfile.c:4543
        i = 0x5
        pfn = 0x3d190
        phys_start = 0x3d18ee58
        phys_end = 0x3d18f018
        pfn_start = 0x3d18e
        pfn_end = 0x3d18f
        pfn_start_roundup = 0x3d190
        pfn_end_round = 0x3d188
        pfn_start_byte = 0x7a32
        pfn_end_byte = 0x7a31
[..]
(gdb) list makedumpfile.c:4543
4538					return FALSE;
4539
4540			pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
4541			pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
4542
4543			memset(info->partial_bitmap2 + pfn_start_byte,
4544			       0xff,
4545			       pfn_end_byte - pfn_start_byte);
4546
4547			for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 makedumpfile.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 23251a1..ef08d91 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4435,11 +4435,13 @@ create_1st_bitmap_cyclic()
 		pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
 		pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
 
-		memset(info->partial_bitmap1 + pfn_start_byte,
-		       0xff,
-		       pfn_end_byte - pfn_start_byte);
+		if (pfn_start_byte < pfn_end_byte) {
+			memset(info->partial_bitmap1 + pfn_start_byte,
+			       0xff,
+			       pfn_end_byte - pfn_start_byte);
 
-		pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
+			pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
+		}
 
 		for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
 			if (set_bit_on_1st_bitmap(pfn))
@@ -4540,9 +4542,11 @@ initialize_2nd_bitmap_cyclic(void)
 		pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
 		pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
 
-		memset(info->partial_bitmap2 + pfn_start_byte,
-		       0xff,
-		       pfn_end_byte - pfn_start_byte);
+		if (pfn_start_byte < pfn_end_byte) {
+			memset(info->partial_bitmap2 + pfn_start_byte,
+			       0xff,
+			       pfn_end_byte - pfn_start_byte);
+		}
 
 		for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
 			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
