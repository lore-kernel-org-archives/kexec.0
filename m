Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJoGr-005n2L-0I
 for kexec@lists.infradead.org; Wed, 10 Mar 2021 02:08:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D70B665001
 for <kexec@lists.infradead.org>; Wed, 10 Mar 2021 02:08:18 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id mm21so34104825ejb.12
 for <kexec@lists.infradead.org>; Tue, 09 Mar 2021 18:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20210220005204.1417200-1-bauerman@linux.ibm.com>
In-Reply-To: <20210220005204.1417200-1-bauerman@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Mar 2021 19:08:05 -0700
Message-ID: <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
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
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Feb 19, 2021 at 6:52 PM Thiago Jung Bauermann
<bauerman@linux.ibm.com> wrote:
>
> Commit 2377c92e37fe ("powerpc/kexec_file: fix FDT size estimation for kdump
> kernel") fixed how elf64_load() estimates the FDT size needed by the
> crashdump kernel.
>
> At the same time, commit 130b2d59cec0 ("powerpc: Use common
> of_kexec_alloc_and_setup_fdt()") changed the same code to use the generic
> function of_kexec_alloc_and_setup_fdt() to calculate the FDT size. That
> change made the code overestimate it a bit by counting twice the space
> required for the kernel command line and /chosen properties.
>
> Therefore change kexec_fdt_totalsize_ppc64() to calculate just the extra
> space needed by the kdump kernel, and change the function name so that it
> better reflects what the function is now doing.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/kexec.h  |  2 +-
>  arch/powerpc/kexec/elf_64.c       |  2 +-
>  arch/powerpc/kexec/file_load_64.c | 26 ++++++++------------------
>  3 files changed, 10 insertions(+), 20 deletions(-)

I ended up delaying the referenced series til 5.13, but have applied
it now. Can I get an ack from the powerpc maintainers on this one?
I'll fixup the commit log to make sense given the commit id's aren't
valid.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
