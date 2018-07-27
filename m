Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fivQV-0003qu-TN
 for kexec@lists.infradead.org; Fri, 27 Jul 2018 05:36:33 +0000
Received: by mail-pg1-x542.google.com with SMTP id n7-v6so2554859pgq.4
 for <kexec@lists.infradead.org>; Thu, 26 Jul 2018 22:36:21 -0700 (PDT)
Date: Fri, 27 Jul 2018 14:37:55 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v12 10/16] arm64: kexec_file: load initrd and device-tree
Message-ID: <20180727053754.GF11258@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-11-takahiro.akashi@linaro.org>
 <99f87d6c-b5e3-4f98-5f3b-7032ff4780b1@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99f87d6c-b5e3-4f98-5f3b-7032ff4780b1@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Thu, Jul 26, 2018 at 02:34:55PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 24/07/18 07:57, AKASHI Takahiro wrote:
> > load_other_segments() is expected to allocate and place all the necessary
> > memory segments other than kernel, including initrd and device-tree
> > blob (and elf core header for crash).
> > While most of the code was borrowed from kexec-tools' counterpart,
> > users may not be allowed to specify dtb explicitly, instead, the dtb
> > presented by the original boot loader is reused.
> > 
> > arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> > specific data allocated in load_other_segments().
> 
> Since v11 you've renamed struct kimage_arch's dtb_buf as dtb, but not changed
> the struct. This series doesn't build until patch 12 where you fix it. This will
> cause anyone trying to bisect through here a problem.

Right. My last-minute change introduced this screw-up.
I will double-check at v13.

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
> 
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index e17f0529a882..026f7e408f0c 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> 
> > +struct kimage_arch {
> > +	void *dtb_buf;
> > +	unsigned long dtb_mem;
> > +};
> 
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index c38a8048ed00..b28fbb0659c9 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> 
> > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > +{
> > +	vfree(image->arch.dtb);
> > +	image->arch.dtb = NULL;
> > +
> > +	return kexec_image_post_load_cleanup_default(image);
> > +}
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
