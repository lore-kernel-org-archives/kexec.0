Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com
 ([40.107.244.77] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDDIe-0022Za-6C
 for kexec@lists.infradead.org; Mon, 09 Aug 2021 21:59:16 +0000
Subject: Re: [PATCH 06/11] x86/sev: Replace occurrences of sev_es_active()
 with prot_guest_has()
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <ba565128b88661a656fc3972f01bb2e295158a15.1627424774.git.thomas.lendacky@amd.com>
 <YQfMw2FRO5M1osGF@8bytes.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <934f3e72-49d1-be56-6fa2-f37a02413fb2@amd.com>
Date: Mon, 9 Aug 2021 16:59:00 -0500
In-Reply-To: <YQfMw2FRO5M1osGF@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

On 8/2/21 5:45 AM, Joerg Roedel wrote:
> On Tue, Jul 27, 2021 at 05:26:09PM -0500, Tom Lendacky wrote:
>> @@ -48,7 +47,7 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
>>  	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
>>  		th->flags |= TH_FLAGS_SME_ACTIVE;
>>  
>> -	if (sev_es_active()) {
>> +	if (prot_guest_has(PATTR_GUEST_PROT_STATE)) {
>>  		/*
>>  		 * Skip the call to verify_cpu() in secondary_startup_64 as it
>>  		 * will cause #VC exceptions when the AP can't handle them yet.
> 
> Not sure how TDX will handle AP booting, are you sure it needs this
> special setup as well? Otherwise a check for SEV-ES would be better
> instead of the generic PATTR_GUEST_PROT_STATE.

Yes, I'm not sure either. I figure that change can be made, if needed, as
part of the TDX support.

Thanks,
Tom

> 
> Regards,
> 
> Joerg
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
