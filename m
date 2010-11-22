Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PKajM-0003gB-6O
	for kexec@lists.infradead.org; Mon, 22 Nov 2010 18:03:08 +0000
Date: Mon, 22 Nov 2010 09:59:09 -0800
From: Greg KH <gregkh@suse.de>
Subject: Re: [Stable-review] [08/45] mm, x86: Saving vmcore with non-lazy
	freeing of vmas
Message-ID: <20101122175909.GB18867@suse.de>
References: <20101119214410.087440440@clark.site>
	<1290219372.3818.113.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1290219372.3818.113.camel@localhost>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@kernel.org, stable-review@kernel.org, Ingo Molnar <mingo@elte.hu>, torvalds@linux-foundation.org, Cliff Wickman <cpw@sgi.com>, alan@lxorguk.ukuu.org.uk

On Sat, Nov 20, 2010 at 02:16:12AM +0000, Ben Hutchings wrote:
> On Fri, 2010-11-19 at 13:42 -0800, Greg KH wrote:
> > 2.6.32-stable review patch.  If anyone has any objections, please let us know.
> > 
> > ------------------
> > 
> > From: Cliff Wickman <cpw@sgi.com>
> > 
> > commit 3ee48b6af49cf534ca2f481ecc484b156a41451d upstream.
> > 
> > During the reading of /proc/vmcore the kernel is doing
> > ioremap()/iounmap() repeatedly. And the buildup of un-flushed
> > vm_area_struct's is causing a great deal of overhead. (rb_next()
> > is chewing up most of that time).
> > 
> > This solution is to provide function set_iounmap_nonlazy(). It
> > causes a subsequent call to iounmap() to immediately purge the
> > vma area (with try_purge_vmap_area_lazy()).
> > 
> > With this patch we have seen the time for writing a 250MB
> > compressed dump drop from 71 seconds to 44 seconds.
> [...]
> 
> Useful, but it doesn't seem to meet the criteria for stable updates.

I disagree, it's a major speedup, and an obvious bugfix for the problem.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
