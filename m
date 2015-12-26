Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aCrJM-0004ld-Hm
 for kexec@lists.infradead.org; Sat, 26 Dec 2015 16:03:16 +0000
Date: Sun, 27 Dec 2015 00:05:22 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v2 14/16] x86, nvdimm, kexec: Use walk_iomem_res_desc() for
 iomem search
Message-ID: <20151226160522.GA28533@dhcp-128-25.nay.redhat.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
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
To: Toshi Kani <toshi.kani@hpe.com>
Cc: linux-arch@vger.kernel.org, linux-nvdimm@ml01.01.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bp@alien8.de, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>

Ccing kexec maillist.

On 12/25/15 at 03:09pm, Toshi Kani wrote:
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index c245085..e2bd737 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -522,10 +522,10 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>  
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
>  	if (image->type == KEXEC_TYPE_CRASH)
> -		ret = walk_iomem_res("Crash kernel",
> -				     IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -				     crashk_res.start, crashk_res.end, kbuf,
> -				     locate_mem_hole_callback);
> +		ret = walk_iomem_res_desc(IORES_DESC_CRASH_KERNEL,

Since crashk_res's desc has been assigned to IORES_DESC_CRASH_KERNEL, it
is better to use crashk_res.desc, instead of using
IORES_DESC_CRASH_KERNEL directly.

Thanks
Minfei

> +				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				crashk_res.start, crashk_res.end, kbuf,
> +				locate_mem_hole_callback);
>  	else
>  		ret = walk_system_ram_res(0, -1, kbuf,
>  					  locate_mem_hole_callback);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
