Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecS2d-0007fe-Fr
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 08:28:52 +0000
Received: by mail-pg0-x244.google.com with SMTP id c194so890692pga.12
 for <kexec@lists.infradead.org>; Fri, 19 Jan 2018 00:28:41 -0800 (PST)
Date: Fri, 19 Jan 2018 17:28:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180119082835.GA477@jagdpanzerIV>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180119054538.GA484@jagdpanzerIV>
 <20180119081628.GB3985@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180119081628.GB3985@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: pmladek@suse.com, Andi Kleen <ak@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

On (01/19/18 16:16), Dave Young wrote:
> On 01/19/18 at 02:45pm, Sergey Senozhatsky wrote:
> > On (01/18/18 10:02), Andi Kleen wrote:
> > > Dave Young <dyoung@redhat.com> writes:
> > > >  		printk("%sHardware name: %s\n",
> > > >  		       log_lvl, dump_stack_arch_desc_str);
> > > > +	if (kexec_crash_loaded())
> > > > +		printk("%skdump kernel loaded\n", log_lvl);
> > > 
> > > Oops/warnings are getting longer and longer, often scrolling away
> > > from the screen, and if the kernel crashes backscroll does not work
> > > anymore, so precious information is lost.
> > 
> > true. I even ended up having a console_reflush_on_panic() function. it
> > simply re-prints with a delay [so I can at least read the oops] logbuf
> > entries every once in a while, staring with the first oops_in_progress
> > record.
> > 
> 
> If too many messages printed on screen, then the next flush will 
> still scroll up. 

right. but it re-prints Oops with a new console_unlock_delay() delay
which gives me enough time to either read it as many times as I want,
or take a picture, etc. it's not as fast as the normal oops print out.

[I'm not entirely sure I see why do we have printk_delay() in
   vprintk_emit()... I mean I probably can see some reasoning behind
   it, but at the same it makes sense to slow down console_unlock()
   as well]

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
