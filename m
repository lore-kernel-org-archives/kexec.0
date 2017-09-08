Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dq93N-0002pF-Nv
 for kexec@lists.infradead.org; Fri, 08 Sep 2017 02:29:59 +0000
Received: by mail-pf0-x22d.google.com with SMTP id e199so2382534pfh.3
 for <kexec@lists.infradead.org>; Thu, 07 Sep 2017 19:29:36 -0700 (PDT)
Date: Fri, 8 Sep 2017 11:31:17 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 05/14] kexec_file: factor out crashdump elf header
 function from x86
Message-ID: <20170908023115.GA17186@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-6-takahiro.akashi@linaro.org>
 <20170825054749.GA8604@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170825054749.GA8604@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, davem@davemloft.net, vgoyal@redhat.com

On Fri, Aug 25, 2017 at 01:47:49PM +0800, Dave Young wrote:
> On 08/24/17 at 05:18pm, AKASHI Takahiro wrote:
> > prepare_elf_headers() can also be useful for other architectures,
> > including arm64. So let it factored out.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/kernel/crash.c | 324 ----------------------------------------------
> >  include/linux/kexec.h   |  19 +++
> >  kernel/crash_core.c     | 333 ++++++++++++++++++++++++++++++++++++++++++++++++
> 
> It looks better to add these to kexec_file.c instead.

Sure

-Takahiro AKASHI

> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
