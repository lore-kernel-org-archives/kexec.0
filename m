Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bl2nam02on0625.outbound.protection.outlook.com
 ([2a01:111:f400:fe46::625]
 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dJ6Ti-0002f9-TC
 for kexec@lists.infradead.org; Thu, 08 Jun 2017 23:04:36 +0000
Subject: Re: [PATCH v6 25/34] swiotlb: Add warnings for use of bounce buffers
 with SME
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191732.28645.42876.stgit@tlendack-t1.amdoffice.net>
 <20170608075829.GA2446@infradead.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <8d78db0c-7c3e-9304-7d04-31095246ec83@amd.com>
Date: Thu, 8 Jun 2017 18:04:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170608075829.GA2446@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 6/8/2017 2:58 AM, Christoph Hellwig wrote:
> On Wed, Jun 07, 2017 at 02:17:32PM -0500, Tom Lendacky wrote:
>> Add warnings to let the user know when bounce buffers are being used for
>> DMA when SME is active.  Since the bounce buffers are not in encrypted
>> memory, these notifications are to allow the user to determine some
>> appropriate action - if necessary.
> 
> And what would the action be?  Do we need a boot or other option to
> disallow this fallback for people who care deeply?

The action could be to enable the IOMMU so that lower DMA addresses are
used, or to replace the device with one that supports 64-bit DMA or, if
the device is not used much, you could just ignore it.

I'm not sure we need an option to disallow the fallback.  Are you
thinking along the lines of disabling the device?

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
