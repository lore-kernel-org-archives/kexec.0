Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dOKxm-00064S-AO
 for kexec@lists.infradead.org; Fri, 23 Jun 2017 09:33:16 +0000
Date: Fri, 23 Jun 2017 11:32:36 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 33/36] x86/mm: Use proper encryption attributes with
 /dev/mem
Message-ID: <20170623093236.ei7z2zmc6vjq5lod@pd.tnic>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185607.18967.51412.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170616185607.18967.51412.stgit@tlendack-t1.amdoffice.net>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jun 16, 2017 at 01:56:07PM -0500, Tom Lendacky wrote:
> When accessing memory using /dev/mem (or /dev/kmem) use the proper
> encryption attributes when mapping the memory.
> 
> To insure the proper attributes are applied when reading or writing
> /dev/mem, update the xlate_dev_mem_ptr() function to use memremap()
> which will essentially perform the same steps of applying __va for
> RAM or using ioremap() for if not RAM.
> 
> To insure the proper attributes are applied when mmapping /dev/mem,
> update the phys_mem_access_prot() to call phys_mem_access_encrypted(),
> a new function which will check if the memory should be mapped encrypted
> or not. If it is not to be mapped encrypted then the VMA protection
> value is updated to remove the encryption bit.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/io.h |    3 +++
>  arch/x86/mm/ioremap.c     |   18 +++++++++---------
>  arch/x86/mm/pat.c         |    3 +++
>  3 files changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
