Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KHOBu-00075y-Nr
	for kexec@lists.infradead.org; Fri, 11 Jul 2008 19:22:03 +0000
Date: Fri, 11 Jul 2008 12:21:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Message-Id: <20080711122131.b6461ab1.akpm@linux-foundation.org>
In-Reply-To: <20080708145051.GA14745@redhat.com>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080708145051.GA14745@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Kexec, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Huang Ying <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org

On Tue, 8 Jul 2008 10:50:51 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Jul 07, 2008 at 11:25:22AM +0800, Huang Ying wrote:
> > This patch provides an enhancement to kexec/kdump. It implements
> > the following features:
> > 
> > - Backup/restore memory used by the original kernel before/after
> >   kexec.
> > 
> > - Save/restore CPU state before/after kexec.
> > 
> 
> Hi Huang,
> 
> In general this patch set looks good enough to live in -mm and
> get some testing going.
> 
> To me, adding capability to return back to original kernel looks
> like a logical extension to kexec functionality.

Exciting ;)  It's much less code than I expected.

I don't think I understand the feature any more.  Once upon a time we
thought that this might become a new and better (or at least
better-code-sharing) way of doing suspend-to-disk.  How far are we from
that?

What are the prospects of supporting other architectures?

Who maintains kexec-tools, and are they OK with merging up the
corresponding changes?

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
