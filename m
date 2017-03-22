Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqcLU-0000hr-83
 for kexec@lists.infradead.org; Wed, 22 Mar 2017 09:14:22 +0000
Subject: Re: [PATCH v3 1/3] kexec: Move vmcoreinfo out of the kernel's .bss
 section
References: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
 <87pohbz4lo.fsf@xmission.com> <58D23BF6.5080101@redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58D240FB.3060506@redhat.com>
Date: Wed, 22 Mar 2017 17:16:43 +0800
MIME-Version: 1.0
In-Reply-To: <58D23BF6.5080101@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

On 03/22/2017 at 04:55 PM, Xunlei Pang wrote:
> On 03/21/2017 at 11:33 AM, Eric W. Biederman wrote:
>> Xunlei Pang <xlpang@redhat.com> writes:
>>
>>> As Eric said,
>>> "what we need to do is move the variable vmcoreinfo_note out
>>> of the kernel's .bss section.  And modify the code to regenerate
>>> and keep this information in something like the control page.
>>>
>>> Definitely something like this needs a page all to itself, and ideally
>>> far away from any other kernel data structures.  I clearly was not
>>> watching closely the data someone decided to keep this silly thing
>>> in the kernel's .bss section."
>>>
>>> This patch allocates extra pages for these vmcoreinfo_XXX variables,
>>> one advantage is that it enhances some safety of vmcoreinfo, because
>>> vmcoreinfo now is kept far away from other kernel data structures.
>> Can you preceed this patch with a patch that removes CRASHTIME from
>> vmcoreinfo?  If someone actually cares we can add a separate note that holds
>> a 64bit crashtime in the per cpu notes.  
> Hi Eric,
>
> Thanks for your review, I took some time and did some investigation.
>
> Removing "CRASHTIME=X" from vmcoreinfo_note will break user-space tools.
> For example, makedumpfile gets vmcoreinfo note information by reading
> "/sys/kernel/vmcoreinfo"  its PA, then get its "VA = PA | PAGE_OFFSET",
> and then get the timestamp. This operates in the first kernel even before
> kdump is loaded.

Think more, this is not a problem for "makedumpfile --mem-usage",
as the system doesn't have "CRASHTIME" before crash. But still we
may have the following concerns.

>
> Actually, even moving vmcoreinfo_note[] into the crash memory, it
> may have problems, for example, on s390 system the crash memory
> range will be unmapped, so I guess it may cause some risks.
>
> Additionally, there is no available way for us to allocate a page from the
> crash memory during kernel initialization, we only can achieve this during
> the kexec syscalls. There is not a neat way to implement a function to
> allocate pages from the crash memory during kernel initialization without
> some hack code added, because user-space tools(like kexec-tools) can
> allocate the crash segment by their own ways from the crash memory.
>
> That's why I only copy vmcoreinfo_data[] into the crash memory, and
> not touch vmcoreinfo_note, so vmcoreinfo_data is well protected in
> the crash memory copy, then in crash_save_vmcoreinfo(), we copy
> this guaranteed copy into vmcoreinfo_note[], so the correctness of
> vmcoreinfo_note[] is guaranteed. This is what [PATCH v3 3/3] does.
>
> The current crash_save_vmcoreinfo() only involves memory(memcpy)
> operations even for get_seconds(no locks), the only risk I can think
> of now is that vmcoreinfo_note pointer may be corrupted. If it is a concern,
> I guess we can put it into struct kimage" just like vmcoreinfo_XXX_copy
> in this patch. After all if kimage structure was corrupted when crash happens,
> we can do nothing but have to accept the fate.
>
> So does it really deserve to eliminate crash_save_vmcoreinfo()?
>
> Regards,
> Xunlei
>
>> As we are looking at reliability concerns removing CRASHTIME should make
>> everything in vmcoreinfo a boot time constant.  Which should simplify
>> everything considerably.
>>
>> Which means we only need to worry abou the per-cpu notes being written
>> at the time of a crash.
>>
>>> Suggested-by: Eric Biederman <ebiederm@xmission.com>
>>> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
>>> ---
>>>  arch/ia64/kernel/machine_kexec.c |  5 -----
>>>  arch/x86/kernel/crash.c          |  2 +-
>>>  include/linux/kexec.h            |  2 +-
>>>  kernel/kexec_core.c              | 29 ++++++++++++++++++++++++-----
>>>  kernel/ksysfs.c                  |  2 +-
>>>  5 files changed, 27 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
>>> index 599507b..c14815d 100644
>>> --- a/arch/ia64/kernel/machine_kexec.c
>>> +++ b/arch/ia64/kernel/machine_kexec.c
>>> @@ -163,8 +163,3 @@ void arch_crash_save_vmcoreinfo(void)
>>>  #endif
>>>  }
>>>  
>>> -phys_addr_t paddr_vmcoreinfo_note(void)
>>> -{
>>> -	return ia64_tpa((unsigned long)(char *)&vmcoreinfo_note);
>>> -}
>>> -
>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>> index 3741461..4d35fbb 100644
>>> --- a/arch/x86/kernel/crash.c
>>> +++ b/arch/x86/kernel/crash.c
>>> @@ -456,7 +456,7 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
>>>  	bufp += sizeof(Elf64_Phdr);
>>>  	phdr->p_type = PT_NOTE;
>>>  	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
>>> -	phdr->p_filesz = phdr->p_memsz = sizeof(vmcoreinfo_note);
>>> +	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
>>>  	(ehdr->e_phnum)++;
>>>  
>>>  #ifdef CONFIG_X86_64
>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>> index e98e546..f1c601b 100644
>>> --- a/include/linux/kexec.h
>>> +++ b/include/linux/kexec.h
>>> @@ -317,7 +317,7 @@ extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
>>>  extern struct resource crashk_low_res;
>>>  typedef u32 note_buf_t[KEXEC_NOTE_BYTES/4];
>>>  extern note_buf_t __percpu *crash_notes;
>>> -extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
>>> +extern u32 *vmcoreinfo_note;
>>>  extern size_t vmcoreinfo_size;
>>>  extern size_t vmcoreinfo_max_size;
>>>  
>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>> index bfe62d5..e3a4bda 100644
>>> --- a/kernel/kexec_core.c
>>> +++ b/kernel/kexec_core.c
>>> @@ -52,10 +52,10 @@
>>>  note_buf_t __percpu *crash_notes;
>>>  
>>>  /* vmcoreinfo stuff */
>>> -static unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
>>> -u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
>>> +static unsigned char *vmcoreinfo_data;
>>>  size_t vmcoreinfo_size;
>>> -size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
>>> +size_t vmcoreinfo_max_size = VMCOREINFO_BYTES;
>>> +u32 *vmcoreinfo_note;
>>>  
>>>  /* Flag to indicate we are going to kexec a new kernel */
>>>  bool kexec_in_progress = false;
>>> @@ -1369,6 +1369,9 @@ static void update_vmcoreinfo_note(void)
>>>  
>>>  void crash_save_vmcoreinfo(void)
>>>  {
>>> +	if (!vmcoreinfo_note)
>>> +		return;
>>> +
>>>  	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
>>>  	update_vmcoreinfo_note();
>>>  }
>>> @@ -1397,13 +1400,29 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>>>  void __weak arch_crash_save_vmcoreinfo(void)
>>>  {}
>>>  
>>> -phys_addr_t __weak paddr_vmcoreinfo_note(void)
>>> +phys_addr_t paddr_vmcoreinfo_note(void)
>>>  {
>>> -	return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
>>> +	return __pa(vmcoreinfo_note);
>>>  }
>>>  
>>>  static int __init crash_save_vmcoreinfo_init(void)
>>>  {
>>> +	/* One page should be enough for VMCOREINFO_BYTES under all archs */
>>> +	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
>>> +	if (!vmcoreinfo_data) {
>>> +		pr_warn("Memory allocation for vmcoreinfo_data failed\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	vmcoreinfo_note = alloc_pages_exact(VMCOREINFO_NOTE_SIZE,
>>> +						GFP_KERNEL | __GFP_ZERO);
>>> +	if (!vmcoreinfo_note) {
>>> +		free_page((unsigned long)vmcoreinfo_data);
>>> +		vmcoreinfo_data = NULL;
>>> +		pr_warn("Memory allocation for vmcoreinfo_note failed\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>>  	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
>>>  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
>>>  
>>> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
>>> index ee1bc1b..9de6fcc 100644
>>> --- a/kernel/ksysfs.c
>>> +++ b/kernel/ksysfs.c
>>> @@ -130,7 +130,7 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
>>>  {
>>>  	phys_addr_t vmcore_base = paddr_vmcoreinfo_note();
>>>  	return sprintf(buf, "%pa %x\n", &vmcore_base,
>>> -		       (unsigned int)sizeof(vmcoreinfo_note));
>>> +			(unsigned int)VMCOREINFO_NOTE_SIZE);
>>>  }
>>>  KERNEL_ATTR_RO(vmcoreinfo);
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
