Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dFzjr-0000sZ-Bx
 for kexec@lists.infradead.org; Wed, 31 May 2017 09:16:28 +0000
Date: Wed, 31 May 2017 11:15:53 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 32/32] x86/mm: Add support to make use of Secure
 Memory Encryption
Message-ID: <20170531091553.jwqcwkfivmmhndwv@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212223.10190.85121.stgit@tlendack-t1.amdoffice.net>
 <c29edaff-24f2-ee9b-4142-bdbf8c42083f@amd.com>
 <20170519113005.3f5kwzg4pgh7j6a5@pd.tnic>
 <20170519201651.dhayf2pwjlsnouz4@treble>
 <1ac40d18-a8b2-94eb-35ed-c30768667be8@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ac40d18-a8b2-94eb-35ed-c30768667be8@amd.com>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, May 30, 2017 at 10:48:27AM -0500, Tom Lendacky wrote:
> I'll look at doing that instead of removing the support for the whole
> file.

Right, so I don't think the stack protector is even ready that early -
we do set it up later:

        /* Set up %gs.
         *
         * The base of %gs always points to the bottom of the irqstack
         * union.  If the stack protector canary is enabled, it is
         * located at %gs:40.  Note that, on SMP, the boot cpu uses
         * init data section till per cpu areas are set up.
         */
        movl    $MSR_GS_BASE,%ecx
        movl    initial_gs(%rip),%eax
        movl    initial_gs+4(%rip),%edx
        wrmsr

so I think marking the function "no-stack-protector" is the only option
right now. We can always look at fixing that later.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
