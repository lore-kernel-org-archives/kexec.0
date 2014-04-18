Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WbEfh-0002Uu-IW
 for kexec@lists.infradead.org; Fri, 18 Apr 2014 19:42:02 +0000
Date: Fri, 18 Apr 2014 21:41:33 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140418214133.2668464c@hananiah.suse.cz>
In-Reply-To: <20140418142912.GA2023@dhcp-17-102.nay.redhat.com>
References: <20140410214433.GF18808@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97201A0F@BPXM01GP.gisp.nec.co.jp>
 <585335973.3025244.1397211578378.JavaMail.zimbra@redhat.com>
 <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
 <20140416064445.GC8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
 <20140417045208.GE8084@dhcp-16-105.nay.redhat.com>
 <20140417050219.GF8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
 <20140418142912.GA2023@dhcp-17-102.nay.redhat.com>
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "zzou@redhat.com" <zzou@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On Fri, 18 Apr 2014 22:29:12 +0800
"bhe@redhat.com" <bhe@redhat.com> wrote:

> 
> > >> It definitely will cause OOM. On my test machine, it has 100G memory. So
> > >> per old code, its needed_size is 3200K*2 == 6.4M, if currently free
> > >> memory is only 15M left, the free_size will be 15M*0.4 which is 6M. So
> > >> info->bufsize_cyclic is assigned to be 6M. and only 3M is left for other
> > >> use, e.g page cache, dynamic allocation. OOM will happen.
> > >>
> > >
> > >BTW, in our case, there's about 30M free memory when we started saving
> > >dump. It should be caused by my coarse estimation above.
> > 
> > Thanks for your description, I understand that situation and
> > the nature of the problem.
> > 
> > That is, the assumption that 20% of free memory is enough for
> > makedumpfile can be broken if free memory is too small.
> > If your machine has 200GB memory, OOM will happen even after fix
> > the too allocation bug.
> 
> Well, we have done some experiments to try to get the statistical memory
> range which kdump really need. Then a final reservation will be
> calculated automatically as (base_value + linear growth of total memory). 
> If one machine has 200GB memory, its reservation will grow too. Since
> except of the bitmap cost, other memory cost is almost fixed. 
> 
> Per this scheme things should be go well, if memory always goes to the
> edge of OOM, an adjust of base_value is needed. So a constant value as
> you said may not be needed.
> 
> Instead, I am wondering how the 80% comes from, and why 20% of free
> memory must be safe.

I believe these 80% come from the default value of vm.dirty_ratio,
which is 20%. In other words, the kernel won't block further writes
until 20% of available RAM is used up by dirty cache. But if you
fill up all free memory with dirty pages and then touch another (though
allocated) page, the kernel will go into direct reclaim, and if nothing
can be written out ATM, it will invoke the OOM Killer.

I figured out that the actual requirements also depend on the target
device driver, filesystem (e.g. NFS is considerably more memory-hungry
than ext3) and (not the least) number of online CPUs.

The calculation is quite complex, and that's probably why nobody has
done it properly yet.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
