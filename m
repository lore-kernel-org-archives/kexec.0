Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ikK1K-0006Bq-2r
 for kexec@lists.infradead.org; Thu, 26 Dec 2019 03:41:08 +0000
Subject: Re: [PATCH] makedumpfile/s390: Add get_kaslr_offset() for s390x
References: <20191203222725.64734-1-zaslonko@linux.ibm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03597AB9@BPXM09GP.gisp.nec.co.jp>
 <323f61d4-6aab-a0b4-faa3-e41756fb9913@linux.ibm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03597F4E@BPXM09GP.gisp.nec.co.jp>
 <8fd807f1-c296-1a34-e42a-a102df62f3a0@linux.ibm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03598540@BPXM09GP.gisp.nec.co.jp>
From: lijiang <lijiang@redhat.com>
Message-ID: <726b8852-77af-b440-99b2-6b5a7b05e674@redhat.com>
Date: Thu, 26 Dec 2019 11:38:33 +0800
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03598540@BPXM09GP.gisp.nec.co.jp>
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
To: kexec@lists.infradead.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>

Hi, Kazu and Mikhail,

> Hi Mikhail,
> 
>> -----Original Message-----
>> Hi,
>>
>> On 12.12.2019 17:12, Kazuhito Hagio wrote:
>>> Hi Mikhail,
>>>
>>>> -----Original Message-----
>>>> Hello Kazu,
>>>>
>>>> I think we can try to generalize the kaslr offset extraction.
>>>> I won't speak for other architectures, but for s390 that get_kaslr_offset_arm64()
>>>> should work fine. The only concern of mine is this TODO statement:
>>>>
>>>> if (_text <= vaddr && vaddr <= _end) {
>>>> 	DEBUG_MSG("info->kaslr_offset: %lx\n", info->kaslr_offset);
>>>> 	return info->kaslr_offset;
>>>> 	} else {
>>>> 	/*
>>>> 	* TODO: we need to check if it is vmalloc/vmmemmap/module
>>>> 	* address, we will have different offset
>>>> 	*/
>>>> 	return 0;
>>>> }
>>>>
>>>> Could you explain this one?
>>>
>>> Probably it was considered that the check would be needed to support
>>> the whole KASLR behavior when get_kaslr_offset_x86_64() was written
>>> originally.
>>>
>>> But in the current makedumpfile for x86_64 and arm64 supporting KASLR,
>>> the offset we need is the one for symbol addresses in vmlinux only.
>>> As I said below, module symbol addresses are retrieved from vmcore.
>>> Other addresses should not be passed to the function for now, as far
>>> as I know.
>>>
>>> So I think the TODO comment is confusing, and it would be better to
>>> remove it or change it to something like:
>>> /*
>>>  * Returns 0 if vaddr does not need the offset to be added,
>>>  * e.g. for module address.
>>>  */
>>>
>>> But if s390 uses get_kaslr_offset() in its arch-specific code to
>>> adjust addresses other than kernel text address, we might need to
>>> modify it for s390, not generalize it.
>>
>> Currently, s390 doesn't use get_kaslr_offset() in its arch-specific
>> code.
> 
> OK, I pushed a patch that generalizes it to my test repository.
> Could you enable s390 to use it and test?
> https://github.com/k-hagio/makedumpfile/tree/add-get_kaslr_offset_general
> 

I enabled it on s390 as below and tested, it worked.

@@ -1075,7 +1075,7 @@ int is_iomem_phys_addr_s390x(unsigned long addr);
 #define get_phys_base()                stub_true()
 #define get_machdep_info()     get_machdep_info_s390x()
 #define get_versiondep_info()  stub_true()
-#define get_kaslr_offset(X)    stub_false()
+#define get_kaslr_offset(X)    get_kaslr_offset_general(X)
 #define vaddr_to_paddr(X)      vaddr_to_paddr_s390x(X)

But, there is still a problem that needs to be improved. In the find_kaslr_offsets(),
the value of SYMBOL(_stext) is always 0(zero) and it is passed to the get_kaslr_offset().
For the following code in the get_kaslr_offset_general(), it does not work as expected.
...
	if (_text <= vaddr && vaddr <= _end)
		return info->kaslr_offset;
	else
		return 0;
...
Here is my log:
get_kaslr_offset_general: info->kaslr_offset: 67ebc000, _text:100000, _end:10ba000, vaddr:0

After applied the following patch, got the expected result.
 int
 find_kaslr_offsets()
 {
@@ -3973,6 +4042,11 @@ find_kaslr_offsets()
         * called this function between open_vmcoreinfo() and
         * close_vmcoreinfo()
         */
+       READ_SYMBOL("_stext", _stext);
+       if (SYMBOL(_stext) == NOT_FOUND_SYMBOL) {
+                ERRMSG("Can't get the symbol of _stext.\n");
+                goto out;
+       }
        get_kaslr_offset(SYMBOL(_stext));

Here is my log:
get_kaslr_offset_general: info->kaslr_offset: 67ebc000, _text:100000, _end:10ba000, vaddr:67fbc000

Basically, before using the value of SYMBOL(_stext), need to ensure that the SYMBOL(_stext) is parsed
correctly.

Thanks.

> Thanks,
> Kazu
> 
>>
>>>
>>> Thanks,
>>> Kazu
>>>
>>>>
>>>> Thanks,
>>>> Mikhail
>>>>
>>>> On 09.12.2019 23:02, Kazuhito Hagio wrote:
>>>>> Hi Mikhail,
>>>>>
>>>>> Sorry for late reply.
>>>>>
>>>>>> -----Original Message-----
>>>>>> Since kernel v5.2 KASLR is supported on s390. In makedumpfile however no
>>>>>> support has been added yet. This patch adds the arch specific function
>>>>>> get_kaslr_offset() for s390x.
>>>>>> Since the values in vmcoreinfo are already relocated, the patch is
>>>>>> mainly relevant for vmlinux processing (-x option).
>>>>>
>>>>> In the current implementation of makedumpfile, the get_kaslr_offset(vaddr)
>>>>> is supposed to return the KASLR offset only when the offset is needed to
>>>>> add to the vaddr.  So generally symbols from kernel (vmlinux) need it, but
>>>>> symbols from modules are resolved dynamically and don't need the offset.
>>>> \>
>>>>> This patch always returns the offset if any, as a result, I guess this patch
>>>>> will not work as expected with module symbols in filter config file.
>>>>>
>>>>> So... How about making get_kaslr_offset_arm64() general for other archs
>>>>> (get_kaslr_offset_general() or something), then using it also for s390?
>>>>> If OK, I can do that generalization.
>>>>>
>>>>> Thanks,
>>>>> Kazu
>>>>>
>>>>>>
>>>>>> Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
>>>>>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>>>>>> ---
>>>>>>  arch/s390x.c   | 32 ++++++++++++++++++++++++++++++++
>>>>>>  makedumpfile.h |  3 ++-
>>>>>>  2 files changed, 34 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/s390x.c b/arch/s390x.c
>>>>>> index bf9d58e..892df14 100644
>>>>>> --- a/arch/s390x.c
>>>>>> +++ b/arch/s390x.c
>>>>>> @@ -122,6 +122,38 @@ get_machdep_info_s390x(void)
>>>>>>  	return TRUE;
>>>>>>  }
>>>>>>
>>>>>> +unsigned long
>>>>>> +get_kaslr_offset_s390x(unsigned long vaddr)
>>>>>> +{
>>>>>> +	unsigned int i;
>>>>>> +	char buf[BUFSIZE_FGETS], *endp;
>>>>>> +
>>>>>> +	if (!info->file_vmcoreinfo)
>>>>>> +		return FALSE;
>>>>>> +
>>>>>> +	if (fseek(info->file_vmcoreinfo, 0, SEEK_SET) < 0) {
>>>>>> +		ERRMSG("Can't seek the vmcoreinfo file(%s). %s\n",
>>>>>> +		       info->name_vmcoreinfo, strerror(errno));
>>>>>> +		return FALSE;
>>>>>> +	}
>>>>>> +
>>>>>> +	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
>>>>>> +		i = strlen(buf);
>>>>>> +		if (!i)
>>>>>> +			break;
>>>>>> +		if (buf[i - 1] == '\n')
>>>>>> +			buf[i - 1] = '\0';
>>>>>> +		if (strncmp(buf, STR_KERNELOFFSET,
>>>>>> +			    strlen(STR_KERNELOFFSET)) == 0) {
>>>>>> +			info->kaslr_offset =
>>>>>> +				strtoul(buf + strlen(STR_KERNELOFFSET), &endp, 16);
>>>>>> +			DEBUG_MSG("info->kaslr_offset: %lx\n", info->kaslr_offset);
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>> +	return info->kaslr_offset;
>>>>>> +}
>>>>>> +
>>>>>>  static int
>>>>>>  is_vmalloc_addr_s390x(unsigned long vaddr)
>>>>>>  {
>>>>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>>>>> index ac11e90..26f6247 100644
>>>>>> --- a/makedumpfile.h
>>>>>> +++ b/makedumpfile.h
>>>>>> @@ -1071,11 +1071,12 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
>>>>>>  int get_machdep_info_s390x(void);
>>>>>>  unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
>>>>>>  int is_iomem_phys_addr_s390x(unsigned long addr);
>>>>>> +unsigned long get_kaslr_offset_s390x(unsigned long vaddr);
>>>>>>  #define find_vmemmap()		stub_false()
>>>>>>  #define get_phys_base()		stub_true()
>>>>>>  #define get_machdep_info()	get_machdep_info_s390x()
>>>>>>  #define get_versiondep_info()	stub_true()
>>>>>> -#define get_kaslr_offset(X)	stub_false()
>>>>>> +#define get_kaslr_offset(X)	get_kaslr_offset_s390x(X)
>>>>>>  #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
>>>>>>  #define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
>>>>>>  #define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
>>>>>> --
>>>>>> 2.17.1
>>>>>>
>>>>>
>>>>>
>>>
>>>
> 
> 
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
