Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifL7W-0005sv-3a
 for kexec@lists.infradead.org; Thu, 12 Dec 2019 09:50:56 +0000
Subject: Re: [PATCH] makedumpfile/s390: Add get_kaslr_offset() for s390x
References: <20191203222725.64734-1-zaslonko@linux.ibm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03597AB9@BPXM09GP.gisp.nec.co.jp>
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <323f61d4-6aab-a0b4-faa3-e41756fb9913@linux.ibm.com>
Date: Thu, 12 Dec 2019 10:50:48 +0100
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03597AB9@BPXM09GP.gisp.nec.co.jp>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "prudo@linux.ibm.com" <prudo@linux.ibm.com>, "dyoung@redhat.com" <dyoung@redhat.com>

Hello Kazu,

I think we can try to generalize the kaslr offset extraction. 
I won't speak for other architectures, but for s390 that get_kaslr_offset_arm64() 
should work fine. The only concern of mine is this TODO statement:

if (_text <= vaddr && vaddr <= _end) {
	DEBUG_MSG("info->kaslr_offset: %lx\n", info->kaslr_offset);
	return info->kaslr_offset;
	} else {
	/*
	* TODO: we need to check if it is vmalloc/vmmemmap/module
	* address, we will have different offset
	*/
	return 0;
}

Could you explain this one?

Thanks,
Mikhail

On 09.12.2019 23:02, Kazuhito Hagio wrote:
> Hi Mikhail,
> 
> Sorry for late reply.
> 
>> -----Original Message-----
>> Since kernel v5.2 KASLR is supported on s390. In makedumpfile however no
>> support has been added yet. This patch adds the arch specific function
>> get_kaslr_offset() for s390x.
>> Since the values in vmcoreinfo are already relocated, the patch is
>> mainly relevant for vmlinux processing (-x option).
> 
> In the current implementation of makedumpfile, the get_kaslr_offset(vaddr)
> is supposed to return the KASLR offset only when the offset is needed to
> add to the vaddr.  So generally symbols from kernel (vmlinux) need it, but
> symbols from modules are resolved dynamically and don't need the offset.
\> 
> This patch always returns the offset if any, as a result, I guess this patch
> will not work as expected with module symbols in filter config file.
> 
> So... How about making get_kaslr_offset_arm64() general for other archs
> (get_kaslr_offset_general() or something), then using it also for s390?
> If OK, I can do that generalization.
> 
> Thanks,
> Kazu
> 
>>
>> Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>> ---
>>  arch/s390x.c   | 32 ++++++++++++++++++++++++++++++++
>>  makedumpfile.h |  3 ++-
>>  2 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390x.c b/arch/s390x.c
>> index bf9d58e..892df14 100644
>> --- a/arch/s390x.c
>> +++ b/arch/s390x.c
>> @@ -122,6 +122,38 @@ get_machdep_info_s390x(void)
>>  	return TRUE;
>>  }
>>
>> +unsigned long
>> +get_kaslr_offset_s390x(unsigned long vaddr)
>> +{
>> +	unsigned int i;
>> +	char buf[BUFSIZE_FGETS], *endp;
>> +
>> +	if (!info->file_vmcoreinfo)
>> +		return FALSE;
>> +
>> +	if (fseek(info->file_vmcoreinfo, 0, SEEK_SET) < 0) {
>> +		ERRMSG("Can't seek the vmcoreinfo file(%s). %s\n",
>> +		       info->name_vmcoreinfo, strerror(errno));
>> +		return FALSE;
>> +	}
>> +
>> +	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
>> +		i = strlen(buf);
>> +		if (!i)
>> +			break;
>> +		if (buf[i - 1] == '\n')
>> +			buf[i - 1] = '\0';
>> +		if (strncmp(buf, STR_KERNELOFFSET,
>> +			    strlen(STR_KERNELOFFSET)) == 0) {
>> +			info->kaslr_offset =
>> +				strtoul(buf + strlen(STR_KERNELOFFSET), &endp, 16);
>> +			DEBUG_MSG("info->kaslr_offset: %lx\n", info->kaslr_offset);
>> +		}
>> +	}
>> +
>> +	return info->kaslr_offset;
>> +}
>> +
>>  static int
>>  is_vmalloc_addr_s390x(unsigned long vaddr)
>>  {
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index ac11e90..26f6247 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -1071,11 +1071,12 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
>>  int get_machdep_info_s390x(void);
>>  unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
>>  int is_iomem_phys_addr_s390x(unsigned long addr);
>> +unsigned long get_kaslr_offset_s390x(unsigned long vaddr);
>>  #define find_vmemmap()		stub_false()
>>  #define get_phys_base()		stub_true()
>>  #define get_machdep_info()	get_machdep_info_s390x()
>>  #define get_versiondep_info()	stub_true()
>> -#define get_kaslr_offset(X)	stub_false()
>> +#define get_kaslr_offset(X)	get_kaslr_offset_s390x(X)
>>  #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
>>  #define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
>>  #define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
>> --
>> 2.17.1
>>
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
