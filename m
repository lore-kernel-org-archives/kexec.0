Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hss1V-00075s-9C
 for kexec@lists.infradead.org; Wed, 31 Jul 2019 17:04:22 +0000
Received: by mail-ed1-x543.google.com with SMTP id s49so31545305edb.1
 for <kexec@lists.infradead.org>; Wed, 31 Jul 2019 10:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153857.4045-1-pasha.tatashin@soleen.com>
 <20190731163258.GH39768@lakrids.cambridge.arm.com>
 <CA+CK2bAYUFBBGo-LHBK4UWRK1tpx3AZ4Z9NkDxiDK0UYEDozaQ@mail.gmail.com>
 <20190731165007.GJ39768@lakrids.cambridge.arm.com>
In-Reply-To: <20190731165007.GJ39768@lakrids.cambridge.arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 31 Jul 2019 13:04:08 -0400
Message-ID: <CA+CK2bBOSC0iYjq_A18DNaNCYskTTJJTkM4N-WAqssoxpxuNPg@mail.gmail.com>
Subject: Re: [RFC v2 0/8] arm64: MMU enabled kexec relocation
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 31, 2019 at 12:50 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jul 31, 2019 at 12:40:51PM -0400, Pavel Tatashin wrote:
> > On Wed, Jul 31, 2019 at 12:33 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > Hi Pavel,
> > >
> > > Generally, the cover letter should state up-front what the goal is (or
> > > what problem you're trying to solve). It would be really helpful to have
> > > that so that we understand what you're trying to achieve, and why.
>
> [...]
>
> > > > Here is the current data from the real hardware:
> > > > (because of bug, I forced EL1 mode by setting el2_switch always to zero in
> > > > cpu_soft_restart()):
> > > >
> > > > For this experiment, the size of kernel plus initramfs is 25M. If initramfs
> > > > was larger, than the improvements would be even greater, as time spent in
> > > > relocation is proportional to the size of relocation.
> > > >
> > > > Previously:
> > > > kernel shutdown       0.022131328s
> > > > relocation    0.440510736s
> > > > kernel startup        0.294706768s
> > >
> > > In total this takes ~0.76s...
> > >
> > > >
> > > > Relocation was taking: 58.2% of reboot time
> > > >
> > > > Now:
> > > > kernel shutdown       0.032066576s
> > > > relocation    0.022158152s
> > > > kernel startup        0.296055880s
> > >
> > > ... and this takes ~0.35s
> > >
> > > So do we really need this complexity for a few blinks of an eye?
> >
> > Yes, we have an extremely tight reboot budget, 0.35s is not an acceptable waste.
>
> Could you please elaborate on your use-case?
>
> Understanfin what you're trying to achieve would help us to understand
> which solutions make sense.

An extremely high availability device with an update story utilizing
kexec functionality for a faster kernel update and also for being able
to preserve some state in memory without wasting the time of copying
it to and from a backing storage. We at Microsoft will be using a
fleet of these devices. The total reboot budget is less than half a
second, out of which 0.44s is currently spent in kexec relocation.

Pasha

>
> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
