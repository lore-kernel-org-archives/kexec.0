Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6GPP-0007aX-1S
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 15:44:24 +0000
Received: by mail-ed1-x544.google.com with SMTP id i1so6719820edv.4
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 08:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-6-pasha.tatashin@soleen.com>
 <ddd81093-89fc-5146-0b33-ad3bd9a1c10c@arm.com>
In-Reply-To: <ddd81093-89fc-5146-0b33-ad3bd9a1c10c@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 11:44:10 -0400
Message-ID: <CA+CK2bBXfa0MFspOpWAGL4Q7iYH9UMdKAwMD-PyL7Wp4s64x+Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] arm64, hibernate: check pgd table allocation
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

On Fri, Sep 6, 2019 at 11:17 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > There is a bug in create_safe_exec_page(), when page table is allocated
> > it is not checked that table is allocated successfully:
> >
> > But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).
>
> If there is a bug, it shouldn't be fixed part way through a series. This makes it
> difficult to backport the fix.
>
> Please split this out as an independent patch with a 'Fixes:' tag for the commit that
> introduced the bug.
>
>
> > Another issue,
>
> So this patch does two things? That is rarely a good idea. Again, this makes it difficult
> to backport the fix.
>
>
> > is that phys_to_ttbr() uses an offset in page table instead
> > of pgd directly.
>
> If you were going to reuse this, that would be a bug. But because the only page that is
> being mapped, is mapped to PAGE_SIZE, all the top bits will be 0. The offset calls are
> boiler-plate. It doesn't look intentional, but its harmless.

Yes, it is harmless otherwise the code would not work. But it is
confusing to read, and looks broken. I will separate this change as
two patches as you suggested.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
