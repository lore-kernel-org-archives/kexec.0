Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RTD9a-0008VW-Ab
 for kexec@lists.infradead.org; Wed, 23 Nov 2011 13:46:23 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
 (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
 by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id pANDkHOA013158
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 13:46:17 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pANDkGSc2637966
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 13:46:16 GMT
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pANDkGxT017022
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 06:46:16 -0700
Message-ID: <1322055976.10119.17.camel@br98xy6r>
Subject: Re: [PATCH v2] kdump: crashk_res init check for
 /sys/kernel/kexec_crash_size
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 23 Nov 2011 14:46:16 +0100
In-Reply-To: <4ECCF669.6080007@redhat.com>
References: <1322043068.10119.7.camel@br98xy6r>
 <20111123102214.GA4914@verge.net.au> <1322054283.10119.11.camel@br98xy6r>
 <4ECCF669.6080007@redhat.com>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
To: Dave Young <dyoung@redhat.com>
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, "Eric W.
 Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hi Dave,

On Wed, 2011-11-23 at 21:34 +0800, Dave Young wrote:
> On 11/23/2011 09:18 PM, Michael Holzheu wrote:
> 
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > Currently it is possible to set the crash_size via the sysfs
> > /sys/kernel/kexec_crash_size even if no crash kernel memory has
> > been defined with the "crashkernel" parameter. In this case
> > "crashk_res" is not initialized and crashk_res.start = crashk_res.end = 0.
> > Unfortunately resource_size(&crashk_res) returns 1 in this case.
> > This breaks the s390 implementation of crash_(un)map_reserved_pages().
> > 
> > To fix the problem the correct "old_size" is now calculated in
> > crash_shrink_memory(). "old_size is set to "0" if crashk_res is
> > not initialized. With this change crash_shrink_memory() will do nothing,
> > when "crashk_res" is not initialized. It will return "0" for
> > "echo 0 > /sys/kernel/kexec_crash_size" and -EINVAL for
> > "echo [not zero] > /sys/kernel/kexec_crash_size".
> > 
> > In addition to that this patch also simplifies the "ret = -EINVAL"
> > vs. "ret = 0" logic as suggested by Simon Horman.
> > 
> > Cc: Simon Horman <horms@verge.net.au>
> > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > ---
> >  kernel/kexec.c |   10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1131,7 +1131,7 @@ void __weak crash_free_reserved_phys_ran
> >  int crash_shrink_memory(unsigned long new_size)
> >  {
> >  	int ret = 0;
> > -	unsigned long start, end;
> > +	unsigned long start, end, old_size;
> 
> 
> Sorry for jump in a little late, instead of introduce a new variable,
> why not add something like:
> 
> if (!end)
> 	return -EINVAL;

If the crashkernel parameter is not set, "/sys/kernel/kexec_crash_size"
returns zero:

cat /sys/kernel/kexec_crash_size
0

So I think if we set it again to zero we should *not* return -EINVAL:

echo 0 > /sys/kernel/kexec_crash_size
--> Exit code should be zero in this case

Otherwise we would change the current behavior.

And besides of that, I think introducing the "old_size" variable makes
the code more readable.

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
