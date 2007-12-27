Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J7iYN-0007Vi-Ky
	for kexec@lists.infradead.org; Thu, 27 Dec 2007 02:33:06 +0000
Subject: Re: [PATCH 0/3 -mm] kexec jump -v8
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20071227015716.GA6718@redhat.com>
References: <1198222399.1965.15.camel@caritas-dev.intel.com>
	<20071227015716.GA6718@redhat.com>
Date: Thu, 27 Dec 2007 10:33:13 +0800
Message-Id: <1198722793.7320.15.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Wed, 2007-12-26 at 20:57 -0500, Vivek Goyal wrote:
[...]
> > 9. Now, you are in the original kernel again. You can read/write the
> >    memory image of kexeced kernel via /proc/kimgcore.
> > 
> 
> Why do we need two interfaces, /proc/vmcore and /proc/kimgcore? Can't
> we have just one say /proc/vmcore. Irrespective of what kernel you are
> in /proc/vmcore gives you the access to the memory of kernel which was
> previously booted.

In theory we can kexec another kernel even in a kexeced kernel, that is,
in kernel A kexec kernel B, and in kernel B kexec another kernel C. In
this situation, both /proc/vmcore and /proc/kimgcore has valid contents.
So I think, it may be better to keep two interfaces.

In fact, current kexec jump implementation use a dummy "jump back helper
image" in kexeced kernel to jump back to the original kernel. The "jump
back helper image" has no PT_LOAD segment, it is used to provide a
struct kimage (including control page, swap page) and entry point to
jump back.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
