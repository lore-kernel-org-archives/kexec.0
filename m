Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam03on0076.outbound.protection.outlook.com
 ([104.47.42.76] helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNffG-0003hw-6e
 for kexec@lists.infradead.org; Wed, 21 Jun 2017 13:27:23 +0000
Subject: Re: [PATCH v7 06/36] x86/mm: Add Secure Memory Encryption (SME)
 support
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185054.18967.52228.stgit@tlendack-t1.amdoffice.net>
 <alpine.DEB.2.20.1706202244480.2157@nanos>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <efa51470-5d8f-6883-b9da-f2face12ea22@amd.com>
Date: Wed, 21 Jun 2017 08:26:44 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1706202244480.2157@nanos>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>

On 6/20/2017 3:49 PM, Thomas Gleixner wrote:
> On Fri, 16 Jun 2017, Tom Lendacky wrote:
>>   
>> +config ARCH_HAS_MEM_ENCRYPT
>> +	def_bool y
>> +	depends on X86
> 
> That one is silly. The config switch is in the x86 KConfig file, so X86 is
> on. If you intended to move this to some generic place outside of
> x86/Kconfig then this should be
> 
> config ARCH_HAS_MEM_ENCRYPT
> 	bool
> 
> and x86/Kconfig should have
> 
>      	select ARCH_HAS_MEM_ENCRYPT
> 
> and that should be selected by AMD_MEM_ENCRYPT

This is used for deciding whether to include the asm/mem_encrypt.h file
so it needs to be on whether AMD_MEM_ENCRYPT is configured or not. I'll
leave it in the x86/Kconfig file and remove the depends on line.

Thanks,
Tom

> 
>> +config AMD_MEM_ENCRYPT
>> +	bool "AMD Secure Memory Encryption (SME) support"
>> +	depends on X86_64 && CPU_SUP_AMD
>> +	---help---
>> +	  Say yes to enable support for the encryption of system memory.
>> +	  This requires an AMD processor that supports Secure Memory
>> +	  Encryption (SME).
> 
> Thanks,
> 
> 	tglx
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
