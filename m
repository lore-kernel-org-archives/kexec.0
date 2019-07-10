Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlEw3-0007rC-LJ
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 15:55:13 +0000
Received: by mail-ed1-x542.google.com with SMTP id s49so2687662edb.1
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2019 08:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
 <d57ec270-a9dc-1820-195c-eb7ef61f9828@redhat.com>
In-Reply-To: <d57ec270-a9dc-1820-195c-eb7ef61f9828@redhat.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 10 Jul 2019 11:54:59 -0400
Message-ID: <CA+CK2bC_e=mkxeic--Rw6t84pnP139S_JqoGp9CsJ=aSrnY5mA@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, "Eric W. Biederman" <ebiederm@xmission.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 10, 2019 at 3:32 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Pavel,
>
> On 07/09/2019 11:50 PM, Pavel Tatashin wrote:
> > Changelog
> > v1 - v2
> >       - No changes to patches, addressed suggestion from James Morse
> >         to add "arm64" tag to cover letter.
>
> Minor nit. Please also add PATCH to the subject line. Something like
> [PATCH v2]

OK

>
> Also will suggest to wait for atleast a couple of days before sending a
> new version of the patchset so as to give sufficient time for reviews to
> happen.

OK

>
> >       - Improved cover letter information based on discussion.
>
> > Currently, it is only allowed to reserve memory for crash kernel, because
> > it is a requirement in order to be able to boot into crash kernel without
> > touching memory of crashed kernel is to have memory reserved.
>
> > The second benefit for having memory reserved for kexec kernel is
> > that it does not require a relocation after segments are loaded into
> > memory.
>
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
>
> Note that we normally have two dimensions to this (and similar)
> problem(s) - time we spend in relocating the kernel + initramfs v/s the
> memory space we reserve while enabling kexeckernel (in this case) in the
> primary kernel.

Yes, for our specific case (Microsoft), it is more important to faster
reboot and have 64M permanently reserved. However, after thinking
about this, I decided to go ahead, and implement MMU enabled kernel
relocation for ARM64.

>
> Just to give you an example, I have to shrink even the crashkernel
> reservation size in the primary kernel on arm64 systems running fedora
> which have very small memory footprint. I have a amazon ec2 (aarch64)
> for example which runs with 256M memory space and even enabling
> crashkernel on the same was quite a challenge :)
>
> In such a case we need to do a comparison between the space we reserve
> v/s the time we spend while relocating while doing a kexec load.
>
> Note that we recently had issues with OOM in crashkernel boot, because
> of which we had to introduce kernel command-line parameter to allow a
> user to disable device dump to reduce memory usage, see the following
> commit:
>
> a3a3031b384f ("vmcore: Add a kernel parameter novmcoredd")
>
> More on the same below ...
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
>
> ... may be its time to explore this path now with a fresh mind. I know
> Pratyush tried a bit on this and now I am experimenting on the same on
> several aarch64 systems, mainly because we are really short on memory
> resources on several aarch64 systems (used in embedded/cloud domain) and
> frequently run into OOM issues even in the primary kernel.
>
> Some more comments below:
>
> 1. I recommend protecting this code under a CONFIG (CONFIG_FAST_KEXEC ?)
> option and make it dependent on ARM64 being enabled (via CONFIG_ARM64
> option) to avoid causing issues on other archs like s390, powerpc,
> x86_64 (which probably don't need these changes).
>
> Also better to make the CONFIG option disabled by default, so that we
> can avoid OOM issues in primary kernel on arm64 systems with smaller
> memory footprints. A user can enabled it, if he needs fast kexec load
> experience..
>
> 2. Also, I don't see timing results for kexec_file_load() in this cover
> letter. Can you add some results for the same here, or are they on
> similar lines?
>
> I will give this a go on some aarch64 systems at my end and come back
> with more on the kernel + initramfs relocation time v/s memory space
> taken up results.
>
> Thanks,
> Bhupesh
>
> > Note: the above time is relocation time only. Purgatory usually also
> > computes checksum, but that is skipped, because --no-check is used when
> > kernel image is loaded via kexec.
> >
> > Pavel Tatashin (5):
> >    kexec: quiet down kexec reboot
> >    kexec: add resource for normal kexec region
> >    kexec: export common crashkernel/kexeckernel parser
> >    kexec: use reserved memory for normal kexec reboot
> >    arm64, kexec: reserve kexeckernel region
> >
> >   .../admin-guide/kernel-parameters.txt         |  7 ++
> >   arch/arm64/kernel/setup.c                     |  5 ++
> >   arch/arm64/mm/init.c                          | 83 ++++++++++++-------
> >   include/linux/crash_core.h                    |  6 ++
> >   include/linux/ioport.h                        |  1 +
> >   include/linux/kexec.h                         |  6 +-
> >   kernel/crash_core.c                           | 27 +++---
> >   kernel/kexec_core.c                           | 50 +++++++----
> >   8 files changed, 127 insertions(+), 58 deletions(-)
> >
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
