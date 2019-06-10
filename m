Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1haHvD-0001YW-Q8
 for kexec@lists.infradead.org; Mon, 10 Jun 2019 10:53:12 +0000
Received: by mail-pg1-f195.google.com with SMTP id n2so4834277pgp.11
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2019 03:53:03 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
 <58c6cda9-9fd4-3b3e-740a-7b9b80b1f634@redhat.com>
 <a48bb02c-8f93-4e3b-085d-a6f0e5a1f3a0@arm.com>
 <66da4098-b221-408b-50ca-f3790b943965@redhat.com>
 <380b137b-a611-5c8d-3890-8021084f87fe@redhat.com>
 <2a4af3a0-1342-fdd2-1cfd-e37abb99d8bd@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <3ab2ca1a-95de-cecf-f590-1e2d00bb644b@redhat.com>
Date: Mon, 10 Jun 2019 16:22:55 +0530
MIME-Version: 1.0
In-Reply-To: <2a4af3a0-1342-fdd2-1cfd-e37abb99d8bd@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Steve Capper <Steve.Capper@arm.com>, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

Hi James,

On 06/07/2019 08:41 PM, James Morse wrote:
> Hi Bhupesh,
> 
> (sorry for the delay on this)

No problem.

> On 04/05/2019 13:53, Bhupesh Sharma wrote:
>> On 04/03/2019 11:24 PM, Bhupesh Sharma wrote:
>>> On 04/02/2019 10:56 PM, James Morse wrote:
>>>> Yes the kernel code is going to move around, this is why the information we expose via
>>>> vmcoreinfo needs to be thought through: something we would always need, regardless of how
>>>> the kernel implements it.
>>>>
> 
>>>> Pointer-auth changes all this again, as we may prefer to use the bits for pointer-auth in
>>>> one TTB or the other. PTRS_PER_PGD may show the 52bit value in this case, but neither TTBR
>>>> is mapping 52bits of VA.
>>>>
>>>>
>>>>> So far, I have generally come across discussions where the following variations of the
>>>>> address spaces have been proposed/requested:
>>>>> - 48bit kernel VA + 48-bit User VA,
>>>>> - 48-bit kernel VA + 52-bit User VA,
>>>>
>>>> + 52bit kernel, because there is excessive quantities of memory, and the kernel maps it
>>>> all, but 48-bit user, because it never maps all the memory, and we prefer the bits for
>>>> pointer-auth.
>>>>
>>>>> - 52-bit kernel VA + 52-bit User VA.
>>>>
>>>> And...  all four may happen with the same built image. I don't see how you can tell these
>>>> cases apart with the one (build-time-constant!) PTRS_PER_PGD value.
>>>>
>>>> I'm sure some of these cases are hypothetical, but by considering it all now, we can avoid
>>>> three more kernel:vmcoreinfo updates, and three more fix-user-space-to-use-the-new-value.
>>>
>>> Agree.
>>>
>>>> I think you probably do need PTRS_PER_PGD, as this is the one value the mm is using to
>>>> generate page tables. I'm pretty sure you also need T0SZ and T1SZ to know if that's
>>>> actually in use, or the kernel is bodging round it with an offset.
>>>
>>> Sure, I am open to suggestions (as I realize that we need an additional VA_BITS_ACTUAL
>>> variable export'ed for 52-bit kernel VA changes).
> 
> (stepping back a bit:)
> 
> I'm against exposing arch-specific #ifdefs that correspond to how we've configured the
> arch code's interactions with mm. These are all moving targets, we can't have any of it
> become ABI.

Sure, I understand your concerns.

> I have a straw-man for this: What is the value of PTE_FILE_MAX_BITS on your system?
> I have no idea what this value is or means, an afternoon's archaeology would be needed(!).
> This is something that made sense for one kernel version, a better idea came along, and it
> was replaced. If we'd exposed this to user-space, we'd have to generate a value, even if
> it doesn't mean anything. Exposing VA_BITS_ACTUAL is the same.
> 
> (Keep an eye out for when we change the kernel memory map, and any second-guessing based
> on VA_BITS turns out to be wrong)
> 
> 
> What we do have are the hardware properties. The kernel can't change these.
> 
> 
>>> Also how do we standardize reading T0SZ and T1SZ in user-space. Do you propose I make an
>>> enhancement in the cpu-feature-registers interface (see [1]) or the HWCAPS interface
>>> (see [2]) for the same?
> 
> cpufeature won't help you if you've already panic()d and only have the vmcore file. This
> stuff needs to go in vmcoreinfo.
> 
> As long as there is a description of how userspace uses these values, I think adding
> key/values for TCR_EL1.TxSZ to the vmcoreinfo is a sensible way out of this. You probably
> need TTBR1_EL1.BADDR too. (it should be specific fields, to prevent 'new uses' becoming ABI)
> 
> This tells you how the hardware was configured, and covers any combination of TxSZ tricks
> we play, and whether those address bits are used for VA, or ptrauth for TTBR0 or TTRB1.

Fair enough. Let me try and experiment with this suggestion a bit and I 
will come back with a RFC patch/patchset by this weekend. Hopefully, it 
will cover all the weird PA/VA bit combinations we are handling in arm64 
distros these days :)

Thanks,
Bhupesh


>> Any comments on the above points? At the moment we have to carry these fixes in the
>> distribution kernels and I would like to have these fixed in upstream kernel itself.
> 
> 
> Thanks,
> 
> James
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
