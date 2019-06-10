Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1haIGq-0004j1-Qu
 for kexec@lists.infradead.org; Mon, 10 Jun 2019 11:15:26 +0000
Received: by mail-lj1-f195.google.com with SMTP id h10so1665735ljg.0
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2019 04:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190528161026.13193-1-steve.capper@arm.com>
 <762411c4-1148-a10e-2a79-d2c9e38bc46e@redhat.com>
 <20190610105425.d4vubtcknc2wn5uk@mbp>
In-Reply-To: <20190610105425.d4vubtcknc2wn5uk@mbp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 10 Jun 2019 16:45:10 +0530
Message-ID: <CACi5LpMpyNWEoX8oR-YpjDjO9XkvaA3KYiivozm=0hT+hkQ5sw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] 52-bit kernel + user VAs
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph von Recklinghausen <crecklin@redhat.com>, Steve Capper <steve.capper@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Catalin,

On Mon, Jun 10, 2019 at 4:24 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 10, 2019 at 04:10:50PM +0530, Bhupesh Sharma wrote:
> > On 05/28/2019 09:40 PM, Steve Capper wrote:
> > >   2) How can this memory map be advertised to kdump tools/documentation?
> > >      I was planning on getting the kernel VA structure agreed on, then I
> > >      would add the relevant exports/documentation.
> >
> > Indeed, in the absence of corresponding changes to the Documentation
> > section, it is hard to visualize the changes being made in the memory
> > map.
>
> We used to have some better documentation in the arm64 memory.txt until
> commit 08375198b010 ("arm64: Determine the vmalloc/vmemmap space at
> build time based on VA_BITS") which removed it in favour of what the
> kernel was printing. Subsequently, the kernel VA layout printing was
> also removed. It would be nice to bring back the memory.txt, even if it
> is for a single configuration as per defconfig.

Indeed, that's what I suggested during the v1 review as well. See
<https://www.spinics.net/lists/arm-kernel/msg718096.html> for details.

Also, we may want to have a doc dedicated to 52-bit address space
details on arm64, similar to what we have currently for x86 (see [1a]
and [1b])

[1a]. https://github.com/torvalds/linux/blob/master/Documentation/x86/x86_64/5level-paging.txt
[1b].https://github.com/torvalds/linux/blob/master/Documentation/x86/x86_64/mm.txt

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
