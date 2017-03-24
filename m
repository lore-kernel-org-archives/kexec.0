Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1crNy6-0001Ko-VO
 for kexec@lists.infradead.org; Fri, 24 Mar 2017 12:05:24 +0000
Received: by mail-wm0-x236.google.com with SMTP id n11so11248677wma.1
 for <kexec@lists.infradead.org>; Fri, 24 Mar 2017 05:05:02 -0700 (PDT)
Date: Fri, 24 Mar 2017 15:04:58 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC PATCH] x86_64/mm/boot: Fix kernel_ident_mapping_init()
 failure for kexec
Message-ID: <20170324120458.nw3fwpmdptjtj5qb@node.shutemov.name>
References: <1489990291-2252-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1489990291-2252-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

On Mon, Mar 20, 2017 at 02:11:31PM +0800, Xunlei Pang wrote:
> I found that the kdump is broken on linux-4.11.0-rc2+

That's actually tip tree or linux-next. The problematic change is not in
Linus' tree.

> , probably
> due to the 5level-paging feature that "#define p4d_present(p4d) 1",
> as a result in ident_p4d_init(), it will go into ident_pud_init()
> directly without allocating the new pud.
> 
> Looks like this patch can make it work again.

Okay, that's bisectability issue. Uncovered by splitting my patchset into
parts.

Could you check if applying "Part 2" of 5-level paging changes[1] would
help you?

Making the code work with both <asm-generic/5level-fixup.h> and
<asm-generic/pgtable-nop4d.h> would make it even uglier. Not sure if it
makes sense to address it on its own if second part fixes the situation.

[1] http://lkml.kernel.org/r/20170317185515.8636-1-kirill.shutemov@linux.intel.com

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
