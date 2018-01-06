Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eXqzz-0001RQ-D2
 for kexec@lists.infradead.org; Sat, 06 Jan 2018 16:07:09 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64FE280467
 for <kexec@lists.infradead.org>; Sat,  6 Jan 2018 16:06:56 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58ED95DA60
 for <kexec@lists.infradead.org>; Sat,  6 Jan 2018 16:06:56 +0000 (UTC)
Date: Sat, 6 Jan 2018 11:06:56 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <877254148.3374192.1515254816148.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180106061346.GA18939@dhcp-128-65.nay.redhat.com>
References: <mailman.7.1515009607.12089.kexec@lists.infradead.org>
 <727199273.2520585.1515010910495.JavaMail.zimbra@redhat.com>
 <20180105023828.GA11054@dhcp-128-65.nay.redhat.com>
 <1123355622.3166541.1515161806514.JavaMail.zimbra@redhat.com>
 <20180106061346.GA18939@dhcp-128-65.nay.redhat.com>
Subject: Re: makedumpfile saving vmcore fails with dynamically allocated
 mem_section (was: Re: [PATCH] handle renamed init_level4_pgt ->
 init_top_pgt)
MIME-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> On 01/05/18 at 09:16am, Dave Anderson wrote:
> > 
> > 
> > ----- Original Message -----
> > > On 01/03/18 at 03:21pm, Dave Anderson wrote:
> > > > 
> > > > 
> > > > ----- Original Message -----
> > > > 
> > > > > On 01/02/18 at 05:08pm, Baoquan He wrote:
> > > > > > On 01/02/18 at 04:57pm, Dave Young wrote:
> > > > > > > The root cause is this commit makes mem_section as a pointer
> > > > > > > instead
> > > > > > > of
> > > > > > > the static array.
> > > > > > > 
> > > > > > > VMCOREINFO_SYMBOL() expand it as &mem_section, this is not
> > > > > > > correct in
> > > > > > > the test case any more.
> > > > > > > 
> > > > > > > This hack code works for me:
> > > > > > > 
> > > > > > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > > > > > index b3663896278e..f5fe6068ae39 100644
> > > > > > > --- a/kernel/crash_core.c
> > > > > > > +++ b/kernel/crash_core.c
> > > > > > > @@ -376,6 +376,8 @@ phys_addr_t __weak
> > > > > > > paddr_vmcoreinfo_note(void)
> > > > > > >  {
> > > > > > >  	return __pa(vmcoreinfo_note);
> > > > > > >  }
> > > > > > > +#define VMCOREINFO_SYMBOL_HACK(name) \
> > > > > > > +	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned
> > > > > > > long)name)
> > > > > > 
> > > > > > Oh, you made a new one. We may use vmcoreinfo_append_str directly
> > > > > > since
> > > > > > there's an existing one in crash_save_vmcoreinfo():
> > > > > 
> > > > > Yes, it should be something like this instead, this should ensure
> > > > > makedumpfile maybe crash tool works without any modifications,
> > > > > waiting for feedback from Atsushi, also ccing Dave for crash utility
> > > > > potential issue.
> > > > 
> > > > Yeah, I ran into that issue when testing 4.15, and fixed it upstream:
> > > > 
> > > >   https://github.com/crash-utility/crash/commit/264f22dafe9f37780c4113fd08e8d5b2138edbce
> > > > 
> > > >   commit 264f22dafe9f37780c4113fd08e8d5b2138edbce
> > > >   Author: Dave Anderson <anderson@redhat.com>
> > > >   Date:   Wed Nov 29 15:28:41 2017 -0500
> > > > 
> > > >     Fix for Linux 4.15 and later kernels that are configured with
> > > >     CONFIG_SPARSEMEM_EXTREME, and that contain kernel commit
> > > >     83e3c48729d9ebb7af5a31a504f3fd6aff0348c4, titled "mm/sparsemem:
> > > >     Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y".
> > > >     Without the patch, kernels configured with SPARSEMEM_EXTREME
> > > >     have changed the data type of "mem_section" from an array to
> > > >     a pointer, leading to errors in commands such as "kmem -p",
> > > >     "kmem -n", "kmem -s", and any other command that translates a
> > > >     physical address to its page struct address.
> > > >     (anderson@redhat.com)
> > > > 
> > > 
> > > Hi Dave,
> > > 
> > > I tried latest crash tool, but segment fault happened, I put the
> > > vmlinux/vmcore in below url, could you have a look?:
> > > http://people.redhat.com/ruyang/rhbz1528542/127.0.0.1-2018-01-05-10:29:23/
> > 
> > I can't access them:
> > 
> >   Forbidden
> > 
> >   You don't have permission to access
> >   /ruyang/rhbz1528542/127.0.0.1-2018-01-05-10:29:23/vmcore on this server.
> 
> Oops, updated with chmod 666
> > 
> > Although, in the meantime, what should first be clarified is why this
> > message occurred:
> > 
> >   WARNING: kernel version inconsistency between vmlinux and dumpfile
> > 
> > If you run with at least "crash -d1", it will display the version strings from
> > the vmlinux file and the dumpfile, and they should be identical.
> 
> Sorry about that, maybe I mistakenly use another build:
> dumpfile /proc/version:
> Linux version 4.15.0-rc6+ (dyoung@dhcp-128-65.nay.redhat.com) (gcc version
> 7.2.1 20170915 (Red Hat 7.2.1-4) (GCC)) #455 SMP Fri Jan 5 09:57:01 CST 2018
> vmlinux:
> Linux version 4.15.0-rc6+ (dyoung@dhcp-128-65.nay.redhat.com) (gcc version
> 7.2.1 20170915 (Red Hat 7.2.1-4) (GCC)) #456 SMP Fri Jan 5 10:26:27 CST 2018
> 
> But should be some simple change over the vmcore_append_str as Baoquan's
> suggestions, maybe I used Fedora default crash tool, I'm not sure now :(

No it's not the crash utility version that's the problem, but rather the 
vmcore_append_str() addition, which would modify/increment the virtual 
addresses of all static data symbols that come after it.  The crash utility
doesn't stand a prayer of working when the data symbol values in the vmlinux
do not match those in the vmcore.  

Dave


> 
> Retest with a fresh build, crash works fine to me. Here are the new
> files:
> http://people.redhat.com/ruyang/rhbz1528542/127.0.0.1-2018-01-06-14:02:59/
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
