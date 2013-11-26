Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlJzx-0006G1-Qy
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 14:52:22 +0000
Date: Tue, 26 Nov 2013 14:51:55 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v4 04/12] efi: cleanup efi_enter_virtual_mode function
Message-ID: <20131126145155.GL11521@console-pimps.org>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-5-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385445477-9665-5-git-send-email-dyoung@redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, 26 Nov, at 01:57:49PM, Dave Young wrote:
> Add two small functions:
> efi_merge_regions and efi_map_regions, efi_enter_virtual_mode
> calls them instead of embedding two long for loop.
> 
> v1->v2:
> refresh; coding style fixes.
> 
> v2->v3:
> Toshi Kani:
> remove unused variable
> Matt: check return value of krealloc.
> v3->v4:
> Boris: Stretch comment to 80 cols
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> Acked-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/platform/efi/efi.c | 109 +++++++++++++++++++++++++++-----------------
>  1 file changed, 66 insertions(+), 43 deletions(-)

[...]

> @@ -922,9 +948,6 @@ void __init efi_enter_virtual_mode(void)
>  			 0, NULL);
>  
>  	return;
> -
> - err_out:
> -	pr_err("Error reallocating memory, EFI runtime non-functional!\n");
>  }
>  
>  /*
 
Teeny, tiny comment: You could now delete the above return statement.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
