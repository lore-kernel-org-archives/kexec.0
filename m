Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iL6jm-0008Ux-6g
 for kexec@lists.infradead.org; Thu, 17 Oct 2019 14:26:48 +0000
Received: by mail-ed1-x544.google.com with SMTP id l21so1899252edr.5
 for <kexec@lists.infradead.org>; Thu, 17 Oct 2019 07:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 17 Oct 2019 10:26:33 -0400
Message-ID: <CA+CK2bC2KwWufE1DWa4szn_hQ1dbjDVHgYUu7=J4O_kvKXTrHg@mail.gmail.com>
Subject: Re: [PATCH v7 00/25] arm64: MMU enabled kexec relocation
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>, James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Bhupesh Sharma <bhsharma@redhat.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>

> https://lore.kernel.org/lkml/45a2f0b8-5bac-8b5d-d595-f92e9acb27ad@arm.com
> > +     /* Map relocation function va == pa */
> > +     rc = trans_pgd_map_page(&info, trans_ttbr0,  __va(kern_reloc),
> > +                             kern_reloc, PAGE_KERNEL_EXEC);
> > +     if (rc)
> > +             return rc;
> James wrote:
> You can't do this with the page table helpers. We support platforms
> with no memory in range of TTBR0's VA space. See dd006da21646f
>
> You will need some idmapped memory to turn the MMU off on a system
> that booted at EL1. This will need to be in a set of page tables
> that the helpers can't easily touch - so it should only be a single
> page. (like the arch code's existing idmap - although that may
> have been overwritten).
>
> (I have a machine where this is a problem, if I get the time I will
> have a stab at making hibernate's safe page idmaped).
> ---
>
> As I understand, there are platforms where TTBR0 cannot include all
> physical memory for idmap. However, kexec must have at least one page
> idmapped (kimage->control_code_page) to be able to relocate kernel
> while MMU is enabled:
>
> I am still trying to fully understand the problem:
> CONFIG_ARM64_VA_BITS must be smaller than 48 and physical memory must
> start at a high address for this problem to occur.
>
> Why can't we simply decrease T0SZ to cover all physical memory?

Is there a way to reproduce this platform with qemu?

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
