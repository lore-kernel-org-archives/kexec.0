Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bA6PL-0003Ok-0y
 for kexec@lists.infradead.org; Tue, 07 Jun 2016 02:06:19 +0000
Received: by mail-qk0-f179.google.com with SMTP id i187so88266461qkd.3
 for <kexec@lists.infradead.org>; Mon, 06 Jun 2016 19:05:56 -0700 (PDT)
Date: Tue, 7 Jun 2016 07:35:50 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH kexec-tools v2 04/32] kdump: fix kdump mapping
Message-ID: <20160607020550.GA9722@dhcppc6>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
 <E1b9xrj-0003rn-3S@e0050434b2927.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1b9xrj-0003rn-3S@e0050434b2927.dyn.armlinux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, linux-arm-kernel@lists.infradead.org

On 06/06/2016:05:59:03 PM, Russell King wrote:
> When kdump tries to map the program header, it fails to take account
> of ehdr->e_phoff being an offset from the start of the ELF "file",
> which causes:
> 
> Cannot mmap /dev/mem offset: 64 size: 392: Invalid argument
> 
> Ensure that we take account of the start address when mapping this.
> 
> This fix has been extracted from a larger patch by Vitaly Andrianov
> adding support for Keystone 2.
> 
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Reviewed-by: Pratyush Anand <panand@redhat.com>
> ---
>  kdump/kdump.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kdump/kdump.c b/kdump/kdump.c
> index 1f5b984..34d2149 100644
> --- a/kdump/kdump.c
> +++ b/kdump/kdump.c
> @@ -284,7 +284,8 @@ int main(int argc, char **argv)
>  	}
>  	
>  	/* Get the program header */
> -	phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum), ehdr->e_phoff);
> +	phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum), 
> +			start_addr + ehdr->e_phoff);
>  
>  	/* Collect up the notes */
>  	note_bytes = 0;
> -- 
> 1.9.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
