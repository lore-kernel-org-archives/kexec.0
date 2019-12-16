Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igk9H-0006cZ-49
 for kexec@lists.infradead.org; Mon, 16 Dec 2019 06:46:32 +0000
Received: by mail-lj1-f197.google.com with SMTP id 140so1789374ljj.3
 for <kexec@lists.infradead.org>; Sun, 15 Dec 2019 22:46:26 -0800 (PST)
MIME-Version: 1.0
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
 <20191214122734.GC28635@zn.tnic>
In-Reply-To: <20191214122734.GC28635@zn.tnic>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 16 Dec 2019 12:16:12 +0530
Message-ID: <CACi5LpP2PPcmaQw95V4MUzhvENq9+mB7UR7eib2HADCDHLz4oA@mail.gmail.com>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Dave Anderson <anderson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Will Deacon <will@kernel.org>, x86@kernel.org, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, James Morse <james.morse@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Steve Capper <steve.capper@arm.com>

Hi Boris,

On Sat, Dec 14, 2019 at 5:57 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 29, 2019 at 01:53:36AM +0530, Bhupesh Sharma wrote:
> > Bhupesh Sharma (5):
> >   crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
> >   arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
> >   Documentation/arm64: Fix a simple typo in memory.rst
> >   Documentation/vmcoreinfo: Add documentation for 'MAX_PHYSMEM_BITS'
> >   Documentation/vmcoreinfo: Add documentation for 'TCR_EL1.T1SZ'
>
> why are those last two separate patches and not part of the patches
> which export the respective variable/define?

I remember there was a suggestion during the review of an earlier
version to keep them as a separate patch(es) so that the documentation
text is easier to review, but I have no strong preference towards the
same.

I can merge the documentation patches with the respective patches
(which export the variables/defines to vmcoreinfo) in v6, unless other
maintainers have an objections towards the same.

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
