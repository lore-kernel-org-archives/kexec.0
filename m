Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RBV2A-0004GO-6Q
	for kexec@lists.infradead.org; Wed, 05 Oct 2011 17:13:30 +0000
Date: Wed, 5 Oct 2011 13:13:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111005171308.GG30146@redhat.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<m162k64c7w.fsf@fess.ebiederm.org>
	<20111003120336.GK2223@in.ibm.com>
	<20111004063440.GB5723@liondog.tnic>
	<20111005070728.GA2235@in.ibm.com>
	<20111005073111.GA13478@liondog.tnic>
	<20111005094727.GB7485@in.ibm.com>
	<20111005155217.GE30146@redhat.com>
	<10327.1317830438@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10327.1317830438@turing-police.cc.vt.edu>
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
To: Valdis.Kletnieks@vt.edu
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, anderson@redhat.com, "K.Prasad" <prasad@linux.vnet.ibm.com>, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 12:00:38PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 05 Oct 2011 11:52:17 EDT, Vivek Goyal said:
> 
> > I am assuming that basic MCE error messages are available in kernel log. 
> 
> They're not in the kernel log if it's an MCE that causes the kernel to declare
> a panic. There's some MCE's that you can retry the operation and continue, and
> some that you can get away with poisoning a page, killing the process, and rest
> of the system is OK.  But some you really need to roll over and die because you
> can't guarantee kernel integrity anymore.
> 
> And at that point, those messages are never gonna make it to syslogd and onto
> disk.

Actually I meant that these messages should have made into kernel log
buffer and not on disk. And user space has capability to just extract
kernel log buffer by looking at /proc/vmcore.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
