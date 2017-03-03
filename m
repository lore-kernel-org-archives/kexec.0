Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjeTA-0001vp-P9
 for kexec@lists.infradead.org; Fri, 03 Mar 2017 04:05:30 +0000
Received: by mail-pg0-f49.google.com with SMTP id 25so39388033pgy.0
 for <kexec@lists.infradead.org>; Thu, 02 Mar 2017 20:05:06 -0800 (PST)
Subject: Re: [PATCH v3] Only print debug message when failed to serach for
 kernel symbol from /proc/kallsyms
References: <1488513135-29611-1-git-send-email-bhe@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <2afd6d3d-b13a-7ff6-db97-b4e4a59a97c4@redhat.com>
Date: Fri, 3 Mar 2017 09:35:02 +0530
MIME-Version: 1.0
In-Reply-To: <1488513135-29611-1-git-send-email-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>, horms@verge.net.au
Cc: dyoung@redhat.com, kexec@lists.infradead.org



On Friday 03 March 2017 09:22 AM, Baoquan He wrote:
> Kernel symbol page_offset_base could be unavailable when mm KASLR code is
> not compiled in kernel. It's unappropriate to print out error message
> when failed to search for page_offset_base from /proc/kallsyms. Seems now
> there is not a way to find out if mm KASLR is compiled in or not. An
> alternative approach is only printing out debug message in get_kernel_sym
> if failed to search a expected kernel symbol.
>
> Do it in this patch, a simple fix.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Yes, a particular symbol can be kernel version dependent and may not be 
available in all the kernel version.

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/i386/crashdump-x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 88aeee3..c4cf201 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -127,7 +127,7 @@ static unsigned long long get_kernel_sym(const char *symbol)
>  		}
>  	}
>
> -	fprintf(stderr, "Cannot get kernel %s symbol address\n", symbol);
> +	dbgprintf("Cannot get kernel %s symbol address\n", symbol);
>  	return 0;
>  }
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
