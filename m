Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bao7F-0003G7-8s
 for kexec@lists.infradead.org; Fri, 19 Aug 2016 18:02:02 +0000
Received: by mail-wm0-x22a.google.com with SMTP id o80so52182039wme.1
 for <kexec@lists.infradead.org>; Fri, 19 Aug 2016 11:01:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160819024146.GA12340@x1.redhat.com>
References: <1471531632-23003-1-git-send-email-thgarnie@google.com>
 <20160819024146.GA12340@x1.redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 19 Aug 2016 11:01:36 -0700
Message-ID: <CAGXu5j+2o5iPbesqJA5t2QDM2hK=g7mZAAdoS4EqHzVE76DzcA@mail.gmail.com>
Subject: Re: [PATCH v1] kdump,
 vmcoreinfo: report memory sections virtual addresses
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
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Eugene Surovegin <surovegin@google.com>, Kexec Mailing List <kexec@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, Xunlei Pang <xlpang@redhat.com>, LKML <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Thomas Garnier <thgarnie@google.com>

On Thu, Aug 18, 2016 at 7:41 PM, Baoquan He <bhe@redhat.com> wrote:
>
> This makes sense. Makedumpfile need this to parse memory sections.

Yup, good addition.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

>
> Ack.
>
> Acked-by: Baoquan He <bhe@redhat.com>
>
> On 08/18/16 at 07:47am, Thomas Garnier wrote:
>> KASLR memory randomization can randomize the base of the physical memory
>> mapping (PAGE_OFFSET), vmalloc (VMALLOC_START) and vmemmap
>> (VMEMMAP_START). Adding these variables on VMCOREINFO so tools can
>> easily identify the base of each memory section.
>>
>> Signed-off-by: Thomas Garnier <thgarnie@google.com>
>> ---
>> Based on next-20160817
>> ---
>>  arch/x86/kernel/machine_kexec_64.c | 3 +++
>>  include/linux/kexec.h              | 6 ++++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index fc3389f..b1f15a2 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -338,6 +338,9 @@ void arch_crash_save_vmcoreinfo(void)
>>       vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
>>                             kaslr_offset());
>>       VMCOREINFO_PHYS_BASE(phys_base);
>> +     VMCOREINFO_PAGE_OFFSET(PAGE_OFFSET);
>> +     VMCOREINFO_VMALLOC_START(VMALLOC_START);
>> +     VMCOREINFO_VMEMMAP_START(VMEMMAP_START);
>>  }
>>
>>  /* arch-dependent functionality related to kexec file-based syscall */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index d3ae429..cd3874c 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -261,6 +261,12 @@ phys_addr_t paddr_vmcoreinfo_note(void);
>>       vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
>>  #define VMCOREINFO_PHYS_BASE(value) \
>>       vmcoreinfo_append_str("PHYS_BASE=%lx\n", (unsigned long)value)
>
> Could it be better to define only one MACRO like VMCOREINFO_
>> +#define VMCOREINFO_PAGE_OFFSET(value) \
>> +     vmcoreinfo_append_str("PAGE_OFFSET=%lx\n", (unsigned long)value)
>> +#define VMCOREINFO_VMALLOC_START(value) \
>> +     vmcoreinfo_append_str("VMALLOC_START=%lx\n", (unsigned long)value)
>> +#define VMCOREINFO_VMEMMAP_START(value) \
>> +     vmcoreinfo_append_str("VMEMMAP_START=%lx\n", (unsigned long)value)
>>
>>  extern struct kimage *kexec_image;
>>  extern struct kimage *kexec_crash_image;
>> --
>> 2.8.0.rc3.226.g39d4020
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Kees Cook
Nexus Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
