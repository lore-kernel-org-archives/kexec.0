Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OMyh1-0001Ye-3x
	for kexec@lists.infradead.org; Fri, 11 Jun 2010 07:30:21 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id o5B7UB1h026109
	for <kexec@lists.infradead.org>; Fri, 11 Jun 2010 13:00:11 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5B7UCdE3715274
	for <kexec@lists.infradead.org>; Fri, 11 Jun 2010 13:00:12 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5B7UAuo021951
	for <kexec@lists.infradead.org>; Fri, 11 Jun 2010 13:00:11 +0530
Subject: Re: [PATCH] Fix Oops in crash_shrink_memory
From: Pavan Naregundi <pavan@linux.vnet.ibm.com>
In-Reply-To: <20100610142622.497061e8.akpm@linux-foundation.org>
References: <1275895711.4365.18.camel@pavan.naregundi>
	<1275980857.2583.15.camel@pavan.naregundi>
	<20100608075959.GB7110@cr0.nay.redhat.com>
	<1275986405.5015.13.camel@pavan.naregundi>
	<20100608085440.GC7110@cr0.nay.redhat.com>
	<1275990107.5015.55.camel@pavan.naregundi>
	<20100609034452.GA28948@verge.net.au>
	<1276064834.2622.7.camel@pavan.naregundi>
	<20100610142622.497061e8.akpm@linux-foundation.org>
Content-Type: multipart/mixed; boundary="=-LHlCRG1LvcuEh6hgenH6"
Date: Fri, 11 Jun 2010 13:00:09 +0530
Message-ID: <1276241409.2714.59.camel@pavan.naregundi>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Simon Horman <horms@verge.net.au>, =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, vgoyal@redhat.com


--=-LHlCRG1LvcuEh6hgenH6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2010-06-10 at 14:26 -0700, Andrew Morton wrote:
> On Wed, 09 Jun 2010 11:57:14 +0530
> Pavan Naregundi <pavan@linux.vnet.ibm.com> wrote:
> 
> > Resending the patch with fixed style issues.
> > 
> > Signed-off-by: Pavan Naregundi <pavan@linux.vnet.ibm.com>
> > Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>
> > --
> > 
> > 
> > 
> > 
> > [fix-kexec.patch  text/x-patch (685B)]
> > diff -Naur a/kernel/kexec.c b/kernel/kexec.c
> > --- a/kernel/kexec.c	2010-06-08 21:17:21.850000033 +0530
> > +++ b/kernel/kexec.c	2010-06-09 18:01:37.590007921 +0530
> > @@ -1089,9 +1089,10 @@
> >  
> >  size_t crash_get_memory_size(void)
> >  {
> > -	size_t size;
> > +	size_t size = 0;
> >  	mutex_lock(&kexec_mutex);
> > -	size = crashk_res.end - crashk_res.start + 1;
> > +	if (crashk_res.end != crashk_res.start)
> > +		size = crashk_res.end - crashk_res.start + 1;
> >  	mutex_unlock(&kexec_mutex);
> >  	return size;
> >  }
> > @@ -1134,7 +1135,7 @@
> >  
> >  	free_reserved_phys_range(end, crashk_res.end);
> >  
> > -	if (start == end)
> > +	if ((start == end) && (crashk_res.parent != NULL))
> >  		release_resource(&crashk_res);
> >  	crashk_res.end = end - 1;
> 
> The patch doesn't have a changelog and I'd prefer not to have to crawl
> through the email thread and write one myself.
> 
> Please resend, including a full description of the bug and of its fix.

Subject: kexec: fix Oops in crash_shrink_memory()
From: Pavan Naregundi <pavan@linux.vnet.ibm.com>

When crashkernel is not enabled, "echo 0 > /sys/kernel/kexec_crash_size"
OOPSes the kernel in crash_shrink_memory. This happens when
crash_shrink_memory tries to release the 'crashk_res' resource which are
not reserved. Also value of "/sys/kernel/kexec_crash_size" shows as 1,
which should be 0.

This patch fixes the OOPS in crash_shrink_memory and shows
"/sys/kernel/kexec_crash_size" as 0 when crash kernel memory is not
reserved.

Signed-off-by: Pavan Naregundi <pavan@linux.vnet.ibm.com>
Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--=-LHlCRG1LvcuEh6hgenH6
Content-Disposition: attachment; filename="kexec-fix-oops-in-crash_shrink_memory.patch"
Content-Type: text/x-patch; name="kexec-fix-oops-in-crash_shrink_memory.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -uprN a/kernel/kexec.c b/kernel/kexec.c
--- a/kernel/kexec.c	2010-06-08 21:17:21.850000033 +0530
+++ b/kernel/kexec.c	2010-06-09 18:01:37.590007921 +0530
@@ -1089,9 +1089,10 @@ void crash_kexec(struct pt_regs *regs)
 
 size_t crash_get_memory_size(void)
 {
-	size_t size;
+	size_t size = 0;
 	mutex_lock(&kexec_mutex);
-	size = crashk_res.end - crashk_res.start + 1;
+	if (crashk_res.end != crashk_res.start)
+		size = crashk_res.end - crashk_res.start + 1;
 	mutex_unlock(&kexec_mutex);
 	return size;
 }
@@ -1134,7 +1135,7 @@ int crash_shrink_memory(unsigned long ne
 
 	free_reserved_phys_range(end, crashk_res.end);
 
-	if (start == end)
+	if ((start == end) && (crashk_res.parent != NULL))
 		release_resource(&crashk_res);
 	crashk_res.end = end - 1;
 

--=-LHlCRG1LvcuEh6hgenH6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--=-LHlCRG1LvcuEh6hgenH6--


