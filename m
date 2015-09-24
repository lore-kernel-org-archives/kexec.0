Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-x233.google.com ([2a00:1450:400c:c05::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf5RF-0001AT-PN
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 12:15:50 +0000
Received: by wicfx3 with SMTP id fx3so25191923wic.1
 for <kexec@lists.infradead.org>; Thu, 24 Sep 2015 05:15:27 -0700 (PDT)
Date: Thu, 24 Sep 2015 14:15:25 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 09/13] Move bp_type_idx to kernel/event/hw_breakpoint.c
Message-ID: <20150924121524.GA6050@lerouge>
References: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-10-git-send-email-palmer@dabbelt.com>
 <20150915080607.GW16853@twins.programming.kicks-ass.net>
 <2023922.x7a6gQp0x7@wuerfel>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2023922.x7a6gQp0x7@wuerfel>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: dave@sr71.net, Peter Zijlstra <peterz@infradead.org>, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, plagnioj@jcrosoft.com, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

On Tue, Sep 15, 2015 at 11:15:29PM +0200, Arnd Bergmann wrote:
> On Tuesday 15 September 2015 10:06:07 Peter Zijlstra wrote:
> > > diff --git a/include/uapi/linux/hw_breakpoint.h b/include/uapi/linux/hw_breakpoint.h
> > > index b04000a2296a..7a6a5a7f9511 100644
> > > --- a/include/uapi/linux/hw_breakpoint.h
> > > +++ b/include/uapi/linux/hw_breakpoint.h
> > > @@ -17,14 +17,4 @@ enum {
> > >       HW_BREAKPOINT_INVALID   = HW_BREAKPOINT_RW | HW_BREAKPOINT_X,
> > >  };
> > >  
> > > -enum bp_type_idx {
> > > -     TYPE_INST       = 0,
> > > -#ifdef CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
> > > -     TYPE_DATA       = 0,
> > > -#else
> > > -     TYPE_DATA       = 1,
> > > -#endif
> > > -     TYPE_MAX
> > > -};
> > 
> > This is rather unfortunate; you are correct that the naming is too
> > generic (and I tend to agree), but I think these values are required by
> > userspace to fill out:
> > 
> >   perf_event_attr::bp_type
> > 
> > So removing them will break things.
> > 
> > Frederic?
> 
> If user space actually relies on the definition from this header file,
> then it will use the wrong one on x86 and get 'TYPE_DATA = 1', while the
> kernel uses 'TYPE_DATA = 0'.
> 
> That seems unlikely to work, so I suspect it gets a different definition.
> If it uses this definition and it does work, we can probably use
> 
> #if defined(__KERNEL__) && defined(CONFIG_HAVE_MIXED_BREAKPOINTS_REGS)
> 
> but that requires a comment explaining exactly why that works.

I think this TYPE_DATA/TYPE_INST can be safely removed from uapi. This is only
about internal kernel code. Userspace only relies on HW_BREAKPOINT_[R/W/X]
to tell about the nature of the breakpoint.

If userspace ever relies on it, which I have no idea why, it even needs to define
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS. No really there shouldn't be any user of that outside
the kernel.

Thanks.

> 
> 	Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
