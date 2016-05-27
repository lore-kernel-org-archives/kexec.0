Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6FvN-0003ee-PJ
 for kexec@lists.infradead.org; Fri, 27 May 2016 11:27:30 +0000
Received: by mail-oi0-f53.google.com with SMTP id j1so168909450oih.3
 for <kexec@lists.infradead.org>; Fri, 27 May 2016 04:27:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXTL-0004ib-Ho@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTL-0004ib-Ho@e0050434b2927.dyn.arm.linux.org.uk>
Date: Fri, 27 May 2016 16:57:08 +0530
Message-ID: <CAHB_GuptCq67COZdXN=5QPghXgchpHFgbao0RhNGKobrehvMwQ@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 17/32] arm: return proper error for missing
 crash kernel
From: Pratyush Anand <panand@redhat.com>
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
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Return the proper error code (ENOCRASHKERNEL) for a missing crash
> kernel region in /proc/iomem, so the error handling in kexec.c can
> print the appropriate message.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index d85ab9b..4755f06 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -451,7 +451,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>                          * No crash kernel memory reserved. We cannot do more
>                          * but just bail out.
>                          */
> -                       return -1;
> +                       return ENOCRASHKERNEL;
>                 }
>                 base = start;
>         } else {
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
