Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PHqZM-00044R-Bh
	for kexec@lists.infradead.org; Mon, 15 Nov 2010 04:21:29 +0000
Date: Mon, 15 Nov 2010 12:54:06 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v1] makedumpfile: s390x: Add support for s390x crashdump
	analysis
Message-Id: <20101115125406.5acb1fdc.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4CDCE715.4050708@linux.vnet.ibm.com>
References: <20101111052840.14598.72719.stgit@mars.in.ibm.com>
	<20101112102856.a20dae40.oomichi@mxs.nes.nec.co.jp>
	<20101112113318.a69b0b57.oomichi@mxs.nes.nec.co.jp>
	<4CDCE715.4050708@linux.vnet.ibm.com>
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
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec-ml <kexec@lists.infradead.org>, Michael Holzheu <holzheu@de.ibm.com>, Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Fri, 12 Nov 2010 12:34:53 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >>>
> >>> This patch adds support for processing s390x kernel crashdumps.
> >>>
> >>> The changes have been tested on s390x system.
> >>> The dump compression and filtering (for all dump levels 1,2,4,8,16 and 31)
> >>> tests are succussfull.
> >>
> >> What version of linux kernel are the above tests on ?
> >> I'd like to write the version on README file.
> > 
> > Also, please let me know the memory model (flatmem, discontigmem,
> > or sparsemem) too.
> > 
> >   # make menuconfig
> >   -> Processor type and features
> >      -> Memory model
> > 
> 
> I have tested this on RHEL6.0 GA kernel version 2.6.32-71.el6.s390x.
> 
> The memory model is 'Sparse Memory'

Thank you.
Your patch has been merged to git tree.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
