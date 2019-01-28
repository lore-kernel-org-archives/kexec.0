Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4cq-0002Pr-Bs
 for kexec@lists.infradead.org; Mon, 28 Jan 2019 10:58:49 +0000
Date: Mon, 28 Jan 2019 11:58:44 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] purgatory: Use standalond CFLAGS
Message-ID: <20190128105844.zx4bmpkovlzs2wsx@verge.net.au>
References: <20190128105040.30520-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128105040.30520-1-kasong@redhat.com>
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
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

On Mon, Jan 28, 2019 at 06:50:40PM +0800, Kairui Song wrote:
> There has been a lot of workarounds for purgatory disabling many
> specified CFLAGS that will break purgatory. It will be better to not
> let the CFLAGS used to compile purgatory honor the CFLAGS from
> environment variables. So we will have stable CFLAGS for purgatory.
> 
> If anyone still wants to change purgatory CFLAGS, PURGATORY_EXTRA_CFLAGS
> is still honored.

Thanks, this seems reasonable to me.
But I'd like to wait to see if there is feedback from others before applying.

> 
> ---
>  purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index 49ce80a..2dd6c47 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -45,7 +45,7 @@ purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
>  	$(COMPILE.c) -o $@ $^
>  
>  $(PURGATORY): CC=$(TARGET_CC)
> -$(PURGATORY): CFLAGS+=$(PURGATORY_EXTRA_CFLAGS) \
> +$(PURGATORY): CFLAGS=$(PURGATORY_EXTRA_CFLAGS) \
>  		      $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
>  		      -Os -fno-builtin -ffreestanding \
>  		      -fno-zero-initialized-in-bss \
> -- 
> 2.20.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
