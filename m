Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l36u1-0000rz-Jm
 for kexec@lists.infradead.org; Sat, 23 Jan 2021 00:35:47 +0000
Received: by mail-ed1-x534.google.com with SMTP id d22so8602358edy.1
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2021 16:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-8-pasha.tatashin@soleen.com>
 <b79b0b58-5f8e-913b-3913-b95551ef7ce1@arm.com>
In-Reply-To: <b79b0b58-5f8e-913b-3913-b95551ef7ce1@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 22 Jan 2021 19:35:08 -0500
Message-ID: <CA+CK2bD0amaPDJgoYn2-VK_LbzCkJBa_oMBgVsDTfbZvUw=3QA@mail.gmail.com>
Subject: Re: [PATCH v9 07/18] arm64: trans_pgd: hibernate: idmap the single
 page that holds the copy page routines
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, rfontana@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Selin Dag <selindag@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 29, 2020 at 1:01 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > From: James Morse <james.morse@arm.com>
> >
> > To resume from hibernate, the contents of memory are restored from
> > the swap image. This may overwrite any page, including the running
> > kernel and its page tables.
> >
> > Hibernate copies the code it uses to do the restore into a single
> > page that it knows won't be overwritten, and maps it with page tables
> > built from pages that won't be overwritten.
> >
> > Today the address it uses for this mapping is arbitrary, but to allow
> > kexec to reuse this code, it needs to be idmapped. To idmap the page
> > we must avoid the kernel helpers that have VA_BITS baked in.
> >
> > Convert create_single_mapping() to take a single PA, and idmap it.
> > The page tables are built in the reverse order to normal using
> > pfn_pte() to stir in any bits between 52:48. T0SZ is always increased
> > to cover 48bits, or 52 if the copy code has bits 52:48 in its PA.
> >
> > Pasha: The original patch from James
> > inux-arm-kernel/20200115143322.214247-4-james.morse@arm.com
>
> -EBROKENLINK
>
> The convention is to use a 'Link:' tag in the signed-off area.
> e.g. 5a3577039cbe

OK Fixed.

>
> > Adopted it to trans_pgd, so it can be commonly used by both Kexec
> > and Hibernate. Some minor clean-ups.
>
> Please describe your changes just before your SoB. This means each author sign's off on
> the stuff above their SoB, and its obvious who made which changes.
>
> Search for 'Lucky K Maintainer' in process/submitting-patches.rst for an example.

OK, Fixed.
eed the maximum T0SZ.
> > + *
> > + * Returns 0 on success, and -ENOMEM on failure.
> > + * On success trans_ttbr0 contains page table with idmapped page, t0sz is set to
>
> > + * maxumum T0SZ for this page.
>
> maxumum
>

Ok.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
