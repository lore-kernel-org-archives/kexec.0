Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6IEk-0008WP-Dz
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 17:41:32 +0000
Received: by mail-ed1-x544.google.com with SMTP id c19so6968315edy.10
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 10:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-8-pasha.tatashin@soleen.com>
 <f1db863a-de57-2d1a-6bec-6020b2130964@arm.com>
In-Reply-To: <f1db863a-de57-2d1a-6bec-6020b2130964@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 13:41:17 -0400
Message-ID: <CA+CK2bDTVGm6pNRGQx7eAyEP6m0xr9X1No_=qgUOTDAoL9uigw@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] arm64, hibernate: move page handling function to
 new trans_pgd.c
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 6, 2019 at 11:18 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Now, that we abstracted the required functions move them to a new home.
> > Later, we will generalize these function in order to be useful outside
> > of hibernation.
>
> > diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> > new file mode 100644
> > index 000000000000..00b62d8640c2
> > --- /dev/null
> > +++ b/arch/arm64/mm/trans_pgd.c
> > @@ -0,0 +1,211 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (c) 2019, Microsoft Corporation.
> > + * Pavel Tatashin <patatash@linux.microsoft.com>
>
> Hmmm, while line-count isn't a useful metric: this file contains 41% of the code that was
> in hibernate.c, but has stripped the substantial copyright-pedigree that the hibernate
> code had built up over the years.
> (counting lines identified by 'cloc' as code, not comments or blank)
>
> If you are copying or moving a non trivial quantity of code, you need to preserve the
> copyright. Something like 'Derived from the arm64 hibernate support which has:'....

I will do that.  The copyright thing was meant to appear in
"generalization" patch that comes later, where I unified most of the
code to be symmetric.
So, I will add it there, and also do the derived message that you suggested.

>
>
> > + */
> > +
> > +/*
> > + * Transitional tables are used during system transferring from one world to
> > + * another: such as during hibernate restore, and kexec reboots. During these
> > + * phases one cannot rely on page table not being overwritten.
>
> I think you need to mention that hibernate and kexec are rewriting memory, and may
> overwrite the live page tables, therefore ...

Will add, thank you.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
