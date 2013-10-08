Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VTTf8-0008PV-Ei
 for kexec@lists.infradead.org; Tue, 08 Oct 2013 09:33:08 +0000
Message-ID: <5253D136.7050400@hp.com>
Date: Tue, 08 Oct 2013 17:32:38 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
References: <20130924124931.14715.24507.stgit@k.asiapacific.hpqcorp.net>
 <52422FCF.1030206@jp.fujitsu.com> <52429BF1.3050303@hp.com>
 <52539B13.6060406@jp.fujitsu.com> <5253B3B5.6060000@hp.com>
 <5253C38C.2050105@jp.fujitsu.com>
In-Reply-To: <5253C38C.2050105@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, chaowang@redhat.com, lisa.mitchell@hp.com, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, anderson@redhat.com, vgoyal@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, Jingbai Ma <jingbai.ma@hp.com>, crash-utility@redhat.com

On 10/08/2013 04:34 PM, HATAYAMA Daisuke wrote:
> (2013/10/08 16:26), Jingbai Ma wrote:
>> On 10/08/2013 01:41 PM, HATAYAMA Daisuke wrote:
>>> (2013/09/25 17:16), Jingbai Ma wrote:
>>>> On 09/25/2013 08:35 AM, HATAYAMA Daisuke wrote:
>>>>> (2013/09/24 21:49), Jingbai Ma wrote:
>>>>>> This patch will fix a bug of makedumpfile doesn't work correctly on
>>>>>> system
>>>>>> has over 44-bit addressing in compression dump mode.
>>>>>> This bug was posted here:
>>>>>> http://lists.infradead.org/pipermail/kexec/2013-September/009587.html
>>>>>>
>>>>>> This patch will add a new field in struct kdump_sub_header.
>>>>>> unsigned long max_mapnr;
>>>>>>
>>>>>> And the old "unsigned int max_mapnr" in struct disk_dump_header will
>>>>>> not be used anymore. But still be there for compatibility purpose.
>>>>>>
>>>>>> This patch will change the header_version to 6.
>>>>>>
>>>>>> The corresponding patch for crash utility will be sent out
>>>>>> separately.
>>>>>>
>>>>>> This patch doesn't change sadump_header.
>>>>>> Because of in sadump file, there is no any sub-header, it has to
>>>>>> change
>>>>>> the sadump_header itself.
>>>>>> And if do so, will cause backwards-compatibility issue.
>>>>>> So it could be a separate patch if needed.
>>>>>>
>>>>>> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
>>>>>> ---
>>>>>> IMPLEMENTATION | 1 +
>>>>>> diskdump_mod.h | 5 ++++-
>>>>>> makedumpfile.c | 28 ++++++++++++++++++++++------
>>>>>> 3 files changed, 27 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/IMPLEMENTATION b/IMPLEMENTATION
>>>>>> index f0f3135..d576811 100644
>>>>>> --- a/IMPLEMENTATION
>>>>>> +++ b/IMPLEMENTATION
>>>>>> @@ -77,6 +77,7 @@
>>>>>> unsigned long size_note; /* header_version 4 and later */
>>>>>> off_t offset_eraseinfo; /* header_version 5 and later */
>>>>>> unsigned long size_eraseinfo; /* header_version 5 and later */
>>>>>> + unsigned long max_mapnr; /* header_version 6 and later */
>>>>>
>>>>> x86 PAE mode can represents 52-bit physical addresses and so 40-bit
>>>>> physical
>>>>> page frames. On x86_32 unsigned long has 32-bit length only. So, you
>>>>> should
>>>>> define max_mapnr as unsigned long long.
>>>>>
>>>>
>>>> Good catch, I forgot x86 PAE mode also may exceed 32-bit length.
>>>> Will fix it.
>>>>
>>>
>>> Though perhaps you've already noticed, both start_pfn and end_pfn in
>>> kdump sub
>>> header have 32-bit length on x86_32. These need to be extended to 64-bit
>>> length,
>>> too.
>>>
>>> /*
>>> * Sub header for KDUMP
>>> * But Common header of KDUMP is disk_dump_header of diskdump.
>>> */
>>> struct kdump_sub_header {
>>> unsigned long phys_base;
>>> int dump_level; /* header_version 1 and later */
>>> int split; /* header_version 2 and later */
>>> unsigned long start_pfn; /* header_version 2 and later */
>>> unsigned long end_pfn; /* header_version 2 and later */
>>> off_t offset_vmcoreinfo;/* header_version 3 and later */
>>> unsigned long size_vmcoreinfo; /* header_version 3 and later */
>>> off_t offset_note; /* header_version 4 and later */
>>> unsigned long size_note; /* header_version 4 and later */
>>> off_t offset_eraseinfo; /* header_version 5 and later */
>>> unsigned long size_eraseinfo; /* header_version 5 and later */
>>> };
>>>
>>
>> Thanks for your reminder.
>> Yes, I'm going to add another two new 64-bit values for them as well
>> as max_mapnr.
>> How about these names?
>> unsigned long long start_pfn_64;
>> unsigned long long end_pfn_64;
>> unsigned long long max_mapnr_64;
>>
>> BTW, Could you give me any suggestions about the the max_mapnr in
>> sadump header.
>> Currently, it defined as below:
>> struct sadump_header {
>> ...
>> uint32_t max_mapnr; /* = max_mapnr */
>> ...
>> };
>> And there is no any sub-header in sadump format. How would you like to
>> keep the backward compatibility?
>> I can add a new unit64_t max_mapnr_64 in this sadump_header but it
>> will change the header size. It should work if I add some code to
>> check header_version for sadump format, and for old format just assign
>> the value of max_mapnr to max_mapnr_64.
>>
>>
>
> Thanks. But you don't need to change sadump format. The format is used
> by Fujitsu sadump that is firmware-based crash dump mechanism. Currently
> we don't have system with more than 16TiB memory. So, there's no issue in
> sadump format now.
>
> Also, this format is maintained by firmware developers differnet from me.
> The time I'll modify the format will be after they changes their firmware
> implementation.
>
> Anyway, you don't need to care about definition of sadump format now.
>

Got it. Thanks for your clarification!


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
