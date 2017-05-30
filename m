Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam03on0061.outbound.protection.outlook.com
 ([104.47.40.61] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dFiIv-0006dR-M0
 for kexec@lists.infradead.org; Tue, 30 May 2017 14:39:27 +0000
Subject: Re: [PATCH v5 32/32] x86/mm: Add support to make use of Secure Memory
 Encryption
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212223.10190.85121.stgit@tlendack-t1.amdoffice.net>
 <20170519112703.voajtn4t7uy6nwa3@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <7c522f65-c5c8-9362-e1eb-d0765e3ea6c9@amd.com>
Date: Tue, 30 May 2017 09:38:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170519112703.voajtn4t7uy6nwa3@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 5/19/2017 6:27 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:22:23PM -0500, Tom Lendacky wrote:
>> Add support to check if SME has been enabled and if memory encryption
>> should be activated (checking of command line option based on the
>> configuration of the default state).  If memory encryption is to be
>> activated, then the encryption mask is set and the kernel is encrypted
>> "in place."
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/kernel/head_64.S |    1 +
>>   arch/x86/mm/mem_encrypt.c |   83 +++++++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 80 insertions(+), 4 deletions(-)
> 
> ...
> 
>> +unsigned long __init sme_enable(struct boot_params *bp)
>>   {
>> +	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
>> +	unsigned int eax, ebx, ecx, edx;
>> +	unsigned long me_mask;
>> +	bool active_by_default;
>> +	char buffer[16];
>> +	u64 msr;
>> +
>> +	/* Check for the SME support leaf */
>> +	eax = 0x80000000;
>> +	ecx = 0;
>> +	native_cpuid(&eax, &ebx, &ecx, &edx);
>> +	if (eax < 0x8000001f)
>> +		goto out;
>> +
>> +	/*
>> +	 * Check for the SME feature:
>> +	 *   CPUID Fn8000_001F[EAX] - Bit 0
>> +	 *     Secure Memory Encryption support
>> +	 *   CPUID Fn8000_001F[EBX] - Bits 5:0
>> +	 *     Pagetable bit position used to indicate encryption
>> +	 */
>> +	eax = 0x8000001f;
>> +	ecx = 0;
>> +	native_cpuid(&eax, &ebx, &ecx, &edx);
>> +	if (!(eax & 1))
>> +		goto out;
> 
> <---- newline here.
> 
>> +	me_mask = 1UL << (ebx & 0x3f);
>> +
>> +	/* Check if SME is enabled */
>> +	msr = __rdmsr(MSR_K8_SYSCFG);
>> +	if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
>> +		goto out;
>> +
>> +	/*
>> +	 * Fixups have not been applied to phys_base yet, so we must obtain
>> +	 * the address to the SME command line option data in the following
>> +	 * way.
>> +	 */
>> +	asm ("lea sme_cmdline_arg(%%rip), %0"
>> +	     : "=r" (cmdline_arg)
>> +	     : "p" (sme_cmdline_arg));
>> +	asm ("lea sme_cmdline_on(%%rip), %0"
>> +	     : "=r" (cmdline_on)
>> +	     : "p" (sme_cmdline_on));
>> +	asm ("lea sme_cmdline_off(%%rip), %0"
>> +	     : "=r" (cmdline_off)
>> +	     : "p" (sme_cmdline_off));
>> +
>> +	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
>> +		active_by_default = true;
>> +	else
>> +		active_by_default = false;
>> +
>> +	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
>> +				     ((u64)bp->ext_cmd_line_ptr << 32));
>> +
>> +	cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer));
>> +
>> +	if (strncmp(buffer, cmdline_on, sizeof(buffer)) == 0)
>> +		sme_me_mask = me_mask;
> 
> Why doesn't simply
> 
> 	if (!strncmp(buffer, "on", 2))
> 		...
> 
> work?

In this case we're running identity mapped and the "on" constant ends up
as kernel address (0xffffffff81...) which results in a segfault.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
