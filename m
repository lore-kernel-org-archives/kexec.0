Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZZHK-00033h-M5
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 05:17:59 +0000
Date: Mon, 14 Apr 2014 13:17:31 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH RESEND v5 04/10] x86, cleanup: add_memmap() only do
 alignment check on RANGE_RAM
Message-ID: <20140414051731.GA18927@dhcp-17-89.nay.redhat.com>
References: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
 <1397183011-1526-5-git-send-email-chaowang@redhat.com>
 <20140414021351.GK22411@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140414021351.GK22411@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/14/14 at 11:13am, Simon Horman wrote:
> Could you please explain why this is necessary.

add_memmap() will also add memory range with type RANGE_ACPI and
RANGE_ACPI_NVS (RANGE_RESERVED in the future) besides RANGE_RAM to
memmap_p.

Among these types of memory range, only RANGE_RAM needs to
be aligned with certain alignment. RANGE_ACPI, RANGE_ACPI_NVS and
RANGE_RESERVED doesn't have to be aligned.

I'll add above comment to the patch description.

> 
> Also, it seems to me that it would make sense to move this
> patch so that is is immediately after patch 2 in the series.

Will do.

> 
> On Fri, Apr 11, 2014 at 10:23:25AM +0800, WANG Chao wrote:
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > ---
> >  kexec/arch/i386/crashdump-x86.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index 43eb8f7..4072c10 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -482,8 +482,8 @@ static int add_memmap(struct memory_range *memmap_p, int *nr_memmap_p,
> >  	int i, j, nr_entries = 0, tidx = 0, align = 1024;
> >  	unsigned long long mstart, mend;
> >  
> > -	/* Do alignment check. */
> > -	if ((addr%align) || (size%align))
> > +	/* Do alignment check if it's RANGE_RAM */
> > +	if ((type == RANGE_RAM) && ((addr%align) || (size%align)))
> >  		return -1;
> >  
> >  	/* Make sure at least one entry in list is free. */
> > -- 
> > 1.8.5.3
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
