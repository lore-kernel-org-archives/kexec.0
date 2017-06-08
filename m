Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn3nam01on0064.outbound.protection.outlook.com
 ([104.47.33.64] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dJ05R-00088I-D9
 for kexec@lists.infradead.org; Thu, 08 Jun 2017 16:15:15 +0000
Subject: Re: [PATCH v6 00/34] x86: Secure Memory Encryption (AMD)
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <CAOcCaLYWoOu0c-Fkee-=wegNqkzUp9pLFLmaFrXuhiXRnUZ3Xw@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <2dd424fe-0af1-d82f-b608-271ea5e1f62b@amd.com>
Date: Thu, 8 Jun 2017 11:14:38 -0500
MIME-Version: 1.0
In-Reply-To: <CAOcCaLYWoOu0c-Fkee-=wegNqkzUp9pLFLmaFrXuhiXRnUZ3Xw@mail.gmail.com>
Content-Language: en-US
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
To: Nick Sarnie <commendsarnex@gmail.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>

On 6/7/2017 9:40 PM, Nick Sarnie wrote:
> On Wed, Jun 7, 2017 at 3:13 PM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>> This patch series provides support for AMD's new Secure Memory Encryption (SME)
>> feature.
>>
>> SME can be used to mark individual pages of memory as encrypted through the
>> page tables. A page of memory that is marked encrypted will be automatically
>> decrypted when read from DRAM and will be automatically encrypted when
>> written to DRAM. Details on SME can found in the links below.
>>
>> The SME feature is identified through a CPUID function and enabled through
>> the SYSCFG MSR. Once enabled, page table entries will determine how the
>> memory is accessed. If a page table entry has the memory encryption mask set,
>> then that memory will be accessed as encrypted memory. The memory encryption
>> mask (as well as other related information) is determined from settings
>> returned through the same CPUID function that identifies the presence of the
>> feature.
>>
>> The approach that this patch series takes is to encrypt everything possible
>> starting early in the boot where the kernel is encrypted. Using the page
>> table macros the encryption mask can be incorporated into all page table
>> entries and page allocations. By updating the protection map, userspace
>> allocations are also marked encrypted. Certain data must be accounted for
>> as having been placed in memory before SME was enabled (EFI, initrd, etc.)
>> and accessed accordingly.
>>
>> This patch series is a pre-cursor to another AMD processor feature called
>> Secure Encrypted Virtualization (SEV). The support for SEV will build upon
>> the SME support and will be submitted later. Details on SEV can be found
>> in the links below.
>>
>> The following links provide additional detail:
>>
>> AMD Memory Encryption whitepaper:
>>     http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
>>
>> AMD64 Architecture Programmer's Manual:
>>     http://support.amd.com/TechDocs/24593.pdf
>>     SME is section 7.10
>>     SEV is section 15.34
>>
>> ---
>>

...

> 
> 
> Hi Tom,
> 
> Thanks for your work on this. This may be a stupid question, but is
> using bounce buffers for the GPU(s) expected to reduce performance in
> any/a noticeable way? I'm hitting another issue which I've already
> sent mail about so I can't test it for myself at the moment,

That all depends on the workload, how much DMA is being performed, etc.
But it is extra overhead to use bounce buffers.

Thanks,
Tom

> 
> Thanks,
> Sarnex
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
