Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1430933681.12082.23.camel@infradead.org>
Subject: Re: [PATCH] arm64: Kexec: Add support for binary image
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 06 May 2015 10:34:41 -0700
In-Reply-To: <770bae1ed7d53e74874f99343070b4c5a69cb9a2.1429704995.git.panand@redhat.com>
References: <770bae1ed7d53e74874f99343070b4c5a69cb9a2.1429704995.git.panand@redhat.com>
Mime-Version: 1.0
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org

Hi,

On Wed, 2015-04-22 at 17:56 +0530, Pratyush Anand wrote:

> @@ -30,6 +32,7 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
>  "     --dtb=FILE            Use FILE as the device tree blob.\n"
>  "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
>  "     --lite                Fast reboot, no memory integrity checks.\n"
> +"     --page-offset         Kernel page-offset for binary image load.\n"

Sorry I didn't see this before, but page-offset is for Image load, so
should go in the image_arm64_usage().

I think it is OK to keep page_offset in struct arm64_opts, then just
ignore it for the other file formats.

>  "     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
>  "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
>  "     --reuse-cmdline       Use command line arg of primary kernel.\n";

> --- a/kexec/arch/arm64/kexec-image-arm64.c
> +++ b/kexec/arch/arm64/kexec-image-arm64.c
> +static unsigned long long get_kernel_page_offset(void)
> +{
> +	unsigned long long text_sym_addr = get_kernel_text_sym();
> +	unsigned long long text_page_offset =
> +		text_sym_addr & 0xFFFFFFFFFFE00000;
> +
> +	if(arm64_opts.page_offset) {
> +		if (text_page_offset != arm64_opts.page_offset)
> +			dbgprintf("User page offset did not match with text page offset\n"); 

I'd like to see the values printed.

> +		return arm64_opts.page_offset;
> +	} else if(text_page_offset) {
> +		dbgprintf("text page offset is %llx\n", text_page_offset);
> +		return text_page_offset;
> +	} else {
> +		return ARM64_DEFAULT_PAGE_OFFSET;
> +	}
>  }

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
