Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dl39D-0006SD-Eg
 for kexec@lists.infradead.org; Fri, 25 Aug 2017 01:10:56 +0000
Received: by mail-pg0-x232.google.com with SMTP id a7so5670910pgn.1
 for <kexec@lists.infradead.org>; Thu, 24 Aug 2017 18:10:35 -0700 (PDT)
Date: Fri, 25 Aug 2017 10:10:23 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 08/14] arm64: kexec_file: create purgatory
Message-ID: <20170825011022.GA7245@akashi-kouhiroshi-no-MacBook-Air.local>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
 <CAKv+Gu9UUF-36iEkpsweOAPKOX8nQcoRy1+ushr6GTJiUC6fKg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9UUF-36iEkpsweOAPKOX8nQcoRy1+ushr6GTJiUC6fKg@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Aug 24, 2017 at 10:10:37AM +0100, Ard Biesheuvel wrote:
> On 24 August 2017 at 09:18, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > This is a basic purgtory, or a kind of glue code between the two kernel,
> > for arm64. We will later add a feature of verifying a digest check against
> > loaded memory segments.
> >
> > arch_kexec_apply_relocations_add() is responsible for re-linking any
> > relative symbols in purgatory. Please note that the purgatory is not
> > an executable, but a non-linked archive of binaries so relative symbols
> > contained here must be resolved at kexec load time.
> 
> This sounds fragile to me. What is the reason we cannot let the linker
> deal with this, similar to, e.g., how the VDSO gets linked?

Please note this is exactly what x86 code does.
I guess that the reason is that x86 guys borrowed the logic directly
from kexec-tools.

> Otherwise, couldn't we reuse the module loader to get these objects
> relocated in memory? I'm sure there are differences that would require
> some changes there, but implementing all of this again sounds like
> overkill to me.

I'll look at both of your suggestions.

Thanks,
-Takahiro AKASHI

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
