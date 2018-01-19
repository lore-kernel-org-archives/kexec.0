Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecZLA-0007HO-EF
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 16:16:29 +0000
Date: Fri, 19 Jan 2018 08:16:04 -0800
From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180119161604.GH7844@tassilo.jf.intel.com>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180119054538.GA484@jagdpanzerIV>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180119054538.GA484@jagdpanzerIV>
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
Cc: pmladek@suse.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

On Fri, Jan 19, 2018 at 02:45:38PM +0900, Sergey Senozhatsky wrote:
> On (01/18/18 10:02), Andi Kleen wrote:
> > Dave Young <dyoung@redhat.com> writes:
> > >  		printk("%sHardware name: %s\n",
> > >  		       log_lvl, dump_stack_arch_desc_str);
> > > +	if (kexec_crash_loaded())
> > > +		printk("%skdump kernel loaded\n", log_lvl);
> > 
> > Oops/warnings are getting longer and longer, often scrolling away
> > from the screen, and if the kernel crashes backscroll does not work
> > anymore, so precious information is lost.
> 
> true. I even ended up having a console_reflush_on_panic() function. it
> simply re-prints with a delay [so I can at least read the oops] logbuf
> entries every once in a while, staring with the first oops_in_progress
> record.

It would be better to make scrollback work even after panic (e.g. with a polled
keyboard driver)

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
