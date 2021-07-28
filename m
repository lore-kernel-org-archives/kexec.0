Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8mPW-001ch8-Uz
 for kexec@lists.infradead.org; Wed, 28 Jul 2021 16:28:02 +0000
Date: Wed, 28 Jul 2021 18:28:01 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 01/11] mm: Introduce a function to check for
 virtualization protection features
Message-ID: <YQGFh3BlaD8RAEBz@nazgul.tnic>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
 <YQFY5/cq2thyHzUe@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YQFY5/cq2thyHzUe@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Brijesh Singh <brijesh.singh@amd.com>

On Wed, Jul 28, 2021 at 02:17:27PM +0100, Christoph Hellwig wrote:
> So common checks obviously make sense, but I really hate the stupid
> multiplexer.  Having one well-documented helper per feature is much
> easier to follow.

We had that in x86 - it was called cpu_has_<xxx> where xxx is the
feature bit. It didn't scale with the sheer amount of feature bits that
kept getting added so we do cpu_feature_enabled(X86_FEATURE_XXX) now.

The idea behind this is very similar - those protected guest flags
will only grow in the couple of tens range - at least - so having a
multiplexer is a lot simpler, I'd say, than having a couple of tens of
helpers. And those PATTR flags should have good, readable names, btw.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
