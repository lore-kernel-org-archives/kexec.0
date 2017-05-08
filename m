Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d7d1L-0002N6-Q9
 for kexec@lists.infradead.org; Mon, 08 May 2017 07:23:53 +0000
Subject: Re: [PATCH v3 2/2] x86_64/kexec: Use PUD level 1GB page for identity
 mapping if available
References: <1493862171-8799-1-git-send-email-xlpang@redhat.com>
 <1493862171-8799-2-git-send-email-xlpang@redhat.com>
 <20170505065253.s5yv7c2cxgfcf4i3@gmail.com> <590C2A96.3090106@redhat.com>
 <20170505092046.2qu72pdherfxjmec@gmail.com> <590C5912.80202@redhat.com>
 <20170508062932.bzg6ck5efarvzqlt@gmail.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <59101D3B.2030606@redhat.com>
Date: Mon, 8 May 2017 15:24:43 +0800
MIME-Version: 1.0
In-Reply-To: <20170508062932.bzg6ck5efarvzqlt@gmail.com>
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
To: Ingo Molnar <mingo@kernel.org>, xlpang@redhat.com
Cc: Yinghai Lu <yinghai@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On 05/08/2017 at 02:29 PM, Ingo Molnar wrote:
> * Xunlei Pang <xpang@redhat.com> wrote:
>
>> On 05/05/2017 at 05:20 PM, Ingo Molnar wrote:
>>> * Xunlei Pang <xpang@redhat.com> wrote:
>>>
>>>> On 05/05/2017 at 02:52 PM, Ingo Molnar wrote:
>>>>> * Xunlei Pang <xlpang@redhat.com> wrote:
>>>>>
>>>>>> @@ -122,6 +122,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>>>>>>  
>>>>>>  	level4p = (pgd_t *)__va(start_pgtable);
>>>>>>  	clear_page(level4p);
>>>>>> +
>>>>>> +	if (direct_gbpages)
>>>>>> +		info.direct_gbpages = true;
>>>>> No, this should be keyed off the CPU feature (X86_FEATURE_GBPAGES) automatically, 
>>>>> not set blindly! AFAICS this patch will crash kexec on any CPU that does not 
>>>>> support gbpages.
>>>> It should be fine, probe_page_size_mask() already takes care of this:
>>>>     if (direct_gbpages && boot_cpu_has(X86_FEATURE_GBPAGES)) {
>>>>         printk(KERN_INFO "Using GB pages for direct mapping\n");
>>>>         page_size_mask |= 1 << PG_LEVEL_1G;
>>>>     } else {
>>>>         direct_gbpages = 0;
>>>>     }
>>>>
>>>> So if X86_FEATURE_GBPAGES is not supported, direct_gbpages will be set to 0.
>>> So why is the introduction of the info.direct_gbpages flag necessary? AFAICS it 
>>> just duplicates the kernel's direct_gbpages flag. One outcome is that hibernation 
>>> won't use gbpages, which is silly.
>> boot/compressed/pagetable.c also uses kernel_ident_mapping_init() for kaslr, at 
>> the moment we don't have "direct_gbpages" definition or X86_FEATURE_GBPAGES 
>> feature detection.
>>
>> I thought that we can change the other call sites when found really needed.
> Ok, you are right - I'll use the original patches as submitted, with the updated 
> changelogs.

Thanks!

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
