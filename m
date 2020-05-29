Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v8 5/5] dt-bindings: chosen: Document
 linux,low-memory-range for arm64 kdump
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200521093805.64398-6-chenzhou10@huawei.com>
 <CAL_Jsq+EV02YBqEGoJrsJW8Y+g_GkB_LkTwWCxNCb3F+8MSdyw@mail.gmail.com>
 <a419602e-6a85-ca35-39de-b3c26d433199@huawei.com>
 <20200526211800.GA352001@bogus>
From: James Morse <james.morse@arm.com>
Message-ID: <ff7c9f68-b578-3a1a-0815-e61c6f87bc4e@arm.com>
Date: Fri, 29 May 2020 17:11:07 +0100
MIME-Version: 1.0
In-Reply-To: <20200526211800.GA352001@bogus>
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
To: Rob Herring <robh@kernel.org>, chenzhou <chenzhou10@huawei.com>
Cc: Simon Horman <horms@verge.net.au>, John.p.donnelly@oracle.com, Baoquan He <bhe@redhat.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <guohanjun@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, pkushwaha@marvell.com, dyoung@redhat.com, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>

Hi guys,

On 26/05/2020 22:18, Rob Herring wrote:
> On Fri, May 22, 2020 at 11:24:11AM +0800, chenzhou wrote:
>> On 2020/5/21 21:29, Rob Herring wrote:
>>> On Thu, May 21, 2020 at 3:35 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>>>> Add documentation for DT property used by arm64 kdump:
>>>> linux,low-memory-range.
>>>> "linux,low-memory-range" is an another memory region used for crash
>>>> dump kernel devices.

>>>> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
>>>> index 45e79172a646..bfe6fb6976e6 100644
>>>> --- a/Documentation/devicetree/bindings/chosen.txt
>>>> +++ b/Documentation/devicetree/bindings/chosen.txt

>>>> +linux,low-memory-range
>>>> +----------------------
>>>> +This property (arm64 only) holds a base address and size, describing a
>>>> +limited region below 4G. Similar to "linux,usable-memory-range", it is
>>>> +an another memory range which may be considered available for use by the
>>>> +kernel.

>>> Why can't you just add a range to "linux,usable-memory-range"? It
>>> shouldn't be hard to figure out which part is below 4G.

>> The comments from James:
>> Won't this break if your kdump kernel doesn't know what the extra parameters are?
>> Or if it expects two ranges, but only gets one? These DT properties should be treated as
>> ABI between kernel versions, we can't really change it like this.
>>
>> I think the 'low' region is an optional-extra, that is never mapped by the first kernel. I
>> think the simplest thing to do is to add an 'linux,low-memory-range' that we
>> memblock_add() after memblock_cap_memory_range() has been called.
>> If its missing, or the new kernel doesn't know what its for, everything keeps working.
> 
> 
> I don't think there's a compatibility issue here though. The current 
> kernel doesn't care if the property is longer than 1 base+size. It only 
> checks if the size is less than 1 base+size.

Aha! I missed that.


> And yes, we can rely on 
> that implementation detail. It's only an ABI if an existing user 
> notices.
> 
> Now, if the low memory is listed first, then an older kdump kernel 
> would get a different memory range. If that's a problem, then define 
> that low memory goes last. 

This first entry would need to be the 'crashkernel' range where the kdump kernel is
placed, otherwise an older kernel won't boot. The rest can be optional extras, as long as
we are tolerant of it being missing...

I'll try and look at the rest of this series on Monday,


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
