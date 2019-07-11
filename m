Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlY9f-0005gQ-45
 for kexec@lists.infradead.org; Thu, 11 Jul 2019 12:26:32 +0000
Received: by mail-ed1-x543.google.com with SMTP id s49so5628614edb.1
 for <kexec@lists.infradead.org>; Thu, 11 Jul 2019 05:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
 <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
 <CA+CK2bBrwBHhD-PFO_gVnDYoFi0Su6t456WNdtBWpOe4qM+oww@mail.gmail.com>
 <2d60f302-5161-638a-76cd-d7d79e5631fe@arm.com>
 <CA+CK2bA40wQvX=KieE5Qg2Ny5ZyiDAAjAb9W7Phu2Ou_9r6bOA@mail.gmail.com>
 <f9bea5bd-370a-47b5-8ad1-a30bd43d6cca@arm.com>
 <CA+CK2bBWis8TgyOmDhVgLYrOU95Za-UhSGSB3ufsjiNDt-Zd_w@mail.gmail.com>
 <93f99d54-9fe4-a191-4877-080ad78322bb@arm.com>
In-Reply-To: <93f99d54-9fe4-a191-4877-080ad78322bb@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 11 Jul 2019 08:26:16 -0400
Message-ID: <CA+CK2bCOeV=4+MZcZfScvTDZ8Not6qxEn1DKZKSwtJOvq-hotQ@mail.gmail.com>
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
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, Jonathan Corbet <corbet@lwn.net>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, James Morse <james.morse@arm.com>, Eric Biederman <ebiederm@xmission.com>, will@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, Jul 11, 2019 at 4:12 AM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> Hi,
>
> On 7/10/19 4:56 PM, Pavel Tatashin wrote:
> > On Wed, Jul 10, 2019 at 11:19 AM James Morse <james.morse@arm.com> wrote:
> >>
> >> Hi Pasha,
> >>
> >> On 09/07/2019 14:07, Pavel Tatashin wrote:
> >>>>> Enabling MMU and D-Cache for relocation  would essentially require the
> >>>>> same changes in kernel. Could you please share exactly why these were
> >>>>> not accepted upstream into kexec-tools?
> >>>>
> >>>> Because '--no-checks' is a much simpler alternative.
> >>>>
> >>>> More of the discussion:
> >>>> https://lore.kernel.org/linux-arm-kernel/5599813d-f83c-d154-287a-c131c48292ca@arm.com/
> >>>>
> >>>> While you can make purgatory a fully-fledged operating system, it doesn't really need to
> >>>> do anything on arm64. Errata-workarounds alone are a reason not do start down this path.
> >>>
> >>> Thank you James. I will summaries the information gathered from the
> >>> yesterday's/today's discussion and add it to the cover letter together
> >>> with ARM64 tag. I think, the patch series makes sense for ARM64 only,
> >>> unless there are other platforms that disable caching/MMU during
> >>> relocation.
> >>
> >> I'd prefer not to reserve additional memory for regular kexec just to avoid the relocation.
> >> If the kernel's relocation work is so painful we can investigate doing it while the MMU is
> >> enabled. If you can compare regular-kexec with kexec_file_load() you eliminate the
> >> purgatory part of the work.
> >
> > Relocation time is exactly the same for regular-kexec and
> > kexec_file_load(). So, the relocation is indeed painful for our case.
> > I am working on adding MMU enabled kernel relocation.
>
> Out of curiosity, does enabling only I-cache make a difference? IIRC, it doesn't
> require setting MMU, in contrast to D-cache.

Resend:

Thank you for suggestion. I have actually experimented with enabling
caches without MMU. Did not see a difference.

Thank you,
Pasha

>
> Cheers
> Vladimir
>
> >
> > Pasha
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
