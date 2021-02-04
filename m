Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20210127172706.617195-1-pasha.tatashin@soleen.com>
 <a8a72826-0a27-de9b-bfb7-be8286cd61fe@arm.com>
 <CA+CK2bBSJaL9Hn_LBy78ccaCt7=r9cSaEqUVemRVmKg6cwpLnQ@mail.gmail.com>
Date: Wed, 03 Feb 2021 19:11:10 -0600
In-Reply-To: <CA+CK2bBSJaL9Hn_LBy78ccaCt7=r9cSaEqUVemRVmKg6cwpLnQ@mail.gmail.com>
 (Pavel Tatashin's message of "Mon, 1 Feb 2021 14:59:32 -0500")
Message-ID: <871rdwocwh.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Selin Dag <selindag@gmail.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Tyler Hicks <tyhicks@linux.microsoft.com>, James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, rfontana@redhat.com, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Pavel Tatashin <pasha.tatashin@soleen.com> writes:

> Hi James,
>
>> The problem I see with this is rewriting the relocation code. It needs to work whether the
>> machine has enough memory to enable the MMU during kexec, or not.
>>
>> In off-list mail to Pavel I proposed an alternative implementation here:
>> https://gitlab.arm.com/linux-arm/linux-jm/-/tree/kexec+mmu/v0
>>
>> By using a copy of the linear map, and passing the phys_to_virt offset into
>> arm64_relocate_new_kernel() its possible to use the same code when we fail to allocate the
>> page tables, and run with the MMU off as it does today.
>> I'm convinced someone will crawl out of the woodwork screaming 'regression' if we
>> substantially increase the amount of memory needed to kexec at all.
>>
>> From that discussion: this didn't meet Pavel's timing needs.
>> If you depend on having all the src/dst pages lined up in a single line, it sounds like
>> you've over-tuned this to depend on the CPU's streaming mode. What causes the CPU to
>> start/stop that stuff is very implementation specific (and firmware configurable).
>> I don't think we should let this rule out systems that can kexec today, but don't have
>> enough extra memory for the page tables.
>> Having two copies of the relocation code is obviously a bad idea.
>
> I understand that having an extra set of page tables could potentially
> waste memory, especially if VAs are sparse, but in this case we use
> page tables exclusively for contiguous VA space (copy [src, src +
> size]). Therefore, the extra memory usage is tiny. The ratio for
> kernels with  4K page_size is (size of relocated memory) / 512.  A
> normal initrd + kernel is usually under 64M, an extra space which
> means ~128K for the page table. Even with a huge relocation, where
> initrd is ~512M the extra memory usage in the worst case is just ~1M.
> I really doubt we will have any problem from users because of such
> small overhead in comparison to the total kexec-load size.

Foolish question.

Does arm64 have something like 2M pages that it can use for the
linear map?

On x86_64 we always generate page tables, because they are necessary to
be in 64bit mode.  As I recall on x86_64 we always use 2M pages which
means for each 4K of page tables we map 1GiB of memory.   Which is very
tiny.

If you do as well as x86_64 for arm64 I suspect that will be good enough
for people to not claim regression.

Would a variation on the x86_64 implementation that allocates page
tables work for arm64?

>> (as before: ) Instead of trying to make the relocations run quickly, can we reduce them?
>> This would benefit other architectures too.
>
> This was exactly my first approach [1] where I tried to pre-reserve
> memory similar to how it is done for a crash kernel, but I was asked
> to go away [2] as this is an ARM64 specific problem, where current
> relocation performance is prohibitively slow. I have tested on x86,
> and it does not suffer from this problem, relocation performance is
> just as fast as with MMU enabled ARM64.
>
>>
>> Can the kexec core code allocate higher order pages, instead of doing everything page at
>> at time?
>
> Yes, however, failures during kexec-load due to failure to coalesce
> huge pages can add extra hassle to users, and therefore this should be
> only an optimization with fallback to base pages.
>
>>
>> If you have a crash kernel reservation, can we use that to eliminate the relocations
>> completely?
>> (I think this suggestion has been lost in translation each time I make it.
>> I mean like this:
>> https://gitlab.arm.com/linux-arm/linux-jm/-/tree/kexec/kexec_in_crashk/v0
>> Runes to test it:
>> | sudo ./kexec -p -u
>> | sudo cat /proc/iomem | grep Crash
>> |  b0200000-f01fffff : Crash kernel
>> | sudo ./kexec --mem-min=0xb0200000 --mem-max=0xf01ffffff -l ~/Image --reuse-cmdline
>>
>> I bet its even faster!)
>
> There is a problem with this approach. While, with kexec_load() call
> it is possible to specify physical destinations for each segment, with
> kexec_file_load() it is not possible. The secure systems that do IMA
> checks during kexec load require kexec_file_load(), and we cannot
> ahead of time specify destinations for these segments (at least
> without substantially changing common kexec code which is not going to
> happen as this arm64 specific problem).


>> I think 'as fast as possible' and 'memory constrained' are mutually exclusive
>> requirements. We need to make the page tables optional with a single implementation.

In my experience the slowdown with disabling a cpus cache (which
apparently happens on arm64 when the MMU is disabled) is freakishly
huge.

Enabling the cache shouldn't be 'as fast as possible' but simply
disengaging the parking brake.

> In my opinion having two different types of relocations will only add
> extra corner cases, confusion about different performance, and bugs.
> It is better to have two types: 1. crash kernel type without
> relocation, 2. fast relocation where MMU is enabled.
>
> [1] https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
> [2] https://lore.kernel.org/lkml/20190710065953.GA4744@localhost.localdomain/

As long as the page table provided is a linear mapping of physical
memory (aka it looks like paging is disabled).  The the code that
relocates memory should be pretty much the same.

My experience with other architectures suggests only a couple of
instructions need to be different to deal with a MMU being enabled.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
