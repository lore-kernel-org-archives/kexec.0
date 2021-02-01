Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v11 0/6] arm64: MMU enabled kexec relocation
References: <20210127172706.617195-1-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <a8a72826-0a27-de9b-bfb7-be8286cd61fe@arm.com>
Date: Mon, 1 Feb 2021 18:32:52 +0000
MIME-Version: 1.0
In-Reply-To: <20210127172706.617195-1-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, selindag@gmail.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, tyhicks@linux.microsoft.com, rfontana@redhat.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 27/01/2021 17:27, Pavel Tatashin wrote:
> Enable MMU during kexec relocation in order to improve reboot performance.
> 
> If kexec functionality is used for a fast system update, with a minimal
> downtime, the relocation of kernel + initramfs takes a significant portion
> of reboot.
> 
> The reason for slow relocation is because it is done without MMU, and thus
> not benefiting from D-Cache.
> 
> Performance data
> ----------------
> For this experiment, the size of kernel plus initramfs is small, only 25M.
> If initramfs was larger, than the improvements would be greater, as time
> spent in relocation is proportional to the size of relocation.
> 
> Previously:
> kernel shutdown	0.022131328s
> relocation	0.440510736s
> kernel startup	0.294706768s
> 
> Relocation was taking: 58.2% of reboot time
> 
> Now:
> kernel shutdown	0.032066576s
> relocation	0.022158152s
> kernel startup	0.296055880s
> 
> Now: Relocation takes 6.3% of reboot time
> 
> Total reboot is x2.16 times faster.
> 
> With bigger userland (fitImage 380M), the reboot time is improved by 3.57s,
> and is reduced from 3.9s down to 0.33s

> Previous approaches and discussions
> -----------------------------------

The problem I see with this is rewriting the relocation code. It needs to work whether the
machine has enough memory to enable the MMU during kexec, or not.

In off-list mail to Pavel I proposed an alternative implementation here:
https://gitlab.arm.com/linux-arm/linux-jm/-/tree/kexec+mmu/v0

By using a copy of the linear map, and passing the phys_to_virt offset into
arm64_relocate_new_kernel() its possible to use the same code when we fail to allocate the
page tables, and run with the MMU off as it does today.
I'm convinced someone will crawl out of the woodwork screaming 'regression' if we
substantially increase the amount of memory needed to kexec at all.

From that discussion: this didn't meet Pavel's timing needs.
If you depend on having all the src/dst pages lined up in a single line, it sounds like
you've over-tuned this to depend on the CPU's streaming mode. What causes the CPU to
start/stop that stuff is very implementation specific (and firmware configurable).
I don't think we should let this rule out systems that can kexec today, but don't have
enough extra memory for the page tables.
Having two copies of the relocation code is obviously a bad idea.


(as before: ) Instead of trying to make the relocations run quickly, can we reduce them?
This would benefit other architectures too.

Can the kexec core code allocate higher order pages, instead of doing everything page at
at time?

If you have a crash kernel reservation, can we use that to eliminate the relocations
completely?
(I think this suggestion has been lost in translation each time I make it.
I mean like this:
https://gitlab.arm.com/linux-arm/linux-jm/-/tree/kexec/kexec_in_crashk/v0
Runes to test it:
| sudo ./kexec -p -u
| sudo cat /proc/iomem | grep Crash
|  b0200000-f01fffff : Crash kernel
| sudo ./kexec --mem-min=0xb0200000 --mem-max=0xf01ffffff -l ~/Image --reuse-cmdline

I bet its even faster!)


I think 'as fast as possible' and 'memory constrained' are mutually exclusive
requirements. We need to make the page tables optional with a single implementation.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
