Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7gTv-0001gL-61
 for kexec@lists.infradead.org; Thu, 04 Feb 2021 15:23:49 +0000
Received: by mail-ed1-x531.google.com with SMTP id s11so4620288edd.5
 for <kexec@lists.infradead.org>; Thu, 04 Feb 2021 07:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20210127172706.617195-1-pasha.tatashin@soleen.com>
 <a8a72826-0a27-de9b-bfb7-be8286cd61fe@arm.com>
 <CA+CK2bBSJaL9Hn_LBy78ccaCt7=r9cSaEqUVemRVmKg6cwpLnQ@mail.gmail.com>
 <871rdwocwh.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rdwocwh.fsf@x220.int.ebiederm.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 4 Feb 2021 10:23:03 -0500
Message-ID: <CA+CK2bD9NQ=waaoi4=Ub9o9uKWaAs_ZO8LEwxB2XFhacRhnbOQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] arm64: MMU enabled kexec relocation
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Selin Dag <selindag@gmail.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Tyler Hicks <tyhicks@linux.microsoft.com>, James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, rfontana@redhat.com, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

> > I understand that having an extra set of page tables could potentially
> > waste memory, especially if VAs are sparse, but in this case we use
> > page tables exclusively for contiguous VA space (copy [src, src +
> > size]). Therefore, the extra memory usage is tiny. The ratio for
> > kernels with  4K page_size is (size of relocated memory) / 512.  A
> > normal initrd + kernel is usually under 64M, an extra space which
> > means ~128K for the page table. Even with a huge relocation, where
> > initrd is ~512M the extra memory usage in the worst case is just ~1M.
> > I really doubt we will have any problem from users because of such
> > small overhead in comparison to the total kexec-load size.

Hi Eric,

>
> Foolish question.

Thank you for your e-mail, you gave some interesting insights.

>
> Does arm64 have something like 2M pages that it can use for the
> linear map?

Yes, with 4K pages arm64 as well has 2M pages, but arm64 also has a
choice of 16K and 64K and second level pages are bigger there.

> On x86_64 we always generate page tables, because they are necessary to
> be in 64bit mode.  As I recall on x86_64 we always use 2M pages which
> means for each 4K of page tables we map 1GiB of memory.   Which is very
> tiny.
>
> If you do as well as x86_64 for arm64 I suspect that will be good enough
> for people to not claim regression.
>
> Would a variation on the x86_64 implementation that allocates page
> tables work for arm64?
...
>
> As long as the page table provided is a linear mapping of physical
> memory (aka it looks like paging is disabled).  The the code that
> relocates memory should be pretty much the same.
>
> My experience with other architectures suggests only a couple of
> instructions need to be different to deal with a MMU being enabled.

I think what you are proposing is similar to what James proposed. Yes,
for a linear map relocation should be pretty much the same as we do
relocation as with MMU disabled.

Linear map still uses memory, because page tables must be outside of
destination addresses of segments of the next kernel. Therefore, we
must allocate a page table for the linear map. It might be a little
smaller, but in reality the difference is small with 4K pages, and
insignificant with 64K pages. The benefit of my approach is that the
assembly copy loop is simpler, and allows hardware prefetching to
work.

The regular relocation loop works like this:

for (entry = head; !(entry & IND_DONE); entry = *ptr++) {
        addr = __va(entry & PAGE_MASK);

        switch (entry & IND_FLAGS) {
        case IND_DESTINATION:
                dest = addr;
                break;
        case IND_INDIRECTION:
                ptr = addr;
                break;
        case IND_SOURCE:
                copy_page(dest, addr);
                dest += PAGE_SIZE;
        }
}

The entry for the next relocation page has to be always fetched, and
therefore prefetching cannot help with the actual loop.

In comparison, the loop that I am proposing is like this:

for (addr = head; addr < end; addr += PAGE_SIZE, dst += PAGE_SIZE)
        copy_page(dest, addr);

Here is assembly code for my loop:

1: copy_page x1, x2, x3, x4, x5, x6, x7, x8, x9, x10
    sub x11, x11, #PAGE_SIZE
    cbnz x11, 1b

That said, if James and you agree that linear map is the way to go
forward, I am OK with that as well, as it is still much better than
having no caching at all.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
