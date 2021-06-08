Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqfpO-009mqk-4C
 for kexec@lists.infradead.org; Tue, 08 Jun 2021 17:47:54 +0000
Received: by mail-ed1-f49.google.com with SMTP id b11so25541610edy.4
 for <kexec@lists.infradead.org>; Tue, 08 Jun 2021 10:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
 <20210527150526.271941-4-pasha.tatashin@soleen.com>
 <87sg28rx3c.wl-maz@kernel.org>
 <CA+CK2bDvsFX_s-G5tRcE1GreNW_xLTognosUFbPPgaUK7-cafQ@mail.gmail.com>
 <87r1hl22qm.wl-maz@kernel.org>
 <CA+CK2bBwd2+QB6qCWYQdC5x_Vkf7-64pr8UWJFoUkQgtfaAsHQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBwd2+QB6qCWYQdC5x_Vkf7-64pr8UWJFoUkQgtfaAsHQ@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 8 Jun 2021 13:46:10 -0400
Message-ID: <CA+CK2bB6YOmASnDJevgibdu_noDhEuBj1=5qhZ3uCdUjN_qrSg@mail.gmail.com>
Subject: Re: [PATCH 03/18] arm64: hyp-stub: Move elx_sync into the vectors
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
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com

On Tue, Jun 1, 2021 at 9:18 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > > It cannot call mutate_to_vhe because #HVC_VHE_RESTART is not used
> > > here. But, if it had to it would not work as we cannot return to the
> > > old kernel text after relocation.
> >
> > OK, so you are happy with having a dangling branch pointing to
> > nowhere? Something in me screams that it isn't a good idea, in
> > general.
> >
> > If HVC_SOFT_RESTART is all you need, I'd rather you have a small stub
> > that implements exactly that and nothing else. Feel free to extract it
> > as a reusable macro if you want.

Using macro won't help here to save kernel text. Optimally, we would
want to use only one vector table to reduce kernel text memory usage.
I could do that by overwriting sync entries in
trans_pgd_copy_el2_vectors(). But, that would be ugly, as I would need
to have some specific assumptions about what entries need to be
overwritten. Therefore, I decided to move the vector table that we
currently have in hibernate code, and make it common between kexec and
hibernate; trans_pgd_copy_el2_vectors() will use that table's body to
create copies.

Thanks,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
