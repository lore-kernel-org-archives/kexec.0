Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr4Ba-0004Nx-NZ
 for kexec@lists.infradead.org; Thu, 02 Jul 2020 18:43:51 +0000
Received: by mail-qk1-f198.google.com with SMTP id s5so1250017qkj.1
 for <kexec@lists.infradead.org>; Thu, 02 Jul 2020 11:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <159370984726.27923.4874334372278158979.b4-ty@arm.com>
In-Reply-To: <159370984726.27923.4874334372278158979.b4-ty@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 3 Jul 2020 00:13:31 +0530
Message-ID: <CACi5LpNUDmoMkEuHvw0Asg=OHJCB3SfZR7XmuyzpFdSkdb5vjw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
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
Cc: Mark Rutland <mark.rutland@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Amit Kachhap <amit.kachhap@arm.com>, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, John Donnelly <john.p.donnelly@oracle.com>, Scott Branden <scott.branden@broadcom.com>, Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Steve Capper <steve.capper@arm.com>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Dave Anderson <anderson@redhat.com>, linuxppc-dev@lists.ozlabs.org

On Thu, Jul 2, 2020 at 10:45 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, 14 May 2020 00:22:35 +0530, Bhupesh Sharma wrote:
> > Apologies for the delayed update. Its been quite some time since I
> > posted the last version (v5), but I have been really caught up in some
> > other critical issues.
> >
> > Changes since v5:
> > ----------------
> > - v5 can be viewed here:
> >   http://lists.infradead.org/pipermail/kexec/2019-November/024055.html
> > - Addressed review comments from James Morse and Boris.
> > - Added Tested-by received from John on v5 patchset.
> > - Rebased against arm64 (for-next/ptr-auth) branch which has Amit's
> >   patchset for ARMv8.3-A Pointer Authentication feature vmcoreinfo
> >   applied.
> >
> > [...]
>
> Applied to arm64 (for-next/vmcoreinfo), thanks!
>
> [1/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
>       https://git.kernel.org/arm64/c/1d50e5d0c505
> [2/2] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
>       https://git.kernel.org/arm64/c/bbdbc11804ff

Thanks Catalin for pulling in the changes.

Dave and James, many thanks for reviewing the same as well.

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
