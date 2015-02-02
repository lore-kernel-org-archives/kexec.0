Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YI7jx-0001rg-F0
 for kexec@lists.infradead.org; Mon, 02 Feb 2015 03:31:58 +0000
Date: Mon, 2 Feb 2015 11:31:30 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] ppc64: erase unnecessary segment info printing
Message-ID: <20150202033130.GA5398@dhcp-16-116.nay.redhat.com>
References: <1414570795-29258-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1414570795-29258-1-git-send-email-bhe@redhat.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

Hi Simon,

ping.

Could you please have a look at this patch and merge it if you think
it's OK?

Thanks
Baoquan

On 10/29/14 at 04:19pm, Baoquan He wrote:
> In ppc64 loading, it will print the segment information. This is not
> wanted since other Archs don't have this. People even think there's
> something wrong. So erase it to make it be consistent with other Archs.
> 
> And if people really want to check these info, they can specify "-d"
> option. They are printed in print_segments() too.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  kexec/arch/ppc64/kexec-elf-ppc64.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
> index ce10367..4a1540e 100644
> --- a/kexec/arch/ppc64/kexec-elf-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
> @@ -377,10 +377,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>  	dbgprintf("opal_base is %llx\n", (unsigned long long) my_opal_base);
>  	dbgprintf("opal_entry is %llx\n", (unsigned long long) my_opal_entry);
>  
> -	for (i = 0; i < info->nr_segments; i++)
> -		fprintf(stderr, "segment[%d].mem:%p memsz:%zu\n", i,
> -			info->segment[i].mem, info->segment[i].memsz);
> -
>  	return 0;
>  }
>  
> -- 
> 1.9.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
