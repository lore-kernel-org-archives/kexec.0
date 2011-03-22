Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q1rse-0002zA-6n
	for kexec@lists.infradead.org; Tue, 22 Mar 2011 03:03:37 +0000
Date: Tue, 22 Mar 2011 12:00:32 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: s390x: Fix KVBASE to correct value for
	s390x arcitecture.
Message-Id: <20110322120032.0edfbd03.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <1300443097.1981.16.camel@holzheu-laptop>
References: <20110315170902.32471.52757.stgit@mars.in.ibm.com>
	<20110317153912.de4162a9.oomichi@mxs.nes.nec.co.jp>
	<1300443097.1981.16.camel@holzheu-laptop>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec-ml <kexec@lists.infradead.org>, Michael Holzheu <holzheu@de.ibm.com>, Sachin P Sant <sachinp@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Michael,

Thank you for the explanation.

On Fri, 18 Mar 2011 11:11:37 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> 
> On Thu, 2011-03-17 at 15:39 +0900, Ken'ichi Ohmichi wrote:
> > Hi Mahesh,
> > 
> > On Tue, 15 Mar 2011 22:39:23 +0530
> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > >
> > > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > > 
> > > While excluding free pages from s390x dumps taken on LPAR, makedumpfile
> > > fails to convert page address to pfn. The reason is, the memory for
> > > mem_section structure is allocated below '_stext' and since KVBASE is
> > > set to SYMBOL(_stext), the function is_kvaddr() fails and return NULL
> > > address.
> > 
> > Why do we need this patch ?
> > to support the latest kernel version of s390 ?
> > or to support LPAR of s390 ?
> 
> The problem is that on s390 depending on the kernel configuration it can
> happen that memory below _stext is available for buffer allocation.
> Therefore the mem_section structure has been allocated below _stext. On
> s390 the kernel page tables have a 1:1 mapping from 0 to memory_end
> (memory holes are possible). Therefore I think the check "> 0" is ok for
> s390.

I see. And I confirmed there is the same code (kvbase is 0) in the crash
utility in the case of s390x, so this change is right.
Mahesh's patch has been merged to the git tree.

http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=commit;h=c69f915b8163bb9209cb329a6186b7261b545a4b


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
