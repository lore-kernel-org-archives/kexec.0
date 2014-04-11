Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYRkF-0001m5-5a
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 03:03:11 +0000
Date: Fri, 11 Apr 2014 11:02:45 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v5 03/10] x86, cleanup: add other types of memory range
 for 2nd kernel boot to memmap_p
Message-ID: <20140411030245.GE2944@dhcp-17-89.nay.redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
 <1397121186-9353-4-git-send-email-chaowang@redhat.com>
 <20140411022449.GF5493@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140411022449.GF5493@dhcp-16-198.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/11/14 at 10:24am, Dave Young wrote:
> On 04/10/14 at 05:12pm, WANG Chao wrote:
> > Now memmap_p contains all the memory range for 2nd kernel boot.
> 
> Hi, the patch description is not infomative, I still do not get the idea
> why this patch is need, what it is doing..
> 
> > 
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > ---
> >  kexec/arch/i386/crashdump-x86.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index e695eaf..43eb8f7 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -1006,12 +1006,15 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> >  
> >  	/* Inform second kernel about the presence of ACPI tables. */
> >  	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
> > -		unsigned long start, end;
> > +		unsigned long start, end, size, type;
> >  		if ( !( mem_range[i].type == RANGE_ACPI
> >  			|| mem_range[i].type == RANGE_ACPI_NVS) )
> >  			continue;
> >  		start = mem_range[i].start;
> >  		end = mem_range[i].end;
> > +		type = mem_range[i].type;
> > +		size = end - start;
> 
> Probably size = end - start + 1;

Right. end is inclusive. Will fix.

> 
> > +		add_memmap(memmap_p, &nr_memmap_p, start, size, type);
> >  		cmdline_add_memmap_acpi(mod_cmdline, start, end);
> >  	}
> >  	return 0;
> > -- 
> > 1.8.5.3
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
