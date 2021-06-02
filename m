Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loFXj-001SXu-0f
 for kexec@lists.infradead.org; Wed, 02 Jun 2021 01:19:36 +0000
Received: by mail-ed1-x531.google.com with SMTP id y7so887588eda.2
 for <kexec@lists.infradead.org>; Tue, 01 Jun 2021 18:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
 <20210527150526.271941-4-pasha.tatashin@soleen.com>
 <87sg28rx3c.wl-maz@kernel.org>
 <CA+CK2bDvsFX_s-G5tRcE1GreNW_xLTognosUFbPPgaUK7-cafQ@mail.gmail.com>
 <87r1hl22qm.wl-maz@kernel.org>
In-Reply-To: <87r1hl22qm.wl-maz@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 1 Jun 2021 21:18:54 -0400
Message-ID: <CA+CK2bBwd2+QB6qCWYQdC5x_Vkf7-64pr8UWJFoUkQgtfaAsHQ@mail.gmail.com>
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

> > It cannot call mutate_to_vhe because #HVC_VHE_RESTART is not used
> > here. But, if it had to it would not work as we cannot return to the
> > old kernel text after relocation.
>
> OK, so you are happy with having a dangling branch pointing to
> nowhere? Something in me screams that it isn't a good idea, in
> general.
>
> If HVC_SOFT_RESTART is all you need, I'd rather you have a small stub
> that implements exactly that and nothing else. Feel free to extract it
> as a reusable macro if you want.

Sure, I will add in the next revision.

Thanks,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
