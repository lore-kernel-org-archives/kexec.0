Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hnSuh-0002EI-WC
 for kexec@lists.infradead.org; Tue, 16 Jul 2019 19:15:01 +0000
Received: by mail-lj1-f193.google.com with SMTP id 16so21068384ljv.10
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2019 12:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
In-Reply-To: <20190716165641.6990-1-pasha.tatashin@soleen.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 17 Jul 2019 00:44:45 +0530
Message-ID: <CACi5LpOO+sF3o+5u4jHXzba+Ki8fZ5auekKLayxSwNOL6Lp=-w@mail.gmail.com>
Subject: Re: [RFC v1 0/4] arm64: MMU enabled kexec kernel relocation
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

On Tue, Jul 16, 2019 at 10:26 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Added identity mapped page table, and keep MMU enabled while
> kernel is being relocated from sparse pages to the final
> destination during kexec.
>
> More description about the problem I am trying to solve here, can be
> found here:
> https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com/
>
> This patch series works in terms, that I can kexec-reboot both in QEMU
> and on a physical machine. However, I do not see performance improvement
> during relocation. The performance is just as slow as before with disabled
> caches.

Thanks for the patchset, but if the changes still don't positively
impact the kexec-reboot timings, I am not sure we if gain by adding
these to the kernel.

Like I mentioned in the previous threads, we have been carrying some
relevant fixes for the same in Linux distros. I have been trying to
find time to fix them and send them upstream, but I am caught up with
some nasty kexec_file_load() issues on arm64 currently.

So, I will find some time to work on them (may be next week) and will
Cc you when I post them out after some checks on real physical
hardware.

Thanks,
Bhupesh

> Am I missing something? Perhaps, there is some flag that I should also
> enable in page table? Please provide me with any suggestions.
>
> Pavel Tatashin (4):
>   arm64, mm: identity mapped page table
>   arm64, kexec: interface preparation for mmu enabled kexec
>   arm64, kexec: add kexec's own identity page table
>   arm64: Keep MMU on while kernel is being relocated
>
>  arch/arm64/include/asm/ident_map.h  |  26 ++++++
>  arch/arm64/include/asm/kexec.h      |   5 +-
>  arch/arm64/kernel/cpu-reset.S       |   8 --
>  arch/arm64/kernel/cpu-reset.h       |   7 +-
>  arch/arm64/kernel/machine_kexec.c   | 128 +++++++++++++++++++++-------
>  arch/arm64/kernel/relocate_kernel.S |  36 +++++---
>  arch/arm64/mm/Makefile              |   1 +
>  arch/arm64/mm/ident_map.c           |  99 +++++++++++++++++++++
>  8 files changed, 255 insertions(+), 55 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ident_map.h
>  create mode 100644 arch/arm64/mm/ident_map.c
>
> --
> 2.22.0
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
