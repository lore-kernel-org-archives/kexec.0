Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBGiC-0002Oz-1Q
 for kexec@lists.infradead.org; Tue, 02 Apr 2019 10:32:13 +0000
Date: Tue, 2 Apr 2019 12:32:01 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3 v2] x86/kexec: Do not map the kexec area as decrypted
 when SEV is active
Message-ID: <20190402103201.GF6826@zn.tnic>
References: <20190327053629.17935-1-lijiang@redhat.com>
 <20190327053629.17935-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190327053629.17935-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Wed, Mar 27, 2019 at 01:36:27PM +0800, Lianbo Jiang wrote:
> Currently, the arch_kexec_post_{alloc,free}_pages() unconditionally
> maps the kexec area as decrypted. This works fine when SME is active.
> Because in SME, the first kernel is loaded in decrypted area by the
> BIOS, so the second kernel must be also loaded into the decrypted
> memory.
> 
> When SEV is active, the first kernel is loaded into the encrypted
> area, so the second kernel must be also loaded into the encrypted
> memory. Lets make sure that arch_kexec_post_{alloc,free}_pages()
> does not clear the memory encryption mask from the kexec area when
> SEV is active.

This commit message still doesn't explain the big picture why you want
this change.

And it must explain it because it might be all clear in your head now
but months from now, you, we, all would've forgotten why this change was
needed.

So pls add blurb that this whole effort is being done so that SEV VMs
can kdump too. I.e., the 10000ft picture.

Anyone must be able to figure out *why* a change has been done just by
doing git archeology. So make sure you explain it properly.

If unsure, try to put yourself in the shoes of some future kernel
developer who is trying to find out why this change has been done. Now
read the commit message you've written. Does it make any sense to him? I
think not.

Do you catch my drift?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
