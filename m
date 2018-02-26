Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqGuM-0008KI-BX
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 11:25:28 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QBOHva127390
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 06:25:16 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gceq9pt3m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 06:25:15 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 11:25:13 -0000
Date: Mon, 26 Feb 2018 12:25:05 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 03/13] kexec_file,x86,powerpc: factor out
 kexec_file_ops functions
In-Reply-To: <20180226100138.GC6019@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-4-takahiro.akashi@linaro.org>
 <20180223092459.GC4433@dhcp-128-65.nay.redhat.com>
 <20180226100138.GC6019@linaro.org>
MIME-Version: 1.0
Message-Id: <20180226122505.3d999efc@ThinkPad>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, julien.thierry@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com, arnd@arndb.de, vgoyal@redhat.com, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, 26 Feb 2018 19:01:39 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> On Fri, Feb 23, 2018 at 05:24:59PM +0800, Dave Young wrote:
> > Hi AKASHI,
> > 
> > On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:  
> > > As arch_kexec_kernel_*_{probe,load}(), arch_kimage_file_post_load_cleanup()
> > > and arch_kexec_kernel_verify_sg can be parameterized with a kexec_file_ops
> > > array and now duplicated among some architectures, let's factor them out.
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > > ---
> > >  arch/powerpc/include/asm/kexec.h            |  2 +-
> > >  arch/powerpc/kernel/kexec_elf_64.c          |  2 +-
> > >  arch/powerpc/kernel/machine_kexec_file_64.c | 39 ++------------------
> > >  arch/x86/include/asm/kexec-bzimage64.h      |  2 +-
> > >  arch/x86/kernel/kexec-bzimage64.c           |  2 +-
> > >  arch/x86/kernel/machine_kexec_64.c          | 45 +----------------------
> > >  include/linux/kexec.h                       | 15 ++++----
> > >  kernel/kexec_file.c                         | 57 +++++++++++++++++++++++++++--
> > >  8 files changed, 70 insertions(+), 94 deletions(-)
> > >   
> > 
> > [snip]
> >   
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 990adae52151..a6d14a768b3e 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -26,34 +26,83 @@
> > >  #include <linux/vmalloc.h>
> > >  #include "kexec_internal.h"
> > >  
> > > +const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
> > > +
> > >  #ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
> > >  static int kexec_calculate_store_digests(struct kimage *image);
> > >  #else
> > >  static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
> > >  #endif
> > >  
> > > +int _kexec_kernel_image_probe(struct kimage *image, void *buf,
> > > +			     unsigned long buf_len)
> > > +{
> > > +	const struct kexec_file_ops * const *fops;
> > > +	int ret = -ENOEXEC;
> > > +
> > > +	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
> > > +		ret = (*fops)->probe(buf, buf_len);
> > > +		if (!ret) {
> > > +			image->fops = *fops;
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  /* Architectures can provide this probe function */
> > >  int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> > >  					 unsigned long buf_len)
> > >  {
> > > -	return -ENOEXEC;
> > > +	return _kexec_kernel_image_probe(image, buf, buf_len);  
> > 
> > 
> > I vaguely remember previously I suggest split the _kexec_kernel_image_probe
> > because arch code can call them, and common code also use it like above.
> > But in your new series I do not find where else calls this function
> > except the common code arch_kexec_kernel_image_probe.  If nobody use
> > them then it is not worth to split them out, it is better to just embed
> > them in the __weak functions.  
> 
> Powerpc's arch_kexec_kernel_image_probe() uses
> _kexec_kekrnel_image_probe() as it needs an extra check to rule out
> crash dump for now.

s390 has to use it too. We have to write to a fixed address in the buffer. So
we need to check if the buffer is large enough to write to that address.

Philipp
 
> Thanks,
> -Takahiro AKASHI
> 
> 
> > Ditto for other similar functions.
> > 
> > [snip]
> > 
> > Thanks
> > Dave  
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
