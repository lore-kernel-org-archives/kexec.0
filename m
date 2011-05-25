Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QP8lZ-0007hn-DI
	for kexec@lists.infradead.org; Wed, 25 May 2011 07:44:31 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p4P7e4MR006281
	for <kexec@lists.infradead.org>; Wed, 25 May 2011 17:40:04 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4P7hgm31327342
	for <kexec@lists.infradead.org>; Wed, 25 May 2011 17:43:42 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4P7iD01028460
	for <kexec@lists.infradead.org>; Wed, 25 May 2011 17:44:14 +1000
Date: Wed, 25 May 2011 13:14:07 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement to
	filter out kernel data from vmcore
Message-ID: <20110525074407.GA9525@in.ibm.com>
References: <20110517195751.12740.97565.stgit@mars.in.ibm.com>
	<20110524203542.GH3860@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110524203542.GH3860@redhat.com>
Reply-To: mahesh@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, V Srivatsa <vatsa@linux.vnet.ibm.com>, Tachibana <tachibana@mxm.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>

On 2011-05-24 16:35:42 Tue, Vivek Goyal wrote:
> On Wed, May 18, 2011 at 01:29:06AM +0530, Mahesh J Salgaonkar wrote:
> > Hi All,
> > 
> > Please find the version 2 of makedumpfile enhancement patchset that introduces
> > a data filtering feature which enables makedumpfile to filter out desired kernel
> > symbol data and it's members from the specified VMCORE file. The data to be
> > filtered out is poisoned with character 'X' (58 in Hex).
> > 
> > This feature will be very useful for the customers who wants to erase the
> > customer sensitive data like security keys and other confidential data, in
> > DUMPFILE before sending it to support team for analysis.
> 
> Mahesh,
> 
> Apart from security keys, what are the other examples of data which needs
> to be removed?

The idea is to allow customer to remove any such confidential data that
he thinks should not be disclosed outside. The framework is generic
enough to accommodate any new such fields. The is intended just as a
security filter and not to be used as detrimental to crash's analysis of the
dump.

> 
> By erasing the data, you mean you set it to zero? Will it make sense to
> poison it with some specific pattern so that if crash or other tool
> are looking into it they know it has been posioned and it is not a
> case of corruption. This might help if a user erased a symbol which was
> required by crash for some analysis etc.

The data to be erased is poisoned with character 'X' (58 in Hex).

The last two patches 7/8 and 8/8 introduces eraseinfo section into
filtered compressed kdump and ELF kdump file. The compressed kdump file
now carries additional fields namely offset_eraseinfo and size_eraseinfo in
kdump sub header that can help crash to identify whether filtering is
been done. Similarly, ELF kdump file now contains new ELF note of type
NT_ERASEINFO, that can help crash to identify whether the filtering has been
done or not.

Thanks,
-Mahesh.

> 
> Thanks
> Vivek
> 
> > 
> > This feature introduces a filter config file where, using filter commands,
> > user can specify desired kernel data symbols and it's members that need to be
> > filtered out while creating o/p DUMPFILE. The Syntax for filter commands are
> > provided in the makedumpfile.conf(8) man page.
> > 
> > The first 4 patches prepares the base work for filtering framework. The
> > patches 5 and 6 implements the generic filtering framework to erase desired
> > kernel data. The last two patches implements inclusion of eraseinfo data into
> > o/p dumpfile (kdump as well as ELF). The eraseinfo data contains the
> > effective lines from configuration files.
> > 
> > I have tested these patches on x86_64 and s390x architecture against RHEL6 GA
> > kernel. The feature supports filtering data from ELF as well as
> > kdump-compressed formatted dump.
> > 
> > Change in v2:
> > - Changes in patch 5 and inclusion of new patches 7 & 8
> > - Re-named filter.conf file to makedumpfile.conf and some cleanup work.
> > - Introduced last two patches that implements inclusion of eraseinfo data
> >   into kdump compressed as well as ELF formatted dumpfile.
> > 
> > Please review the patchset and let me know your comments.
> > 
> > Thanks,
> > -Mahesh.
> > ---
> > 
> > Mahesh Salgaonkar (8):
> >       makedumpfile: Add '--config' option to specify filter config file.
> >       makedumpfile: Apply relocation while loading module debuginfo.
> >       makedumpfile: Load the module symbol data from vmcore.
> >       makedumpfile: Introduce routines to get type name from debuginfo.
> >       makedumpfile: Read and process filter commands from config file.
> >       makedumpfile: Read and process 'for' command from config file.
> >       makedumpfile: Add erased information in compressed kdump file
> >       makedumpfile: Add erase information in ELF formatted dumpfile
> > 
> > 
> >  IMPLEMENTATION      |    6 
> >  Makefile            |    8 
> >  diskdump_mod.h      |    2 
> >  makedumpfile.8      |   20 
> >  makedumpfile.c      | 2747 ++++++++++++++++++++++++++++++++++++++++++++++++---
> >  makedumpfile.conf   |  149 +++
> >  makedumpfile.conf.8 |  419 ++++++++
> >  makedumpfile.h      |  199 ++++
> >  8 files changed, 3394 insertions(+), 156 deletions(-)
> >  create mode 100644 makedumpfile.conf
> >  create mode 100644 makedumpfile.conf.8
> > 
> > -- 
> > Signature
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

-- 
Mahesh J Salgaonkar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
