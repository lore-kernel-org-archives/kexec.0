Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
 <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
 <CACi5LpOa-BMRSTShS019DDv7MoxNfpnnsqjwR3z13GZC49NrSA@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <9c4d7c8d-3f0b-ff2f-68e8-03638a5fe2a4@arm.com>
Date: Mon, 23 Jul 2018 18:05:47 +0100
MIME-Version: 1.0
In-Reply-To: <CACi5LpOa-BMRSTShS019DDv7MoxNfpnnsqjwR3z13GZC49NrSA@mail.gmail.com>
Content-Language: en-US
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Bhupesh,

(CC: +mips list, looks like mips is missing vmcore's KERNELOFFSET too.
Start of this thread: https://lkml.org/lkml/2018/7/18/951 )

On 19/07/18 15:55, Bhupesh Sharma wrote:
> On Thu, Jul 19, 2018 at 5:01 PM, James Morse <james.morse@arm.com> wrote:
>> On 18/07/18 22:37, Bhupesh Sharma wrote:
>>> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
>>>
>>> makedumpfile user-space utility will need fixup to use this KASLR offset
>>> to work with cases where we need to find a way to translate symbol
>>> address from vmlinux to kernel run time address in case of KASLR boot on
>>> arm64.
>>
>> You need the kernel VA for a symbol. Isn't this what kallsyms is for?
>> | root@frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
>> | ffff5404610d0000 B swapper_pg_dir

> Its already used by other archs like x86_64.
> Its just that we are enabling this feature for arm64 now that the
> KASLR boot cases are more widely seen on arm64 boards (as newer EFI
> firmware implementations are available which support EFI_RNG_PROTOCOL
> and hence KASLR boot).
> 
> And we want existing user-space application(s) to work similarly on
> arm64 distributions as they work historically on other archs like
> x86_64 (in most cases the user-space user is not even aware, if he is
> developing for or using an underlying hardware which is arm64 or
> x86_64)

Aha, so its ABI. This is the information that should be in the commit message as
it describes why this patch should be merged.

... Ideally core code would do this, that way this information won't be missed
when an architecture adds KASLR support.

But mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
and x86 always provides this value, not just if CONFIG_RANDOMIZE_BASE is
selected. I can't see a way to do this without touching all three architectures.
(we can try and tidy it up once its clear whether mips needs this too)


I think the patch is fine, but could you re-post it with a commit message that
describes that vmcore parsing in user-space already expects this value in the
notes. We're providing it for portability of those existing tools with x86.


>> I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
>> to work out this offset. (you should expect the kernel to rename these symbols
>> at a whim).
>>
> 
> Perhaps you missed what the above makedumpfile command was doing, so
> let me summarize again:

Yes, I glossed over it, all that seemed relevant is you are trying to find the
kernel-va of a symbol from the value in the vmlinux.


> as it breaks the
> existing user-space use-cases and the .conf file can be user-defined
> (and hence he can pick any symbol/functions

My suggestion was you can calculate the offset between the link-time and
run-time address from information you already have. You just need one of each.
This would be better as its independent of how the kernel does the relocation.

But, this is irrelevant as 'KERNELOFFSET=' is already an ABI string.


> which might not even be present in 'kallsyms').

Eh? How can that happen? I thought even modules had their symbols added to kallsyms.



Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
