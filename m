Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecSG1-0002jf-Pn
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 08:42:43 +0000
Date: Fri, 19 Jan 2018 16:42:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180119084223.GC3985@dhcp-128-65.nay.redhat.com>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180119054538.GA484@jagdpanzerIV>
 <20180119081628.GB3985@dhcp-128-65.nay.redhat.com>
 <20180119082835.GA477@jagdpanzerIV>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180119082835.GA477@jagdpanzerIV>
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: pmladek@suse.com, Andi Kleen <ak@linux.intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

On 01/19/18 at 05:28pm, Sergey Senozhatsky wrote:
> On (01/19/18 16:16), Dave Young wrote:
> > On 01/19/18 at 02:45pm, Sergey Senozhatsky wrote:
> > > On (01/18/18 10:02), Andi Kleen wrote:
> > > > Dave Young <dyoung@redhat.com> writes:
> > > > >  		printk("%sHardware name: %s\n",
> > > > >  		       log_lvl, dump_stack_arch_desc_str);
> > > > > +	if (kexec_crash_loaded())
> > > > > +		printk("%skdump kernel loaded\n", log_lvl);
> > > > 
> > > > Oops/warnings are getting longer and longer, often scrolling away
> > > > from the screen, and if the kernel crashes backscroll does not work
> > > > anymore, so precious information is lost.
> > > 
> > > true. I even ended up having a console_reflush_on_panic() function. it
> > > simply re-prints with a delay [so I can at least read the oops] logbuf
> > > entries every once in a while, staring with the first oops_in_progress
> > > record.
> > > 
> > 
> > If too many messages printed on screen, then the next flush will 
> > still scroll up. 
> 
> right. but it re-prints Oops with a new console_unlock_delay() delay
> which gives me enough time to either read it as many times as I want,
> or take a picture, etc. it's not as fast as the normal oops print out.
> 
> [I'm not entirely sure I see why do we have printk_delay() in
>    vprintk_emit()... I mean I probably can see some reasoning behind
>    it, but at the same it makes sense to slow down console_unlock()
>    as well]

Looks like I am the guy who added the code :)  Actually no special
reason, just did not thinking about the performance issue at all at that
time..

> 
> 	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
