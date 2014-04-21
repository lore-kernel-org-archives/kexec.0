Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcGQz-0003sq-9V
 for kexec@lists.infradead.org; Mon, 21 Apr 2014 15:47:05 +0000
Date: Mon, 21 Apr 2014 17:46:30 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140421174630.78565d63@hananiah.suse.cz>
In-Reply-To: <20140421151914.GD4367@redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE97201A0F@BPXM01GP.gisp.nec.co.jp>
 <585335973.3025244.1397211578378.JavaMail.zimbra@redhat.com>
 <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
 <20140416064445.GC8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
 <20140417045208.GE8084@dhcp-16-105.nay.redhat.com>
 <20140417050219.GF8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
 <20140418142912.GA2023@dhcp-17-102.nay.redhat.com>
 <20140418214133.2668464c@hananiah.suse.cz>
 <20140421151914.GD4367@redhat.com>
Mime-Version: 1.0
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
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>

On Mon, 21 Apr 2014 11:19:14 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Apr 18, 2014 at 09:41:33PM +0200, Petr Tesarik wrote:
> > On Fri, 18 Apr 2014 22:29:12 +0800
> > "bhe@redhat.com" <bhe@redhat.com> wrote:
>[...]
> > > Instead, I am wondering how the 80% comes from, and why 20% of free
> > > memory must be safe.
> > 
> > I believe these 80% come from the default value of vm.dirty_ratio,
> 
> Actually I had suggested this 80% number when --cyclic feature was
> implemented. And I did not base it on dirty_ratio. Just a random
> suggestion.

Hm. OK, you seem to have very good suggestions, even if they are
random. ;-)

> > which is 20%. In other words, the kernel won't block further writes
> > until 20% of available RAM is used up by dirty cache. But if you
> > fill up all free memory with dirty pages and then touch another (though
> > allocated) page, the kernel will go into direct reclaim, and if nothing
> > can be written out ATM, it will invoke the OOM Killer.
> 
> We can start playig with reducing dirty_raio too and see how does it go.

Or use direct I/O... Is it still broken?

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
