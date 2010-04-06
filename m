Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Nyyx4-0002lV-B3
	for kexec@lists.infradead.org; Tue, 06 Apr 2010 02:55:43 +0000
Date: Tue, 6 Apr 2010 11:44:54 +0900
From: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
Subject: [crash][patch] handle !SPARSEMEM_EX properly
Message-Id: <20100406114454.d44aa12c.nishimura@mxp.nes.nec.co.jp>
In-Reply-To: <20100406094531.dcf912de.nishimura@mxp.nes.nec.co.jp>
References: <20100319182555.GF3565@hmsreliant.think-freely.org>
	<4BA80AC7.5060807@mxs.nes.nec.co.jp>
	<20100323110132.GA3429@hmsreliant.think-freely.org>
	<4BABFDC1.1020801@mxs.nes.nec.co.jp>
	<20100326010047.GA2949@localhost.localdomain>
	<4BAC0B2F.1080607@mxs.nes.nec.co.jp>
	<20100326105445.GA3007@hmsreliant.think-freely.org>
	<4BB0617C.9030006@mxs.nes.nec.co.jp>
	<20100406094531.dcf912de.nishimura@mxp.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org, Neil Horman <nhorman@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, crash-utility@redhat.com

In !SPARSEMEM_EX case, the symbol mem_section points a array of struct mem_section,
doesn't point a array of pointer to mem_section[], so I think the check:

	if ((mem_sec[SECTION_NR_TO_ROOT(nr)] == 0) || 
	    !IS_KVADDR(mem_sec[SECTION_NR_TO_ROOT(nr)]))
		return 0;

in nr_to_section() is not a valid check in this case.

To make the matters worse, if CONFIG_CGROUP_MEM_RES_CTLR is enabled, the end of
struct mem_section is padded with 0.

So, reading mem_section by "rd" will look like:

	crash> rd mem_section 128
	c08b71e0:  c9002003 c9001200 f7000000 00000000   . ..............
	c08b71f0:  c9002003 c9001260 f6980000 00000000   . ..`...........
	c08b7200:  c9002003 c90012c0 f6300000 00000000   . ........0.....
	c08b7210:  c9002003 c9001320 f5c80000 00000000   . .. ...........
	...

This means nr_to_section() will return 0 when "nr" is 3,7,11,... because it meets
the condition(mem_sec[SECTION_NR_TO_ROOT(nr)] == mem_sec[nr] == 0).

As a result, mem_map for section 3,7,11,... cannot be handled properly.
Actually, "kmem -n" doesn't show a mem_map for them.

	crash> kmem -n
	...
	NR  SECTION   CODED_MEM_MAP  MEM_MAP   PFN
	 0  c08b71e0  c9002000  c9002000  0
	 1  c08b71f0  c9002000  c9402000  131072
	 2  c08b7200  c9002000  c9802000  262144
	 4  c08b7220  c9002000  ca002000  524288
	 5  c08b7230  c9002000  ca402000  655360
	 6  c08b7240  c9002000  ca802000  786432
	 8  c08b7260  c8c02000  cac02000  1048576
	 9  c08b7270  c8c02000  cb002000  1179648
	10  c08b7280  c8c02000  cb402000  1310720
	12  c08b72a0  c8c02000  cbc02000  1572864
	...

This patch is a fix for this problem. nr_to_section() will check "addr" by
IS_KVADDR() later anyway, so this patch just removes the problematic check.

Signed-off-by: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
---
diff -uprN crash-5.0.2.orig/memory.c crash-5.0.2/memory.c
--- crash-5.0.2.orig/memory.c	2010-04-05 16:08:52.000000000 +0900
+++ crash-5.0.2/memory.c	2010-04-06 09:56:43.000000000 +0900
@@ -13030,10 +13030,6 @@ nr_to_section(ulong nr)
 		}
 	}
 
-	if ((mem_sec[SECTION_NR_TO_ROOT(nr)] == 0) || 
-	    !IS_KVADDR(mem_sec[SECTION_NR_TO_ROOT(nr)]))
-		return 0;
-
 	if (IS_SPARSEMEM_EX())
 		addr = mem_sec[SECTION_NR_TO_ROOT(nr)] + 
 		    (nr & SECTION_ROOT_MASK()) * SIZE(mem_section);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
