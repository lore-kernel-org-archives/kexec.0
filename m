Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iamWZ-0003eu-23
 for kexec@lists.infradead.org; Fri, 29 Nov 2019 20:06:00 +0000
Received: by mail-lf1-f69.google.com with SMTP id i29so4436529lfc.18
 for <kexec@lists.infradead.org>; Fri, 29 Nov 2019 12:05:50 -0800 (PST)
MIME-Version: 1.0
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
 <20191129102421.GA28322@willie-the-truck>
In-Reply-To: <20191129102421.GA28322@willie-the-truck>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Sat, 30 Nov 2019 01:35:36 +0530
Message-ID: <CACi5LpNQPw41kGsW+d0PyZaC7gSrbgwT2VxwyO5r3j83h-mkEQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Boris Petkov <bp@alien8.de>, Dave Anderson <anderson@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Steve Capper <steve.capper@arm.com>

Hi Will,

On Fri, Nov 29, 2019 at 3:54 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Nov 29, 2019 at 01:53:36AM +0530, Bhupesh Sharma wrote:
> > Changes since v4:
> > ----------------
> > - v4 can be seen here:
> >   http://lists.infradead.org/pipermail/kexec/2019-November/023961.html
> > - Addressed comments from Dave and added patches for documenting
> >   new variables appended to vmcoreinfo documentation.
> > - Added testing report shared by Akashi for PATCH 2/5.
>
> Please can you fix your mail setup? The last two times you've sent this
> series it seems to get split into two threads, which is really hard to
> track in my inbox:
>
> First thread:
>
> https://lore.kernel.org/lkml/1574972621-25750-1-git-send-email-bhsharma@redhat.com/
>
> Second thread:
>
> https://lore.kernel.org/lkml/1574972716-25858-1-git-send-email-bhsharma@redhat.com/

There seems to be some issue with my server's msmtp settings. I have
tried resending the v5 (see
<http://lists.infradead.org/pipermail/linux-arm-kernel/2019-November/696833.html>).

I hope the threading is ok this time.

Thanks for your patience.

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
