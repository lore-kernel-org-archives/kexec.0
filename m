Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTZvd-0004qv-Pm
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 16:46:50 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 28 Mar 2014 16:46:28 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id AF65A17D805C
 for <kexec@lists.infradead.org>; Fri, 28 Mar 2014 16:47:12 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2SGkDhe60358810
 for <kexec@lists.infradead.org>; Fri, 28 Mar 2014 16:46:13 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2SGkODs008277
 for <kexec@lists.infradead.org>; Fri, 28 Mar 2014 10:46:24 -0600
Date: Fri, 28 Mar 2014 17:46:22 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Message-ID: <20140328174622.2896296e@holzheu>
In-Reply-To: <20140328120047.24a056ea@hananiah.suse.cz>
References: <20140325171420.6b558576@holzheu>
 <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
 <20140326185426.5e2e5fc4@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FA0EC@BPXM01GP.gisp.nec.co.jp>
 <20140327145441.4c956989@holzheu>
 <20140328120047.24a056ea@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

On Fri, 28 Mar 2014 12:00:47 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> On Thu, 27 Mar 2014 14:54:41 +0100
> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

[snip]

> > > >Here the fixed patch:
> > > 
> > > Thanks, I'll merge the fixed version into v1.5.6.
> > 
> > Great!
> 
> I'm sorry to spoil the party, but this patch broke Xen dumps for me.
> I'm getting an long series of these messages:
> 
> set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap91pbsO). Invalid argument
> set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap91pbsO). Invalid argument
> set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap91pbsO). Invalid argument
> ...
> 
> In fact, it most likely broke all non-cyclic dumps.
> 
> That's because the bitmap length is calculated in prepare_bitmap_buffer
> using info->max_mapnr, but create_1st_bitmap() still loops over all
> PT_LOAD segments, calling set_bit_on_1st_bitmap() for each PFN. The
> offset may easily fall beyond the bitmap size.

What about the following patch. It works for me when I specify
the "--non-cyclic" option.

Michael
---
[PATCH] makedumpfile: Fix bitmap create for adjusted info->max_mapnr

If info->max_mapnr has been adjusted, for example because the dumped
system has specified the "mem=" kernel parameter, makedumpfile writes
the following error messages for Xen dumps or when the "--non-cyclic"
option has been specified:

set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap96s9V8). Success

Fix this and consider "info->max_mapnr" in the create bitmap functions.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 makedumpfile.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4402,6 +4402,9 @@ create_1st_bitmap(void)
 
 		pfn_start = paddr_to_pfn(phys_start);
 		pfn_end   = paddr_to_pfn(phys_end);
+		if (pfn_start > info->max_mapnr)
+			continue;
+		pfn_end = MIN(phys_end, info->max_mapnr);
 
 		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
 			set_bit_on_1st_bitmap(pfn);
@@ -7511,6 +7514,9 @@ exclude_xen3_user_domain(void)
 		pfn     = paddr_to_pfn(phys_start);
 		pfn_end = paddr_to_pfn(phys_end);
 		size    = pfn_end - pfn;
+		if (pfn > info->max_mapnr)
+			continue;
+		pfn_end = MIN(phys_end, info->max_mapnr);
 
 		for (j = 0; pfn < pfn_end; pfn++, j++) {
 			print_progress(PROGRESS_XEN_DOMAIN, j + (size * i),
@@ -7575,6 +7581,9 @@ exclude_xen4_user_domain(void)
 		pfn     = paddr_to_pfn(phys_start);
 		pfn_end = paddr_to_pfn(phys_end);
 		size    = pfn_end - pfn;
+		if (pfn > info->max_mapnr)
+			continue;
+		pfn_end = MIN(phys_end, info->max_mapnr);
 
 		for (j = 0; pfn < pfn_end; pfn++, j++) {
 			print_progress(PROGRESS_XEN_DOMAIN, j + (size * i),


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
