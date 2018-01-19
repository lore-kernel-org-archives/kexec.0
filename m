Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecOac-0007Hv-LG
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 04:47:44 +0000
Date: Fri, 19 Jan 2018 12:47:19 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180119044719.GA3985@dhcp-128-65.nay.redhat.com>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180118135704.62d0f79f@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180118135704.62d0f79f@gandalf.local.home>
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: pmladek@suse.com, Andi Kleen <ak@linux.intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

On 01/18/18 at 01:57pm, Steven Rostedt wrote:
> On Thu, 18 Jan 2018 10:02:17 -0800
> Andi Kleen <ak@linux.intel.com> wrote:
> 
> > Dave Young <dyoung@redhat.com> writes:
> > >  		printk("%sHardware name: %s\n",
> > >  		       log_lvl, dump_stack_arch_desc_str);
> > > +	if (kexec_crash_loaded())
> > > +		printk("%skdump kernel loaded\n", log_lvl);  
> > 
> > Oops/warnings are getting longer and longer, often scrolling away
> > from the screen, and if the kernel crashes backscroll does not work
> > anymore, so precious information is lost.
> > 
> > Can you merge it with some other line?
> > 
> > Just a [KDUMP] or so somewhere should be good enough.
> 
> Or perhaps we should add it as a TAINT. Not all taints are bad.

Hmm, I also thought about this before but It sounds like not match the
"tainted" meaning with the assumption that it is bad :(

Maybe it would be better to do like Andi said, but print a better word
than "KDUMP", eg. "Kdumpable" sounds better.  If this is fine I can
repost the patch.

> 
> -- Steve

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
