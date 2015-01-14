Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <54B65B15.7020704@huawei.com>
Date: Wed, 14 Jan 2015 17:33:33 +0530
From: Anurup M <anurup.m@huawei.com>
MIME-Version: 1.0
Subject: Re: Kdump on ARM64
References: <54AE2544.2010801@huawei.com> <54AE3B7A.4070301@linaro.org>
 <54B5003A.1050508@huawei.com> <54B5D030.20809@linaro.org>
In-Reply-To: <54B5D030.20809@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, geoff@infradead.org
Cc: "sanil.kumar@hisilicon.com" <sanil.kumar@hisilicon.com>, kexec@lists.infradead.org, dingtianhong@huawei.com



On 1/14/2015 7:40 AM, AKASHI Takahiro wrote:
> On 01/13/2015 08:23 PM, Anurup M wrote:
>>
>> Hi Akashi,
>>
>>     Thanks for the reply.
>>
>> Hi  Akashi, Geoff,
>>
>>     In the code I could find assert(arm64_mem.memstart) in the function virt_to_phys. This address can be 0x0 when the
>>    segment start address is 0x0. so can we use this assert?
> 
> Probably you're right.
> 
>>     The code flow is elf_arm64_load->load_crashdump_segments->add_buffer_phys_virt->add_segment_phys_virt->virt_to_phys
>>    and this call is also before the call to load_elf_exec_in_crashmem which init's arm64_mem.memstart to crash_reserved_mem.start.
>>    So arm64_mem.memstart is also not set before the call to virt_to_phys.
> 
> I need refresh my memory about the flow, but in this particular case,
> the last argument, phys, of add_buffer_phys_virt() is 0 and virt_to_phys()
> will not be called.
> 

Yes, You are right. The code flow which I gave was wrong. It is observed  when I don't input the -p option (only kexec). The error flow is
elf_arm64_load->elf_exec_load->add_segment->add_buffer_phys_virt->add_segment_phys_virt->virt_to_phys

Thanks,
Anurup

> Do you have any other evidence that the assertion above is broken?
> 
> Thanks,
> -Takahiro AKASHI
> 
> 
>>     Please share your comments.
>>
>> Thanks,
>> Anurup
>>
>>
>> On 1/8/2015 1:40 PM, AKASHI Takahiro wrote:
>>> Hi Anurup,
>>>
>>> On 01/08/2015 03:35 PM, Anurup M wrote:
>>>> Hi Akashi, Geoff,
>>>>
>>>>      I tried to check kdump on arm64 on Foundation model. The/proc/vmcore is generated.
>>>> But I couldnot check if it is proper. Is there a makedumpfile binary for arm64? and also crash tool.
>>>> I used the master branch of https://git.linaro.org/people/geoff.levand/linux-kexec.git to verify.
>>>>        Please provide some information about the current status or support for kdump on arm64?
>>>> and the ways to verify or start development on Foundation model.
>>>
>>> The story is that I used to work on kdump, but handed it off
>>> to Geoff at some time. Since then, he merged it into his repo
>>> but I don't think that he has tested (verified) it yet.
>>> So please take it as a study work (or prototype), although I'm
>>> pretty sure that it works well on model except some issues.
>>>
>>> Regarding /proc/vmcore, if you can retrieve it to your host machine,
>>> you can simply verify the contents as follows:
>>>    $ aarch64-linux-gnu-gdb vmlinux core(=vmcore)
>>>    (gdb) info threads
>>>    (gdb) bt
>>>     ...
>>>
>>> I also have a trivial patch for crash tool to cross-build it, but
>>> arm64 support (by RedHat folk) is already there.
>>>
>>> Thanks,
>>> -Takahiro AKASHI
>>>
>>>> Thanks,
>>>> Anurup M
>>>>
>>>
> .
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
