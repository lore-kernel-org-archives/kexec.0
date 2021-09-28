Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVKEi-008oOo-I9
 for kexec@lists.infradead.org; Tue, 28 Sep 2021 21:02:01 +0000
Subject: Re: [PATCH v4 0/8] Implement generic cc_platform_has() helper function
References: <20210928191009.32551-1-bp@alien8.de>
 <80593893-c63b-d481-45f1-42a3a6fd762a@linux.intel.com>
 <YVN7vPE/7jecXcJ/@zn.tnic>
 <7319b756-55dc-c4d1-baf6-4686f0156ac4@linux.intel.com>
 <YVOB3mFV1Kj3MXAs@zn.tnic>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <695a3bf6-5382-68df-3ab5-8841b777fca2@linux.intel.com>
Date: Tue, 28 Sep 2021 14:01:57 -0700
MIME-Version: 1.0
In-Reply-To: <YVOB3mFV1Kj3MXAs@zn.tnic>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Young <dyoung@redhat.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <hca@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@infradead.org>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org



On 9/28/21 1:58 PM, Borislav Petkov wrote:
> On Tue, Sep 28, 2021 at 01:48:46PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> Just read it. If you want to use cpuid_has_tdx_guest() directly in
>> cc_platform_has(), then you want to rename intel_cc_platform_has() to
>> tdx_cc_platform_has()?
> 
> Why?
> 
> You simply do:
> 
> 	if (cpuid_has_tdx_guest())
> 		intel_cc_platform_has(...);
> 
> and lemme paste from that mail: " ...you should use
> cpuid_has_tdx_guest() instead but cache its result so that you don't
> call CPUID each time the kernel executes cc_platform_has()."
> 
> Makes sense?

Yes. But, since the check is related to TDX, I just want to confirm whether
you are fine with naming the function as intel_*().

Since this patch is going to have dependency on TDX code, I will include
this patch in TDX patch set.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
