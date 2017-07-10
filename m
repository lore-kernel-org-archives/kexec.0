Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bl2nam02on0623.outbound.protection.outlook.com
 ([2a01:111:f400:fe46::623]
 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dUd35-0007oY-E2
 for kexec@lists.infradead.org; Mon, 10 Jul 2017 18:04:45 +0000
Subject: Re: [PATCH v9 00/38] x86: Secure Memory Encryption (AMD)
References: <20170707133804.29711.1616.stgit@tlendack-t1.amdoffice.net>
 <20170708092426.prf7xmmnv6xvdqx4@gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <fce185d2-4420-7255-6331-6231c643c8c7@amd.com>
Date: Mon, 10 Jul 2017 13:04:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170708092426.prf7xmmnv6xvdqx4@gmail.com>
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
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>



On 7/8/2017 4:24 AM, Ingo Molnar wrote:
> 
> * Tom Lendacky <thomas.lendacky@amd.com> wrote:
> 
>> This patch series provides support for AMD's new Secure Memory Encryption (SME)
>> feature.
> 
> I'm wondering, what's the typical performance hit to DRAM access latency when SME
> is enabled?

It's about an extra 10 cycles of DRAM latency when performing an
encryption or decryption operation.

> 
> On that same note, if the performance hit is noticeable I'd expect SME to not be
> enabled in native kernels typically - but still it looks like a useful hardware

In some internal testing we've seen about 1.5% or less reduction in
performance. Of course it all depends on the workload: the number of
memory accesses, cache friendliness, etc.

> feature. Since it's controlled at the page table level, have you considered
> allowing SME-activated vmas via mmap(), even on kernels that are otherwise not
> using encrypted DRAM?

That is definitely something to consider as an additional SME-related
feature and something I can look into after this.

Thanks,
Tom

> 
> One would think that putting encryption keys into such encrypted RAM regions would
> generally improve robustness against various physical space attacks that want to
> extract keys but don't have full control of the CPU.
> 
> Thanks,
> 
> 	Ingo
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
