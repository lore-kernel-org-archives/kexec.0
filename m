Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hyhl8-0001HU-P8
 for kexec@lists.infradead.org; Fri, 16 Aug 2019 19:19:36 +0000
Received: by mail-ed1-x542.google.com with SMTP id z51so6011951edz.13
 for <kexec@lists.infradead.org>; Fri, 16 Aug 2019 12:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
 <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
 <ba8a2519-ed95-2518-d0e8-66e8e0c14ff5@arm.com>
 <CA+CK2bAqBi43Cchr=md7EPRuEWH-iuToK0PxN3ysSBQ42Hd0-g@mail.gmail.com>
 <746ceee3-43a7-231d-b2f6-0991a4148a28@arm.com>
In-Reply-To: <746ceee3-43a7-231d-b2f6-0991a4148a28@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 16 Aug 2019 15:19:20 -0400
Message-ID: <CA+CK2bAEFU2s5v9seo4Y_5M0WLp0PCQGAZ=ovgO855jR7zDSwg@mail.gmail.com>
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
To: James Morse <james.morse@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi James,

Thank you for your feedback, my replies below:

> > It is not really an all-new implementation of hibernate (for kexec it
> > is true though). I used the current implementation of hibernate as
> > bases, and simply generalized the functions by providing a flexible
> > interface. So what you are asking is actually exactly what I am doing.
>
> I disagree. The resume page-table code is the bulk of the complexity in hibernate.c. Your
> first patch dumps ~200 lines of differently-complex code, and your second switches
> hibernate over to it.

OK, I will make the change incremental.

>
> Instead, please move that code, keeping it as it is. git will spot the move, and the
> generated diffstat should only reflect the build-system changes. You don't need to 'switch
> hibernate to transitional page tables.'
>
> Adding kexec will then show-up what needs changing, each change comes with a commit
> message explaining why. Having these as 'generalisations' in the first patch is a mess.

Makes sense, I will fix it.

>
> There is existing code that we don't want to break. Any changes need to be done as a
> sequence of small incremental changes. It can't be reviewed any other way.
>
>
> > I realize, that I introduced a bug that I will fix.
>
> Done as a sequence of small incremental changes, I could bisect it to the patch that
> introduces the bug, and probably fix it from the description in the commit message.

BTW, I root caused it, there were two trivial errors:
1. In "arm64, mm: transitional tables"
int i = pgd_index(addr);
In trans_table_copy_*:
should be: pte_index(), pmd_index(), pud_index(), accordingly.
2. In trans_table_create_copy()
pgd_offset_k(PAGE_OFFSET) should be: mm_init.pgd

> >> It looks like you are creating the page tables just after the kexec:segments have been
> >> loaded. This will go horribly wrong if anything changes between then and kexec time. (e.g.
> >> memory you've got mapped gets hot-removed).
> >> This needs to be done as late as possible, so we don't waste memory, and the world can't
> >> change around us. Reboot notifiers run before kexec, can't we do the memory-allocation there?
>
> > Kexec by design does not allow allocate during kexec time. This is
> > because we cannot fail during kexec syscall.
>
> This problem needs solving.
>
> | Reboot notifiers run before kexec, can't we do the memory-allocation there?
>
>
> > All allocations must be done during kexec load time.
>
> This increases the memory footprint. I don't think we should waste ~2MB per GB of kernel
> memory on this feature. (Assuming 4K pages and rodata_full)
>
> Another option is to allocate this memory at load time, but then free it so it can be used
> in the meantime. You can keep the list of allocated pfn, as we know they aren't in use by
> the running kernel, kexec metadata, loaded images etc.

This is until a new kernel module is loaded, I do not think this is safe to do.

In my opinion 2M per 1 GB is a fair trade off for a faster kexec
performance. Unlike with crash kexec for which we do not add any
memory useage, the kernel does not have to be all the time in memory,
but can be loaded by user before reboot. If machine is so scare on
memory resources that 2M per 1G matters, user simply won't keep new
kernel in memory until it is actually needed.

>
> Memory hotplug would need handling carefully, as would anything that 'donates' memory to
> another agent. (I suspect the TEE stuff does this, I don't know how it interacts with kexec)
>
>
> > Kernel memory cannot be hot-removed, as
> > it is not part of ZONE_MOVABLE, and cannot be migrated.
>
> Today, yes. Tomorrow?, "arm64/mm: Enable memory hot remove":
> https://lore.kernel.org/r/1563171470-3117-1-git-send-email-anshuman.khandual@arm.com

I understand that ARM64 is about to get hot-remove feature, but what I
am saying is that my feature does not introduce new problem because
the current kexec code assumes that kernel memory is not movable
(array of sparse physical source dest addresses in kimage->head). It
is possible to offline and hot-remove only memory that can be freed by
page migration, the pages that were allocated for kexec kernel are not
one of them.

> >>>> Previously:
> >>>> kernel shutdown 0.022131328s
> >>>> relocation      0.440510736s
> >>>> kernel startup  0.294706768s
> >>>>
> >>>> Relocation was taking: 58.2% of reboot time
> >>>>
> >>>> Now:
> >>>> kernel shutdown 0.032066576s
> >>>> relocation      0.022158152s
> >>>> kernel startup  0.296055880s
> >>>>
> >>>> Now: Relocation takes 6.3% of reboot time
> >>>>
> >>>> Total reboot is x2.16 times faster.
> >>
> >> When I first saw these numbers they were ~'0.29s', which I wrongly assumed was 29 seconds.
> >> Savings in milliseconds, for _reboot_ is a hard sell. I'm hoping that on the machines that
> >> take minutes to kexec we'll get numbers that make this change more convincing.
>
> > Sure, this userland is very small kernel+userland is only 47M. Here is
> > another data point: fitImage: 380M, it contains a larger userland.
> > The numbers for kernel shutdown and startup are the same as this is
> > the same kernel, but relocation takes: 3.58s
> > shutdown: 0.02s
> > relocation: 3.58s
> > startup:  0.30s
> >
> > Relocation take 88% of reboot time. And, we must have it under one second.
>
> Where does this one second number come from? (was it ever a reasonable starting point?)

Currently we have two fitImages for this system in development: one
that has a bare minimal userland, only ~40 packages, and another has a
more complete userland. So, my first experiment shows the data from
this first bare minimum ftImage, the second experiment from the second
more complete fitImage. As I stated in cover letter, kexec time is
proportional to the size of the image and this series fixes this
scalability issue by making relocation  ~20 times faster.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
