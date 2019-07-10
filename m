Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlEu9-0005zC-50
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 15:53:14 +0000
Received: by mail-ed1-x52c.google.com with SMTP id v15so2658180eds.9
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2019 08:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
 <20190710065953.GA4744@localhost.localdomain>
In-Reply-To: <20190710065953.GA4744@localhost.localdomain>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 10 Jul 2019 11:53:00 -0400
Message-ID: <CA+CK2bAC2371999HMMCv6TCf1351u_nV4R1gBLc=79dpLakhHA@mail.gmail.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, "Eric W. Biederman" <ebiederm@xmission.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

> The crashkernel reservation for kdump is a must, there are already a lot
> of different problems need to consider, for example the low and high
> memory issues, and a lot of other things.  I'm not convinced to enable
> this for kexec reboot.
>
> This really looks to workaround the arm64 issue and move the
> complication to kernel.

I will be working on MMU arm64 kernel relocation solution.

Pasha

>
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
> > --
> > 2.22.0
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
