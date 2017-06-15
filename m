Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn3nam01on0059.outbound.protection.outlook.com
 ([104.47.33.59] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dLUkX-0000fu-Gh
 for kexec@lists.infradead.org; Thu, 15 Jun 2017 13:23:51 +0000
Subject: Re: [PATCH v6 25/34] swiotlb: Add warnings for use of bounce buffers
 with SME
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191732.28645.42876.stgit@tlendack-t1.amdoffice.net>
 <20170614165052.fyn5t4gkq5leczcc@pd.tnic>
 <33d1debc-c684-cba1-7d95-493678f086d0@amd.com>
 <20170615090832.ncmq2kgom32cchhw@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a6fb0334-42e4-a08f-ac95-f33c48b0711f@amd.com>
Date: Thu, 15 Jun 2017 08:23:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170615090832.ncmq2kgom32cchhw@pd.tnic>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 6/15/2017 4:08 AM, Borislav Petkov wrote:
> On Wed, Jun 14, 2017 at 02:49:02PM -0500, Tom Lendacky wrote:
>> I guess I don't need the sme_active() check since the second part of the
>> if statement can only ever be true if SME is active (since mask is
>> unsigned).
> 
> ... and you can define sme_me_mask as an u64 directly (it is that already,
> practically, as we don't do SME on 32-bit) and then get rid of the cast.

Let me look into that. There are so many places that are expecting an
unsigned long I'll have to see how that all works out from a build
perspective.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
