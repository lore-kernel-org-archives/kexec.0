Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QRSwO-00051T-9W
	for kexec@lists.infradead.org; Tue, 31 May 2011 17:41:17 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id p4VHelKr025221
	for <kexec@lists.infradead.org>; Tue, 31 May 2011 23:10:47 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4VHel253227728
	for <kexec@lists.infradead.org>; Tue, 31 May 2011 23:10:47 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4VHekWF019207
	for <kexec@lists.infradead.org>; Tue, 31 May 2011 23:10:46 +0530
Date: Tue, 31 May 2011 23:10:43 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 4/6] PANIC_MCE: Introduce a new panic flag for fatal
	MCE, capture related information
Message-ID: <20110531174043.GA2000@in.ibm.com>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526171521.GD17988@in.ibm.com>
	<m1fwo09g15.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1fwo09g15.fsf@fess.ebiederm.org>
Reply-To: prasad@linux.vnet.ibm.com
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
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On Fri, May 27, 2011 at 11:04:06AM -0700, Eric W. Biederman wrote:
> "K.Prasad" <prasad@linux.vnet.ibm.com> writes:
> 
> > PANIC_MCE: Introduce a new panic flag for fatal MCE, capture related information
> >
> > Fatal machine check exceptions (caused due to hardware memory errors) will now
> > result in a 'slim' coredump that captures vital information about the MCE. This
> > patch introduces a new panic flag, and new parameters to *panic functions
> > that can capture more information pertaining to the cause of crash.
> >
> > Enable a new elf-notes section to store additional information about the crash.
> > For MCE, enable a new notes section that captures relevant register status
> > (struct mce) to be later read during coredump analysis.
> 
> There may be a reason to pass everything struct mce through 5 layers of
> code but right now it looks like it just makes everything uglier to no
> real purpose.

We could have stopped with just a blank elf-note of type NT_MCE
indicating an MCE triggered panic, but dumping 'struct mce' in it will
help gather more useful information about the error - especially the
memory address that experienced unrecoverable error (stored in
mce->addr).

The patch 6/6 for the 'crash' tool enabled decoding of 'struct
mce' to show this information (although the sample log in patch 0/6)
didn't show these benefits because 'mce-inject' tool used to soft-inject
these errors doesn't populate all registers with valid contents.

The idea was that when mce->addr contains physical address is shown
while decoding coredump, the corresponding memory DIMM could be identified
for replacement/isolation.

Given that 'struct mce' isn't placed in a user-space visible file its
duplicate copies have to be maintained in 'crash' (like it is done in
'mcelog' tool), and that's one disadvantage.

If you think that this complicates the patch, I'll start with a much
'slimmer' version (!) of the slimdump and the improvements may be
contemplated iteratively.

Thanks,
K.Prasad

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
