Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1d0rh7-0003Iu-UR
 for kexec@lists.infradead.org; Wed, 19 Apr 2017 15:39:07 +0000
Date: Wed, 19 Apr 2017 17:38:19 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 01/32] x86: Documentation for AMD Secure Memory
 Encryption (SME)
Message-ID: <20170419153818.3pl3gkdpe42lve44@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211625.10190.52568.stgit@tlendack-t1.amdoffice.net>
 <20170419090224.frmv2jhwfwoxvdie@pd.tnic>
 <bbda868c-9b34-4404-f563-98b000124ac5@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bbda868c-9b34-4404-f563-98b000124ac5@amd.com>
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Apr 19, 2017 at 09:23:47AM -0500, Tom Lendacky wrote:
> Btw, I tried to update all the subjects and descriptions to be
> more descriptive but I'm sure there is still room for improvement
> so keep the comments on them coming.

No worries there :)

> Note, just because the bit is set in %cr3 doesn't mean the full
> hierarchy is encrypted. Each level in the hierarchy needs to have the
> encryption bit set. So, theoretically, you could have the encryption
> bit set in %cr3 so that the PGD is encrypted, but not set the encryption
> bit in the PGD entry for a PUD and so the PUD pointed to by that entry
> would not be encrypted.

Ha, that is a nice detail I didn't realize. You could add it to the text.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
