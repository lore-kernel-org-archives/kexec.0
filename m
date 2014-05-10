Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WjPFo-00026V-CO
 for kexec@lists.infradead.org; Sun, 11 May 2014 08:37:04 +0000
Date: Sun, 11 May 2014 08:59:17 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RESEND] condition check fix
Message-ID: <20140510235917.GA2595@verge.net.au>
References: <1399548377-10417-1-git-send-email-chaowang@redhat.com>
 <20140508141429.GD9224@redhat.com>
 <20140510234354.GG31760@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140510234354.GG31760@verge.net.au>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>

On Sun, May 11, 2014 at 08:43:54AM +0900, Simon Horman wrote:
> On Thu, May 08, 2014 at 10:14:29AM -0400, Vivek Goyal wrote:
> > On Thu, May 08, 2014 at 07:26:17PM +0800, WANG Chao wrote:
> > > In commit 91f5b9c ("kdump: pass e820 reserved region to 2nd kernel via
> > > e820 table or setup_data"), I made a wrong condition check.
> > > 
> > > We should only add cmdline for a memory range if --pass-memmap-cmdline
> > > and the range type isn't RANGE_RESERVED.
> > > 
> > > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > 
> > Ok, this fixes the issue for me. Thanks.
> > 
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> 
> Thanks, and apologies for the delay.
> I am currently returning from a weeks vacation.
> I have applied this locally and will push it some
> time after I get off the plane ride home.
> 
> > BTW, on a related note, I see that we are doing GART check two times.
> > 
> >                 } else if (memcmp(str, "GART\n", 5) == 0) {
> >                 } else if (memcmp(str, "GART\n", 5) == 0) {
> > 
> > I am not sure if it is due to your patches or not.
> 
> I believe it is introduced in the same patch that is mentioned above.
> Chao, could you post a fix?

I see you have already done so, thanks.

> 
> > Thanks
> > Vivek
> > 
> > > ---
> > >  kexec/arch/i386/crashdump-x86.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > > index cc33347..999a837 100644
> > > --- a/kexec/arch/i386/crashdump-x86.c
> > > +++ b/kexec/arch/i386/crashdump-x86.c
> > > @@ -1000,7 +1000,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> > >  		type = mem_range[i].type;
> > >  		size = end - start + 1;
> > >  		add_memmap(memmap_p, &nr_memmap, start, size, type);
> > > -		if (arch_options.pass_memmap_cmdline || type != RANGE_RESERVED)
> > > +		if (arch_options.pass_memmap_cmdline && type != RANGE_RESERVED)
> > >  			cmdline_add_memmap_acpi(mod_cmdline, start, end);
> > >  	}
> > >  
> > > -- 
> > > 1.9.0
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
