Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dJN0m-00045T-Fx
 for kexec@lists.infradead.org; Fri, 09 Jun 2017 16:43:53 +0000
Date: Fri, 9 Jun 2017 18:43:09 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 06/34] x86/mm: Add Secure Memory Encryption (SME)
 support
Message-ID: <20170609164309.45xgyzibdkzmdbde@pd.tnic>
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191416.28645.58145.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170607191416.28645.58145.stgit@tlendack-t1.amdoffice.net>
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

On Wed, Jun 07, 2017 at 02:14:16PM -0500, Tom Lendacky wrote:
> Add support for Secure Memory Encryption (SME). This initial support
> provides a Kconfig entry to build the SME support into the kernel and
> defines the memory encryption mask that will be used in subsequent
> patches to mark pages as encrypted.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/Kconfig                   |   22 ++++++++++++++++++++++
>  arch/x86/include/asm/mem_encrypt.h |   35 +++++++++++++++++++++++++++++++++++
>  arch/x86/mm/Makefile               |    1 +
>  arch/x86/mm/mem_encrypt.c          |   21 +++++++++++++++++++++
>  include/asm-generic/mem_encrypt.h  |   27 +++++++++++++++++++++++++++
>  include/linux/mem_encrypt.h        |   18 ++++++++++++++++++
>  6 files changed, 124 insertions(+)
>  create mode 100644 arch/x86/include/asm/mem_encrypt.h
>  create mode 100644 arch/x86/mm/mem_encrypt.c
>  create mode 100644 include/asm-generic/mem_encrypt.h
>  create mode 100644 include/linux/mem_encrypt.h

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
