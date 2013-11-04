Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdLzh-0006aD-9B
 for kexec@lists.infradead.org; Mon, 04 Nov 2013 15:23:10 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6B8CC3EE0EA
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:44 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5E3C545DE4D
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:44 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F27F45DDCF
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:44 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 31DCC1DB803A
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:44 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CE4C21DB8038
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:43 +0900 (JST)
Subject: [PATCH v2 1/2] Use memset() to improve the 1st bitmap
 initialization performance
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Tue, 05 Nov 2013 00:22:43 +0900
Message-ID: <20131104152243.2556.99504.stgit@localhost6.localdomain6>
In-Reply-To: <20131104152202.2556.83382.stgit@localhost6.localdomain6>
References: <20131104152202.2556.83382.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, vgoyal@redhat.com

Currently, 1st bitmap is initialized per bits. This is very slow, in
particular, on large memory system more than tera bytes. Instead, use
memset() to initialize bitmap quickly.

This helps next patch that changes the 1st bitmap creation to be done
at each cycle.

Here area a simple benchmark program that measures initialization time
for 384 MiB bitmap corresponding to 12 TiB memory.

On Xeon E7-4820 2.00GHz, output example is as follows:

$ ./bench
17.420970
0.340347

Also, the average result of 10 times excluding max and min are:

old: 17.453785 sec
new:  0.340808 sec

==
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

enum {
        PAGE_SIZE = 4096,
        BITSPERBYTE = 8,
};

static inline double getdtime(void)
{
        struct timeval tv;
        gettimeofday(&tv, NULL);
        return (double)tv.tv_sec + (double)tv.tv_usec * 1.0e-6;
}

int main(int argc, char **argv)
{
        const unsigned long long mem_size = 12ULL << 40;
        const unsigned long long max_pfn = mem_size / PAGE_SIZE;
        const size_t bitmap_size = max_pfn / BITSPERBYTE;
        char *bitmap1 = calloc(bitmap_size, sizeof(char));
        char *bitmap2 = calloc(bitmap_size, sizeof(char));
        unsigned long long pfn;
        double t1, t2;

        t1 = getdtime();
        for (pfn = 0; pfn < max_pfn; ++pfn) {
                bitmap1[pfn >> 3] |= 1 << (pfn & 7);
        }
        t2 = getdtime();

        printf("%lf\n", t2 - t1);

        t1 = getdtime();
        memset(bitmap2, 0xff, bitmap_size);
        t2 = getdtime();

        printf("%lf\n", t2 - t1);

        return 0;
}
==

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 428c53e..4b6c0ed 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4317,6 +4317,8 @@ create_1st_bitmap_cyclic()
 	unsigned long long pfn, pfn_bitmap1;
 	unsigned long long phys_start, phys_end;
 	unsigned long long pfn_start, pfn_end;
+	unsigned long long pfn_start_roundup, pfn_end_round;
+	unsigned long pfn_start_byte, pfn_end_byte;
 
 	/*
 	 * At first, clear all the bits on the 1st-bitmap.
@@ -4329,10 +4331,30 @@ create_1st_bitmap_cyclic()
 	 */
 	pfn_bitmap1 = 0;
 	for (i = 0; get_pt_load(i, &phys_start, &phys_end, NULL, NULL); i++) {
-		pfn_start = paddr_to_pfn(phys_start);
-		pfn_end   = paddr_to_pfn(phys_end);
+		pfn_start = MAX(paddr_to_pfn(phys_start), info->cyclic_start_pfn);
+		pfn_end   = MIN(paddr_to_pfn(phys_end), info->cyclic_end_pfn);
 
-		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
+		if (pfn_start >= pfn_end)
+			continue;
+
+		pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
+		pfn_end_round = round(pfn_end, BITPERBYTE);
+
+		for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
+			if (set_bit_on_1st_bitmap(pfn))
+				pfn_bitmap1++;
+		}
+
+		pfn_start_byte = (pfn_start_roundup - info->cyclic_start_pfn) >> 3;
+		pfn_end_byte = (pfn_end_round - info->cyclic_start_pfn) >> 3;
+
+		memset(info->partial_bitmap1 + pfn_start_byte,
+		       0xff,
+		       pfn_end_byte - pfn_start_byte);
+
+		pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
+
+		for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
 			if (set_bit_on_1st_bitmap(pfn))
 				pfn_bitmap1++;
 		}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
