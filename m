Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQe3L-0003sh-Ua
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 13:30:09 +0000
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 12 Apr 2013 23:22:30 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7A2EC2BB0023
 for <kexec@lists.infradead.org>; Fri, 12 Apr 2013 23:29:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3CDTkaW5636456
 for <kexec@lists.infradead.org>; Fri, 12 Apr 2013 23:29:46 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3CDTqIw005256
 for <kexec@lists.infradead.org>; Fri, 12 Apr 2013 23:29:52 +1000
Message-ID: <51680C4D.1090309@linux.vnet.ibm.com>
Date: Fri, 12 Apr 2013 18:59:49 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Move scrubbing process from reader to writer.
References: <20130412151718.dc8eaa97cf73eddfea74edc0@mxc.nes.nec.co.jp>
 <20130412151756.afe14ce0df4cdd8bf96be9e6@mxc.nes.nec.co.jp>
In-Reply-To: <20130412151756.afe14ce0df4cdd8bf96be9e6@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: ptesarik@suse.cz, kexec@lists.infradead.org

On 04/12/2013 11:47 AM, Atsushi Kumagai wrote:
> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Date: Thu, 11 Apr 2013 09:36:36 +0900
> Subject: [PATCH 1/2] Move scrubbing process from reader to writer.
> 
> When create a dumpfile in the kdump-compressed format, scrubbing
> process is done in reading process via read_pfn(). But it would be
> better to do it just before actually writing the data like the
> case of ELF.
> 
> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

Hi Atsushi,

Changes looks good to me.

Thanks,
-Mahesh.

> ---
>  makedumpfile.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 9cf907c..725100b 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5337,7 +5337,6 @@ read_pfn(unsigned long long pfn, unsigned char *buf)
>  			ERRMSG("Can't get the page data.\n");
>  			return FALSE;
>  		}
> -		filter_data_buffer(buf, paddr, info->page_size);
>  		return TRUE;
>  	}
> 
> @@ -5360,7 +5359,6 @@ read_pfn(unsigned long long pfn, unsigned char *buf)
>  		ERRMSG("Can't get the page data.\n");
>  		return FALSE;
>  	}
> -	filter_data_buffer(buf, paddr, size1);
>  	if (size1 != info->page_size) {
>  		size2 = info->page_size - size1;
>  		if (!offset2) {
> @@ -5370,7 +5368,6 @@ read_pfn(unsigned long long pfn, unsigned char *buf)
>  				ERRMSG("Can't get the page data.\n");
>  				return FALSE;
>  			}
> -			filter_data_buffer(buf + size1, paddr + size1, size2);
>  		}
>  	}
>  	return TRUE;
> @@ -5805,6 +5802,7 @@ write_kdump_pages(struct cache_data *cd_header, struct cache_data *cd_page)
> 
>  		if (!read_pfn(pfn, buf))
>  			goto out;
> +		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
> 
>  		/*
>  		 * Exclude the page filled with zeros.
> @@ -5983,6 +5981,7 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
> 
>  		if (!read_pfn(pfn, buf))
>  			goto out;
> +		filter_data_buffer(buf, pfn_to_paddr(pfn), info->page_size);
> 
>  		/*
>  		 * Exclude the page filled with zeros.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
