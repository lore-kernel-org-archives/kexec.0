Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb5kL-008GRN-JC
 for kexec@lists.infradead.org; Mon, 26 Apr 2021 18:14:15 +0000
Received: by mail-ej1-x631.google.com with SMTP id t4so2529972ejo.0
 for <kexec@lists.infradead.org>; Mon, 26 Apr 2021 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
 <20210408040537.2703241-4-pasha.tatashin@soleen.com>
 <480272f8fb3e46d24a0ee1418fb85809@kernel.org>
 <CA+CK2bDc+9EsH_TLTgg9Pqv_-rZfZfPohdZEfsYjT8ss+8skjg@mail.gmail.com>
 <87v98wom5n.wl-maz@kernel.org>
 <CA+CK2bB9M05UKfvu66_wMK1u_HBvRws4R0KxPgTu4vPdKuGy9w@mail.gmail.com>
 <CA+CK2bADNkoX-Q3tNyjJ7fo6-f4sBPkAVYLiQh-rxFOcHzbJGw@mail.gmail.com>
In-Reply-To: <CA+CK2bADNkoX-Q3tNyjJ7fo6-f4sBPkAVYLiQh-rxFOcHzbJGw@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 26 Apr 2021 14:11:37 -0400
Message-ID: <CA+CK2bDcZiWhQ+xALnQm43zGpv+BE9wkHejMS81v=wk3iJPttA@mail.gmail.com>
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

> > > Please give people a chance to review this lot first. This isn't code
> > > that is easy to digest, and immediate re-spinning does more harm than
> > > good (this isn't targeting 5.13, I would assume).

Sorry for top posting, the previous e-mail intended as a reply to the above.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
