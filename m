Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlEz2-0000Od-2H
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 15:58:17 +0000
Received: by mail-ed1-x542.google.com with SMTP id e3so2668509edr.10
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2019 08:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
 <0a141018-c09e-56e4-6a73-45b951e8490f@gmail.com>
In-Reply-To: <0a141018-c09e-56e4-6a73-45b951e8490f@gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 10 Jul 2019 11:58:04 -0400
Message-ID: <CA+CK2bBJydDGSGtQ49RDLR-WdiH=8G4WfDe5PEe8DE1rfEFONQ@mail.gmail.com>
Subject: Re: [v2 0/5] arm64: allow to reserve memory for normal kexec kernel
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
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, "Eric W. Biederman" <ebiederm@xmission.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 10, 2019 at 11:28 AM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 09/07/2019 20:20, Pavel Tatashin wrote:
> > Changelog
> > v1 - v2
> >       - No changes to patches, addressed suggestion from James Morse
> >         to add "arm64" tag to cover letter.
> >       - Improved cover letter information based on discussion.
> >
> > Currently, it is only allowed to reserve memory for crash kernel, because
> > it is a requirement in order to be able to boot into crash kernel without
> > touching memory of crashed kernel is to have memory reserved.
> >
> > The second benefit for having memory reserved for kexec kernel is
> > that it does not require a relocation after segments are loaded into
> > memory.
> >
> > If kexec functionality is used for a fast system update, with a minimal
> > downtime, the relocation of kernel + initramfs might take a significant
> > portion of reboot.
> >
> > In fact, on the machine that we are using, that has ARM64 processor
> > it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
> > time:
> >
> > kernel shutdown       0.03s
> > relocation    0.35s
> > kernel startup        0.29s
> >
> > Image: 13M and initramfs is 24M. If initramfs increases, the relocation
> > time increases proportionally.
> >
> > While, it is possible to add 'kexeckernel=' parameters support to other
> > architectures by modifying reserve_crashkernel(), in this series this is
> > done for arm64 only.
> >
>
> I wonder if we couldn't use the crashkernel reserved memory area for that and
> just add logic to kexec-tools to pass to the kernel a flag (a new magic reboot
> number?) to use the crashkernel memory for that?
> The kernel would then unload the crash/capture system in the reserved memory
> area and reuse the latter for kexec.
> This would also enable the feature for all architectures.

I decided to take another route: enable MMU during kernel relocation
on ARM64. This will eliminate the problem that I am experiencing with
slow relocation.

Pasha

>
> Regards,
> Matthias
>
> > The reason it is so slow on arm64 to relocate kernel is because the code
> > that does relocation does this with MMU disabled, and thus D-Cache and
> > I-Cache must also be disabled.
> >
> > Alternative solution is more complicated: Setup a temporary page table
> > for relocation_routine and also for code from cpu_soft_restart. Perform
> > relocation with MMU enabled, do cpu_soft_restart where MMU and caching
> > are disabled, jump to purgatory. A similar approach was suggested for
> > purgatory and was rejected due to making purgatory too complicated.
> > On, the other hand hibernate does something similar already, but there
> > MMU never needs to be disabled, and also by the time machine_kexec()
> > is called, allocator is not available, as we can't fail to do reboot,
> > so page table must be pre-allocated during kernel load time.
> >
> > Note: the above time is relocation time only. Purgatory usually also
> > computes checksum, but that is skipped, because --no-check is used when
> > kernel image is loaded via kexec.
> >
> > Pavel Tatashin (5):
> >   kexec: quiet down kexec reboot
> >   kexec: add resource for normal kexec region
> >   kexec: export common crashkernel/kexeckernel parser
> >   kexec: use reserved memory for normal kexec reboot
> >   arm64, kexec: reserve kexeckernel region
> >
> >  .../admin-guide/kernel-parameters.txt         |  7 ++
> >  arch/arm64/kernel/setup.c                     |  5 ++
> >  arch/arm64/mm/init.c                          | 83 ++++++++++++-------
> >  include/linux/crash_core.h                    |  6 ++
> >  include/linux/ioport.h                        |  1 +
> >  include/linux/kexec.h                         |  6 +-
> >  kernel/crash_core.c                           | 27 +++---
> >  kernel/kexec_core.c                           | 50 +++++++----
> >  8 files changed, 127 insertions(+), 58 deletions(-)
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
