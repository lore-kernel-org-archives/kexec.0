Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm3nam03on0067.outbound.protection.outlook.com
 ([104.47.41.67] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dajZw-0000hd-IR
 for kexec@lists.infradead.org; Thu, 27 Jul 2017 14:15:54 +0000
Subject: Re: [PATCH v1 1/2] x86/mm, kexec: Fix memory corruption with SME on
 successive kexecs
References: <cover.1501092102.git.thomas.lendacky@amd.com>
 <28648b23b9957506069e20bd985e3d7e8af94780.1501092102.git.thomas.lendacky@amd.com>
 <20170727071717.aydwpzaji6l2o6xs@gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <62566e96-4e05-1622-bf3c-bf392506e84b@amd.com>
Date: Thu, 27 Jul 2017 09:15:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170727071717.aydwpzaji6l2o6xs@gmail.com>
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
To: Ingo Molnar <mingo@kernel.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On 7/27/2017 2:17 AM, Ingo Molnar wrote:
> 
> * Tom Lendacky <thomas.lendacky@amd.com> wrote:
> 
>> After issuing successive kexecs it was found that the SHA hash failed
>> verification when booting the kexec'd kernel.  When SME is enabled, the
>> change from using pages that were marked encrypted to now being marked as
>> not encrypted (through new identify mapped page tables) results in memory
>> corruption if there are any cache entries for the previously encrypted
>> pages. This is because separate cache entries can exist for the same
>> physical location but tagged both with and without the encryption bit.
>>
>> To prevent this, issue a wbinvd before copying the pages from the source
>> location to the destination location to clear any possible cache entry
>> conflicts.
>>
>> Cc: <kexec@lists.infradead.org>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/kernel/relocate_kernel_64.S | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
>> index 98111b3..c11d8bc 100644
>> --- a/arch/x86/kernel/relocate_kernel_64.S
>> +++ b/arch/x86/kernel/relocate_kernel_64.S
>> @@ -132,6 +132,13 @@ identity_mapped:
>>   	/* Flush the TLB (needed?) */
>>   	movq	%r9, %cr3
>>   
>> +	/*
>> +	 * If SME is/was active, there could be old encrypted cache line
>> +	 * entries that will conflict with the now unencrypted memory
>> +	 * used by kexec. Flush the caches before copying the kernel.
>> +	 */
>> +	wbinvd
> 
> WBINVD is very expensive IIRC - several milliseconds.
> 
> So if we change the page table from encrypted to unencrypted we need to do a full
> cache flush sounds pretty broken to me - how can then this be done via an API such
> as mmap() without executing WBINVD?

The hardware doesn't enforce coherency between encrypted and unencrypted
mappings of the same physical page[1].  There are APIs that will perform
a targeted cache flush when changing the encryption bit associated with
a page table entry (set_memory_encrypted()/set_memory_decrypted()) and
don't require a full cache flush. But in the case of kexec, there is a
wholesale change of the page tables from what was active to the new
identity mapped tables without any way to know what was previously
mapped and whether it was previously mapped as encrypted or unencrypted.
In this case I don't think an API such as mmap() will help.  For SME, we
will need to be sure the cache is flushed to avoid any coherency issues.

I can #ifdef the wbinvd based on whether AMD_MEM_ENCRYPT is configured
or not so that the wbinvd is avoided if not configured.

Thanks,
Tom

[1] http://support.amd.com/TechDocs/24593.pdf (Section 7.10.6)

> 
> Thanks,
> 
> 	Ingo
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
