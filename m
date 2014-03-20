Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQa9H-0002JP-2i
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 10:24:31 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 20 Mar 2014 10:24:05 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id F0C402190046
 for <kexec@lists.infradead.org>; Thu, 20 Mar 2014 10:23:56 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KANovx53412076
 for <kexec@lists.infradead.org>; Thu, 20 Mar 2014 10:23:50 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KAO1ta004318
 for <kexec@lists.infradead.org>; Thu, 20 Mar 2014 04:24:01 -0600
Date: Thu, 20 Mar 2014 11:23:59 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: makedumpfile: get_max_mapnr() from ELF header problem
Message-ID: <20140320112359.25f0ad54@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971F7B95@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu> <531FDF6D.5080901@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971F512A@BPXM01GP.gisp.nec.co.jp>
 <20140312171812.02f0bfe1@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F672F@BPXM01GP.gisp.nec.co.jp>
 <20140314151928.5c49f17f@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971F7B95@BPXM01GP.gisp.nec.co.jp>
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

On Wed, 19 Mar 2014 07:14:25 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> >Hello Atsushi,
> >
> >I debugged my problem a bit further and tried to implement
> >a function that gets the maximum page frame number from the
> >Linux kernel memory management structures.
> >
> >I am no memory management expert, so the following patch probably
> >is not complete, but at least for my setup it worked.
> 
> The patch looks good for your case, but I don't think it's a proper
> approach for this problem.

Hello Atsushi,

If you don't like that solution, what about using the mem_map_data[]
array of makedumpfile to adjust "max_mapnr"?

The patch below also works fine for my dump.

Michael
---
 makedumpfile.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2829,7 +2829,8 @@ get_mem_map_without_mm(void)
 int
 get_mem_map(void)
 {
-	int ret;
+	unsigned long max_pfn = 0;
+	int ret, i;
 
 	switch (get_mem_type()) {
 	case SPARSEMEM:
@@ -2861,6 +2862,17 @@ get_mem_map(void)
 		ret = FALSE;
 		break;
 	}
+	/*
+	 * Adjust "max_mapnr" for the case that Linux uses less memory
+	 * than is dumped. For example when "mem=" has been used for the
+	 * dumped system.
+	 */
+	for (i = 0; i < info->num_mem_map; i++) {
+		if (info->mem_map_data[i].mem_map == NOT_MEMMAP_ADDR)
+			continue;
+		max_pfn = MAX(max_pfn, info->mem_map_data[i].pfn_end);
+	}
+	info->max_mapnr = max_pfn;
 	return ret;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
