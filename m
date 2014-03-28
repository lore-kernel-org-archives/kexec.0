Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTNOT-0008Fk-Ae
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 03:23:45 +0000
Date: Fri, 28 Mar 2014 11:24:38 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 2/4] x86: Store memory ranges globally used for crash
 kernel to boot into
Message-ID: <20140328032438.GD26116@dhcp-16-126.nay.redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <1395216241-13983-3-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395216241-13983-3-git-send-email-chaowang@redhat.com>
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

>  
> +static void exclude_ram(struct memory_range *mr, int *nr_mr)
> +{
> +	int ranges, i, j, m;
> +
> +	ranges = *nr_mr;
> +	for (i = 0, j = 0; i < ranges; i++) {
> +		if (mr[j].type == RANGE_RAM) {
> +			dbgprintf("Remove RAM %016llx-%016llxx: (%d)\n", mr[j].start, mr[j].end, mr[j].type);
> +			for (m = j; m < *nr_mr; m++)
> +				mr[m] = mr[m+1];
> +			(*nr_mr)--;
> +		} else {
> +			j++;
> +		}
> +	}
> +
> +	dbgprint_mem_range("After remove RAM", mr, *nr_mr);
> +}

This is probably not necessary, what I understand you are doing is below:

get_crash_memory_ranges()
 -> collect all SYSTEM_RAM, ACPI, ACPI_NVS ranges, exclude crash reserved ranges.
 -> the system ram ranges are used to create elf header
 -> the ACPI, ACPI_NVS ranges are used by cmdline_add_memmap_acpi etc.

memmap_p
 -> contains all the crash reserved ranges
 -> to be used by cmdline_add_memmap

The several memory ranges are twisted and somehow the funcions are duplicate.

So how about just keep one memory ranges array which contains all the ranges which
include system_ram, acpi, acpi_nvs, crash_reserved range.

In the crashdump-elf.c the function for creating elf headers will check the
range type, it will just skip the range which is not ram.

Ditto for other functions they can also just select what range type they need instead
of creating these different arrays which is confusing.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
