Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3806DCA1008
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 16:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=teJlDQJiET67m1R3BMFocULYbm4uxaEl7um7lW6c+Z4=; b=geCv7Ea8yttB9r
	7vBFTVNYyUJn03Obclj0F+C15ZSeYU7KYfaVenijIiVWX8/ghD5zmaYtmpqbUtNEXnahB16qSUElb
	RRy3OqCJzyJZYjJ6+eseskoVQ5z5JNeNoA1THYIpbbAEhGm1VF9edET98lZ8dJs4AwLDixnEG1KLy
	tiR4LUEChJbZ5Z3zcpgdbSpDDefP1x1lYmp+KFSb0AiIRCHE4DiAyXWpJ1VsX2vf+ajdxBGzGvgvk
	d/JpQwlU/1pLBN0j26oXxfl67Gr32RefNfZckGl5Em2MsRAXMoVfjkKwm/EHvXOnKTm9lrAdTqv6o
	Wacd7gM8uAtPfvN3WlZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk43k-00000006vwm-2t7C;
	Fri, 30 Aug 2024 16:01:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk2sv-00000006ej7-0OLC
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 14:45:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725029155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poMuVC2rWak5xNQz8AshgocATbY4uKgllYK+isxtXuw=;
	b=bP9kyiAGr6AjVclXXBN4OfkiA0E0d0VrSGjnl9g92i8bAmvz1xZv1AjgvBPqKrfoNLkuNW
	Umfkxf3n7EoLTLGaRdeXZ9m4ASO1+2PdPcGf7lVcYXZv3EhlHlbLi6CUOZLwq+vTirD0Bl
	NhXFmNlT7CkV+uzhfqxXivswLKsy15c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-SJ0C32O-MsC2AVBv5PeHPA-1; Fri,
 30 Aug 2024 10:45:52 -0400
X-MC-Unique: SJ0C32O-MsC2AVBv5PeHPA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 843A21955F28;
	Fri, 30 Aug 2024 14:45:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD1D51955DD8;
	Fri, 30 Aug 2024 14:45:48 +0000 (UTC)
Date: Fri, 30 Aug 2024 22:45:44 +0800
From: Baoquan He <bhe@redhat.com>
To: Jacek Tomaka <jacekt@dugeo.com>
Cc: kexec@lists.infradead.org, horms@kernel.org, dan.j.williams@intel.com,
	Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: Re: [PATCH] Add support for soft reserved memory range
Message-ID: <ZtHbGIuXOAT59IBJ@MiWiFi-R3L-srv>
References: <20240814052024.25731-1-jacekt@dugeo.com>
 <20240814053313.35251-1-jacekt@dugeo.com>
MIME-Version: 1.0
In-Reply-To: <20240814053313.35251-1-jacekt@dugeo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_074557_281742_833F6D3F 
X-CRM114-Status: GOOD (  22.92  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

On 08/14/24 at 01:33pm, Jacek Tomaka wrote:
> Essentially catch up with e820 related changes in the kernel.
> Intel Sapphire Rappids MAX has high bandwidth memory which is
> precious resource that is better not allocated by the kernel.

Wondering what use cases you have encountered and want to use this patch
to resolve. Could you say more about it?

> 
> Userspace later can enable soft reserved range using daxctl.
> 
> Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
> ---
>  include/x86/x86-linux.h               | 2 ++
>  kexec/arch/i386/crashdump-x86.c       | 7 +++++++
>  kexec/arch/i386/kexec-multiboot-x86.c | 1 +
>  kexec/arch/i386/kexec-x86-common.c    | 5 +++++
>  kexec/arch/i386/x86-linux-setup.c     | 3 +++
>  kexec/firmware_memmap.c               | 2 ++
>  kexec/kexec.h                         | 1 +
>  7 files changed, 21 insertions(+)
> 
> diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
> index 9646102835..fbde93df94 100644
> --- a/include/x86/x86-linux.h
> +++ b/include/x86/x86-linux.h
> @@ -23,6 +23,8 @@ struct e820entry {
>  #define E820_NVS	4
>  #define E820_PMEM       7
>  #define E820_PRAM       12
> +#define E820_SOFT_RESERVED 0xefffffff
> +
>  } __attribute__((packed));
>  #endif
>  
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index a01031e570..49108b2032 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -288,6 +288,10 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  			type = RANGE_RESERVED;
>  		} else if (memcmp(str, "Reserved\n", 9) == 0) {
>  			type = RANGE_RESERVED;
> +		} else if (memcmp(str, "soft reserved\n", 14) == 0 ) {
> +			type = RANGE_SOFT_RESERVED;
> +		} else if (memcmp(str, "Soft Reserved\n", 14) == 0 ) {
> +			type = RANGE_SOFT_RESERVED;
>  		} else if (memcmp(str, "GART\n", 5) == 0) {
>  			gart_start = start;
>  			gart_end = end;
> @@ -615,6 +619,8 @@ static void cmdline_add_memmap_internal(char *cmdline, unsigned long startk,
>  		strcat (str_mmap, "K@");
>  	else if (type == RANGE_RESERVED)
>  		strcat (str_mmap, "K$");
> +	else if (type == RANGE_SOFT_RESERVED)
> +		strcat (str_mmap, "K*");
>  	else if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
>  		strcat (str_mmap, "K#");
>  	else if (type == RANGE_PRAM)
> @@ -985,6 +991,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>  		if ( !( mem_range[i].type == RANGE_ACPI
>  			|| mem_range[i].type == RANGE_ACPI_NVS
>  			|| mem_range[i].type == RANGE_RESERVED
> +			|| mem_range[i].type == RANGE_SOFT_RESERVED
>  			|| mem_range[i].type == RANGE_PMEM
>  			|| mem_range[i].type == RANGE_PRAM))
>  			continue;
> diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
> index 33c885a2fa..49d57cb5ae 100644
> --- a/kexec/arch/i386/kexec-multiboot-x86.c
> +++ b/kexec/arch/i386/kexec-multiboot-x86.c
> @@ -379,6 +379,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
>  			mmap[i].Type = 4;
>  			break;
>  		case RANGE_RESERVED:
> +		case RANGE_SOFT_RESERVED:
>  		default:
>  			mmap[i].Type = 2;  /* Not RAM (reserved) */
>  		}
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> index ffc95a9e43..116c4f4fd3 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -99,6 +99,9 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
>  		else if (strncasecmp(str, "reserved\n", 9) == 0) {
>  			type = RANGE_RESERVED;
>  		}
> +		else if (strncasecmp(str, "soft reserved\n", 9) == 0) {
> +			type = RANGE_SOFT_RESERVED;
> +		}
>  		else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
>  			type = RANGE_ACPI;
>  		}
> @@ -170,6 +173,8 @@ unsigned xen_e820_to_kexec_type(uint32_t type)
>  			return RANGE_PMEM;
>  		case E820_PRAM:
>  			return RANGE_PRAM;
> +		case E820_SOFT_RESERVED;
> +			return RANGE_SOFT_RESERVED;
>  		case E820_RESERVED:
>  		default:
>  			return RANGE_RESERVED;
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 73251b9339..afc83fe729 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -755,6 +755,9 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
>  			case RANGE_PRAM:
>  				e820[i].type = E820_PRAM;
>  				break;
> +			case RANGE_SOFT_RESERVED:
> +				e820[i].type = E820_SOFT_RESERVED;
> +				break;
>  			default:
>  			case RANGE_RESERVED:
>  				e820[i].type = E820_RESERVED;
> diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
> index 457c3dc9a6..fa0c22140a 100644
> --- a/kexec/firmware_memmap.c
> +++ b/kexec/firmware_memmap.c
> @@ -182,6 +182,8 @@ static int parse_memmap_entry(const char *entry, struct memory_range *range)
>  		range->type = RANGE_RESERVED;
>  	else if (strcmp(type, "Reserved") == 0)
>  		range->type = RANGE_RESERVED;
> +        else if (strcmp(type, "Soft Reserved") == 0)
> +                range->type = RANGE_SOFT_RESERVED;
>  	else if (strcmp(type, "Unknown E820 type") == 0)
>  		range->type = RANGE_RESERVED;
>  	else if (strcmp(type, "ACPI Non-volatile Storage") == 0)
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 31c323f674..dbb27a7607 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -139,6 +139,7 @@ struct memory_range {
>  #define RANGE_UNCACHED	4
>  #define RANGE_PMEM		6
>  #define RANGE_PRAM		11
> +#define RANGE_SOFT_RESERVED 0xefffffff
>  };
>  
>  struct memory_ranges {
> -- 
> 2.17.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
