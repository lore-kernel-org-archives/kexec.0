Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQAjR-0001Pa-Af
 for kexec@lists.infradead.org; Wed, 19 Mar 2014 07:16:11 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile: get_max_mapnr() from ELF header problem
Date: Wed, 19 Mar 2014 07:14:25 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F7B95@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu> <531FDF6D.5080901@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971F512A@BPXM01GP.gisp.nec.co.jp>
 <20140312171812.02f0bfe1@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F672F@BPXM01GP.gisp.nec.co.jp>
 <20140314151928.5c49f17f@holzheu>
In-Reply-To: <20140314151928.5c49f17f@holzheu>
Content-Language: ja-JP
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
To: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>Hello Atsushi,
>
>I debugged my problem a bit further and tried to implement
>a function that gets the maximum page frame number from the
>Linux kernel memory management structures.
>
>I am no memory management expert, so the following patch probably
>is not complete, but at least for my setup it worked.

The patch looks good for your case, but I don't think it's a proper
approach for this problem.

Now, I think this is a problem of get_mm_sparsemem() in makedumpfile.
To say in more detail, the problem is "wrong calculating the address
of unused mem_map".

Looking at the log you sent, some addresses of mem_map corresponding
to unused pages look invalid like below:

mem_map (256)
  mem_map    : 80000c0002018
  pfn_start  : 1000000
  pfn_end    : 1010000
mem_map (257)
  mem_map    : 800001840400000
  pfn_start  : 1010000
  pfn_end    : 1020000
...
mem_map (544)
  mem_map    : a82400012f14fffc
  pfn_start  : 2200000
  pfn_end    : 2210000

...(and more)

However, makedumpfile should calculate such unused mem_map addresses
as 0(NOT_MEMMAP_ADDR). Actually it works as expected at least in my
environment(x86_64):

...
mem_map (16)
  mem_map    : 0
  pfn_start  : 80000
  pfn_end    : 88000
mem_map (17)
  mem_map    : 0
  pfn_start  : 88000
  pfn_end    : 90000
...

makedumpfile get the address from mem_section.section_mem_map,
it will be initialized with zero: 

[CONFIG_SPARSEMEM_EXTREAM]
  paging_init()
    sparse_memory_present_with_active_regions()
      memory_present()
        sparse_index_init()
          sparse_index_alloc()   // allocate mem_section with kzalloc()

makedumpfile assumes the value of unused mem_section will remain as 0,
but I suspect this assumption may be broken in your environment.

Moreover, if it's true, the problem will happen when memmap= parameter
is specified even if max_mapnr is correct.
This is because the unused pages created by memmap= will be placed
below max_mapnr and its mem_map will be calculated wrongly by
get_mm_sparsemem().

I'll continue to investigate to find better solution for this problem,
any comments are helpful.


Thanks
Atsushi Kumagai

>Michael
>---
> makedumpfile.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 58 insertions(+)
>
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -2029,6 +2029,48 @@ pgdat4:
> 	return SYMBOL(contig_page_data);
> }
>
>+int
>+get_max_pfn(void)
>+{
>+	unsigned long pgdat, node_start_pfn, node_spanned_pages, max_pfn = 0;
>+	int num_nodes, node;
>+
>+	if ((node = next_online_node(0)) < 0) {
>+		ERRMSG("Can't get next online node.\n");
>+		return FALSE;
>+	}
>+	if (!(pgdat = next_online_pgdat(node))) {
>+		ERRMSG("Can't get pgdat list.\n");
>+		return FALSE;
>+	}
>+	for (num_nodes = 1; num_nodes <= vt.numnodes; num_nodes++) {
>+		if (!readmem(VADDR, pgdat + OFFSET(pglist_data.node_start_pfn),
>+		    &node_start_pfn, sizeof node_start_pfn)) {
>+			ERRMSG("Can't get node_start_pfn.\n");
>+			return FALSE;
>+		}
>+		if (!readmem(VADDR,
>+			     pgdat + OFFSET(pglist_data.node_spanned_pages),
>+			     &node_spanned_pages, sizeof node_spanned_pages)) {
>+			ERRMSG("Can't get node_spanned_pages.\n");
>+			return FALSE;
>+		}
>+		max_pfn = MAX(max_pfn, (node_start_pfn + node_spanned_pages));
>+		if (num_nodes < vt.numnodes) {
>+			if ((node = next_online_node(node + 1)) < 0) {
>+				ERRMSG("Can't get next online node.\n");
>+				return FALSE;
>+			} else if (!(pgdat = next_online_pgdat(node))) {
>+				ERRMSG("Can't determine pgdat list (node %d).\n",
>+				    node);
>+				return FALSE;
>+			}
>+		}
>+	}
>+	info->max_mapnr = max_pfn;
>+	return TRUE;
>+}
>+
> void
> dump_mem_map(unsigned long long pfn_start,
>     unsigned long long pfn_end, unsigned long mem_map, int num_mm)
>@@ -2853,6 +2908,9 @@ out:
> 		if (!get_numnodes())
> 			return FALSE;
>
>+		if (!get_max_pfn())
>+			return FALSE;
>+
> 		if (!get_mem_map())
> 			return FALSE;
>
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
