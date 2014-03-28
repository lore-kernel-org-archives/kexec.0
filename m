Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTQ3b-00026r-2T
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 06:14:24 +0000
Date: Fri, 28 Mar 2014 14:13:53 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v4 2/4] x86: Store memory ranges globally used for crash
 kernel to boot into
Message-ID: <20140328061353.GF2944@dhcp-17-89.nay.redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <1395216241-13983-3-git-send-email-chaowang@redhat.com>
 <20140328032438.GD26116@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140328032438.GD26116@dhcp-16-126.nay.redhat.com>
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

On 03/28/14 at 11:24am, Dave Young wrote:
> >  
> > +static void exclude_ram(struct memory_range *mr, int *nr_mr)
> > +{
> > +	int ranges, i, j, m;
> > +
> > +	ranges = *nr_mr;
> > +	for (i = 0, j = 0; i < ranges; i++) {
> > +		if (mr[j].type == RANGE_RAM) {
> > +			dbgprintf("Remove RAM %016llx-%016llxx: (%d)\n", mr[j].start, mr[j].end, mr[j].type);
> > +			for (m = j; m < *nr_mr; m++)
> > +				mr[m] = mr[m+1];
> > +			(*nr_mr)--;
> > +		} else {
> > +			j++;
> > +		}
> > +	}
> > +
> > +	dbgprint_mem_range("After remove RAM", mr, *nr_mr);
> > +}
> 
> This is probably not necessary, what I understand you are doing is below:
> 
> get_crash_memory_ranges()
>  -> collect all SYSTEM_RAM, ACPI, ACPI_NVS ranges, exclude crash reserved ranges.
>  -> the system ram ranges are used to create elf header
>  -> the ACPI, ACPI_NVS ranges are used by cmdline_add_memmap_acpi etc.

Yes.

> 
> memmap_p
>  -> contains all the crash reserved ranges
>  -> to be used by cmdline_add_memmap

There's no memmap_p. I'll reuse crash_memory_ranges structure to store
crash reserved ranges, ACPI and ACPI_NVS ranges. So after building ELF
headers for 1st kernel memory ranges, all I have to do is exclude the
SYSTEM_RAM and add crash_reserved to crash_memory_ranges. And then
crash_memory_ranges can be used as 2nd kernel memory ranges.

> 
> The several memory ranges are twisted and somehow the funcions are duplicate.

These functions look like similar but each does serve for different purpose.

> 
> So how about just keep one memory ranges array which contains all the ranges which
> include system_ram, acpi, acpi_nvs, crash_reserved range.
> 
> In the crashdump-elf.c the function for creating elf headers will check the
> range type, it will just skip the range which is not ram.

We don't build EFL headers for crash_reserved ranges. So we can't store
system ram and crash_reserved together before building EFL header.

> 
> Ditto for other functions they can also just select what range type they need instead
> of creating these different arrays which is confusing.
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
