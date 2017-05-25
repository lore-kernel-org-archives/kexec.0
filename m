Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dDlMd-0001Jx-OB
 for kexec@lists.infradead.org; Thu, 25 May 2017 05:31:13 +0000
Received: by mail-pf0-f180.google.com with SMTP id 9so156471828pfj.1
 for <kexec@lists.infradead.org>; Wed, 24 May 2017 22:30:51 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH v3 1/2] makedumpfile: add runtime kaslr
 offset if it exists
References: <cover.1495619809.git.panand@redhat.com>
 <a2b4fcdf5974e6ea8b66abade20fb2ae1ab9ae08.1495619809.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EDACC2@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <a0f93c46-4ca3-cfc7-e2bf-b0059bd8fdea@redhat.com>
Date: Thu, 25 May 2017 11:00:46 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EDACC2@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "xlpang@redhat.com" <xlpang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

Hi Atsushi,


On Thursday 25 May 2017 08:33 AM, Atsushi Kumagai wrote:
> Hello Pratyush,
>
>> If we have to erase a symbol from vmcore whose address is not present in
>> vmcoreinfo, then we need to pass vmlinux as well to get the symbol
>> address.
>> When kaslr is enabled, virtual address of all the kernel symbols are
>> randomized with an offset. vmlinux  always has a static address, but all
>> the arch specific calculation are based on run time kernel address. So
>> we need to find a way to translate symbol address from vmlinux to kernel
>> run time address.
>>
>> without this patch:
>>   # cat > scrub.conf << EOF
>>   [vmlinux]
>>   erase jiffies
>>   erase init_task.utime
>>   for tsk in init_task.tasks.next within task_struct:tasks
>>       erase tsk.utime
>>   endfor
>>   EOF
>>
>>    # makedumpfile --split  -d 5 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
>>
>>    readpage_kdump_compressed: pfn(f97ea) is excluded from vmcore.
>>    readmem: type_addr: 1, addr:f97eaff8, size:8
>>    vtop4_x86_64: Can't get pml4 (page_dir:f97eaff8).
>>    readmem: Can't convert a virtual address(ffffffff819f1284) to physical address.
>>    readmem: type_addr: 0, addr:ffffffff819f1284, size:390
>>    check_release: Can't get the address of system_utsname.
>>
>> After this patch check_release() is ok, and also we are able to erase
>> symbol from vmcore.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>> arch/x86_64.c  | 36 ++++++++++++++++++++++++++++++++++++
>> erase_info.c   |  1 +
>> makedumpfile.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> makedumpfile.h | 16 ++++++++++++++++
>> 4 files changed, 106 insertions(+)
>>
>> diff --git a/arch/x86_64.c b/arch/x86_64.c
>> index e978a36f8878..fd2e8ac154d6 100644
>> --- a/arch/x86_64.c
>> +++ b/arch/x86_64.c
>> @@ -33,6 +33,42 @@ get_xen_p2m_mfn(void)
>> 	return NOT_FOUND_LONG_VALUE;
>> }
>>
>> +unsigned long
>> +get_kaslr_offset_x86_64(unsigned long vaddr)
>> +{
>> +	unsigned int i;
>> +	char buf[BUFSIZE_FGETS], *endp;
>> +
>> +	if (!info->kaslr_offset && info->file_vmcoreinfo) {
>> +		if (fseek(info->file_vmcoreinfo, 0, SEEK_SET) < 0) {
>> +			ERRMSG("Can't seek the vmcoreinfo file(%s). %s\n",
>> +					info->name_vmcoreinfo, strerror(errno));
>> +			return FALSE;
>> +		}
>> +
>> +		while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
>> +			i = strlen(buf);
>> +			if (!i)
>> +				break;
>> +			if (buf[i - 1] == '\n')
>> +				buf[i - 1] = '\0';
>> +			if (strncmp(buf, STR_KERNELOFFSET,
>> +					strlen(STR_KERNELOFFSET)) == 0)
>> +				info->kaslr_offset =
>> +					strtoul(buf+strlen(STR_KERNELOFFSET),&endp,16);
>> +		}
>> +	}
>> +	if (vaddr >= __START_KERNEL_map &&
>> +			vaddr < __START_KERNEL_map + info->kaslr_offset)
>> +		return info->kaslr_offset;
>> +	else
>> +		/*
>> +		 * TODO: we need to check if it is vmalloc/vmmemmap/module
>> +		 * address, we will have different offset
>> +		 */
>> +		return 0;
>> +}
>> +
>> static int
>> get_page_offset_x86_64(void)
>> {
>> diff --git a/erase_info.c b/erase_info.c
>> index f2ba9149e93e..60abfa1a1adf 100644
>> --- a/erase_info.c
>> +++ b/erase_info.c
>> @@ -1088,6 +1088,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_vaddr,
>> 							ce->line, ce->name);
>> 			return FALSE;
>> 		}
>> +		ce->sym_addr += get_kaslr_offset(ce->sym_addr);
>> 		ce->type_name = get_symbol_type_name(ce->name,
>> 					DWARF_INFO_GET_SYMBOL_TYPE,
>> 					&ce->size, &ce->type_flag);
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 301772a8820c..4986d098d69a 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -2099,6 +2099,13 @@ void
>> write_vmcoreinfo_data(void)
>> {
>> 	/*
>> +	 * write 1st kernel's KERNELOFFSET
>> +	 */
>> +	if (info->kaslr_offset)
>> +		fprintf(info->file_vmcoreinfo, "%s%lx\n", STR_KERNELOFFSET,
>> +		    info->kaslr_offset);
>
> When will this data written to VMCOREINFO file be used ?
> info->kaslr_offset is necessary for vmlinux but -x and -i are exclusive.

This is what I thought:

Lets says we have got a vmcore1 after re-filtering original vmcore. Now, if we 
would like to re-filter vmcore1 then we will need kaslr_offset again. So, 
should we not right kaslr_offset in vmcoreinfo of vmcore1 as well?

Thanks for your review.

~Pratyush


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
