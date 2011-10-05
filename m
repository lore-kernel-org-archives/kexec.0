Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBV9N-0004Ln-2Y
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 17:20:57 +0000
Date: Wed, 5 Oct 2011 13:20:35 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005172035.GH30146@redhat.com>
References: <20111003073203.GA22694@in.ibm.com>
	<m162k64c7w.fsf@fess.ebiederm.org>
	<20111003120336.GK2223@in.ibm.com>
	<20111004063440.GB5723@liondog.tnic>
	<20111005070728.GA2235@in.ibm.com>
	<20111005073111.GA13478@liondog.tnic>
	<20111005094727.GB7485@in.ibm.com>
	<20111005155217.GE30146@redhat.com>
	<10327.1317830438@turing-police.cc.vt.edu>
	<20111005161626.GB18592@gere.osrc.amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005161626.GB18592@gere.osrc.amd.com>
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
To: Borislav Petkov <bp@alien8.de>
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, Valdis.Kletnieks@vt.edu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "K.Prasad" <prasad@linux.vnet.ibm.com>, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 06:16:26PM +0200, Borislav Petkov wrote:
> On Wed, Oct 05, 2011 at 12:00:38PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 05 Oct 2011 11:52:17 EDT, Vivek Goyal said:
> > 
> > > I am assuming that basic MCE error messages are available in kernel log. 
> > 
> > They're not in the kernel log if it's an MCE that causes the kernel to declare
> > a panic. There's some MCE's that you can retry the operation and continue, and
> > some that you can get away with poisoning a page, killing the process, and rest
> > of the system is OK.  But some you really need to roll over and die because you
> > can't guarantee kernel integrity anymore.
> > 
> > And at that point, those messages are never gonna make it to syslogd and onto
> > disk.
> 
> AFAICT, and for the sake of getting the MCE info, arguably one could
> look for log_buf in the vmcore of the old kernel and try to find the
> last lines in the kernel log ringbuffer. They should be the MCE error
> information from the do_machine_check MCE handler.
> 
> This all assuming of course we've managed to dump vmcore successfully by
> sidestepping the landmines :-).

We don't have to dump the whole vmcore. "makedumpfile" can extract just
the kernel log buffer. Following is a excerpt from makedumpfile man page.

***************************************************************************
       --dump-dmesg
              This option  overrides  the  normal  behavior  of makedumpfile.
              Instead  of  compressing  and  filtering  a  VMCORE  to make it
              smaller, it simply extracts the dmesg  log  from  a  VMCORE and
              writes it to the specified LOGFILE.

*****************************************************************************

So we can automate the whole thing by first extracting dmesg only, looking
for MCE messages and if there is none in last few lines, then save the
whole vmcore otherwise just save dmesg.

Or break down the dump saving process in two parts. First we just extract
and save the dmesg in a file and then try to save vmcore and in the
process if MCE happens, anyway we will reboot.

Exporting an ELF note just makes MCE information more structured instead
of scanning through dmesg.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
