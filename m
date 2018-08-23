Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v4 1/5] arm64: export memblock_reserve()d regions via
 /proc/iomem
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
 <20180723015732.24252-2-takahiro.akashi@linaro.org>
 <CALAqxLU3+tu09M5=D-6xCqweKenfXtZuBGy6tqEP2DoGAs-LNA@mail.gmail.com>
 <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
 <CALAqxLX=BBcjR3kbK8nhddzdtv7tMiDs2OcvMA-e9QNw6Lv3hg@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <dc5a9115-7536-6d72-18fd-60b5322c870c@arm.com>
Date: Thu, 23 Aug 2018 13:35:08 +0100
MIME-Version: 1.0
In-Reply-To: <CALAqxLX=BBcjR3kbK8nhddzdtv7tMiDs2OcvMA-e9QNw6Lv3hg@mail.gmail.com>
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
To: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, al.stone@linaro.org, G Gregory <graeme.gregory@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, bhsharma@redhat.com, tbaicar@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, hanjun.guo@linaro.org, Catalin Marinas <catalin.marinas@arm.com>, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>

Hi John,

On 21/08/18 20:38, John Stultz wrote:
> On Tue, Aug 21, 2018 at 3:22 AM, James Morse <james.morse@arm.com> wrote:
>> On 08/21/2018 05:39 AM, John Stultz wrote:
>>>
>>> Since this patch landed, on the HiKey board at bootup I'm seeing:
>>>
>>> [    0.451884] WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/setup.c:271
>>> reserve_memblock_reserved_regions+0xd4/0x13c
> ...
>>>  From skimming the patch, it seems this is maybe expected? Or should
>>> this warning raise eyebrows? I can't quite figure it out.
>>

>>> /proc/iomem now has:
>>> ...
>>> 07410000-21efffff : System RAM
>>>    11000000-1113cfff : reserved
>>
>>
>>> 21f00000-21ffffff : reserved
>>
>>
>> ^ This entry is what triggered the warning.
>>
>> It expects that meblock_reserved() memory is also described as memory.
>> (memblock keeps them as separate lists, so its possible to reserve
>> memory that doesn't exist... which it looks like your system is doing)
> 
> So yea, I suspect the hikey dts isn't quite right here then.

The DT mem-reserve code goes and memblock_removes() some regions, instead of
marking them nomap.

Given memblock has a for_each_resv_unavail_range() that explicitly walks
reserved && !memory, it looks like this is expected, and its just me thinking
this is strange.

I will come up with a version of this patch that walks the 'System RAM'
resources that were created during boot, and adds the memblock_reserved()
regions to them, which should stop this happening.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
