Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWasn-0003Sx-Dx
 for kexec@lists.infradead.org; Tue, 11 Dec 2018 05:47:03 +0000
Received: by mail-pl1-x642.google.com with SMTP id y1so6399534plp.9
 for <kexec@lists.infradead.org>; Mon, 10 Dec 2018 21:46:50 -0800 (PST)
Date: Tue, 11 Dec 2018 14:50:02 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v16 16/16] arm64: kexec_file: add kaslr support
Message-ID: <20181211055001.GE21466@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-17-takahiro.akashi@linaro.org>
 <20181130131944.GA9000@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130131944.GA9000@arm.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: prudo@linux.ibm.com, herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, james.morse@arm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Fri, Nov 30, 2018 at 01:19:44PM +0000, Will Deacon wrote:
> On Thu, Nov 15, 2018 at 02:52:55PM +0900, AKASHI Takahiro wrote:
> > Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> > address randomization, at secondary kernel boot. We always do this as
> > it will have no harm on kaslr-incapable kernel.
> > 
> > We don't have any "switch" to turn off this feature directly, but still
> > can suppress it by passing "nokaslr" as a kernel boot argument.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/machine_kexec_file.c | 46 +++++++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index ab296b98d633..a0a730bd9be6 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/libfdt.h>
> >  #include <linux/memblock.h>
> >  #include <linux/of_fdt.h>
> > +#include <linux/random.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> > @@ -28,6 +29,7 @@
> >  #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
> >  #define FDT_PSTR_INITRD_END	"linux,initrd-end"
> >  #define FDT_PSTR_BOOTARGS	"bootargs"
> > +#define FDT_PSTR_KASLR_SEED	"kaslr-seed"
> >  
> >  const struct kexec_file_ops * const kexec_file_loaders[] = {
> >  	&kexec_image_ops,
> > @@ -46,11 +48,38 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >  	return kexec_image_post_load_cleanup_default(image);
> >  }
> >  
> > +/* crng needs to have been initialized for providing kaslr-seed */
> > +static int random_ready;
> > +
> > +static void random_ready_notified(struct random_ready_callback *unused)
> > +{
> > +	random_ready = 1;
> > +}
> > +
> > +static struct random_ready_callback random_ready_cb = {
> > +	.func = random_ready_notified,
> > +};
> > +
> > +static __init int init_random_ready_cb(void)
> > +{
> > +	int ret;
> > +
> > +	ret = add_random_ready_callback(&random_ready_cb);
> > +	if (ret == -EALREADY)
> > +		random_ready = 1;
> > +	else if (ret)
> > +		pr_warn("failed to add a callback for random_ready\n");
> > +
> > +	return 0;
> > +}
> > +late_initcall(init_random_ready_cb)
> 
> Why can't we just call crng_ready()?

because crng_ready() is locally defined in drivers/char/random.c.
Instead, I'd like to use
        wait_for_random_bytes();
        value = get_random_u64();

> > +
> >  static int setup_dtb(struct kimage *image,
> >  		     unsigned long initrd_load_addr, unsigned long initrd_len,
> >  		     char *cmdline, void *dtb)
> >  {
> >  	int nodeoffset;
> > +	u64 value;
> >  	int ret;
> >  
> >  	nodeoffset = fdt_path_offset(dtb, "/chosen");
> > @@ -106,12 +135,27 @@ static int setup_dtb(struct kimage *image,
> >  			return -EINVAL;
> >  	}
> >  
> > +	/* add kaslr-seed */
> > +	ret = fdt_delprop(dtb, nodeoffset, FDT_PSTR_KASLR_SEED);
> > +	if (ret && (ret != -FDT_ERR_NOTFOUND))
> > +		return -EINVAL;
> > +
> > +	if (random_ready) {
> > +		get_random_bytes(&value, sizeof(value));
> 
> get_random_u64() ?

OK.

> > +		ret = fdt_setprop_u64(dtb, nodeoffset, FDT_PSTR_KASLR_SEED,
> > +							value);
> > +		if (ret)
> > +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> > +	} else {
> 
> Wouldn't we be better off preserving the previous seed here, if it was
> present?

While there's no guarantee that dtb won't be (partially) broken
on failure, I will let this function return successfully
by deleting succeeding fdt_delprop().


> > +		pr_notice("kaslr-seed won't be fed\n");
> 
> "fed" is probably not the right word here.

=> won't be *provided* on kexec?

-Takahiro Akashi

> Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
