Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9a72-0006H1-RR
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 11:19:09 +0000
Date: Thu, 6 Sep 2012 12:19:04 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/4]  Add device-tree support to kexec-tools for ARM
Message-ID: <20120906111904.GF858@mudshark.cambridge.arm.com>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
 <20120905123850.GA11453@verge.net.au>
 <000001cd8b73$82e6b4f0$88b41ed0$@leach@arm.com>
 <20120906032901.GG6432@verge.net.au>
 <000101cd8c1f$6f758520$4e608f60$@leach@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000101cd8c1f$6f758520$4e608f60$@leach@arm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew Leach <matthew.leach@arm.com>
Cc: 'Simon Horman' <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Sep 06, 2012 at 12:04:50PM +0100, Matthew Leach wrote:
> I believe that you are loading the dtb at an offset from the base
> of 0x1000, this is where the problem lies in that the dtb can be
> corrupted by the page tables of the decompressor.

Aha, so it is still using the KEXEC_ARM_ATAGS_OFFSET stuff. Sorry if I
confused anybody about the DTB-append comments, I guess I was confusing the
segment layout with the final loaded layout.

It's worth pointing out that, with LPAE kernels, the page tables are larger
and sit at offset 0x3000, so this leaves only 8k for the .dtb which is
definitely not enough.

> I suggest that we put the DTB out of the way, perhaps just after
> the initrd segment, or at the initrd_offset in the case that
> there is no initrd. This would require a kernel change to set the
> correct parameter to the relocate_new_kerenel function, but the
> change is minimal.

I'm fine with changing the kernel, as long as it doesn't break existing
users (it doesn't).

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
