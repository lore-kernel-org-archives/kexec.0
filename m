Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QrmS9-0003CN-8E
	for kexec@lists.infradead.org; Fri, 12 Aug 2011 07:46:50 +0000
Date: Fri, 12 Aug 2011 16:33:06 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 5/8] makedumpfile: Read and process filter commands
	from config file.
Message-Id: <20110812163306.95fa9fce.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110811120348.GB2817@in.ibm.com>
References: <20110517200407.12740.95780.stgit@mars.in.ibm.com>
	<20110811110716.7aec3c9e.oomichi@mxs.nes.nec.co.jp>
	<20110811141751.7927b2bb.oomichi@mxs.nes.nec.co.jp>
	<20110811120348.GB2817@in.ibm.com>
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
To: mahesh@linux.vnet.ibm.com
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Thu, 11 Aug 2011 17:33:48 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > > 
> > > BTW makedumpfile.c has become a large file which is bigger than 10KLine,
> > > and I will separate it to some files for the maintenance.
> > 
> > To shrink makedumpfile.c file, I made a prototype patch.
> > (commit 40f5724152047a12e4ac9db51d9f9e00e7a79ebe of filter-out-devel branch)
> > And I'd like to see your opinion.
> > 
> 
> I like the idea. The prototype patch looks good. I think we can
> even separate out the module symbol load/clean up functions including all
> associated functions out of makedumpfile.c. What do you think?

Yes.
I think it is a good direction that we separete out the module symbol
load code, which is added by you, from makedumpfile.c.
And I will try it.

Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
