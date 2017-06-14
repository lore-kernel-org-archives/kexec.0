Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm3nam03on0083.outbound.protection.outlook.com
 ([104.47.41.83] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dLBvM-0000nx-1m
 for kexec@lists.infradead.org; Wed, 14 Jun 2017 17:17:45 +0000
Subject: Re: [PATCH v6 20/34] x86, mpparse: Use memremap to map the mpf and
 mpc data
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191643.28645.91679.stgit@tlendack-t1.amdoffice.net>
 <20170614160754.c4ywbf5ktqwgc4ij@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <86f31710-76d0-5fee-f4a7-8cdb4b9b9a8e@amd.com>
Date: Wed, 14 Jun 2017 12:06:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170614160754.c4ywbf5ktqwgc4ij@pd.tnic>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 6/14/2017 11:07 AM, Borislav Petkov wrote:
> On Wed, Jun 07, 2017 at 02:16:43PM -0500, Tom Lendacky wrote:
>> The SMP MP-table is built by UEFI and placed in memory in a decrypted
>> state. These tables are accessed using a mix of early_memremap(),
>> early_memunmap(), phys_to_virt() and virt_to_phys(). Change all accesses
>> to use early_memremap()/early_memunmap(). This allows for proper setting
>> of the encryption mask so that the data can be successfully accessed when
>> SME is active.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/kernel/mpparse.c |   98 ++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 70 insertions(+), 28 deletions(-)
> 
> ...
> 
>> @@ -515,6 +516,12 @@ void __init default_get_smp_config(unsigned int early)
>>   	if (acpi_lapic && acpi_ioapic)
>>   		return;
>>   
>> +	mpf = early_memremap(mpf_base, sizeof(*mpf));
>> +	if (!mpf) {
>> +		pr_err("MPTABLE: mpf early_memremap() failed\n");
> 
> If you're going to introduce new prefixes then add:

This isn't new...  there are a number of messages issued in this file
with that prefix, so I was just following convention.  Changing the
prefix could be a follow-on patch.

> 
> #undef pr_fmt
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> at the beginning of the file so that they all say "mpparse:" instead.
> 
> And pls make that message more user-friendly: "Error mapping MP table"
> or so.

Can do.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
