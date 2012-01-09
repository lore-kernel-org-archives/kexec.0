Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RkCRA-0003pH-Li
 for kexec@lists.infradead.org; Mon, 09 Jan 2012 10:26:45 +0000
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hanpt@linux.vnet.ibm.com>;
 Mon, 9 Jan 2012 05:26:43 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q09AQEOE290330
 for <kexec@lists.infradead.org>; Mon, 9 Jan 2012 05:26:14 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q09AQERt005932
 for <kexec@lists.infradead.org>; Mon, 9 Jan 2012 05:26:14 -0500
Date: Mon, 9 Jan 2012 18:26:26 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Subject: Re: [PATCH] Correct magic varible of function name in debug code
Message-ID: <20120109102626.GB2563@hpt.localdomain>
References: <20120109100230.GA29322@hpt.localdomain>
 <4F0ABDB2.9010200@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F0ABDB2.9010200@redhat.com>
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
Cc: horms@verge.net.au, kexec@lists.infradead.org

On Mon, Jan 09, 2012 at 06:13:06PM +0800, Dave Young wrote:
> On 01/09/2012 06:02 PM, Han Pingtian wrote:
> 
> > The magic varible of function name should be uppercase.
> > 
> > Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> > ---
> >  kexec/crashdump.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/kexec/crashdump.c b/kexec/crashdump.c
> > index e7ac42c..847d080 100644
> > --- a/kexec/crashdump.c
> > +++ b/kexec/crashdump.c
> > @@ -103,7 +103,7 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
> >  	*addr = (uint64_t) temp;
> >  	*len = MAX_NOTE_BYTES; /* we should get this from the kernel instead */
> >  #ifdef DEBUG
> > -	printf("%s: crash_notes addr = %Lx\n", __function__, *addr);
> > +	printf("%s: crash_notes addr = %Lx\n", __FUNCTION__, *addr);
> >  #endif
> >  
> >  	fclose(fp);
> 
> 
> 
> Hi, Han
> 
> Glad to see you here.
> 
Thanks.
> I post a similar fix for this issue, please see:
> http://lists.infradead.org/pipermail/kexec/2011-December/005889.html
Great. I'm not very familiar with that, just want to point out there 
is a problem. Hope it can be fixed soon :) 
> 
> -- 
> Thanks
> Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
