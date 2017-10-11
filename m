Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e29Ck-0000ZS-G1
 for kexec@lists.infradead.org; Wed, 11 Oct 2017 05:05:16 +0000
Received: by mail-it0-x229.google.com with SMTP id 72so1408041itl.5
 for <kexec@lists.infradead.org>; Tue, 10 Oct 2017 22:04:53 -0700 (PDT)
Date: Wed, 11 Oct 2017 14:07:35 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v5 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
Message-ID: <20171011050734.GE6756@linaro.org>
References: <20171010063619.6303-1-takahiro.akashi@linaro.org>
 <20171010063619.6303-4-takahiro.akashi@linaro.org>
 <a8a0f36b-e797-289b-04e3-aa87b4088cdd@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a8a0f36b-e797-289b-04e3-aa87b4088cdd@arm.com>
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
To: Julien Thierry <julien.thierry@arm.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Tue, Oct 10, 2017 at 12:02:01PM +0100, Julien Thierry wrote:

[snip]

> >--- a/kernel/kexec_file.c
> >+++ b/kernel/kexec_file.c
> >@@ -26,30 +26,79 @@
> >  #include <linux/vmalloc.h>
> >  #include "kexec_internal.h"
> >
> >+const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
> >+
> >  static int kexec_calculate_store_digests(struct kimage *image);
> >
> >+int _kexec_kernel_image_probe(struct kimage *image, void *buf,
> >+                          unsigned long buf_len)
> >+{
> >+     const struct kexec_file_ops *fops;
> >+     int ret = -ENOEXEC;
> >+
> >+     for (fops = kexec_file_loaders[0]; fops && fops->probe; ++fops) {
> 
> Hmm, that's not gonna work (and I see that what I said in the previous
> patch was not 100% correct either).

Can you elaborate this a bit more?

I'm sure that, with my code, any member of fops, cannot be changed;
"const struct kexec_file_ops *fops" means that fops is a pointer to
"constant sturct kexec_file_ops," while "struct kexec_file_ops *
const kexec_file_loaders[]" means that kexec_file_loaders is a "constant
array" of pointers to "constant struct kexec_file_ops."

Thanks,
-Takahiro AKASHI


> 'fops' should be of type 'const struct kexec_file_ops **', and the loop
> should be:
> 
> for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops)
> 
> With some additional dereferences in the body of the loop.
> 
> Unless you prefer the previous state of the loop (with i and the break
> inside), but I still think this looks better.
> 
> Cheers,
> 
> --
> Julien Thierry
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
