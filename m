Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com
 ([40.107.223.59] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG0va-002nhq-Or
 for kexec@lists.infradead.org; Tue, 17 Aug 2021 15:23:02 +0000
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
 <YRgUxyhoqVJ0Kxvt@zn.tnic> <4710eb91-d054-7b31-5106-09e3e54bba9e@amd.com>
 <YRknDQGUJJ/j9pth@zn.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f4b8bc3c-5158-cd04-6e12-77f08036ea19@amd.com>
Date: Tue, 17 Aug 2021 10:22:52 -0500
In-Reply-To: <YRknDQGUJJ/j9pth@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <jroedel@suse.de>

On 8/15/21 9:39 AM, Borislav Petkov wrote:
> On Sun, Aug 15, 2021 at 08:53:31AM -0500, Tom Lendacky wrote:
>> It's not a cross-vendor thing as opposed to a KVM or other hypervisor
>> thing where the family doesn't have to be reported as AMD or HYGON.
> 
> What would be the use case? A HV starts a guest which is supposed to be
> encrypted using the AMD's confidential guest technology but the HV tells
> the guest that it is not running on an AMD SVM HV but something else?
> 
> Is that even an actual use case?
> 
> Or am I way off?
> 
> I know we have talked about this in the past but this still sounds
> insane.

Maybe the KVM folks have a better understanding of it...

I can change it to be an AMD/HYGON check...  although, I'll have to check
to see if any (very) early use of the function will work with that.

At a minimum, the check in arch/x86/kernel/head64.c will have to be
changed or removed. I'll take a closer look.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
