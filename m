Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
 <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
 <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
 <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
 <CA+CK2bBVcE91YbJx1f_BkNqbD03wGLNtyane7PjCnEu8i_cH2Q@mail.gmail.com>
Message-ID: <b53ba912-6fec-211d-9494-bc6ae6fa3f31@arm.com>
Date: Fri, 25 Oct 2019 18:08:16 +0100
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBVcE91YbJx1f_BkNqbD03wGLNtyane7PjCnEu8i_cH2Q@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, jean-philippe@linaro.org, arnd@arndb.de, Masahiro Yamada <yamada.masahiro@socionext.com>, sboyd@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, zohar@linux.ibm.com, prsriva <prsriva@linux.microsoft.com>, takahiro.akashi@linaro.org, duwe@lst.de, bauerman@linux.ibm.com, allison@lohutok.net, linux-integrity@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Pavel,

On 15/10/2019 19:47, Pavel Tatashin wrote:
>> I think the UEFI persistent-memory-reservations thing is a better fit for this [0][1].

> Thank you for your thought. As I understand you propose the to use the
> existing method as such:
> 1. Use the existing kexec ABI to pass reservation from kernel to
> kernel using EFI the same as is done for GICv3 tables.
> 2. Allow this memory to be reservable only during first Linux boot via
> EFI memory reserve
> 3. Allow to have this memory pre-reserved by firmware or to be
> embedded into device tree.
> 
> A question I have is how to tell that a reserved region is reserved
> for IMA use. With GICv3 it is done by reading the registers, finding
> the interrupt tables memory, and check that the memory ranges are
> indeed pre-reserved.

Good point, efi_mem_reserve_persistent() has no way of describing what a region is for,
you have to know that from somewhere else.


> Is there a way to name memory with the current ABI that you think is acceptable?

This would need to go in the chosen node of the DT, like power-pc already does. This would
work on arm64:ACPI systems too (because they have a DT chosen node).


I'd like to understand why removing these entries is needed, it doesn't look like we have
an API call to remove them from the efi mem-reserve...

If it had a fixed position in memory its the sort of thing we'd expect firmware to
reserved during boot. (e.g. ramoops).

~

From ima_add_kexec_buffer() this really is a transient memory reservation over kexec.
I think the efi mem-reserve and a DT-chosen node entry with the PA is the only way to make
this work smoothly between DT<->ACPI systems.

We'd need a way of removing the efi mem-reserve in ima_free_kexec_buffer(), otherwise the
memory remains lost. The DT-chosen node entry should have its pointer zero'd out once
we've done this. (like we do for the KASLR seed).


Not considered is parsing the DT-chosen node entry as if it were a memreserve during early
boot. This wouldn't work if you kexec something that doesn't know what the node is, it
would overwrite the the memory and may not remove the node for the next kexec, which does.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
