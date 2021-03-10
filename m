Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJpEE-005t9s-Ed
 for kexec@lists.infradead.org; Wed, 10 Mar 2021 03:09:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD1A264FEB
 for <kexec@lists.infradead.org>; Wed, 10 Mar 2021 03:09:37 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id jt13so34677003ejb.0
 for <kexec@lists.infradead.org>; Tue, 09 Mar 2021 19:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20210220005204.1417200-1-bauerman@linux.ibm.com>
 <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
 <7d0c6062-ca73-f183-110d-f5b75ae91d10@linux.microsoft.com>
In-Reply-To: <7d0c6062-ca73-f183-110d-f5b75ae91d10@linux.microsoft.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Mar 2021 20:09:25 -0700
Message-ID: <CAL_JsqK2M_Wfyd0MJK-0Qk7k=CspQZy6_FL6FTWkURmA_ZcARg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/kexec_file: Restore FDT size estimation for
 kdump kernel
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
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Mar 9, 2021 at 7:31 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 3/9/21 6:08 PM, Rob Herring wrote:
>
> Hi Rob,
>
> > On Fri, Feb 19, 2021 at 6:52 PM Thiago Jung Bauermann
> > <bauerman@linux.ibm.com> wrote:
> >>
> >> Commit 2377c92e37fe ("powerpc/kexec_file: fix FDT size estimation for kdump
> >> kernel") fixed how elf64_load() estimates the FDT size needed by the
> >> crashdump kernel.
> >>
> >> At the same time, commit 130b2d59cec0 ("powerpc: Use common
> >> of_kexec_alloc_and_setup_fdt()") changed the same code to use the generic
> >> function of_kexec_alloc_and_setup_fdt() to calculate the FDT size. That
> >> change made the code overestimate it a bit by counting twice the space
> >> required for the kernel command line and /chosen properties.
> >>
> >> Therefore change kexec_fdt_totalsize_ppc64() to calculate just the extra
> >> space needed by the kdump kernel, and change the function name so that it
> >> better reflects what the function is now doing.
> >>
> >> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >> ---
> >>   arch/powerpc/include/asm/kexec.h  |  2 +-
> >>   arch/powerpc/kexec/elf_64.c       |  2 +-
> >>   arch/powerpc/kexec/file_load_64.c | 26 ++++++++------------------
> >>   3 files changed, 10 insertions(+), 20 deletions(-)
> >
> > I ended up delaying the referenced series til 5.13, but have applied
> > it now. Can I get an ack from the powerpc maintainers on this one?
> > I'll fixup the commit log to make sense given the commit id's aren't
> > valid.
>
> I checked the change applied in linux-next branch and also Device Tree's
> for-next branch - it looks like v1 of Thiago's patch has been applied.
> Could you please pick up the v2 patch?

Huh? This patch (v2) hasn't been applied to any tree AFAICT.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
