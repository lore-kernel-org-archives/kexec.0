Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QjA4V-0001rg-Td
	for kexec@lists.infradead.org; Tue, 19 Jul 2011 13:10:54 +0000
Date: Tue, 19 Jul 2011 22:08:27 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading
	module debuginfo.
Message-Id: <20110719220827.809e490e.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E25557C.2080509@linux.vnet.ibm.com>
References: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
	<20110715183541.e9f5e604.oomichi@mxs.nes.nec.co.jp>
	<4E2014B2.70105@linux.vnet.ibm.com>
	<20110719112749.88d83252.oomichi@mxs.nes.nec.co.jp>
	<4E25557C.2080509@linux.vnet.ibm.com>
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
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Tue, 19 Jul 2011 15:29:24 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > 
> > By the way, do you have any documents/samples for dwfl_XXXX functions ?
> > I'd like to see them for reviewing this patch.
> 
> As far as I know there is no formal documentation available for
> dwfl_xxxx functions apart from 'elfutils/libdwfl/libdwfl.h' from
> elfutils sources. In fact the elfutils itself lacks the Documentation
> part for most of it's APIs.
> 
> I used 'elfutils/libdwfl/libdwfl.h' from elfutils sources as a reference
> which has neat explanation for each dwfl_xxx() functions. Apart from
> libdwfl.h I also used to go through actual function implementations
> available under elfutils sources.

OK, Thank you.
I also will see libdwfl.h as a reference.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
