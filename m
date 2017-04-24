Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam02on0618.outbound.protection.outlook.com
 ([2a01:111:f400:fe44::618]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d2gZu-0004IF-9v
 for kexec@lists.infradead.org; Mon, 24 Apr 2017 16:11:07 +0000
Subject: Re: [PATCH v5 09/32] x86/mm: Provide general kernel support for
 memory encryption
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211754.10190.25082.stgit@tlendack-t1.amdoffice.net>
 <0106e3fc-9780-e872-2274-fecf79c28923@intel.com>
 <9fc79e28-ad64-1c2f-4c46-a4efcdd550b0@amd.com>
 <67926f62-a068-6114-92ee-39bc08488b32@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <8bb579a0-2855-f311-e087-d97cdd730922@amd.com>
Date: Mon, 24 Apr 2017 11:10:31 -0500
MIME-Version: 1.0
In-Reply-To: <67926f62-a068-6114-92ee-39bc08488b32@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>

On 4/24/2017 10:57 AM, Dave Hansen wrote:
> On 04/24/2017 08:53 AM, Tom Lendacky wrote:
>> On 4/21/2017 4:52 PM, Dave Hansen wrote:
>>> On 04/18/2017 02:17 PM, Tom Lendacky wrote:
>>>> @@ -55,7 +57,7 @@ static inline void copy_user_page(void *to, void
>>>> *from, unsigned long vaddr,
>>>>      __phys_addr_symbol(__phys_reloc_hide((unsigned long)(x)))
>>>>
>>>>  #ifndef __va
>>>> -#define __va(x)            ((void *)((unsigned long)(x)+PAGE_OFFSET))
>>>> +#define __va(x)            ((void *)(__sme_clr(x) + PAGE_OFFSET))
>>>>  #endif
>>>
>>> It seems wrong to be modifying __va().  It currently takes a physical
>>> address, and this modifies it to take a physical address plus the SME
>>> bits.
>>
>> This actually modifies it to be sure the encryption bit is not part of
>> the physical address.
>
> If SME bits make it this far, we have a bug elsewhere.  Right?  Probably
> best not to paper over it.

That all depends on the approach.  Currently that's not the case for
the one situation that you mentioned with cr3.  But if we do take the
approach that we should never feed physical addresses to __va() with
the encryption bit set then, yes, it would imply a bug elsewhere - which
is probably a good approach.

I'll work on that. I could even add a debug config option that would
issue a warning should __va() encounter the encryption bit if SME is
enabled or active.

Thanks,
Tom

>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
