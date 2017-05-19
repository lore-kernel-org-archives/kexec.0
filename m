Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dBpSh-0002w2-5b
 for kexec@lists.infradead.org; Fri, 19 May 2017 21:29:32 +0000
Date: Fri, 19 May 2017 23:28:54 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 28/32] x86/mm, kexec: Allow kexec to be used with SME
Message-ID: <20170519212854.3dvtt3lawzij5cae@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212121.10190.94885.stgit@tlendack-t1.amdoffice.net>
 <20170517191755.h2xluopk2p6suw32@pd.tnic>
 <1b74e0e6-3dda-f638-461b-f73af9904360@amd.com>
 <20170519205836.3wvl3nztqyyouje3@pd.tnic>
 <5ef96f3a-6ebd-1d4d-7ac9-05dbed45d998@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ef96f3a-6ebd-1d4d-7ac9-05dbed45d998@amd.com>
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

On Fri, May 19, 2017 at 04:07:24PM -0500, Tom Lendacky wrote:
> As long as those never change from static inline everything will be
> fine. I can change it, but I really like how it explicitly indicates

I know what you want to do. But you're practically defining a helper
which contains two arbitrary instructions which probably no one else
will need.

So how about we simplify this function even more. We don't need to pay
attention to kexec being in progress because we're halting anyway so who
cares how fast we halt.

Might have to state that in the comment below though, instead of what's
there now.

And for the exact same moot reason, we don't need to look at SME CPUID
feature - we can just as well WBINVD unconditionally.

void stop_this_cpu(void *dummy)
{
        local_irq_disable();
        /*
         * Remove this CPU:
         */
        set_cpu_online(smp_processor_id(), false);
        disable_local_APIC();
        mcheck_cpu_clear(this_cpu_ptr(&cpu_info));

        for (;;) {
                /*
                 * If we are performing a kexec and the processor supports
                 * SME then we need to clear out cache information before
                 * halting. With kexec, going from SME inactive to SME active
                 * requires clearing cache entries so that addresses without
                 * the encryption bit set don't corrupt the same physical
                 * address that has the encryption bit set when caches are
                 * flushed. Perform a wbinvd followed by a halt to achieve
                 * this.
                 */
                asm volatile("wbinvd; hlt" ::: "memory");
        }
}

How's that?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
