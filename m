Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
 <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
 <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
 <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
 <CA+CK2bBVcE91YbJx1f_BkNqbD03wGLNtyane7PjCnEu8i_cH2Q@mail.gmail.com>
From: prsriva <prsriva@linux.microsoft.com>
Message-ID: <11036cd6-2977-5f78-7fe7-1085ba31f005@linux.microsoft.com>
Date: Mon, 21 Oct 2019 10:38:44 -0700
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBVcE91YbJx1f_BkNqbD03wGLNtyane7PjCnEu8i_cH2Q@mail.gmail.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pavel Tatashin <pasha.tatashin@soleen.com>, James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, jean-philippe@linaro.org, arnd@arndb.de, Ard Biesheuvel <ard.biesheuvel@linaro.org>, sboyd@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, takahiro.akashi@linaro.org, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, zohar@linux.ibm.com, Masahiro Yamada <yamada.masahiro@socionext.com>, duwe@lst.de, allison@lohutok.net, linux-integrity@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, bauerman@linux.ibm.com, Linux ARM <linux-arm-kernel@lists.infradead.org>


On 10/15/19 11:47 AM, Pavel Tatashin wrote:
>> I think the UEFI persistent-memory-reservations thing is a better fit for this [0][1].
> 
> Hi James,
> 
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
> 
> Is there a way to name memory with the current ABI that you think is acceptable?
> 
> Thank you,
> Pasha
> 
Friendly ping.

Thanks,
Prakhar Srivastava


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
