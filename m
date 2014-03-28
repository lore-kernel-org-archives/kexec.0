Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTPTk-0001h0-TS
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 05:37:22 +0000
Date: Fri, 28 Mar 2014 13:36:54 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v4 2/4] x86: Store memory ranges globally used for crash
 kernel to boot into
Message-ID: <20140328053654.GE2944@dhcp-17-89.nay.redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <1395216241-13983-3-git-send-email-chaowang@redhat.com>
 <20140328021913.GC26116@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140328021913.GC26116@dhcp-16-126.nay.redhat.com>
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

On 03/28/14 at 10:19am, Dave Young wrote:
> On 03/19/14 at 04:03pm, WANG Chao wrote:
> > Use these two variables to store the memory ranges and the number of
> > memory ranges for crash kernel to boot into:
> > 
> > struct memory_range crash_memory_range;
> > int crash_memory_range;
> > 
> > These two variables are not static now, so can be used in other file
> > later.
> > 
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > Tested-by: Linn Crosetto <linn@hp.com>
> > ---
> >  kexec/arch/i386/crashdump-x86.c | 134 ++++++++++++++++++++++------------------
> >  kexec/arch/i386/crashdump-x86.h |   5 +-
> >  2 files changed, 77 insertions(+), 62 deletions(-)
> > 
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index 979c2bd..c55a6b1 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -179,7 +179,8 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end);
> >  
> >  /* Stores a sorted list of RAM memory ranges for which to create elf headers.
> >   * A separate program header is created for backup region */
> > -static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
> > +struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
> > +int crash_memory_ranges;
> >  
> >  /* Memory region reserved for storing panic kernel and other data. */
> >  #define CRASH_RESERVED_MEM_NR	8
> > @@ -201,7 +202,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> >  				   int kexec_flags, unsigned long lowmem_limit)
> 
> It's not necessary to replace every static vars in the function, since there's param
> *ranges and **range, so how about just replace them in caller function.

OK. Will do.

> 
> >  {
> >  	const char *iomem = proc_iomem();
> > -	int memory_ranges = 0, gart = 0, i;
> > +	int gart = 0, i;
> >  	char line[MAX_LINE];
> >  	FILE *fp;
> >  	unsigned long long start, end;
> > @@ -218,7 +219,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> >  		char *str;
> >  		int type, consumed, count;
> >  
> > -		if (memory_ranges >= CRASH_MAX_MEMORY_RANGES)
> > +		if (crash_memory_ranges >= CRASH_MAX_MEMORY_RANGES)
> >  			break;
> >  		count = sscanf(line, "%Lx-%Lx : %n",
> >  			&start, &end, &consumed);
> > @@ -250,17 +251,17 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> >  			continue;
> >  		}
> >  
> > -		crash_memory_range[memory_ranges].start = start;
> > -		crash_memory_range[memory_ranges].end = end;
> > -		crash_memory_range[memory_ranges].type = type;
> > +		crash_memory_range[crash_memory_ranges].start = start;
> > +		crash_memory_range[crash_memory_ranges].end = end;
> > +		crash_memory_range[crash_memory_ranges].type = type;
> >  
> > -		segregate_lowmem_region(&memory_ranges, lowmem_limit);
> > +		segregate_lowmem_region(&crash_memory_ranges, lowmem_limit);
> >  
> > -		memory_ranges++;
> > +		crash_memory_ranges++;
> >  	}
> >  	fclose(fp);
> >  	if (kexec_flags & KEXEC_PRESERVE_CONTEXT) {
> > -		for (i = 0; i < memory_ranges; i++) {
> > +		for (i = 0; i < crash_memory_ranges; i++) {
> >  			if (crash_memory_range[i].end > 0x0009ffff) {
> >  				crash_reserved_mem[0].start = \
> >  					crash_memory_range[i].start;
> > @@ -278,17 +279,17 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> >  	}
> >  
> >  	for (i = 0; i < crash_reserved_mem_nr; i++)
> > -		if (exclude_region(&memory_ranges, crash_reserved_mem[i].start,
> > +		if (exclude_region(&crash_memory_ranges, crash_reserved_mem[i].start,
> >  				crash_reserved_mem[i].end) < 0)
> >  			return -1;
> >  
> >  	if (gart) {
> >  		/* exclude GART region if the system has one */
> > -		if (exclude_region(&memory_ranges, gart_start, gart_end) < 0)
> > +		if (exclude_region(&crash_memory_ranges, gart_start, gart_end) < 0)
> >  			return -1;
> >  	}
> >  	*range = crash_memory_range;
> > -	*ranges = memory_ranges;
> > +	*ranges = crash_memory_ranges;
> >  
> >  	return 0;
> >  }
> > @@ -324,7 +325,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
> 
> Ditto for get_crash_memory_ranges_xen, just fix the caller function instead of use
> global variable in this function.

Will do.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
