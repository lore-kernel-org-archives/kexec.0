Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 9 Oct 2018 16:04:05 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v15 07/16] arm64: add image head flag definitions
Message-ID: <20181009150404.cqpkmi2wumututwa@lakrids.cambridge.arm.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-8-takahiro.akashi@linaro.org>
 <20181001125225.7tlfzt5n25sckhyy@lakrids.cambridge.arm.com>
 <20181002075939.GG32578@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181002075939.GG32578@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, prudo@linux.ibm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 04:59:40PM +0900, AKASHI Takahiro wrote:
> Hi Mark,
> 
> On Mon, Oct 01, 2018 at 01:52:26PM +0100, Mark Rutland wrote:
> > On Fri, Sep 28, 2018 at 03:48:32PM +0900, AKASHI Takahiro wrote:
> > > Those image head's flags will be used later by kexec_file loader.
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Acked-by: James Morse <james.morse@arm.com>
> > > ---
> > >  arch/arm64/include/asm/boot.h | 15 +++++++++++++++
> > >  arch/arm64/kernel/head.S      |  2 +-
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
> > > index 355e552a9175..0bab7eed3012 100644
> > > --- a/arch/arm64/include/asm/boot.h
> > > +++ b/arch/arm64/include/asm/boot.h
> > > @@ -5,6 +5,21 @@
> > >  
> > >  #include <asm/sizes.h>
> > >  
> > > +#define ARM64_MAGIC		"ARM\x64"
> > > +
> > > +#define HEAD_FLAG_BE_SHIFT		0
> > > +#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
> > > +#define HEAD_FLAG_BE_MASK		0x1
> > > +#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
> > > +
> > > +#define HEAD_FLAG_BE			1
> > 
> > These already exist in some form in arch/arm64/kernel/image.h; can we
> > please factor those out rather than duplicating them?
> 
> Sure.
> 
> > I'd be happy if you'd update image.h to use the new HEAD_FLAG_* names,
> > and removed the old definitions.
> 
> I want to make sure two things;
> 
> 1. Do you assume all the existing __HEAD_FLAG_xyz's NOT be renamed
>    (say, to HEAD_FLAG_xyz)?

I'm perfectly happy for them to be renamed, I just don't want duplicate
definitions.

Let's rename them to ARM64_IMAGE_FLAG_<foo>, and place them in a new
header, arch/arm64/include/asm/image.h, which arch/arm64/kernel/image.h
can include and make use of.

> 
> 2. Do you mind removing this check in image.h?
>    (we also need to manage 'CONFIG_EFI' part of image.h.)

What exactly do we need from that? AFAICT that's all linker script
stuff that shouldn't matter for kexec.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
