Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecZtf-00042a-OX
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 16:52:10 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0636EAE14
 for <kexec@lists.infradead.org>; Fri, 19 Jan 2018 16:51:55 +0000 (UTC)
Date: Fri, 19 Jan 2018 17:51:53 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180119175153.6c5aa1d2@ezekiel.suse.cz>
In-Reply-To: <20180119161604.GH7844@tassilo.jf.intel.com>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180119054538.GA484@jagdpanzerIV>
 <20180119161604.GH7844@tassilo.jf.intel.com>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org

On Fri, 19 Jan 2018 08:16:04 -0800
Andi Kleen <ak@linux.intel.com> wrote:

> On Fri, Jan 19, 2018 at 02:45:38PM +0900, Sergey Senozhatsky wrote:
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
> 
> It would be better to make scrollback work even after panic (e.g. with a polled
> keyboard driver)

I ended up using a serial console on all my machines. Yes, even my
laptop has one (virtual, provided by Intel AMT).

Anyway, what do you mean by a polled keyboard driver? My keyboard is
connected with USB. A polling xhci driver? Surely possible, but is it
worth the effort?

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
