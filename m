Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zcvej-0001sG-Fs
 for kexec@lists.infradead.org; Fri, 18 Sep 2015 13:24:50 +0000
Date: Fri, 18 Sep 2015 21:25:03 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] Load crash kernel high on x86
Message-ID: <20150918132503.GA23143@dhcp-128-25.nay.redhat.com>
References: <20150918080324.69d7b9d5@hananiah.suse.cz>
 <20150918113902.GA22869@dhcp-128-25.nay.redhat.com>
 <20150918151146.4a95752b@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150918151146.4a95752b@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 09/18/15 at 03:11pm, Petr Tesarik wrote:
> On Fri, 18 Sep 2015 19:39:02 +0800
> Minfei Huang <mhuang@redhat.com> wrote:
> 
> > On 09/18/15 at 08:03am, Petr Tesarik wrote:
> > > Hello,
> > > 
> > > There may be more than one crash kernel regions on x86. However, the kexec
> > > syscall checks that target address is within crashk_res boundaries. Looking
> > > at the logic in arch/x86/kernel/setup.c, there are only two possible layouts:
> > > 
> > >   1. crashk_res is below 4G, and there is only one region,
> > >   2. crashk_res is above 4G, and crashk_low_res is below 4G
> > > 
> > > In either case, kexec-tools must pick the highest region.
> > > 
> > > Currently, kexec-tools picks the largest region. If high reservation is
> > > smaller than low, kexec(2) returns -EADDRNOTAVAIL, and kexec prints out
> > > this error message:
> > > 
> > > kexec_load failed: Cannot assign requested address
> > > 
> > > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > > ---
> > >  kexec/arch/i386/crashdump-x86.c | 12 ++----------
> > >  1 file changed, 2 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > > index 63959b7..2710a9e 100644
> > > --- a/kexec/arch/i386/crashdump-x86.c
> > > +++ b/kexec/arch/i386/crashdump-x86.c
> > > @@ -1034,16 +1034,8 @@ int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end)
> > >  	if (!crash_reserved_mem_nr)
> > >  		return -1;
> > >  
> > > -	for (i = crash_reserved_mem_nr - 1; i >= 0; i--) {
> > > -		sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
> > > -		if (sz <= sz_max)
> > > -			continue;
> > > -		sz_max = sz;
> > > -		idx = i;
> > > -	}
> > > -
> > > -	*start = crash_reserved_mem[idx].start;
> > > -	*end = crash_reserved_mem[idx].end;
> > > +	*start = crash_reserved_mem[crash_reserved_mem_nr - 1].start;
> > > +	*end = crash_reserved_mem[crash_reserved_mem_nr - 1].end;
> > >  
> > >  	return 0;
> > 
> > It is not a proper function name for what it does in your patch. How
> 
> True. It should be now called something like get_crashk_res_location().
> I'm going to change that.
> 
> > about get_reserved_mem_limit()? Also it is appreciative, if you can
> > comment it more detail.
> 
> I'm not sure what would be more detail. Regarding the motivation, I
> have already documented why it fails and what are the symptoms of
> failure. Regarding the implementation, the code speaks for itself, IMO.
> 
> Can you explain what kind of detail you're missing, please?

Sorry, What I mean is to comment above the function why we choose the
region crash_reserved_mem[crash_reserved_mem_nr - 1].

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
