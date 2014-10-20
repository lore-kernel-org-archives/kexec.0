Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XgAts-0002eF-CO
 for kexec@lists.infradead.org; Mon, 20 Oct 2014 11:13:21 +0000
Date: Mon, 20 Oct 2014 19:12:55 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Patch v2] get MODULES_VADDR by KERNEL_IMAGE_SIZE for x86_64
Message-ID: <20141020111255.GA9060@dhcp-16-116.nay.redhat.com>
References: <1411442709-1623-1-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4942B@BPXM01GP.gisp.nec.co.jp>
 <20140924080200.GG8697@dhcp-16-116.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D56C52@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D56C52@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 10/20/14 at 07:17am, Atsushi Kumagai wrote:
> >On 09/24/14 at 07:55am, Atsushi Kumagai wrote:
> >> >diff --git a/makedumpfile.c b/makedumpfile.c
> >> >index b4d43d8..65c893f 100644
> >> >--- a/makedumpfile.c
> >> >+++ b/makedumpfile.c
> >> >@@ -1564,6 +1564,14 @@ get_value_for_old_linux(void)
> >> > 			NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) =
> >> > 			PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_39_to_latest_version;
> >> > 	}
> >> >+#ifdef __x86_64__
> >> >+	if (NUMBER(KERNEL_IMAGE_SIZE) == NOT_FOUND_NUMBER) {
> >> >+		if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
> >> >+			NUMBER(KERNEL_IMAGE_SIZE) = KERNEL_IMAGE_SIZE_ORIG;
> >> >+		else
> >> >+			NUMBER(KERNEL_IMAGE_SIZE) = KERNEL_IMAGE_SIZE_2_6_26;
> >> >+	}
> >> >+#endif
> 
> I noticed that this fix is incomplete because get_value_for_old_linux() is
> too late as shown below:
> 
>   initial()
>     + read_vmcoreinfo_from_vmcore()       // get KERNEL_IMAGE_SIZE from VMCOREINFO (only for new kernels)
>     + get_mem_map()                       // refer KERNEL_IMAGE_SIZE via is_vmalloc_addr_x86_64()
>     + get_value_for_old_linux()           // initialize KERNEL_IMAGE_SIZE for old kernels


Yes, this is a good catch. Thanks for fixing it.

> 
> 
> So I'll fix this issue with the patch below.
> 
> Thanks,
> Atsushi Kumagai
> 
> 
> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Date: Mon, 20 Oct 2014 16:04:57 +0900
> Subject: [PATCH] Initialize symbols early for old kernels.
> 
> It's best to invoke get_value_for_old_linux() immediately after
> reading VMCOREINFO since some functions require the symbols which
> are initialized in it.
> This change is safe because get_value_for_old_linux() doesn't
> overwrite any values.
> 
> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> ---
>  makedumpfile.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 53c3585..b27ea1e 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3203,6 +3203,9 @@ initial(void)
>  		debug_info = TRUE;
>  	}
>  
> +	if (!get_value_for_old_linux())
> +		return FALSE;
> +
>  out:
>  	if (!info->page_size) {
>  		/*
> @@ -3306,9 +3309,6 @@ out:
>  			return FALSE;
>  	}
>  
> -	if (!get_value_for_old_linux())
> -		return FALSE;
> -
>  	/* use buddy identification of free pages whether cyclic or not */
>  	/* (this can reduce pages scan of 1TB memory from 60sec to 30sec) */
>  	if (info->dump_level & DL_EXCLUDE_FREE)
> -- 
> 1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
