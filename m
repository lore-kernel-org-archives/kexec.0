Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0075.outbound.protection.outlook.com
 ([104.47.34.75] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d1Fty-0001oL-1G
 for kexec@lists.infradead.org; Thu, 20 Apr 2017 17:29:56 +0000
Subject: Re: [PATCH v5 05/32] x86/CPU/AMD: Handle SME reduction in physical
 address size
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211711.10190.30861.stgit@tlendack-t1.amdoffice.net>
 <20170420165922.j2inlwbchrs6senw@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <aaa52e93-5875-6033-e72f-8fc3de43ca3a@amd.com>
Date: Thu, 20 Apr 2017 12:29:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170420165922.j2inlwbchrs6senw@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 4/20/2017 11:59 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:17:11PM -0500, Tom Lendacky wrote:
>> When System Memory Encryption (SME) is enabled, the physical address
>> space is reduced. Adjust the x86_phys_bits value to reflect this
>> reduction.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/kernel/cpu/amd.c |   14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> ...
>
>> @@ -622,8 +624,14 @@ static void early_init_amd(struct cpuinfo_x86 *c)
>>
>>  			/* Check if SME is enabled */
>>  			rdmsrl(MSR_K8_SYSCFG, msr);
>> -			if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
>> +			if (msr & MSR_K8_SYSCFG_MEM_ENCRYPT) {
>> +				unsigned int ebx;
>> +
>> +				ebx = cpuid_ebx(0x8000001f);
>> +				c->x86_phys_bits -= (ebx >> 6) & 0x3f;
>> +			} else {
>>  				clear_cpu_cap(c, X86_FEATURE_SME);
>> +			}
>
> Lemme do some simplifying to save an indent level, get rid of local var
> ebx and kill some { }-brackets for a bit better readability:
>
>         if (c->extended_cpuid_level >= 0x8000001f) {
>                 u64 msr;
>
>                 if (!cpu_has(c, X86_FEATURE_SME))
>                         return;
>
>                 /* Check if SME is enabled */
>                 rdmsrl(MSR_K8_SYSCFG, msr);
>                 if (msr & MSR_K8_SYSCFG_MEM_ENCRYPT)
>                         c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
>                 else
>                         clear_cpu_cap(c, X86_FEATURE_SME);
>         }
>

Hmmm... and actually if cpu_has(X86_FEATURE_SME) is true then it's a
given that extended_cpuid_level >= 0x8000001f.  So this can be
simplified to just:

	if (cpu_has(c, X86_FEATURE_SME)) {
		... the rest of your suggestion (minus cpu_has()) ...
	}

Thanks,
Tom

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
