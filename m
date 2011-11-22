Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vx0-f177.google.com ([209.85.220.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RSsno-0008NC-OC
 for kexec@lists.infradead.org; Tue, 22 Nov 2011 16:02:33 +0000
Received: by vcbfo13 with SMTP id fo13so425261vcb.36
 for <kexec@lists.infradead.org>; Tue, 22 Nov 2011 08:02:31 -0800 (PST)
Date: Tue, 22 Nov 2011 08:02:08 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: fix chunk range calculation
Message-ID: <20111122160208.GA3250@google.com>
References: <4EC491B3.705@redhat.com>
 <CAMMEr5k_ynqg5-7Looar2DxXTGZcMqi5Lo+jtETn9awO_bsaGg@mail.gmail.com>
 <4EC4B60C.3030706@redhat.com> <1321548033.12208.12.camel@boudreau>
 <4EC61AB6.4090808@redhat.com> <4EC61B2A.7010000@redhat.com>
 <20111118185535.GA27152@google.com> <4EC9AD4F.3050404@redhat.com>
 <20111121170146.GD15314@google.com> <4ECB104C.3040801@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ECB104C.3040801@redhat.com>
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

On Tue, Nov 22, 2011 at 11:00:28AM +0800, Dave Young wrote:
> > Maybe we can add comment there how it can be further simplified and
> > why things look more complicated than necessary?
> 
> I wonder if it's good to add something like CONFIG_PER_CPU_DEBUG?

Yeah, having more comprehensive sanity checks w/ CONFIG_PER_CPU_DEBUG
would be really nice.

> Anyway I have no strong opinion with this. I'm fine to either of adding
> comment and put it into debug around.

I mostly just don't want to lose the minimal but useful checks in the
phys conversion function.  Please feel free to improve it.

Thank you.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
