Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZWSZ-0001vF-LZ
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 02:17:24 +0000
Date: Mon, 14 Apr 2014 11:16:59 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RESEND v5 08/10] x86, cleanup: Add a funtion
 add_setup_data()
Message-ID: <20140414021659.GL22411@verge.net.au>
References: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
 <1397183011-1526-9-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397183011-1526-9-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On Fri, Apr 11, 2014 at 10:23:29AM +0800, WANG Chao wrote:
> add_setup_data() is used to add an instance to the single linked list
> of setup_data structure.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>

Thanks, applied.

> ---
>  kexec/arch/i386/x86-linux-setup.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index e04e45d..8ed36cc 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -603,6 +603,22 @@ struct efi_info {
>  };
>  
>  /*
> + * Add another instance to single linked list of struct setup_data.
> + * Please refer to kernel Documentation/x86/boot.txt for more details
> + * about setup_data structure.
> + */
> +static void add_setup_data(struct kexec_info *info,
> +			   struct x86_linux_param_header *real_mode,
> +			   struct setup_data *sd)
> +{
> +	int sdsize = sizeof(struct setup_data) + sd->len;
> +
> +	sd->next = real_mode->setup_data;
> +	real_mode->setup_data = add_buffer(info, sd, sdsize, sdsize, getpagesize(),
> +			    0x100000, ULONG_MAX, INT_MAX);
> +}
> +
> +/*
>   * setup_efi_data will collect below data and pass them to 2nd kernel.
>   * 1) SMBIOS, fw_vendor, runtime, config_table, they are passed via x86
>   *    setup_data.
> @@ -611,11 +627,11 @@ struct efi_info {
>  static int setup_efi_data(struct kexec_info *info,
>  			  struct x86_linux_param_header *real_mode)
>  {
> -	int64_t setup_data_paddr, memmap_paddr;
> +	int64_t memmap_paddr;
>  	struct setup_data *sd;
>  	struct efi_setup_data *esd;
>  	struct efi_mem_descriptor *maps;
> -	int nr_maps, size, sdsize, ret = 0;
> +	int nr_maps, size, ret = 0;
>  	struct efi_info *ei = (struct efi_info *)real_mode->efi_info;
>  
>  	ret = access("/sys/firmware/efi/systab", F_OK);
> @@ -648,10 +664,8 @@ static int setup_efi_data(struct kexec_info *info,
>  	sd->len = sizeof(*esd);
>  	memcpy(sd->data, esd, sizeof(*esd));
>  	free(esd);
> -	sdsize = sd->len + sizeof(struct setup_data);
> -	setup_data_paddr = add_buffer(info, sd, sdsize, sdsize, getpagesize(),
> -					0x100000, ULONG_MAX, INT_MAX);
> -	real_mode->setup_data = setup_data_paddr;
> +
> +	add_setup_data(info, real_mode, sd);
>  
>  	size = nr_maps * sizeof(struct efi_mem_descriptor);
>  	memmap_paddr = add_buffer(info, maps, size, size, getpagesize(),
> -- 
> 1.8.5.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
