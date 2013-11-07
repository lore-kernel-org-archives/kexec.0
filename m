Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from omzsmtpe01.verizonbusiness.com ([199.249.25.210])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeWTU-00022Y-4X
 for kexec@lists.infradead.org; Thu, 07 Nov 2013 20:46:44 +0000
From: Don Slutz <dslutz@verizon.com>
Message-ID: <527BFBAF.5070204@terremark.com>
Date: Thu, 7 Nov 2013 15:44:31 -0500
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 5/9] xen: kexec crash image when dom0 crashes
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <1383749386-11891-6-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1383749386-11891-6-git-send-email-david.vrabel@citrix.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Jan Beulich <jbeulich@suse.com>

For what it is worth.

Reviewed-by: Don Slutz <dslutz@verizon.com>
     -Don Slutz

On 11/06/13 09:49, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> Tested-by: Daniel Kiper <daniel.kiper@oracle.com>
> Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
>   xen/common/kexec.c    |    2 ++
>   xen/common/shutdown.c |    3 +++
>   2 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/xen/common/kexec.c b/xen/common/kexec.c
> index c5450ba..9999bab 100644
> --- a/xen/common/kexec.c
> +++ b/xen/common/kexec.c
> @@ -305,6 +305,8 @@ void kexec_crash(void)
>       if ( !test_bit(KEXEC_IMAGE_CRASH_BASE + pos, &kexec_flags) )
>           return;
>   
> +    printk("Executing crash image\n");
> +
>       kexecing = TRUE;
>   
>       kexec_common_shutdown();
> diff --git a/xen/common/shutdown.c b/xen/common/shutdown.c
> index 20f04b0..9bccd34 100644
> --- a/xen/common/shutdown.c
> +++ b/xen/common/shutdown.c
> @@ -47,6 +47,9 @@ void dom0_shutdown(u8 reason)
>       {
>           debugger_trap_immediate();
>           printk("Domain 0 crashed: ");
> +#ifdef CONFIG_KEXEC
> +        kexec_crash();
> +#endif
>           maybe_reboot();
>           break; /* not reached */
>       }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
