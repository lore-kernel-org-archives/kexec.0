Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X240d-0005Qg-KQ
 for kexec@lists.infradead.org; Tue, 01 Jul 2014 19:46:32 +0000
Received: by mail-wg0-f49.google.com with SMTP id y10so10160949wgg.20
 for <kexec@lists.infradead.org>; Tue, 01 Jul 2014 12:46:06 -0700 (PDT)
Date: Tue, 1 Jul 2014 20:46:05 +0100
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 15/15] kexec: Support kexec/kdump on EFI systems
Message-ID: <20140701194605.GJ7539@console-pimps.org>
References: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
 <1403814824-7587-16-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403814824-7587-16-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Thu, 26 Jun, at 04:33:44PM, Vivek Goyal wrote:
> This patch does two thigns. It passes EFI run time mappings to second
> kernel in bootparams efi_info. Second kernel parse this info and create
> new mappings in second kernel. That means mappings in first and second
> kernel will be same. This paves the way to enable EFI in kexec kernel.
> 
> This patch also prepares and passes EFI setup data through bootparams.
> This contains bunch of information about various tables and their
> addresses.
> 
> These information gathering and passing has been written along the lines
> of what current kexec-tools is doing to make kexec work with UEFI.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> CC: linux-efi@vger.kernel.org
> ---
>  arch/x86/kernel/kexec-bzimage64.c  | 146 ++++++++++++++++++++++++++++++++++---
>  drivers/firmware/efi/runtime-map.c |  21 ++++++
>  include/linux/efi.h                |  19 +++++
>  3 files changed, 174 insertions(+), 12 deletions(-)

[...]

> diff --git a/drivers/firmware/efi/runtime-map.c b/drivers/firmware/efi/runtime-map.c
> index 97cdd16..40f2213 100644
> --- a/drivers/firmware/efi/runtime-map.c
> +++ b/drivers/firmware/efi/runtime-map.c
> @@ -138,6 +138,27 @@ add_sysfs_runtime_map_entry(struct kobject *kobj, int nr)
>  	return entry;
>  }
>  
> +int get_efi_runtime_map_size(void)
> +{
> +	return nr_efi_runtime_map * efi_memdesc_size;
> +}
> +
> +int get_efi_runtime_map_desc_size(void)
> +{
> +	return efi_memdesc_size;
> +}
> +
> +int efi_runtime_map_copy(void *buf, size_t bufsz)
> +{
> +	size_t sz = get_efi_runtime_map_size();
> +
> +	if (sz > bufsz)
> +		sz = bufsz;
> +
> +	memcpy(buf, efi_runtime_map, sz);
> +	return 0;
> +}

Could we prefix these with efi_, e.g. efi_get_runtime_map_size() ?

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
