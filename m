Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZZNt-0005U6-6g
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 05:24:45 +0000
Date: Mon, 14 Apr 2014 13:24:18 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH RESEND v5 03/10] x86, cleanup: add other types of memory
 range for 2nd kernel boot to memmap_p
Message-ID: <20140414052418.GB18927@dhcp-17-89.nay.redhat.com>
References: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
 <1397183011-1526-4-git-send-email-chaowang@redhat.com>
 <20140414021242.GJ22411@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140414021242.GJ22411@verge.net.au>
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

On 04/14/14 at 11:12am, Simon Horman wrote:
> On Fri, Apr 11, 2014 at 10:23:24AM +0800, WANG Chao wrote:
> > Now memmap_p contains all the memory range for 2nd kernel boot.
> 
> Could you please include a fuller explanation of what this patch
> achieves and the motivation for it.

In load_crashdump_segments(), memmap_p used to contain RANGE_RAM memory
range for booting 2nd kernel. Now adding types of RANGE_ACPI and
RANGE_ACPI_NVS to memmap_p, so later we can pass all the types of memory
range to 2nd kernel. These all types of memory ranges are all stored in
memmap_p.

I'll add above comment to patch description.

Thanks
WANG Chao

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
