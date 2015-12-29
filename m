Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aDs2v-0002Ba-AJ
 for kexec@lists.infradead.org; Tue, 29 Dec 2015 11:02:30 +0000
Subject: Re: [PATCH 2/2] kexec: Provide
 arch_kexec_protect(unprotect)_crashkres()
References: <1450869146-6186-1-git-send-email-xlpang@redhat.com>
 <1450869146-6186-2-git-send-email-xlpang@redhat.com>
 <20151224055425.GC3480@dhcp-128-65.nay.redhat.com>
 <567B8B44.9070807@redhat.com>
 <20151224061616.GD3480@dhcp-128-65.nay.redhat.com>
 <567B9444.1050608@redhat.com> <5680D780.4070709@redhat.com>
 <20151228121438.GA31802@dhcp-128-25.nay.redhat.com>
From: Xunlei Pang <xlpang@redhat.com>
Message-ID: <5682682C.1070206@redhat.com>
Date: Tue, 29 Dec 2015 19:02:04 +0800
MIME-Version: 1.0
In-Reply-To: <20151228121438.GA31802@dhcp-128-25.nay.redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On 12/28/2015 at 08:14 PM, Minfei Huang wrote:
> On 12/28/15 at 02:32pm, Xunlei Pang wrote:
>> On 12/24/2015 at 02:44 PM, Xunlei Pang wrote:
>>>>>>> +static void kexec_mark_crashkres(bool protect)
>>>>>>> +{
>>>>>>> +	unsigned long control;
>>>>>>> +
>>>>>>> +	kexec_mark_range(crashk_low_res.start, crashk_low_res.end, protect);
>>>>>>> +
>>>>>>> +	/* Don't touch the control code page used in crash_kexec().*/
>>>>>>> +	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
>>>>>>> +	/* Control code page is located in the 2nd page. */
>>>>>>> +	control = control + PAGE_SIZE;
>>>> Though it works because the control code is less than 1 page, but use the macro
>>>> of KEXEC_CONTROL_PAGE_SIZE looks better..
>> The 1st page is pagetable, control code page locates at the 2nd page.
>> The following kexec_mark_range() wants to mark ro from crashk_res.start
>> to the 1st page(included), so here we must use PAGE_SIZE.
>>
>>>>>>> +	kexec_mark_range(crashk_res.start, control - 1, protect);
>>>>>>> +	kexec_mark_range(control + PAGE_SIZE, crashk_res.end, protect);
>>>>>> X86 kexec will copy the page while kexecing, could you check if we can move
>>>>>> that copying to earliyer while kexec loading, maybe machine_kexec_prepare so
>>>>>> that we can make a arch-independent implementation.
>>>>> For some arch, may use huge tlb directly to do the kernel mapping,
>>>>> in such cases, we can't implement this function. So I think it should
>>>>> be arch-dependent.
>>>> Ok, that's fine.
>>> At least moving the x86 control-copying code into arch-related
>>> machine_kexec_prepare() should work, and this can omit the
>>> special treatment of the control code page.
>> The "relocate_kernel" routine in "relocate_kernel_64.S" will use it as
>> a temp storage "for jumping back"(as its comment), so we can't mark
>> it readonly.
> kexec will copy the relocate_kernel binary to control_code_page in
> function machine_kexec. This is a major reason to set the region
> control_code_page to control_code_page + PAGE_SIZE with mode read/write.

Yes, I mean after avoiding this copy by  moving the x86 control-copying
code into arch-related machine_kexec_prepare(), we still can't mark it
readonly because of its temp storage role.

Of course we can still do that by setting its kernel pte to rwx and do a
local tlb invalidation when crash_kexec(), but I think we can simply leave
that alone, since its content is meaningless before crash happens where
the code is copied into it. Unless you want to capture the wrong kernel
operations that only write to this reserved page.

Regards,
Xunlei

>
> Thanks
> Minfei
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
