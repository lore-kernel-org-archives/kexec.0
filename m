Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVnAU-00CuAb-BY
 for kexec@lists.infradead.org; Thu, 30 Sep 2021 03:55:35 +0000
Received: by mail-lf1-x12a.google.com with SMTP id i25so19509379lfg.6
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 20:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-9-pasha.tatashin@soleen.com>
 <20210929123513.GC21631@willie-the-truck>
In-Reply-To: <20210929123513.GC21631@willie-the-truck>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Sep 2021 23:54:55 -0400
Message-ID: <CA+CK2bDw3A7FkZoQbB-AQWHj89Azqjrm12WFQVcfQjS+2Tmgyg@mail.gmail.com>
Subject: Re: [PATCH v17 08/15] arm64: kexec: configure EL2 vectors for kexec
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

> > +/* Allocates pages for kexec page table */
> > +static void *kexec_page_alloc(void *arg)
> > +{
> > +     struct kimage *kimage = (struct kimage *)arg;
> > +     struct page *page = kimage_alloc_control_pages(kimage, 0);
> > +
> > +     if (!page)
> > +             return NULL;
> > +
> > +     memset(page_address(page), 0, PAGE_SIZE);
>
> Hmm, I think we might be missing barriers here to ensure that the zeroes
> are visible to the page-table walker before we plumb the page into the
> page-table.
>
> Usually, that's taken care of by the smp_wmb() in __pXX_alloc() but I
> can't see that here. Is it hiding?

Based on the comment in __pte_alloc() that smp_wmb() is needed in
order to synchronize pte setup with other cpus prior to making it
visible to them. This is not needed here. First, by the time these
page tables are used the other cpus are offlined (kexec reboot code is
single threaded). Second, we never insert any entry into a page table
that is actively used by any cpu.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
