Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WjPFp-00026V-A9
 for kexec@lists.infradead.org; Sun, 11 May 2014 08:37:06 +0000
Date: Sun, 11 May 2014 08:48:37 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [kexec-tools][PATCH v2] zImage-arm: bugfix: kernel offset must
 be 0x8000
Message-ID: <20140510234837.GI31760@verge.net.au>
References: <53678E67.2050508@zonque.org>
 <1399336709-21905-1-git-send-email-wangnan0@huawei.com>
 <5368B120.4000600@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5368B120.4000600@gmail.com>
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
To: Daniel Mack <zonque@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>, kexec@lists.infradead.org, Sven Neumann <s.neumann@raumfeld.com>

On Tue, May 06, 2014 at 11:53:36AM +0200, Daniel Mack wrote:
> On 05/06/2014 02:38 AM, Wang Nan wrote:
> > This patch fixs a problem introduced by commit e5d6a55 which make ARM
> > kexec fails.
> > 
> > Due to that commit, kernel is loaded at a dynamically offset: it computes
> > extra_size using size of dtb, and load zImage at base + extra_size. When
> > dtb size small (for example, 0x3000 bytes), kernel will be loaded at
> > address like 0x60003000. For ARM zImage such address is incorrect.
> > 
> > In kernel code arch/arm/boot/compressed/head.S, zImage builds a
> > temporary page table at (pc & 0xf8000000) + TEXT_OFFSET - 0x4000. The
> > related instructions sequence is:
> > 
> >  mov     r4, pc
> >  and     r4, r4, #0xf8000000
> >  add     r4, r4, #TEXT_OFFSET @ (TEXT_OFFSET == 0x8000 on most platforms)
> >  call cache_on
> >    ...
> >    call __armv7_mmu_cache_on
> >      ...
> >      call __setup_mmu
> >        sub     r3, r4, #16384          @ Page directory size
> > 
> > r3 becomes page table pointer.
> > 
> > When kernel is loaded at 0x60003000, page table is still built at
> > 0x60004000, which destroys kernel.
> > 
> > This patch make extra_size a fix value (0x8000) to avoid the failure.
> > 
> > For the problem commit e5d6a55 tries solve, this patch uses
> > locate_holes() to find a place can hold initrd and dtb.
> > 
> > Change from v1:
> >  - Coding style enhancements.
> > 
> > Signed-off-by: Wang Nan <wangnan0@huawei.com>
> > Cc: Daniel Mack <zonque@gmail.com>
> 
> Tested-by: Daniel Mack <zonque@gmail.com>
> 
> 
> Many thanks again for the fix and the elaboration!

Thanks, and apologies for the delay.
I am currently returning from a weeks vacation.
I have applied this locally and will push it some
time after I get off the plane ride home.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
