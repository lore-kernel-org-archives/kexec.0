Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com
 ([104.47.33.87] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dAi9m-0005hV-7n
 for kexec@lists.infradead.org; Tue, 16 May 2017 19:29:20 +0000
Subject: Re: [PATCH v5 06/32] x86/mm: Add Secure Memory Encryption (SME)
 support
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211727.10190.18774.stgit@tlendack-t1.amdoffice.net>
 <20170427154631.2tsqgax4kqcvydnx@pd.tnic>
 <d9d9f10a-0ce5-53e8-41f5-f8690dbd7362@amd.com>
 <20170504143622.zy2f66e4mkm6xvsq@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <6d266f5b-c28d-fe19-24b5-5133532f9eea@amd.com>
Date: Tue, 16 May 2017 14:28:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170504143622.zy2f66e4mkm6xvsq@pd.tnic>
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

On 5/4/2017 9:36 AM, Borislav Petkov wrote:
> On Thu, May 04, 2017 at 09:24:11AM -0500, Tom Lendacky wrote:
>> I did this so that an the include order wouldn't cause issues (including
>> asm/mem_encrypt.h followed by later by a linux/mem_encrypt.h include).
>> I can make this a bit clearer by having separate #defines for each
>> thing, e.g.:
>>
>> #ifndef sme_me_mask
>> #define sme_me_mask 0UL
>> #endif
>>
>> #ifndef sme_active
>> #define sme_active sme_active
>> static inline ...
>> #endif
>>
>> Is that better/clearer?
>
> I guess but where do we have to include both the asm/ and the linux/
> version?

It's more of the sequence of various includes.  For example,
init/do_mounts.c includes <linux/module.h> that eventually gets down
to <asm/pgtable_types.h> and then <asm/mem_encrypt.h>.  However, a
bit further down <linux/nfs_fs.h> is included which eventually gets
down to <linux/dma-mapping.h> and then <linux/mem_encyrpt.h>.

>
> IOW, can we avoid these issues altogether by partitioning symbol
> declarations differently among the headers?

It's most problematic when CONFIG_AMD_MEM_ENCRYPT is not defined since
we never include an asm/ version from the linux/ path.  I could create
a mem_encrypt.h in include/asm-generic/ that contains the info that
is in the !CONFIG_AMD_MEM_ENCRYPT path of the linux/ version. Let me
look into that.

Thanks,
Tom

>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
