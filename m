Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hknaL-0004US-5W
 for kexec@lists.infradead.org; Tue, 09 Jul 2019 10:42:58 +0000
Received: by mail-lj1-f196.google.com with SMTP id k18so19054962ljc.11
 for <kexec@lists.infradead.org>; Tue, 09 Jul 2019 03:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
In-Reply-To: <20190708211528.12392-1-pasha.tatashin@soleen.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 9 Jul 2019 16:06:05 +0530
Message-ID: <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, Eric Biederman <ebiederm@xmission.com>, will@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Pavel,

On Tue, Jul 9, 2019 at 2:46 AM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> Currently, it is only allowed to reserve memory for crash kernel, because
> it is a requirement in order to be able to boot into crash kernel without
> touching memory of crashed kernel is to have memory reserved.
>
> The second benefit for having memory reserved for kexec kernel is
> that it does not require a relocation after segments are loaded into
> memory.
>
> If kexec functionality is used for a fast system update, with a minimal
> downtime, the relocation of kernel + initramfs might take a significant
> portion of reboot.
>
> In fact, on the machine that we are using, that has ARM64 processor
> it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
> time:
>
> kernel shutdown 0.03s
> relocation      0.35s
> kernel startup  0.29s
>
> Image: 13M and initramfs is 24M. If initramfs increases, the relocation
> time increases proportionally.
>
> While, it is possible to add 'kexeckernel=' parameters support to other
> architectures by modifying reserve_crashkernel(), in this series this is
> done for arm64 only.
>
> Pavel Tatashin (5):
>   kexec: quiet down kexec reboot
>   kexec: add resource for normal kexec region
>   kexec: export common crashkernel/kexeckernel parser
>   kexec: use reserved memory for normal kexec reboot
>   arm64, kexec: reserve kexeckernel region
>
>  .../admin-guide/kernel-parameters.txt         |  7 ++
>  arch/arm64/kernel/setup.c                     |  5 ++
>  arch/arm64/mm/init.c                          | 83 ++++++++++++-------
>  include/linux/crash_core.h                    |  6 ++
>  include/linux/ioport.h                        |  1 +
>  include/linux/kexec.h                         |  6 +-
>  kernel/crash_core.c                           | 27 +++---
>  kernel/kexec_core.c                           | 50 +++++++----
>  8 files changed, 127 insertions(+), 58 deletions(-)
>
> --
> 2.22.0

This seems like an issue with time spent while doing sha256
verification while in purgatory.

Can you please try the following two patches which enable D-cache in
purgatory before SHA verification and disable it before switching to
kernel:

http://lists.infradead.org/pipermail/kexec/2017-May/018839.html
http://lists.infradead.org/pipermail/kexec/2017-May/018840.html

Note that these were not accepted upstream but are included in several
distros in some form or the other :)

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
