Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YieG6-0003NX-Ku
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 07:30:47 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 16 Apr 2015 08:30:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B94DA17D8062
 for <kexec@lists.infradead.org>; Thu, 16 Apr 2015 08:30:53 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3G7UHhG328132
 for <kexec@lists.infradead.org>; Thu, 16 Apr 2015 07:30:17 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3G7UGra026845
 for <kexec@lists.infradead.org>; Thu, 16 Apr 2015 01:30:16 -0600
Message-ID: <552F6507.1010500@linux.vnet.ibm.com>
Date: Thu, 16 Apr 2015 09:30:15 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] purgatory: force PIC/PIE/SSP off
References: <1429161304-2772-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1429161304-2772-1-git-send-email-vapier@gentoo.org>
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
To: Mike Frysinger <vapier@gentoo.org>, kexec@lists.infradead.org
Cc: Mike Frysinger <vapier@chromium.org>

On 16/04/2015 07:15, Mike Frysinger wrote:
> From: Mike Frysinger <vapier@chromium.org>
> 
> If the toolchain has these things turned on automatically, then the
> purgatory code might be miscompiled leading to runtime errors like:
> Unhandled rela relocation: R_X86_64_GOTPC64
> 
> It might look like the problem is with the kernel when in reality,
> kexec is complaining about the purgatory module.  Force off harden
> features that don't make sense in kernel space.
> 
> Signed-off-by: Mike Frysinger <vapier@chromium.org>
> ---
>  purgatory/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index 2d6b2c0..2b5c061 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -49,7 +49,8 @@ $(PURGATORY): CC=$(TARGET_CC)
>  $(PURGATORY): CFLAGS+=$(PURGATORY_EXTRA_CFLAGS) \
>  		      $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
>  		      -Os -fno-builtin -ffreestanding \
> -		      -fno-zero-initialized-in-bss
> +		      -fno-zero-initialized-in-bss \
> +		      -fno-PIC -fno-PIE -fno-stack-protector

Some architectures (ppc64 and s390) are already setting
-fno-stack-protector in purgatory/arch/x/Makefile through
x_PURGATORY_EXTRA_CFLAGS.

It would be cleaner to remove those per architecture settings if you set
it globally.

Cheers,
Laurent.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
