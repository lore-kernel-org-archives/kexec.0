Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QRp3y-00007S-1u
	for kexec@lists.infradead.org; Wed, 01 Jun 2011 17:18:35 +0000
Date: Wed, 1 Jun 2011 13:18:16 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <718105787.11709.1306948696436.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20110531174043.GA2000@in.ibm.com>
Subject: Re: [RFC Patch 4/6] PANIC_MCE: Introduce a new panic flag for fatal
	MCE, capture related information
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: prasad@linux.vnet.ibm.com
Cc: Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>



----- Original Message -----
> On Fri, May 27, 2011 at 11:04:06AM -0700, Eric W. Biederman wrote:
> > "K.Prasad" <prasad@linux.vnet.ibm.com> writes:
> >
> > > PANIC_MCE: Introduce a new panic flag for fatal MCE, capture
> > > related information
> > >
> > > Fatal machine check exceptions (caused due to hardware memory errors) will now
> > > result in a 'slim' coredump that captures vital information about the MCE. This
> > > patch introduces a new panic flag, and new parameters to *panic functions
> > > that can capture more information pertaining to the cause of
> > > crash.
> > >
> > > Enable a new elf-notes section to store additional information about the crash.
> > > For MCE, enable a new notes section that captures relevant register status
> > > (struct mce) to be later read during coredump analysis.
> >
> > There may be a reason to pass everything struct mce through 5 layers of
> > code but right now it looks like it just makes everything uglier to no
> > real purpose.
> 
> We could have stopped with just a blank elf-note of type NT_MCE
> indicating an MCE triggered panic, but dumping 'struct mce' in it will
> help gather more useful information about the error - especially the
> memory address that experienced unrecoverable error (stored in mce->addr).
> 
> The patch 6/6 for the 'crash' tool enabled decoding of 'struct
> mce' to show this information (although the sample log in patch 0/6)
> didn't show these benefits because 'mce-inject' tool used to soft-inject
> these errors doesn't populate all registers with valid contents.
> 
> The idea was that when mce->addr contains physical address is shown
> while decoding coredump, the corresponding memory DIMM could be identified
> for replacement/isolation.
> 
> Given that 'struct mce' isn't placed in a user-space visible file its
> duplicate copies have to be maintained in 'crash' (like it is done in
> 'mcelog' tool), and that's one disadvantage.

FWIW, unlike mcelog, it really doesn't have to be maintained in the crash
utility.  It's just another kernel data structure whose contents can be
determined dynamically during runtime:

  crash> struct mce
  struct mce {
      __u64 status;
      __u64 misc;
      __u64 addr;
      __u64 mcgstatus;
      __u64 ip;
      __u64 tsc;
      __u64 time;
      __u8 cpuvendor;
      __u8 inject_flags;
      __u16 pad;
      __u32 cpuid;
      __u8 cs;
      __u8 bank;
      __u8 cpu;
      __u8 finished;
      __u32 extcpu;
      __u32 socketid;
      __u32 apicid;
      __u64 mcgcap;
  }
  SIZE: 88
  crash> 

Dave
 
> If you think that this complicates the patch, I'll start with a much
> 'slimmer' version (!) of the slimdump and the improvements may be
> contemplated iteratively.
> 
> Thanks,
> K.Prasad

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
