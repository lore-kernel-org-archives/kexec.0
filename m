Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUv6X-0002mX-2j
 for kexec@lists.infradead.org; Tue, 01 Apr 2014 09:35:37 +0000
Date: Tue, 1 Apr 2014 17:36:27 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 2/4] x86: Store memory ranges globally used for crash
 kernel to boot into
Message-ID: <20140401093627.GA22714@dhcp-16-126.nay.redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <1395216241-13983-3-git-send-email-chaowang@redhat.com>
 <20140328032438.GD26116@dhcp-16-126.nay.redhat.com>
 <20140328061353.GF2944@dhcp-17-89.nay.redhat.com>
 <20140328064330.GG26116@dhcp-16-126.nay.redhat.com>
 <20140401070429.GI2944@dhcp-17-89.nay.redhat.com>
 <20140401084119.GB15841@dhcp-16-126.nay.redhat.com>
 <20140401085414.GL2944@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140401085414.GL2944@dhcp-17-89.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/01/14 at 04:54pm, WANG Chao wrote:
> On 04/01/14 at 04:41pm, Dave Young wrote:
> > On 04/01/14 at 03:04pm, WANG Chao wrote:
> > > On 03/28/14 at 02:43pm, Dave Young wrote:
> > > > On 03/28/14 at 02:13pm, WANG Chao wrote:
> > > > > On 03/28/14 at 11:24am, Dave Young wrote:
> > > > > > >  
> > > > > > > +static void exclude_ram(struct memory_range *mr, int *nr_mr)
> > > > > > > +{
> > > > > > > +	int ranges, i, j, m;
> > > > > > > +
> > > > > > > +	ranges = *nr_mr;
> > > > > > > +	for (i = 0, j = 0; i < ranges; i++) {
> > > > > > > +		if (mr[j].type == RANGE_RAM) {
> > > > > > > +			dbgprintf("Remove RAM %016llx-%016llxx: (%d)\n", mr[j].start, mr[j].end, mr[j].type);
> > > > > > > +			for (m = j; m < *nr_mr; m++)
> > > > > > > +				mr[m] = mr[m+1];
> > > > > > > +			(*nr_mr)--;
> > > > > > > +		} else {
> > > > > > > +			j++;
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	dbgprint_mem_range("After remove RAM", mr, *nr_mr);
> > > > > > > +}
> > > > > > 
> > > > > > This is probably not necessary, what I understand you are doing is below:
> > > > > > 
> > > > > > get_crash_memory_ranges()
> > > > > >  -> collect all SYSTEM_RAM, ACPI, ACPI_NVS ranges, exclude crash reserved ranges.
> > > > > >  -> the system ram ranges are used to create elf header
> > > > > >  -> the ACPI, ACPI_NVS ranges are used by cmdline_add_memmap_acpi etc.
> > > > > 
> > > > > Yes.
> > > > > 
> > > > > > 
> > > > > > memmap_p
> > > > > >  -> contains all the crash reserved ranges
> > > > > >  -> to be used by cmdline_add_memmap
> > > > > 
> > > > > There's no memmap_p. I'll reuse crash_memory_ranges structure to store
> > > > > crash reserved ranges, ACPI and ACPI_NVS ranges. So after building ELF
> > > > > headers for 1st kernel memory ranges, all I have to do is exclude the
> > > > > SYSTEM_RAM and add crash_reserved to crash_memory_ranges. And then
> > > > > crash_memory_ranges can be used as 2nd kernel memory ranges.
> > > > 
> > > > How about do nothing and directly use the mem_ranges:
> > > >  * skip RANGE_RAM, only add the range which is not RANGE_RAM
> > > >  * if the range is RANGE_CRASH_KERNEL (introduce a new type?) then use it as SYSTEM_RAM for 2nd kernel.
> > > 
> > > I prefer not do this change in this patchset. Since current
> > > implementation is fine, it looks more like a cleanup to me and we can do
> > > that later.
> > 
> > Ok, that's fine, but I'm still not keen about exclude_ram. Could you manage
> > to drop this function? 
> 
> exclude_ram() is just a static function that my code would use and I
> certainly need a function like that this time. So why are you still keen
> about dropping it :(

Just suppose you agree with the future cleanup, you introduce it now and remove it
later it looks not good so I wonder if it's possible to drop it now and check the
range type instead.

If it's a *must* then I will not object

Thanks
Dave.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
