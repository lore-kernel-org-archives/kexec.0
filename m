Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQwGx-00CBVG-FU
 for kexec@lists.infradead.org; Thu, 16 Sep 2021 18:38:13 +0000
Subject: Re: [PATCH v3 0/8] Implement generic cc_platform_has() helper function
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <YUIjS6lKEY5AadZx@zn.tnic>
 <d48e6a17-d2b4-67da-56d1-fc9a61dfe2b8@linux.intel.com>
 <YUNckGH0+KXdEmqu@zn.tnic>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9fee1cec-fc91-f87d-d590-5e606211f1b7@linux.intel.com>
Date: Thu, 16 Sep 2021 11:38:04 -0700
MIME-Version: 1.0
In-Reply-To: <YUNckGH0+KXdEmqu@zn.tnic>
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@infradead.org>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <dyoung@redhat.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>



On 9/16/21 8:02 AM, Borislav Petkov wrote:
> On Wed, Sep 15, 2021 at 10:26:06AM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> I have a Intel variant patch (please check following patch). But it includes
>> TDX changes as well. Shall I move TDX changes to different patch and just
>> create a separate patch for adding intel_cc_platform_has()?
> 
> Yes, please, so that I can expedite that stuff separately and so that it
> can go in early in order for future work to be based ontop.

Sent it part of TDX patch series. Please check and cherry pick it.

https://lore.kernel.org/lkml/20210916183550.15349-2-sathyanarayanan.kuppuswamy@linux.intel.com/

> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
