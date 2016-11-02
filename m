Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c1qIp-0006ex-TA
 for kexec@lists.infradead.org; Wed, 02 Nov 2016 07:49:45 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH Makedumpfile 1/4] x86_64: Calculate page_offset from
 pt_load
Date: Wed, 2 Nov 2016 07:40:27 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E7C84F@BPXM01GP.gisp.nec.co.jp>
References: <cover.1477327674.git.panand@redhat.com>
 <4b2497eff40bd47eef59cdd6af165e700cfd4408.1477327674.git.panand@redhat.com>
 <c873178b-4d1b-03a2-f419-f2dc6602a5cc@redhat.com>
In-Reply-To: <c873178b-4d1b-03a2-f419-f2dc6602a5cc@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Pratyush Anand <panand@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>

Hello Pratyush,

>On Monday 24 October 2016 10:18 PM, Pratyush Anand wrote:
>> page_offset can always be calculated as 'virtual - physical' for a direct
>> mapping area on x86. Therefore, remove the version dependent calculation
>> and use this method.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>>  arch/x86_64.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86_64.c b/arch/x86_64.c
>> index ddf7be6bc57b..a96fd8ae00a1 100644
>> --- a/arch/x86_64.c
>> +++ b/arch/x86_64.c
>> @@ -44,6 +44,24 @@ get_xen_p2m_mfn(void)
>>  	return NOT_FOUND_LONG_VALUE;
>>  }
>>
>> +static int
>> +get_page_offset_x86_64(void)
>> +{
>> +	int i;
>> +	unsigned long long phys_start;
>> +	unsigned long long virt_start;
>> +
>> +	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
>> +		if (virt_start >= __START_KERNEL_map) {
>
>OK..So, this is the problem. We should have
>
>if (virt_start < __START_KERNEL_map) {
>
>Kernel text region lies above __START_KERNEL_map, which is linearly
>mapped however not a direct mapping. Direct mapping region lies below it
>instead. So, page_offset can only be calculated with a region which is
>below __START_KERNEL_map.
>
>Thanks Baoquan for finding it. 

Could you explain the issue in more detail, what is the difference 
between "linear map" and "direct map" ?

BTW, I confirmed that the difference of v2 patch is only this and
the result of benchmark looks great, thank you very much.


Regards,
Atsushi Kumagai

>> +			info->page_offset = virt_start - phys_start;
>> +			return TRUE;
>> +		}
>> +	}
>> +
>> +	ERRMSG("Can't get any pt_load to calculate page offset.\n");
>> +	return FALSE;
>> +}
>> +
>>  int
>>  get_phys_base_x86_64(void)
>>  {
>> @@ -159,10 +177,8 @@ get_versiondep_info_x86_64(void)
>>  	else
>>  		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
>>
>> -	if (info->kernel_version < KERNEL_VERSION(2, 6, 27))
>> -		info->page_offset = __PAGE_OFFSET_ORIG;
>> -	else
>> -		info->page_offset = __PAGE_OFFSET_2_6_27;
>> +	if (!get_page_offset_x86_64())
>> +		return FALSE;
>>
>>  	if (info->kernel_version < KERNEL_VERSION(2, 6, 31)) {
>>  		info->vmalloc_start = VMALLOC_START_ORIG;
>>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
