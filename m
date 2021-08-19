Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam11on2050.outbound.protection.outlook.com
 ([40.107.220.50] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGl5K-008zFU-Sc
 for kexec@lists.infradead.org; Thu, 19 Aug 2021 16:40:12 +0000
Subject: Re: [PATCH v2 02/12] mm: Introduce a function to check for
 virtualization protection features
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <482fe51f1671c1cd081039801b03db7ec0036332.1628873970.git.thomas.lendacky@amd.com>
 <YR4ohWC4/cLsuCvv@infradead.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f367b8bd-6f82-5aa3-a27c-7a19959ab435@amd.com>
Date: Thu, 19 Aug 2021 11:39:57 -0500
In-Reply-To: <YR4ohWC4/cLsuCvv@infradead.org>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Joerg Roedel <jroedel@suse.de>

On 8/19/21 4:46 AM, Christoph Hellwig wrote:
> On Fri, Aug 13, 2021 at 11:59:21AM -0500, Tom Lendacky wrote:
>> +#define PATTR_MEM_ENCRYPT		0	/* Encrypted memory */
>> +#define PATTR_HOST_MEM_ENCRYPT		1	/* Host encrypted memory */
>> +#define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
>> +#define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
> 
> Please write an actual detailed explanaton of what these mean, that
> is what implications it has on the kernel.

Will do.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
