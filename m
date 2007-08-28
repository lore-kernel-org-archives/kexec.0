Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IPpeO-0002ZI-BG
	for kexec@lists.infradead.org; Mon, 27 Aug 2007 21:13:51 -0400
Subject: Re: [RFC][PATCH 2/2 -mm] kexec based hibernation: kexec restore
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20070827213134.GE3398@elf.ucw.cz>
References: <1188177296.3247.38.camel@caritas-dev.intel.com>
	<20070827213134.GE3398@elf.ucw.cz>
Date: Tue, 28 Aug 2007 09:14:37 +0800
Message-Id: <1188263677.2050.8.camel@caritas-dev.intel.com>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Mon, 2007-08-27 at 23:31 +0200, Pavel Machek wrote:
> Hi!
> 
> > This patch adds writing support for /dev/oldmem. This is used to
> > restore the memory contents of hibernated system.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> > +ssize_t write_oldmem_page(unsigned long pfn, const char *buf,
> > +			  size_t csize, unsigned long offset, int userbuf)
> 
> Hmm, int userbuf is only ever set to one... Does it make sense to have
> write_oldmem_page in the separate file? The onl user is mem.c, perhaps
> it should go there?
> 

write_oldmem_page is kept to be consistent with copy_oldmem_page as much
as possible. The userbuf is used by copy_oldmem_page too, and
write_oldmem_page is in the same file as copy_oldmem_page. I think the
consistence between them is reasonable.

And the copy_oldmem_page/write_oldmem_page is considered to be
architecture dependent. Now, there are different implementations for
copy_oldmem_page on different architectures. So I think the
copy_oldmem_page/write_oldmem_page should be kept in separate file
instead of go mem.c.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
