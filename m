Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com
 ([40.107.236.61] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEyip-00ET7B-Fj
 for kexec@lists.infradead.org; Sat, 14 Aug 2021 18:49:35 +0000
Subject: Re: [PATCH v2 02/12] mm: Introduce a function to check for
 virtualization protection features
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <482fe51f1671c1cd081039801b03db7ec0036332.1628873970.git.thomas.lendacky@amd.com>
 <YRgMUHqdH60jDB06@zn.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9279dcd1-ccd9-c187-1b95-8934d1bf298c@amd.com>
Date: Sat, 14 Aug 2021 13:49:20 -0500
In-Reply-To: <YRgMUHqdH60jDB06@zn.tnic>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Joerg Roedel <jroedel@suse.de>

On 8/14/21 1:32 PM, Borislav Petkov wrote:
> On Fri, Aug 13, 2021 at 11:59:21AM -0500, Tom Lendacky wrote:
>> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
>> new file mode 100644
>> index 000000000000..43d4dde94793
>> --- /dev/null
>> +++ b/include/linux/protected_guest.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Protected Guest (and Host) Capability checks
>> + *
>> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
>> + */
>> +
>> +#ifndef _PROTECTED_GUEST_H
>> +#define _PROTECTED_GUEST_H
>> +
>> +#ifndef __ASSEMBLY__
> 	   ^^^^^^^^^^^^^
> 
> Do you really need that guard? It builds fine without it too. Or
> something coming later does need it...?

No, I probably did it out of habit. I can remove it in the next version.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
