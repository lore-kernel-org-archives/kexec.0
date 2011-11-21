Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qw0-f42.google.com ([209.85.216.42])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RSb8j-0003vv-C7
 for kexec@lists.infradead.org; Mon, 21 Nov 2011 21:10:58 +0000
Received: by qabg40 with SMTP id g40so642950qab.15
 for <kexec@lists.infradead.org>; Mon, 21 Nov 2011 13:10:55 -0800 (PST)
Date: Mon, 21 Nov 2011 13:10:50 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: fix chunk range calculation
Message-ID: <20111121211050.GK25776@google.com>
References: <1321467647.2137.4.camel@boudreau> <4EC47FCA.5090908@redhat.com>
 <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
 <4EC491B3.705@redhat.com>
 <CAMMEr5k_ynqg5-7Looar2DxXTGZcMqi5Lo+jtETn9awO_bsaGg@mail.gmail.com>
 <4EC4B60C.3030706@redhat.com> <1321548033.12208.12.camel@boudreau>
 <4EC61AB6.4090808@redhat.com> <4EC61B2A.7010000@redhat.com>
 <20111118185535.GA27152@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111118185535.GA27152@google.com>
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

On Fri, Nov 18, 2011 at 10:55:35AM -0800, Tejun Heo wrote:
> Percpu allocator recorded the cpus which map to the first and last
> units in pcpu_first/last_unit_cpu respectively and used them to
> determine the address range of a chunk - e.g. it assumed that the
> first unit has the lowest address in a chunk while the last unit has
> the highest address.
> 
> This simply isn't true.  Groups in a chunk can have arbitrary positive
> or negative offsets from the previous one and there is no guarantee
> that the first unit occupies the lowest offset while the last one the
> highest.
> 
> Fix it by actually comparing unit offsets to determine cpus occupying
> the lowest and highest offsets.  Also, rename pcu_first/last_unit_cpu
> to pcpu_low/high_unit_cpu to avoid confusion.
> 
> The chunk address range is used to flush cache on vmalloc area
> map/unmap and decide whether a given address is in the first chunk by
> per_cpu_ptr_to_phys() and the bug was discovered by invalid
> per_cpu_ptr_to_phys() translation for crash_note.
> 
> Kudos to Dave Young for tracking down the problem.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: WANG Cong <xiyou.wangcong@gmail.com>
> Reported-by: Dave Young <dyoung@redhat.com>
> LKML-Reference: <4EC21F67.10905@redhat.com>
> Cc: stable @kernel.org

BTW, waiting for Tested-by.  If someone gives me that, I'll push it
through percpu/for-fixes.

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
