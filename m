Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVnDR-00Cuf2-Tb
 for kexec@lists.infradead.org; Thu, 30 Sep 2021 03:58:39 +0000
Received: by mail-lf1-x134.google.com with SMTP id b15so19393457lfe.7
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 20:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-11-pasha.tatashin@soleen.com>
 <20210929124513.GD21631@willie-the-truck>
In-Reply-To: <20210929124513.GD21631@willie-the-truck>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Sep 2021 23:57:59 -0400
Message-ID: <CA+CK2bBY-9JAtb1Rs4OJ2mmCtqMEsJ0rJs4a5EXnmj8AejvFYQ@mail.gmail.com>
Subject: Re: [PATCH v17 10/15] arm64: kexec: use ld script for relocation
 function
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
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com

On Wed, Sep 29, 2021 at 8:45 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 07:13:20PM -0400, Pasha Tatashin wrote:
> > Currently, relocation code declares start and end variables
> > which are used to compute its size.
> >
> > The better way to do this is to use ld script incited, and put relocation
> > function in its own section.
>
> "incited"? I don't understand ...

I will correct it:
s/incited//


> > +#ifdef CONFIG_KEXEC_CORE
> > +/* kexec relocation code should fit into one KEXEC_CONTROL_PAGE_SIZE */
> > +ASSERT(__relocate_new_kernel_end - (__relocate_new_kernel_start & ~(SZ_4K - 1))
> > +     <= SZ_4K, "kexec relocation code is too big or misaligned")
> > +ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is brokern")
>
> Typo: "brokern",

Will correct it.

Thanks,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
