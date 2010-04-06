Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NyywJ-0007Vn-KE
	for kexec@lists.infradead.org; Tue, 06 Apr 2010 02:54:56 +0000
Date: Tue, 6 Apr 2010 11:45:49 +0900
From: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
Subject: [makedumpfile][patch] handle !SPARSEMEM_EX properly
Message-Id: <20100406114549.88dae199.nishimura@mxp.nes.nec.co.jp>
In-Reply-To: <20100406114454.d44aa12c.nishimura@mxp.nes.nec.co.jp>
References: <20100319182555.GF3565@hmsreliant.think-freely.org>
	<4BA80AC7.5060807@mxs.nes.nec.co.jp>
	<20100323110132.GA3429@hmsreliant.think-freely.org>
	<4BABFDC1.1020801@mxs.nes.nec.co.jp>
	<20100326010047.GA2949@localhost.localdomain>
	<4BAC0B2F.1080607@mxs.nes.nec.co.jp>
	<20100326105445.GA3007@hmsreliant.think-freely.org>
	<4BB0617C.9030006@mxs.nes.nec.co.jp>
	<20100406094531.dcf912de.nishimura@mxp.nes.nec.co.jp>
	<20100406114454.d44aa12c.nishimura@mxp.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Masayuki Igawa <igawa@mxs.nes.nec.co.jp>, crash-utility@redhat.com

In !SPARSEMEM_EX case, the symbol mem_section points a array of struct mem_section,
doesn't point a array of pointer to mem_section[], so I think the check:

	if (!is_kvaddr(mem_sec[SECTION_NR_TO_ROOT(nr)]))
		return NOT_KV_ADDR;

in nr_to_section() is not a valid check in this case.

To make the matters worse, if CONFIG_CGROUP_MEM_RES_CTLR is enabled, the end of
struct mem_section is padded with 0.

So, reading mem_section by "rd" of crash will look like:

	crash> rd mem_section 128
	c08b71e0:  c9002003 c9001200 f7000000 00000000   . ..............
	c08b71f0:  c9002003 c9001260 f6980000 00000000   . ..`...........
	c08b7200:  c9002003 c90012c0 f6300000 00000000   . ........0.....
	c08b7210:  c9002003 c9001320 f5c80000 00000000   . .. ...........
	...

This means nr_to_section() will return 0 when "nr" is 3,7,11,... because it meets
the condition(mem_sec[SECTION_NR_TO_ROOT(nr)] == mem_sec[nr] == 0 == !is_kvaddr).

As a result, mem_map for section 3,7,11,... cannot be handled properly.

This patch is a fix for this problem. nr_to_section() will check "addr" by
is_kvaddr() later anyway, so this patch just removes the problematic check.

Signed-off-by: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
Signed-off-by: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
---
diff --git a/makedumpfile.c b/makedumpfile.c
index 855c718..73fa94f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3547,9 +3547,6 @@ nr_to_section(unsigned long nr, unsigned long *mem_sec)
 {
 	unsigned long addr;
 
-	if (!is_kvaddr(mem_sec[SECTION_NR_TO_ROOT(nr)]))
-		return NOT_KV_ADDR;
-
 	if (is_sparsemem_extreme())
 		addr = mem_sec[SECTION_NR_TO_ROOT(nr)] +
 		    (nr & SECTION_ROOT_MASK()) * SIZE(mem_section);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
