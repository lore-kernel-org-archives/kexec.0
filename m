Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S84U5-0000hj-J3
 for kexec@lists.infradead.org; Thu, 15 Mar 2012 06:48:26 +0000
Date: Thu, 15 Mar 2012 15:48:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/5] Add generic debug option
Message-ID: <20120315064818.GC3449@verge.net.au>
References: <1331188782-10912-1-git-send-email-xiyou.wangcong@gmail.com>
 <20120313002116.GB24671@verge.net.au> <4F5EB7E0.8040701@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F5EB7E0.8040701@gmail.com>
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
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

On Tue, Mar 13, 2012 at 10:58:40AM +0800, Cong Wang wrote:
> On 03/13/2012 08:21 AM, Simon Horman wrote:
> >On Thu, Mar 08, 2012 at 02:39:38PM +0800, Cong Wang wrote:
> >>Currently the debugging code is under #ifdef DEBUG, which
> >>means when we want to debug, we have to re-compile the source
> >>code with -DDEBUG. This is not convenient, we want to have
> >>a generic --debug option so that we can enable debugging code
> >>without re-compiling.
> >>
> >>This patch moves the arch-specific --debug to generic place
> >>and moves code under #ifdef DEBUG to --debug on x86.
> >>
> >>BTW, the size of kexec binary increases very little after this patch.
> >
> >Hi Cong,
> >
> >In general I am happy with making kexec easier to use.  However, it would
> >be nice not to make kexec-tools even bigger than it already is. Its size
> >already seems to be an issue for some people on ARM at least.  Do you
> >have some feeling for the change in binary size on architectures other than
> >i386?
> >
> 
> Hi,
> 
> I only tested the patches on x86 and ppc.
> 
> Sorry I don't have a chance to test it on ARM, on ARM it just adds a
> small function dump_memory_ranges(), if this would be a problem,
> feel free to drop patch 3/5. :)

Hi,

As per my post to the ppc patch, it did not seem to compile for me.
I will push the remaining patches. For reference before and after
sizes for the non-ppc architectures are as follows.


x86_32
------

gcc (GCC) 4.1.1
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

before:
   text	   data	    bss	    dec	    hex	filename
 141357	    828	  57948	 200133	  30dc5	./build/sbin/kexec
after:
   text	   data	    bss	    dec	    hex	filename
 145233	    828	  57948	 204009	  31ce9	./build/sbin/kexec


x86_64
------

gcc (Debian 4.6.2-4) 4.6.2
Copyright (C) 2011 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

before:
   text	   data	    bss	    dec	    hex	filename
 180875	   1552	  66344	 248771	  3cbc3	./build/sbin/kexec
after:
   text	   data	    bss	    dec	    hex	filename
 185371	   1552	  66344	 253267	  3dd53	./build/sbin/kexec


arm
---

gcc (Sourcery G++ Lite 2011.03-41) 4.5.2
Copyright (C) 2010 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

before:
   text	   data	    bss	    dec	    hex	filename
  96914	    704	  16988	 114606	  1bfae	./build/sbin/kexec
after:
   text	   data	    bss	    dec	    hex	filename
  97262	    704	  16988	 114954	  1c10a	./build/sbin/kexec

mips
----

gcc (Sourcery G++ Lite 4.4-303) 4.4.1
Copyright (C) 2009 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

before:
   text	   data	    bss	    dec	    hex	filename
  98160	    784	  11688	 110632	  1b028	./build/sbin/kexec
after:
   text	   data	    bss	    dec	    hex	filename
  98560	    784	  11688	 111032	  1b1b8	./build/sbin/kexec

sh
--

gcc (Sourcery G++ Lite 4.4-200) 4.4.1
Copyright (C) 2009 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

before:
   text	   data	    bss	    dec	    hex	filename
 110675	    696	  11332	 122703	  1df4f	./build/sbin/kexec
after:
   text	   data	    bss	    dec	    hex	filename
 110783	    696	  11332	 122811	  1dfbb	./build/sbin/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
