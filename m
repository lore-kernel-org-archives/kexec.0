Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JJaTE-00085v-1P
	for kexec@lists.infradead.org; Mon, 28 Jan 2008 20:20:50 +0000
Date: Mon, 28 Jan 2008 15:20:41 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kexec command line length
Message-ID: <20080128202041.GD32765@redhat.com>
References: <20080115173753.GB24435@redhat.com>
	<20080125123558.GA5627@hmsreliant.think-freely.org>
	<20080125153924.GA13287@redhat.com> <479A03DD.5030308@zytor.com>
	<20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
	<20080125201305.GG13287@redhat.com>
	<20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
	<20080128170811.GA1174@hmsreliant.think-freely.org>
	<20080128193741.GB32765@redhat.com>
	<20080128200702.GB1174@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080128200702.GB1174@hmsreliant.think-freely.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

[..]
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> 
>  include/x86/x86-linux.h         |   19 +++++++++++++------
>  kexec/arch/i386/kexec-bzImage.c |    7 +++++++
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
> index afe66bd..e75689c 100644
> --- a/include/x86/x86-linux.h
> +++ b/include/x86/x86-linux.h
> @@ -144,18 +144,22 @@ struct x86_linux_param_header {
>  	/* 2.04+ */
>  	uint32_t kernel_alignment;		/* 0x230 */
>  	uint8_t  relocatable_kernel;		/* 0x234 */
> -	uint8_t  reserved15[0x2d0 - 0x235];	/* 0x230 */
> +	uint8_t  reserved15[3];			/* 0x235 */
> +	uint32_t cmdline_size;			/* 0x238 */
> +	uint32_t hardware_subarch;		/* 0x23C */
> +	uint64_t hardware_subarch_data;		/* 0x240 */
> +	uint8_t  reserved16[0x2d0 - 0x248];	/* 0x248 */
>  #endif
>  	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
>  						/* 0x550 */
> -#define COMMAND_LINE_SIZE 256
> +#define COMMAND_LINE_SIZE 2048 
>  };
>  
>  struct x86_linux_faked_param_header {
>  	struct x86_linux_param_header hdr;	/* 0x00 */
> -	uint8_t reserved16[688];		/* 0x550 */
> -	uint8_t command_line[COMMAND_LINE_SIZE]; /* 0x800 */
> -	uint8_t reserved17[1792];		/* 0x900 - 0x1000 */
> +	uint8_t reserved17[0xab0];		/* 0x550 */
> +	uint8_t command_line[COMMAND_LINE_SIZE]; /* 0x1000 */
> +	uint8_t reserved18[0x200];		/* 0x1800 - 0x2000 */
>  };
>  
>  struct x86_linux_header {
> @@ -206,7 +210,10 @@ struct x86_linux_header {
>  #else
>  	uint32_t kernel_alignment;		/* 0x230 */
>  	uint8_t  relocatable_kernel;		/* 0x234 */
> -	uint8_t  tail[32*1024 - 0x235];		/* 0x230 */
> +	uint32_t cmdline_size;                  /* 0x235 */
> +	uint32_t hardware_subarch;              /* 0x239 */
> +	uint64_t hardware_subarch_data;         /* 0x23D */

We need a padding of 3 bytes here too between relocatable kernel and
cmdline_size, in the same way as x86_linux_param_header?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
