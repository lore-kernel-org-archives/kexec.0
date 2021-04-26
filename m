Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb5jH-008GG6-I5
 for kexec@lists.infradead.org; Mon, 26 Apr 2021 18:13:09 +0000
Received: by mail-ed1-x52d.google.com with SMTP id cq11so23219377edb.0
 for <kexec@lists.infradead.org>; Mon, 26 Apr 2021 11:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
 <20210408040537.2703241-4-pasha.tatashin@soleen.com>
 <480272f8fb3e46d24a0ee1418fb85809@kernel.org>
 <CA+CK2bDc+9EsH_TLTgg9Pqv_-rZfZfPohdZEfsYjT8ss+8skjg@mail.gmail.com>
 <87v98wom5n.wl-maz@kernel.org>
 <CA+CK2bB9M05UKfvu66_wMK1u_HBvRws4R0KxPgTu4vPdKuGy9w@mail.gmail.com>
In-Reply-To: <CA+CK2bB9M05UKfvu66_wMK1u_HBvRws4R0KxPgTu4vPdKuGy9w@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 26 Apr 2021 14:10:30 -0400
Message-ID: <CA+CK2bADNkoX-Q3tNyjJ7fo6-f4sBPkAVYLiQh-rxFOcHzbJGw@mail.gmail.com>
Subject: Re: [PATCH v13 03/18] arm64: hyp-stub: Move el1_sync into the vectors
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
To: Marc Zyngier <maz@kernel.org>
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>

Hi Marc

Are you planning to send more review comments, or should I send the new version?

Thanks,
Pasha

On Thu, Apr 8, 2021 at 12:28 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > Thank you for noticing this. Not sure how this missmerge happened. I
> > > have added the missing case, and VHE is initialized correctly during
> > > boot.
> > > [   14.698175] kvm [1]: VHE mode initialized successfully
> > >
> > > During normal boot, kexec reboot, and kdump reboot. I will respin the
> > > series and send the version 14 soon.
> >
> > Please give people a chance to review this lot first. This isn't code
> > that is easy to digest, and immediate re-spinning does more harm than
> > good (this isn't targeting 5.13, I would assume).
> >
>
> There are people who are testing this series, this is why I wanted to
> respin. But, I will wait for review comments before sending the next
> version. In the meantime I will send a fixed version of this patch as
> a reply to this thread instead.
>
> Thanks,
> Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
