Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam08on2044.outbound.protection.outlook.com
 ([40.107.102.44] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m96xl-004WKn-Qy
 for kexec@lists.infradead.org; Thu, 29 Jul 2021 14:24:44 +0000
Subject: Re: [PATCH 02/11] x86/sev: Add an x86 version of prot_guest_has()
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <b3e929a77303dd47fd2adc2a1011009d3bfcee20.1627424774.git.thomas.lendacky@amd.com>
 <YQFaM7nOhD2d6SUQ@infradead.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9f371091-7f73-8f60-e537-166984c650c1@amd.com>
Date: Thu, 29 Jul 2021 09:24:34 -0500
In-Reply-To: <YQFaM7nOhD2d6SUQ@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, Thomas Gleixner <tglx@linutronix.de>

On 7/28/21 8:22 AM, Christoph Hellwig wrote:
> On Tue, Jul 27, 2021 at 05:26:05PM -0500, Tom Lendacky via iommu wrote:
>> Introduce an x86 version of the prot_guest_has() function. This will be
>> used in the more generic x86 code to replace vendor specific calls like
>> sev_active(), etc.
>>
>> While the name suggests this is intended mainly for guests, it will
>> also be used for host memory encryption checks in place of sme_active().
>>
>> The amd_prot_guest_has() function does not use EXPORT_SYMBOL_GPL for the
>> same reasons previously stated when changing sme_active(), sev_active and
> 
> None of that applies here as none of the callers get pulled into
> random macros.  The only case of that is sme_me_mask through
> sme_mask, but that's not something this series replaces as far as I can
> tell.

Ok, let me make sure of that and I'll change to EXPORT_SYMBOL_GPL if
that's the case.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
