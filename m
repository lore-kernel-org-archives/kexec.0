Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vx0-f177.google.com ([209.85.220.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RSXFg-0007py-64
 for kexec@lists.infradead.org; Mon, 21 Nov 2011 17:01:53 +0000
Received: by vcbfo13 with SMTP id fo13so4343105vcb.36
 for <kexec@lists.infradead.org>; Mon, 21 Nov 2011 09:01:50 -0800 (PST)
Date: Mon, 21 Nov 2011 09:01:46 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: fix chunk range calculation
Message-ID: <20111121170146.GD15314@google.com>
References: <4EC47FCA.5090908@redhat.com>
 <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
 <4EC491B3.705@redhat.com>
 <CAMMEr5k_ynqg5-7Looar2DxXTGZcMqi5Lo+jtETn9awO_bsaGg@mail.gmail.com>
 <4EC4B60C.3030706@redhat.com> <1321548033.12208.12.camel@boudreau>
 <4EC61AB6.4090808@redhat.com> <4EC61B2A.7010000@redhat.com>
 <20111118185535.GA27152@google.com> <4EC9AD4F.3050404@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EC9AD4F.3050404@redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, tim@edgecast.com, linux-kernel@vger.kernel.org

Hello, Dave.

On Mon, Nov 21, 2011 at 09:45:51AM +0800, Dave Young wrote:
> On 11/19/2011 02:55 AM, Tejun Heo wrote:
> 
> > Percpu allocator recorded the cpus which map to the first and last
> > units in pcpu_first/last_unit_cpu respectively and used them to
> > determine the address range of a chunk - e.g. it assumed that the
> > first unit has the lowest address in a chunk while the last unit has
> > the highest address.
> > 
> > This simply isn't true.  Groups in a chunk can have arbitrary positive
> > or negative offsets from the previous one and there is no guarantee
> > that the first unit occupies the lowest offset while the last one the
> > highest.
> > 
> > Fix it by actually comparing unit offsets to determine cpus occupying
> > the lowest and highest offsets.  Also, rename pcu_first/last_unit_cpu
> > to pcpu_low/high_unit_cpu to avoid confusion.
> > 
> > The chunk address range is used to flush cache on vmalloc area
> > map/unmap and decide whether a given address is in the first chunk by
> > per_cpu_ptr_to_phys() and the bug was discovered by invalid
> > per_cpu_ptr_to_phys() translation for crash_note.
> > 
> > Kudos to Dave Young for tracking down the problem.
> 
> Tejun, thanks
> 
> Now that if addr is not in first trunk it must be in vmalloc area, below
> logic should be right:
> 	if (in_first_chunk) {
> 		if (!is_vmalloc_addr(addr))
> 			return __pa(addr);
> 		else
> 			return page_to_phys(vmalloc_to_page(addr));
> 	} else
> 		if (!is_vmalloc_addr(addr)) /* not possible */
> 			return __pa(addr);
> 		else
> 			return page_to_phys(pcpu_addr_to_page(addr));
> 
> So how about just simply remove in first chunk checking to simplify the
> code as followging:
> 
> phys_addr_t per_cpu_ptr_to_phys(void *addr)
> {
> 	if (!is_vmalloc_addr(addr))
> 		return __pa(addr);
> 	else
> 		return page_to_phys(pcpu_addr_to_page(addr));
> }

Yes, that's much simpler.  Hmmm... I'm still slightly reluctant
because the current code reflects better how percpu allocator actually
works.  It has special setup for the first chunk, which currently
supports either embedding in linear address space or vmalloc mapping,
and, from the second one, the backing allocator (currently either vm
or km) provides translation.

per_cpu_ptr_to_phys() has been pretty good at exposing wrong
assumptions in address translation mostly because this is one of few
points where the assumptions are visible in a verifiable way (I think
this is the second bug it has discovered).

This forces the verification that "if it isn't in one of the explicit
first chunk areas, it MUST follow backing allocator mapping" which can
discover both bugs in percpu allocator itself and
per_cpu_ptr_to_phys() callers.  e.g. with the proposed change, if the
caller passes in usual kernel address on percpu-vm which is not in the
first chunk, it will return __pa for the address even though that
address can't possibly be a percpu address, but the current code will
trip VIRTUAL_BUG_ON() in vmalloc_to_page().

Maybe we can add comment there how it can be further simplified and
why things look more complicated than necessary?

Thank you.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
