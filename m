Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aM821-0007fP-K1
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 05:43:43 +0000
Received: by mail-pf0-x22c.google.com with SMTP id q63so17983343pfb.1
 for <kexec@lists.infradead.org>; Wed, 20 Jan 2016 21:43:21 -0800 (PST)
Subject: Re: [PATCH 18/19] arm64: kdump: update a kernel doc
References: <20160115201601.GR3262@leverpostej> <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej> <569F1A33.4000208@linaro.org>
 <20160120120257.GD25829@leverpostej> <20160120123620.GE25829@leverpostej>
 <CAKv+Gu9pVAWWRyM+oTpzGUCdeuMXkdnz5cAJnZk3jfE9uKVREw@mail.gmail.com>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <56A06FF3.8050706@linaro.org>
Date: Thu, 21 Jan 2016 14:43:15 +0900
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9pVAWWRyM+oTpzGUCdeuMXkdnz5cAJnZk3jfE9uKVREw@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Christoffer Dall <christoffer.dall@linaro.org>

On 01/20/2016 11:59 PM, Ard Biesheuvel wrote:
> On 20 January 2016 at 13:36, Mark Rutland <mark.rutland@arm.com> wrote:
>> Ard, Ganapatrao, the below is something we need to consider for the
>> combination of the NUMA & kexec approaches. It only becomes a problem
>> if/when we preserve DT memory nodes in the presence of EFI, though it
>> would be nice to not box ourselves into a corner.
>>
>> On Wed, Jan 20, 2016 at 12:02:58PM +0000, Mark Rutland wrote:
>>> On Wed, Jan 20, 2016 at 02:25:07PM +0900, AKASHI Takahiro wrote:
>>>> On 01/19/2016 11:01 PM, Mark Rutland wrote:
>>>>> For NUMA topology in !ACPI kernels, we might need to also retain and
>>>>> parse memory nodes, but only for toplogy information. The kernel would
>>>>> still only use memory as described by the EFI memory map.
>>>>>
>>>>> There's a horrible edge case I've spotted if performing a chain of
>>>>> cross-endian kexecs: LE -> BE -> LE, as the BE kernel would have to
>>>>> respect the EFI memory map so as to avoid corrupting it for the
>>>>> subsequent LE kernel. Other than this I believe everything should just
>>>>> work.
>>>>
>>>> BE kernel doesn't support UEFI yet and cannot access UEFI memmap table. So,
>>>> for LE -> BE, we don't use a dtb generated from /sys/firmware/fdt (or /proc/device-tree)
>>>> (as in the case of LE -> LE) and require users to provide a dtb file explicitly.
>>>
>>> As I mentioned above, the problem exists when memory nodes also exist
>>> (for describing NUMA topology). In that case the BE kernel would try to
>>> use the information from the memory nodes.
>>>
>>>> For BE -> LE, BE kernel doesn't know wther UEFI memmap table is available or not
>>>> and so use the same (explicitly-provided) dtb (as LE -> LE in !UEFI)
>>>
>>> See above. The problem I imagine is:
>>>
>>> LE kernel - uses EFI mmap, takes NUMA information from DT memory nodes
>>>
>>>      v       kexec
>>>
>>> BE kernel - uses DT memory nodes
>>>            - clobbers EFI runtime regions as it sees them as available
>>>
>>>      v       kexec
>>>
>>> LE kernel - uses EFI mmap, takes NUMA information from DT memory nodes
>>>            - tries to call EFI runtime services, and explodes.
>>
>> I'm not really sure what the best approach is here, but I thought that
>> it would be good to raise awareness of the edge-case.
>>
>
> I think we should simply allow the BE kernel to deal with a UEFI
> memory map. It only involves a bit of byte swapping (which I already
> implemented at some point)

Just from my curiosity,
will runtime services be also available on BE kernel with LE uefi?

-Takahiro AKASHI

> It would require some minor refactoring to make the UEFI init code
> separate from all the other bits, but I don't see any major issues
> here
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
