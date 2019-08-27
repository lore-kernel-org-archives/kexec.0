Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v1 0/6] Allow kexec reboot for GICv3 and device tree
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
 <20190826201313.246208e9@why>
 <CA+CK2bAS-jDwY-qKfZQD8TbvyAhS1+rBvcxGqkR4BHd5NR5BGQ@mail.gmail.com>
From: Marc Zyngier <maz@kernel.org>
Message-ID: <d7461fb3-0f6d-8abf-084d-ce0be1f1a18d@kernel.org>
Date: Tue, 27 Aug 2019 09:15:43 +0100
MIME-Version: 1.0
In-Reply-To: <CA+CK2bAS-jDwY-qKfZQD8TbvyAhS1+rBvcxGqkR4BHd5NR5BGQ@mail.gmail.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 26/08/2019 22:25, Pavel Tatashin wrote:
> On Mon, Aug 26, 2019 at 3:13 PM Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Mon, 26 Aug 2019 15:00:50 -0400
>> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>>
>>> Marc Zyngier added the support for kexec and GICv3 for EFI based systems.
>>> However, it is still not possible todo on systems with device trees.
>>>
>>> Here is EFI fixes from Marc:
>>> https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com
>>>
>>> For Device Tree variant: lets allow reserve a memory region in interrupt
>>> controller node, and use this property to allocate interrupt tables.
>>
>> There is no such thing as a "device tree variant". As long as your
>> bootloader implements EFI, everything will work correctly, whether
>> you're using DT, ACPI, or the anything else.
>>
>> This already works today, without any need to add anything to the
>> kernel (I have systems using EDK II and u-boot, both implementing EFI,
>> and I'm able to kexec without any issue). If your bootloader doesn't
>> support EFI, here's a good opportunity to implement it!
> 
> Hi Marc,
> 
> Thank you very much for looking at this work.
> 
> Running Linux without EFI is common, and there are scenarios which
> make it appropriate. As I understand most of embedded linux do not
> have EFI enabled, and thus I do not see a reason why we would not
> support a first class feature of Linux (kexec) on non-EFI bootloaders.

Define "most". All the arm64 systems I have around (and trust me, that's
quite a number of them) can either use u-boot, which has more than
enough EFI support to use this functionality, or use EDK-II natively.

> We (Microsoft) have a small highly secure device with a high uptime
> requirement. The device also has PCIe and thus GICv3. The update for

PCIe doesn't imply GICv3 at all.

> this device relies on kexec. For a number of reasons, it was decided
> to use U-Boot and Linux without EFI enabled. One of those reasons is
> to improve boot performance, enabling EFI in U-Boot alone reduces the
> boot performance by half a second. Our total reboot budget is under a
> second which makes that half a second unacceptable. Also, adding EFI
> support to kernel increases its size and there are security
> implications from enabling more code both in U-Boot and Linux.

You're are missing the point. kexec with EFI has 0 overhead (no
non-kernel EFI code gets executed), doesn't impact your time budget, and
only relies on a single in-memory table. This can be pretty trivially
provided by the dumbest EFI shim.

All you are describing above is a set of self imposed limitations in
your bootloader, which you are fully in control of. So instead of
reinventing a square wheel, I suggest you adopt the existing implementation.

Another reason not to do this is interoperability: I want to be able to
kexec whatever Linux kernel I want, without having to cope with all
flavours of the same functionality. Effectively, the EFI table is a
private ABI between two Linux kernels. We're not changing it.

	M.
-- 
Jazz is not dead, it just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
