Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecWO2-0003EQ-Qk
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 13:07:16 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A0CB2AB40
 for <kexec@lists.infradead.org>; Fri, 19 Jan 2018 13:06:59 +0000 (UTC)
Date: Fri, 19 Jan 2018 14:06:58 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180119140658.2137904e@ezekiel.suse.cz>
In-Reply-To: <20180119044719.GA3985@dhcp-128-65.nay.redhat.com>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180118135704.62d0f79f@gandalf.local.home>
 <20180119044719.GA3985@dhcp-128-65.nay.redhat.com>
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

On Fri, 19 Jan 2018 12:47:19 +0800
Dave Young <dyoung@redhat.com> wrote:

> On 01/18/18 at 01:57pm, Steven Rostedt wrote:
> > On Thu, 18 Jan 2018 10:02:17 -0800
> > Andi Kleen <ak@linux.intel.com> wrote:
> >   
> > > Dave Young <dyoung@redhat.com> writes:  
> > > >  		printk("%sHardware name: %s\n",
> > > >  		       log_lvl, dump_stack_arch_desc_str);
> > > > +	if (kexec_crash_loaded())
> > > > +		printk("%skdump kernel loaded\n", log_lvl);    
> > > 
> > > Oops/warnings are getting longer and longer, often scrolling away
> > > from the screen, and if the kernel crashes backscroll does not work
> > > anymore, so precious information is lost.
> > > 
> > > Can you merge it with some other line?
> > > 
> > > Just a [KDUMP] or so somewhere should be good enough.  
> > 
> > Or perhaps we should add it as a TAINT. Not all taints are bad.  
> 
> Hmm, I also thought about this before but It sounds like not match the
> "tainted" meaning with the assumption that it is bad :(

Not only that. Once set, taint flags are not supposed to go away, but
it is perfectly fine to unload a panic kernel.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
