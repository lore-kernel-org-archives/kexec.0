Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com
 ([40.107.94.85] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEag7-00DDRV-7w
 for kexec@lists.infradead.org; Fri, 13 Aug 2021 17:09:13 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
 <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
 <0a819549-e481-c004-7da8-82ba427b13ce@amd.com>
 <20210812100724.t4cdh7xbkuqgnsc3@box.shutemov.name>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <943223d5-5949-6aba-8a49-0b07078d68e1@amd.com>
Date: Fri, 13 Aug 2021 12:08:59 -0500
In-Reply-To: <20210812100724.t4cdh7xbkuqgnsc3@box.shutemov.name>
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
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>

On 8/12/21 5:07 AM, Kirill A. Shutemov wrote:
> On Wed, Aug 11, 2021 at 10:52:55AM -0500, Tom Lendacky wrote:
>> On 8/11/21 7:19 AM, Kirill A. Shutemov wrote:
>>> On Tue, Aug 10, 2021 at 02:48:54PM -0500, Tom Lendacky wrote:
>>>> On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
...
>>> Looking at code agains, now I *think* the reason is accessing a global
>>> variable from __startup_64() inside TDX version of prot_guest_has().
>>>
>>> __startup_64() is special. If you access any global variable you need to
>>> use fixup_pointer(). See comment before __startup_64().
>>>
>>> I'm not sure how you get away with accessing sme_me_mask directly from
>>> there. Any clues? Maybe just a luck and complier generates code just right
>>> for your case, I donno.
>>
>> Hmm... yeah, could be that the compiler is using rip-relative addressing
>> for it because it lives in the .data section?
> 
> I guess. It has to be fixed. It may break with complier upgrade or any
> random change around the code.

I'll look at doing that separate from this series.

> 
> BTW, does it work with clang for you?

I haven't tried with clang, I'll check on that.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
