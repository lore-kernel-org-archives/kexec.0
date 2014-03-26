Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSs2W-0007au-Pd
 for kexec@lists.infradead.org; Wed, 26 Mar 2014 17:55:01 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 26 Mar 2014 17:54:33 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 850FB2190046
 for <kexec@lists.infradead.org>; Wed, 26 Mar 2014 17:54:23 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2QHsHES5112144
 for <kexec@lists.infradead.org>; Wed, 26 Mar 2014 17:54:17 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2QIsS82026106
 for <kexec@lists.infradead.org>; Wed, 26 Mar 2014 12:54:28 -0600
Date: Wed, 26 Mar 2014 18:54:26 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Message-ID: <20140326185426.5e2e5fc4@holzheu>
In-Reply-To: <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
References: <20140325171420.6b558576@holzheu>
 <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On Wed, 26 Mar 2014 10:55:07 +0100 (a/T)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Subject: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
> Date: Tue, 25 Mar 2014 17:14:20 +0100

[snip]

> > With this patch makedumpfile gets the maximum page frame number from
> > the mem_map array and adjusts info->max_mapnr if this value is smaller
> > than the value calculated from the ELF header.
> > 
> > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > ---
> >  makedumpfile.c |   14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -2829,7 +2829,8 @@ get_mem_map_without_mm(void)
> >  int
> >  get_mem_map(void)
> >  {
> > -	int ret;
> > +	unsigned long max_pfn = 0;
> > +	int ret, i;
> 
> Please define max_pfn as unsigned long long.

Ok done.

> 
> And for i,
> 
> >  
> >  	switch (get_mem_type()) {
> >  	case SPARSEMEM:
> > @@ -2861,6 +2862,17 @@ get_mem_map(void)
> >  		ret = FALSE;
> >  		break;
> >  	}
> > +	/*
> > +	 * Adjust "max_mapnr" for the case that Linux uses less memory
> > +	 * than is dumped. For example when "mem=" has been used for the
> > +	 * dumped system.
> > +	 */
> > +	for (i = 0; i < info->num_mem_map; i++) {
> 
> info->num_mem_map is defined as unsigned int. I guess some warning
> about comparison with different signedness occurs.

Ah ok...

With the default CFLAGS for makedumpfile-1.5.5 tarball I do not get
any warning. When I add "-W" to CFLAGS, I get lots of warnings
including the one you mentioned.

Here the fixed patch:
---
[PATCH 2/2] makedumpfile: Use max_pfn from mem_map array

There are dump mechansims like s390 stand-alond dump or KVM virsh dump
that write the physical memory of a machine and are not aware of the
dumped operating system. For those dump mechanisms it can happen
that for the Linux kernel of the dumped system the "mem=" kernel
parameter has been specified. In this case max_mapnr that makedumpfile
gets from the ELF header can be bigger than the maximum page frame number
used by the dumped Linux kernel.

With this patch makedumpfile gets the maximum page frame number from
the mem_map array and adjusts info->max_mapnr if this value is smaller
than the value calculated from the ELF header.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 makedumpfile.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2829,6 +2829,8 @@ get_mem_map_without_mm(void)
 int
 get_mem_map(void)
 {
+	unsigned long long max_pfn = 0;
+	unsigned int i;
 	int ret;
 
 	switch (get_mem_type()) {
@@ -2861,6 +2863,17 @@ get_mem_map(void)
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
+	info->max_mapnr = MIN(info->max_mapnr, max_pfn);
 	return ret;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
