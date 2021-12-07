Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mubXs-008xOR-17
 for kexec@lists.infradead.org; Tue, 07 Dec 2021 14:34:17 +0000
Date: Tue, 7 Dec 2021 15:34:04 +0100
From: Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH 3/3] s390: add support for --reuse-cmdline
Message-ID: <20211207153404.4ff7f7fd@rhtmp>
In-Reply-To: <20211122071401.3106858-4-svens@linux.ibm.com>
References: <20211122071401.3106858-1-svens@linux.ibm.com>
 <20211122071401.3106858-4-svens@linux.ibm.com>
MIME-Version: 1.0
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
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Alexander Egorenkov <egorenar@linux.ibm.com>

Hi Sven,

makes absolutely sense to have this option. One problem though...

On Mon, 22 Nov 2021 08:14:01 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> --reuse-cmdline reads the command line of the currently
> running kernel from /proc/cmdline and uses that for the
> kernel that should be kexec'd.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  kexec/arch/s390/include/arch/options.h | 10 ++++++----
>  kexec/arch/s390/kexec-image.c          |  9 +++++++++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/kexec/arch/s390/include/arch/options.h b/kexec/arch/s390/include/arch/options.h
> index 76044a301ceb..b030b61d61be 100644
[...]
> diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
> index dbeb689b830a..310d967ea331 100644
> --- a/kexec/arch/s390/kexec-image.c
> +++ b/kexec/arch/s390/kexec-image.c
> @@ -72,6 +72,10 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
>  		case OPT_RAMDISK:
>  			ramdisk = optarg;
>  			break;
> +		case OPT_REUSE_CMDLINE:
> +			free(command_line);
> +			command_line = get_command_line();

get_command_line reads a maximum of 2048 bytes from /prc/cmdline. With
the configurable size on s390 defaulting to 4096 bytes this will
ultimately cause problems. So you need to make get_command_line more
flexible first.

Thanks
Philipp

> +			break;
>  		}
>  	}
>  
> @@ -123,6 +127,10 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>  			if (command_line_add(optarg))
>  				return -1;
>  			break;
> +		case OPT_REUSE_CMDLINE:
> +			free(command_line);
> +			command_line = get_command_line();
> +			break;
>  		case OPT_RAMDISK:
>  			ramdisk = optarg;
>  			break;
> @@ -223,5 +231,6 @@ image_s390_usage(void)
>  	printf("--command-line=STRING Set the kernel command line to STRING.\n"
>  	       "--append=STRING       Set the kernel command line to STRING.\n"
>  	       "--initrd=FILENAME     Use the file FILENAME as a ramdisk.\n"
> +	       "--reuse-cmdline       Use kernel command line from running system.\n"
>  		);
>  }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
