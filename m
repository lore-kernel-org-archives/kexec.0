Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WOSxr-0004Y3-As
 for kexec@lists.infradead.org; Fri, 14 Mar 2014 14:20:00 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 14 Mar 2014 14:19:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A65C0219004D
 for <kexec@lists.infradead.org>; Fri, 14 Mar 2014 14:19:26 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2EEJJlw49873058
 for <kexec@lists.infradead.org>; Fri, 14 Mar 2014 14:19:19 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2EEJUcW023183
 for <kexec@lists.infradead.org>; Fri, 14 Mar 2014 08:19:30 -0600
Date: Fri, 14 Mar 2014 15:19:28 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: makedumpfile: get_max_mapnr() from ELF header problem
Message-ID: <20140314151928.5c49f17f@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971F672F@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu> <531FDF6D.5080901@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971F512A@BPXM01GP.gisp.nec.co.jp>
 <20140312171812.02f0bfe1@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F672F@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Atsushi,

I debugged my problem a bit further and tried to implement
a function that gets the maximum page frame number from the
Linux kernel memory management structures.

I am no memory management expert, so the following patch probably
is not complete, but at least for my setup it worked.

Michael
---
 makedumpfile.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2029,6 +2029,48 @@ pgdat4:
 	return SYMBOL(contig_page_data);
 }
 
+int
+get_max_pfn(void)
+{
+	unsigned long pgdat, node_start_pfn, node_spanned_pages, max_pfn = 0;
+	int num_nodes, node;
+
+	if ((node = next_online_node(0)) < 0) {
+		ERRMSG("Can't get next online node.\n");
+		return FALSE;
+	}
+	if (!(pgdat = next_online_pgdat(node))) {
+		ERRMSG("Can't get pgdat list.\n");
+		return FALSE;
+	}
+	for (num_nodes = 1; num_nodes <= vt.numnodes; num_nodes++) {
+		if (!readmem(VADDR, pgdat + OFFSET(pglist_data.node_start_pfn),
+		    &node_start_pfn, sizeof node_start_pfn)) {
+			ERRMSG("Can't get node_start_pfn.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR,
+			     pgdat + OFFSET(pglist_data.node_spanned_pages),
+			     &node_spanned_pages, sizeof node_spanned_pages)) {
+			ERRMSG("Can't get node_spanned_pages.\n");
+			return FALSE;
+		}
+		max_pfn = MAX(max_pfn, (node_start_pfn + node_spanned_pages));
+		if (num_nodes < vt.numnodes) {
+			if ((node = next_online_node(node + 1)) < 0) {
+				ERRMSG("Can't get next online node.\n");
+				return FALSE;
+			} else if (!(pgdat = next_online_pgdat(node))) {
+				ERRMSG("Can't determine pgdat list (node %d).\n",
+				    node);
+				return FALSE;
+			}
+		}
+	}
+	info->max_mapnr = max_pfn;
+	return TRUE;
+}
+
 void
 dump_mem_map(unsigned long long pfn_start,
     unsigned long long pfn_end, unsigned long mem_map, int num_mm)
@@ -2853,6 +2908,9 @@ out:
 		if (!get_numnodes())
 			return FALSE;
 
+		if (!get_max_pfn())
+			return FALSE;
+
 		if (!get_mem_map())
 			return FALSE;
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
