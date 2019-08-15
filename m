Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hyJMX-0008RJ-Cz
 for kexec@lists.infradead.org; Thu, 15 Aug 2019 17:16:39 +0000
Received: by mail-ed1-x543.google.com with SMTP id r12so2725472edo.5
 for <kexec@lists.infradead.org>; Thu, 15 Aug 2019 10:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
 <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
In-Reply-To: <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 15 Aug 2019 13:16:20 -0400
Message-ID: <CA+CK2bD6e2WGxuPG+jX8c_qyHNZOC=8NZ-wVZXQuMS2ncBNndg@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] arm64: MMU enabled kexec relocation
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>, James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-mm <linux-mm@kvack.org>

Hi,

It is been two weeks, and no review activity yet. Please help with
reviewing this work.

Thank you,
Pasha

On Thu, Aug 8, 2019 at 2:44 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> Just a friendly reminder, please send your comments on this series.
> It's been a week since I sent out these patches, and no feedback yet.
> Also, I'd appreciate if anyone could test this series on vhe hardware
> with vhe kernel, it does not look like QEMU can emulate it yet
>
> Thank you,
> Pasha
>
> On Thu, Aug 1, 2019 at 11:24 AM Pavel Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > Enable MMU during kexec relocation in order to improve reboot performance.
> >
> > If kexec functionality is used for a fast system update, with a minimal
> > downtime, the relocation of kernel + initramfs takes a significant portion
> > of reboot.
> >
> > The reason for slow relocation is because it is done without MMU, and thus
> > not benefiting from D-Cache.
> >
> > Performance data
> > ----------------
> > For this experiment, the size of kernel plus initramfs is small, only 25M.
> > If initramfs was larger, than the improvements would be greater, as time
> > spent in relocation is proportional to the size of relocation.
> >
> > Previously:
> > kernel shutdown 0.022131328s
> > relocation      0.440510736s
> > kernel startup  0.294706768s
> >
> > Relocation was taking: 58.2% of reboot time
> >
> > Now:
> > kernel shutdown 0.032066576s
> > relocation      0.022158152s
> > kernel startup  0.296055880s
> >
> > Now: Relocation takes 6.3% of reboot time
> >
> > Total reboot is x2.16 times faster.
> >
> > Previous approaches and discussions
> > -----------------------------------
> > https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
> > reserve space for kexec to avoid relocation, involves changes to generic code
> > to optimize a problem that exists on arm64 only:
> >
> > https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
> > The first attempt to enable MMU, some bugs that prevented performance
> > improvement. The page tables unnecessary configured idmap for the whole
> > physical space.
> >
> > https://lore.kernel.org/lkml/20190731153857.4045-1-pasha.tatashin@soleen.com
> > No linear copy, bug with EL2 reboots.
> >
> > Pavel Tatashin (8):
> >   kexec: quiet down kexec reboot
> >   arm64, mm: transitional tables
> >   arm64: hibernate: switch to transtional page tables.
> >   kexec: add machine_kexec_post_load()
> >   arm64, kexec: move relocation function setup and clean up
> >   arm64, kexec: add expandable argument to relocation function
> >   arm64, kexec: configure transitional page table for kexec
> >   arm64, kexec: enable MMU during kexec relocation
> >
> >  arch/arm64/Kconfig                     |   4 +
> >  arch/arm64/include/asm/kexec.h         |  51 ++++-
> >  arch/arm64/include/asm/pgtable-hwdef.h |   1 +
> >  arch/arm64/include/asm/trans_table.h   |  68 ++++++
> >  arch/arm64/kernel/asm-offsets.c        |  14 ++
> >  arch/arm64/kernel/cpu-reset.S          |   4 +-
> >  arch/arm64/kernel/cpu-reset.h          |   8 +-
> >  arch/arm64/kernel/hibernate.c          | 261 ++++++-----------------
> >  arch/arm64/kernel/machine_kexec.c      | 199 ++++++++++++++----
> >  arch/arm64/kernel/relocate_kernel.S    | 196 +++++++++---------
> >  arch/arm64/mm/Makefile                 |   1 +
> >  arch/arm64/mm/trans_table.c            | 273 +++++++++++++++++++++++++
> >  kernel/kexec.c                         |   4 +
> >  kernel/kexec_core.c                    |   8 +-
> >  kernel/kexec_file.c                    |   4 +
> >  kernel/kexec_internal.h                |   2 +
> >  16 files changed, 758 insertions(+), 340 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/trans_table.h
> >  create mode 100644 arch/arm64/mm/trans_table.c
> >
> > --
> > 2.22.0
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
