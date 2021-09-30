Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVm4F-00CnjJ-N2
 for kexec@lists.infradead.org; Thu, 30 Sep 2021 02:45:05 +0000
Received: by mail-lf1-x12f.google.com with SMTP id x27so18876871lfa.9
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 19:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-6-pasha.tatashin@soleen.com>
 <20210929121336.GB21631@willie-the-truck>
In-Reply-To: <20210929121336.GB21631@willie-the-truck>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Sep 2021 22:44:23 -0400
Message-ID: <CA+CK2bCcawYWO+EjLbSciLQaM3g4eUWQN0uokNs1zN+An9KYSA@mail.gmail.com>
Subject: Re: [PATCH v17 05/15] arm64: kexec: skip relocation code for inplace
 kexec
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
To: Will Deacon <will@kernel.org>
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com

Hi Will,

> > +             cpu_install_idmap();
> > +             restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
> > +             restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
> > +                     0, 0);
>
> Why can't you call:
>
>         cpu_soft_restart(kimage->start, kimage->arch.dtb_mem, 0, 0);
>
> here instead of open-coding it?

This is part of a cleanup to remove cpu_soft_restart() wrapper and the
header file that contains it. The wrapper is simple enough and has
only one call site. It makes more sense to do what is needed directly
from machine_kexec().

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
