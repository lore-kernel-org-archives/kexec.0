Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam03on0051.outbound.protection.outlook.com
 ([104.47.40.51] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dFjON-0005Bg-FG
 for kexec@lists.infradead.org; Tue, 30 May 2017 15:49:08 +0000
Subject: Re: [PATCH v5 32/32] x86/mm: Add support to make use of Secure Memory
 Encryption
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212223.10190.85121.stgit@tlendack-t1.amdoffice.net>
 <c29edaff-24f2-ee9b-4142-bdbf8c42083f@amd.com>
 <20170519113005.3f5kwzg4pgh7j6a5@pd.tnic>
 <20170519201651.dhayf2pwjlsnouz4@treble>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1ac40d18-a8b2-94eb-35ed-c30768667be8@amd.com>
Date: Tue, 30 May 2017 10:48:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170519201651.dhayf2pwjlsnouz4@treble>
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
To: Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 5/19/2017 3:16 PM, Josh Poimboeuf wrote:
> On Fri, May 19, 2017 at 01:30:05PM +0200, Borislav Petkov wrote:
>>> it is called so early. I can get past it by adding:
>>>
>>> CFLAGS_mem_encrypt.o := $(nostackp)
>>>
>>> in the arch/x86/mm/Makefile, but that obviously eliminates the support
>>> for the whole file.  Would it be better to split out the sme_enable()
>>> and other boot routines into a separate file or just apply the
>>> $(nostackp) to the whole file?
>>
>> Josh might have a better idea here... CCed.
> 
> I'm the stack validation guy, not the stack protection guy :-)
> 
> But there is a way to disable compiler options on a per-function basis
> with the gcc __optimize__ function attribute.  For example:
> 
>    __attribute__((__optimize__("no-stack-protector")))
> 

I'll look at doing that instead of removing the support for the whole
file.

Thanks,
Tom

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
