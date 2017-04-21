Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com
 ([104.47.41.54] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d1gIZ-00050x-U1
 for kexec@lists.infradead.org; Fri, 21 Apr 2017 21:41:05 +0000
Subject: Re: [PATCH v5 07/32] x86/mm: Add support to enable SME in early boot
 processing
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211735.10190.29562.stgit@tlendack-t1.amdoffice.net>
 <20170421145555.v3xeaijv3vjclsos@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0b455224-f73e-d6f6-45c2-336178a89071@amd.com>
Date: Fri, 21 Apr 2017 16:40:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170421145555.v3xeaijv3vjclsos@pd.tnic>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 4/21/2017 9:55 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:17:35PM -0500, Tom Lendacky wrote:
>> Add support to the early boot code to use Secure Memory Encryption (SME).
>> Since the kernel has been loaded into memory in a decrypted state, support
>> is added to encrypt the kernel in place and update the early pagetables
>
> s/support is added to //

Done.

Thanks,
Tom

>
>> with the memory encryption mask so that new pagetable entries will use
>> memory encryption.
>>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
