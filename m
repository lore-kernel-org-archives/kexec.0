Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VabdU-0000Lw-UA
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 01:28:53 +0000
Date: Mon, 28 Oct 2013 09:28:16 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 4/4] Passing efi related data via setup_data
Message-ID: <20131028012816.GF4397@dhcp-16-126.nay.redhat.com>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.350640917@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131027041231.350640917@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, vgoyal@redhat.com

On 10/27/13 at 12:04pm, Dave Young wrote:
> For supporting efi runtime, several efi physical addresses
> fw_vendor, runtime, config tables, smbios and the whole runtime
> mapping info need to be used in kexec kernel. Thus introduce
> setup_data struct for passing these data.
> 
> collect the varialbes from /sys/firmware/efi/systab and
> /sys/firmware/efi/efi-runtime-map
> 
> Tested on qemu+ovmf, dell laptop, lenovo laptop and HP workstation.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  include/x86/x86-linux.h           |    2 
>  kexec/arch/i386/x86-linux-setup.c |  120 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 120 insertions(+), 2 deletions(-)
> 
> --- kexec-tools.orig/include/x86/x86-linux.h
> +++ kexec-tools/include/x86/x86-linux.h
> @@ -115,7 +115,7 @@ struct x86_linux_param_header {
>  	uint32_t ext_ramdisk_image;		/* 0xc0 */
>  	uint32_t ext_ramdisk_size;		/* 0xc4 */
>  	uint32_t ext_cmd_line_ptr;		/* 0xc8 */
> -	uint8_t reserved4_1[0x1c0 - 0xcc];	/* 0xcc */
> +	uint8_t reserved4_1[0x1c0 - 0xcc];	/* 0xe4 */

Above change should be in previous patch. Will update in next version. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
