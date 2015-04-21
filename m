Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YkPf0-00052z-Pp
 for kexec@lists.infradead.org; Tue, 21 Apr 2015 04:19:47 +0000
Message-ID: <5535CFC6.4010802@redhat.com>
Date: Tue, 21 Apr 2015 09:49:18 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 3/6] arm64: allocate memory for other segments after
 kernel
References: <cover.1429201849.git.panand@redhat.com>
 <1d852e11a3f121d5a3cfd86c05102e940e33944c.1429201849.git.panand@redhat.com>
 <20150420032106.GF15033@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20150420032106.GF15033@dhcp-16-116.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org



On Monday 20 April 2015 08:51 AM, Baoquan He wrote:
> On 04/16/15 at 10:17pm, Pratyush Anand wrote:
>> In case of KEXEC_ON_CRASH, load other segments after the addresses where
>> kernel segments finish.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>>   kexec/arch/arm64/crashdump-arm64.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
>> index 41266f294589..75f4e4d269ca 100644
>> --- a/kexec/arch/arm64/crashdump-arm64.c
>> +++ b/kexec/arch/arm64/crashdump-arm64.c
>> @@ -312,5 +312,6 @@ void set_crash_entry(struct mem_ehdr *ehdr, struct kexec_info *info)
>>   off_t locate_dtb_in_crashmem(struct kexec_info *info, off_t dtb_size)
>>   {
>>   	return locate_hole(info, dtb_size, 128UL * 1024,
>> -		crash_reserved_mem.start, crash_reserved_mem.end, 1);
>> +		crash_reserved_mem.start + arm64_mem.text_offset +
>> +		arm64_mem.image_size, crash_reserved_mem.end, 1);
>
> So you have decided to hard code the sequence of segment. It
> seems not good. Why don't do it by calling add_buffer_phys_virt() or
> implement a similar function if you don't like add_buffer_phys_virt.

I agree that code is a bit tightly coupled here. I think, Takahiro  can 
comment better.

arm64 does use add_buffer_phys_virt to add all the buffers into segment 
list. arm64_load_other_segments function adds buffers for all segments 
other than kernel and elfcorehdr. This function calls 
add_buffer_phys_virt to load different segments like dtb, initrd and 
purgatory. Only limitation we are putting that we find free area for all 
these segments after the area where kernel finishes. Currently load 
sequence is like dtb, initrd and then purgatory. But I believe, even if 
we use other load sequence in arm64_load_other_segments, it should work.


Not sure, if understood the question and replied well.

~Pratyush



>
>>   }
>> --
>> 2.1.0
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
