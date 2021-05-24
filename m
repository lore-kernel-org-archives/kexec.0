Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ll5d2-000lPV-1p
 for kexec@lists.infradead.org; Mon, 24 May 2021 08:08:01 +0000
Subject: Re: [PATCH] arm64/crashdump-arm64: align 'Kernel code' with '_stext'
References: <20210519031621.21008-1-piliu@redhat.com>
 <20210523075601.GA23210@vergenet.net>
From: piliu <piliu@redhat.com>
Message-ID: <400ee4b4-317b-98a6-cea6-191344b4f933@redhat.com>
Date: Mon, 24 May 2021 16:07:37 +0800
MIME-Version: 1.0
In-Reply-To: <20210523075601.GA23210@vergenet.net>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org



On 5/23/21 3:56 PM, Simon Horman wrote:
> On Wed, May 19, 2021 at 11:16:21AM +0800, Pingfan Liu wrote:
>> Since kernel commit e2a073dde921 ("arm64: omit [_text, _stext) from
>> permanent kernel mapping"), the physical address of 'Kernel code' in
>> /proc/iomem is mapped from _text, instead, from _stext.
>>
>> Change the code to cope with this kernel change.
>>
>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> 
> Thanks, will kexec still work with older kernels with this change in place?
> 
Oops, it will. Let me try to bring up another idea to tackle it.

Thanks,
Pingfan
>> ---
>>   kexec/arch/arm64/crashdump-arm64.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
>> index 38d1a0f..1da663e 100644
>> --- a/kexec/arch/arm64/crashdump-arm64.c
>> +++ b/kexec/arch/arm64/crashdump-arm64.c
>> @@ -148,7 +148,11 @@ static int crash_get_memory_ranges(void)
>>   	 * For additional kernel code/data segment.
>>   	 * kern_paddr_start/kern_size are determined in iomem_range_callback
>>   	 */
>> -	elf_info.kern_vaddr_start = get_kernel_sym("_text");
>> +	/* Refer to kernel:
>> +	 *     kernel_code.start   = __pa_symbol(_stext);
>> +	 * which is exported through /proc/iomem as "Kernel code"
>> +	 */
>> +	elf_info.kern_vaddr_start = get_kernel_sym("_stext");
>>   	if (!elf_info.kern_vaddr_start)
>>   		elf_info.kern_vaddr_start = UINT64_MAX;
>>   
>> -- 
>> 2.29.2
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
