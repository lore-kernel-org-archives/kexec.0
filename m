Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU9XF-0000XG-QB
 for kexec@lists.infradead.org; Tue, 04 Dec 2018 12:10:44 +0000
Date: Tue, 4 Dec 2018 20:10:24 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86: Clear isVGA flag if current fb driver is mimicking
 VGA
Message-ID: <20181204121024.GA2168@dhcp-128-65.nay.redhat.com>
References: <20181123092801.16411-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123092801.16411-1-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 11/23/18 at 05:28pm, Kairui Song wrote:
> Some device (eg. hyperv_fb) will mimic EFI (or VESA) VGA on first boot
> up, but after the real driver is loaded, it will switch to new mode
> and no longer compatible with EFI/VESA VGA. Keep setting
> orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded and
> try to manipulate the framebuffer in a wrong way.
> 
> As we have already take care of "VESA VGA" and "EFI VGA", just set the
> orig_video_isVGA to 0 for any other driver reports as EFI/VESA VGA but
> is not EFI/VESA VGA.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  kexec/arch/i386/x86-linux-setup.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index dc785a2..a129812 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -152,6 +152,11 @@ static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
>  		err = get_bootparam(&real_mode->orig_video_isVGA, offset, 1);
>  		if (err)
>  			goto out;
> +
> +		if (real_mode->orig_video_isVGA == 0x70 || real_mode->orig_video_isVGA == 0x23) {
> +			/* Clear isVGA flag for fb drivers that mimic EFI/VESA VGA */
> +			real_mode->orig_video_isVGA = 0;
> +		}

The blindly reuse original isVGA might be a problem like you said, but
it does work for me for i915 laptop even if later drm driver loaded.
With your patch it does not work anymore.

kexec reboot with earlyprintk=efi without initramfs looks just hang, but
previously I can see all the kernel console logs.

Probably you can make real_mode->orig_video_isVGA = 0 as default in the
else {} section, and introduce an extra x86 only argument for people to
reuse isVGA blindly. eg.

kexec --reuse-vga-type

>  	}
>  	close(fd);
>  
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
