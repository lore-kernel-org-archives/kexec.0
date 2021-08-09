Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam11on2076.outbound.protection.outlook.com
 ([40.107.220.76] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDDFa-00229o-DE
 for kexec@lists.infradead.org; Mon, 09 Aug 2021 21:56:06 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <YQR+ffO92gMfGDbs@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a8a6a63e-3bb7-47a1-1427-55633f1bf211@amd.com>
Date: Mon, 9 Aug 2021 16:55:53 -0500
In-Reply-To: <YQR+ffO92gMfGDbs@google.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>

On 7/30/21 5:34 PM, Sean Christopherson wrote:
> On Tue, Jul 27, 2021, Tom Lendacky wrote:
>> @@ -451,7 +450,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
>>  	 * The unused memory range was mapped decrypted, change the encryption
>>  	 * attribute from decrypted to encrypted before freeing it.
>>  	 */
>> -	if (mem_encrypt_active()) {
>> +	if (sme_me_mask) {
> 
> Any reason this uses sme_me_mask?  The helper it calls, __set_memory_enc_dec(),
> uses prot_guest_has(PATTR_MEM_ENCRYPT) so I assume it's available?

Probably just a slip on my part. I was debating at one point calling the
helper vs. referencing the variables/functions directly in the
mem_encrypt.c file.

Thanks,
Tom

> 
>>  		r = set_memory_encrypted(vaddr, npages);
>>  		if (r) {
>>  			pr_warn("failed to free unused decrypted pages\n");
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
