Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDDS7-0023LG-BJ
 for kexec@lists.infradead.org; Mon, 09 Aug 2021 22:09:00 +0000
Subject: Re: [PATCH 06/11] x86/sev: Replace occurrences of sev_es_active()
 with prot_guest_has()
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <ba565128b88661a656fc3972f01bb2e295158a15.1627424774.git.thomas.lendacky@amd.com>
 <YQfMw2FRO5M1osGF@8bytes.org> <934f3e72-49d1-be56-6fa2-f37a02413fb2@amd.com>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <e63c166f-fd56-4aba-3d4f-b2d10051769a@linux.intel.com>
Date: Mon, 9 Aug 2021 15:08:53 -0700
MIME-Version: 1.0
In-Reply-To: <934f3e72-49d1-be56-6fa2-f37a02413fb2@amd.com>
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
To: Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>



On 8/9/21 2:59 PM, Tom Lendacky wrote:
>> Not sure how TDX will handle AP booting, are you sure it needs this
>> special setup as well? Otherwise a check for SEV-ES would be better
>> instead of the generic PATTR_GUEST_PROT_STATE.
> Yes, I'm not sure either. I figure that change can be made, if needed, as
> part of the TDX support.

We don't plan to set PROT_STATE. So it does not affect TDX.
For SMP, we use MADT ACPI table for AP booting.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
