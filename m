Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TlUV6-0003sE-GU
 for kexec@lists.infradead.org; Thu, 20 Dec 2012 01:00:41 +0000
Date: Wed, 19 Dec 2012 17:00:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] Add the values related to buddy system for filtering
 free pages.
Message-Id: <20121219170038.f7b260c3.akpm@linux-foundation.org>
In-Reply-To: <878v8ty200.fsf@xmission.com>
References: <20121210103913.020858db777e2f48c59713b6@mxc.nes.nec.co.jp>
 <20121219161856.e6aa984f.akpm@linux-foundation.org>
 <878v8ty200.fsf@xmission.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On Wed, 19 Dec 2012 16:57:03 -0800
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > Is there any way in which we can move some of this logic into the
> > kernel?  In this case, add some kernel code which uses PageBuddy() on
> > behalf of makedumpfile, rather than replicating the PageBuddy() logic
> > in userspace?
> 
> All that exists when makedumpfile runs is a core file.  So it would have
> to be something like a share library that builds with the kernel and
> then makedumpfile loads.

Can we omit free pages from that core file?

And/or add a section to that core file which flags free pages?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
