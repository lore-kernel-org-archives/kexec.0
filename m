Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YKun8-0001gZ-8w
 for kexec@lists.infradead.org; Mon, 09 Feb 2015 20:18:46 +0000
Received: by mail-oi0-f46.google.com with SMTP id x69so2910084oia.5
 for <kexec@lists.infradead.org>; Mon, 09 Feb 2015 12:18:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54CF2800.5070608@redhat.com>
References: <1412060896-1902-1-git-send-email-bhe@redhat.com>
 <1412060896-1902-2-git-send-email-bhe@redhat.com>
 <54CF2800.5070608@redhat.com>
Date: Mon, 9 Feb 2015 12:18:24 -0800
Message-ID: <CAGXu5j+R7zNkt_e29L4EqY1TFdAUiD6XybyRR6=OOb3tT0-1Dg@mail.gmail.com>
Subject: Re: [resend Patch v3 2/2] export the kernel image size
 KERNEL_IMAGE_SIZE
From: Kees Cook <keescook@chromium.org>
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
Cc: Thomas Deutschmann <whissi@whissi.de>, Andi Kleen <ak@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, kumagai-atsushi@mxc.nes.nec.co.jp, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Ping?

Can someone pull this into x86 tip?

Thanks!

-Kees


On Sun, Feb 1, 2015 at 11:32 PM, Baoquan He <bhe@redhat.com> wrote:
>
> Hi Thomas,
>
> Could you please also merge this patch? Since you have merged this patch
> "x86, boot: Skip relocs when load address unchanged [commit f285f4a21]",
> and this issue was raised because it broke kexec/kdump, then I posted
> these 2 patches. Without this patch makedumpfile will be broken when
> enable kaslr and do the kdump.
>
> Thanks
> Baouqan
>
> On 09/30/2014 03:08 PM, Baoquan He wrote:
>> Now kaslr makes kernel image size changable, not the fixed size 512M.
>> So KERNEL_IMAGE_SIZE need be exported to VMCOREINFO, otherwise makedumfile
>> will crash.
>>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> Acked-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Vivek Goyal <vgoyal@redhat.com>
>> ---
>>  kernel/kexec.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index 2bee072..bd680d3 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -2003,6 +2003,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>>  #endif
>>       VMCOREINFO_NUMBER(PG_head_mask);
>>       VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
>> +#ifdef CONFIG_X86
>> +       VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
>> +#endif
>>  #ifdef CONFIG_HUGETLBFS
>>       VMCOREINFO_SYMBOL(free_huge_page);
>>  #endif
>>
>



-- 
Kees Cook
Chrome OS Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
