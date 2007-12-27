Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J7xDU-0001XZ-Nt
	for kexec@lists.infradead.org; Thu, 27 Dec 2007 18:12:30 +0000
Date: Thu, 27 Dec 2007 13:12:18 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/3 -mm] kexec jump -v8
Message-ID: <20071227181218.GA15084@redhat.com>
References: <1198222399.1965.15.camel@caritas-dev.intel.com>
	<20071227015716.GA6718@redhat.com>
	<1198722793.7320.15.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1198722793.7320.15.camel@caritas-dev.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Thu, Dec 27, 2007 at 10:33:13AM +0800, Huang, Ying wrote:
> On Wed, 2007-12-26 at 20:57 -0500, Vivek Goyal wrote:
> [...]
> > > 9. Now, you are in the original kernel again. You can read/write the
> > >    memory image of kexeced kernel via /proc/kimgcore.
> > > 
> > 
> > Why do we need two interfaces, /proc/vmcore and /proc/kimgcore? Can't
> > we have just one say /proc/vmcore. Irrespective of what kernel you are
> > in /proc/vmcore gives you the access to the memory of kernel which was
> > previously booted.
> 
> In theory we can kexec another kernel even in a kexeced kernel, that is,
> in kernel A kexec kernel B, and in kernel B kexec another kernel C. In
> this situation, both /proc/vmcore and /proc/kimgcore has valid contents.
> So I think, it may be better to keep two interfaces.
> 

In those situations I think only one interface is better. For example, 
above will be broken if somebody kexec 4 kernels.

A-->B--->C--->D

I think better option might be if it is stack like situation. A kernel
shows you only the previous kernel's memory contents through /proc/vmcore
interface. So If I am in kernel D, I see only kernel C's memory image.
To see kernel B's memory image, one shall have to go back to kernel C.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
