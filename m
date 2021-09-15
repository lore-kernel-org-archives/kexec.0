Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQZwj-009ixF-5X
 for kexec@lists.infradead.org; Wed, 15 Sep 2021 18:47:50 +0000
Date: Wed, 15 Sep 2021 20:47:37 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
Message-ID: <YUI/yaut2f9ZoJBd@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic> <87lf3yk7g4.fsf@mpe.ellerman.id.au>
 <YUHGDbtiGrDz5+NS@zn.tnic>
 <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, linux-graphics-maintainer@vmware.com, Tom Lendacky <thomas.lendacky@amd.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Wed, Sep 15, 2021 at 07:18:34PM +0200, Christophe Leroy wrote:
> Could you please provide more explicit explanation why inlining such an
> helper is considered as bad practice and messy ?

Tom already told you to look at the previous threads. Let's read them
together. This one, for example:

https://lore.kernel.org/lkml/YSScWvpXeVXw%2Fed5@infradead.org/

| > To take it out of line, I'm leaning towards the latter, creating a new
| > file that is built based on the ARCH_HAS_PROTECTED_GUEST setting.
| 
| Yes.  In general everytime architectures have to provide the prototype
| and not just the implementation of something we end up with a giant mess
| sooner or later.  In a few cases that is still warranted due to
| performance concerns, but i don't think that is the case here.

So I think what Christoph means here is that you want to have the
generic prototype defined in a header and arches get to implement it
exactly to the letter so that there's no mess.

As to what mess exactly, I'd let him explain that.

> Because as demonstrated in my previous response some days ago, taking that
> outline ends up with an unneccessary ugly generated code and we don't
> benefit front GCC's capability to fold in and opt out unreachable code.

And this is real fast path where a couple of instructions matter or what?

set_memory_encrypted/_decrypted doesn't look like one to me.

> I can't see your point here. Inlining the function wouldn't add any
> ifdeffery as far as I can see.

If the function is touching defines etc, they all need to be visible.
If that function needs to call other functions - which is the case on
x86, perhaps not so much on power - then you need to either ifdef around
them or provide stubs with ifdeffery in the headers. And you need to
make them global functions instead of keeping them static to the same
compilation unit, etc, etc.

With a separate compilation unit, you don't need any of that and it is
all kept in that single file.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
