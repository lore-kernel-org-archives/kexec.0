Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qj0Pt-0003kf-Tp
	for kexec@lists.infradead.org; Tue, 19 Jul 2011 02:52:15 +0000
Date: Tue, 19 Jul 2011 11:27:49 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading
	module debuginfo.
Message-Id: <20110719112749.88d83252.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E2014B2.70105@linux.vnet.ibm.com>
References: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
	<20110715183541.e9f5e604.oomichi@mxs.nes.nec.co.jp>
	<4E2014B2.70105@linux.vnet.ibm.com>
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

On Fri, 15 Jul 2011 15:51:38 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > 
> > On my machine (RHEL5 x86_64), I cannot compile makedumpfile with this patch.
> > I guess that it is due to old elfutils of my machine, and I am trying this
> > problem by newer elfutils.
> > 
> > I'd like to get some hints, so can you tell me your environment ?
> > RHEL6 x86_64 ?
> 
> Yes, I had tested these patches on RHEL6.0 and RHEl6.1 x86_64. As far as
> I know RHEL6.0 had elfutils-0.148.
> 
> I did not try my patches on RHEL5 x86-64. Let me see if I can get a
> RHEL5 x86_64 box to verify.

I can compile it with elfutils-0.137 and some compiling options on RHEL5.
We need the following change in Makefile.

-       $(CC) $(CFLAGS) $(OBJ_ARCH) -o $@ $< -static -ldw -lelf -lz
+       $(CC) $(CFLAGS) $(OBJ_ARCH) -o $@ $< -static -ldw -lbz2 -lebl -ldl -lelf -lz


By the way, do you have any documents/samples for dwfl_XXXX functions ?
I'd like to see them for reviewing this patch.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
