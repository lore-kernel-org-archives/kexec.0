Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ya4nh-0003vf-Qq
 for kexec@lists.infradead.org; Mon, 23 Mar 2015 16:02:02 +0000
Date: Mon, 23 Mar 2015 12:01:36 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH v2] kernel/panic/kexec: fix "crash_kexec_post_notifiers"
 option issue in oops path
Message-ID: <20150323160136.GE199787@redhat.com>
References: <54F9D645.2050008@jp.fujitsu.com>
 <20150323034752.GD2068@dhcp-16-105.nay.redhat.com>
 <20150323071943.GA22765@gmail.com>
 <20150323133710.GA3172@redhat.com>
 <20150323135046.GA25012@gmail.com>
 <20150323143158.GB3172@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150323143158.GB3172@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hidehiro.kawai.ez@hitachi.com, =?utf-8?B?IkhhdGF5YW1hLCBEYWlzdWtlL+eVkeWxsSDlpKfovJQi?= <d.hatayama@jp.fujitsu.com>, mingo@redhat.com, ebiederm@xmission.com, masami.hiramatsu.pt@hitachi.com, akpm@linux-foundation.org, bp@suse.de, Ingo Molnar <mingo@kernel.org>

On Mon, Mar 23, 2015 at 10:31:58AM -0400, Vivek Goyal wrote:
> > > I think one of the motivations behind this patch was call to kmsg_dump().
> > > Some vendors have been wanting to have the capability to save kernel logs
> > > to some NVRAM before transition to second kernel happens. Their argument
> > > is that kdump does not succeed all the time and if kdump does not succeed
> > > then atleast they have something to work with (kernel logs retrieved
> > > from pstore interface).
> > 
> > Doesn't pstore attach itself to printk itself? AFAICS it does:
> > 
> >  fs/pstore/platform.c:   register_console(&pstore_console);
> > 
> > so the printk log leading up to and including the crash should be 
> > available, regardless of this patch. What am I missing?
> 
> That's a good point. I was not aware of it. I am Ccing Don Zickus as
> he has spent some time on this in the past.

Hi,

I will throw my two cents in here, though I expect Daisuke to provide better
info.

A number of years ago when I was helping work through some of the birthing
pains of the backend for pstore, we didn't have console support.  I don't
think it made sense for x86 either because:

- lack of space in nvram (for large logs)
- you could mark space for deletion, but space was only recovered on reboot
- the state machine would be slow to write (though mmap might have been
  faster)

Looking through the history of who introduced register_console, it looks
like it was the ARM folks.  They might have a better implementation for a
backend that does not have the above limitations.  I don't know.


> 
> Masami, would you have thougths on this? IIRC, one reason why kmsg_dump()
> was written so that one could dump kernel messages to an NVRAM. Of one
> could simple register pstore as console, then how kmsg_dump() will
> continue to be useful?
> 
> > 
> > > Not that I agree fully with this as problem might happen while we 
> > > try to run panic_notifiers or kmsg_dump hooks and never transition 
> > > into kdump kernel.
> > 
> > btw., this is the big problem with 'notifiers' in general: they are 
> > opaque with barely any semantics defined, and a source of constant 
> > confusion.
> 
> Agreed. That's the reason Eric never liked the idea of letting panic
> notifiers run before crash_kexec().
> 
> > 
> > > And it has been literally years since some developers have been 
> > > pushing for allowing to run panic notifiers before crash_kexec(). 
> > > Eric Biederman has been pushing back saying it reduces the 
> > > reliability of kdump operation so this is not acceptable.
> > 
> > So what do those notifiers do?

I think it was just philosophical differences.  kexec on panic is a
complicated path and a bunch of stuff could go wrong.  As insurance in case kexec
on panic did not work, some companies wanted to pre-maturely capture info,
so they have _something_ to use for a debug analysis.

Vivek, Matthew Garret and myself argued to provide us with failure cases and
we will fix kexec on panic instead.  I think the stability period for kexec
on panic was so long that companies still do not trust it.  Just my guess.

Vivek provided examples of what folks were doing with the notifiers.

> 
> IIRC, two main reasons had come in the past.
> 
> - In a cluster of nodes, people wanted to send some sort of notifications
>   to main server that a node has crashed and don't fence it off as it
>   might be saving dump.
> 
> - And saving kernel logs to non volatile store.
> 
> There might be more and I might not be aware about these. Hatayama and
> Masami, can you shed more light on this.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
