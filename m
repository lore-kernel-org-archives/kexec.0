Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYR5U-0007bs-IU
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 02:21:04 +0000
Date: Fri, 11 Apr 2014 10:20:10 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 06/10] x86, cleanup: Store crash memory ranges
 kexec_info
Message-ID: <20140411022010.GD5493@dhcp-16-198.nay.redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
 <1397121186-9353-8-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397121186-9353-8-git-send-email-chaowang@redhat.com>
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

On 04/10/14 at 05:13pm, WANG Chao wrote:
> Add two new members to kexec_info structure:
> 
> struct memory_range *crash_range
> int nr_crash_ranges;
> 
> crash_range contains the memory ranges used to boot 2nd kernel.
> nr_crash_ranges contains the count of the crash memory ranges.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 6 ++++++
>  kexec/kexec.h                   | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 2437c30..2a6871d 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -997,6 +997,12 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  		add_memmap(memmap_p, &nr_memmap_p, start, size, type);
>  		cmdline_add_memmap_acpi(mod_cmdline, start, end);
>  	}
> +
> +	/* Store 2nd kernel boot memory ranges for later reference in
> +	 * x86-setup-linux.c: setup_linux_system_parameters() */
> +	info->crash_range = memmap_p;
> +	info->nr_crash_ranges = nr_memmap_p;
> +
>  	return 0;
>  }
>  
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index d69bba2..22d4a42 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -148,6 +148,8 @@ struct kexec_info {
>  	int nr_segments;
>  	struct memory_range *memory_range;
>  	int memory_ranges;
> +	struct memory_range *crash_range;
> +	int nr_crash_ranges;

Is the memory_range field used in crash case? If not how about reuse the field for crash ranges.

>  	void *entry;
>  	struct mem_ehdr rhdr;
>  	unsigned long backup_start;
> -- 
> 1.8.5.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
