Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JBLAQ-0006uE-O5
	for kexec@lists.infradead.org; Sun, 06 Jan 2008 02:23:21 +0000
Date: Sat, 5 Jan 2008 18:17:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: kexec refuses to boot latest -mm
Message-Id: <20080105181742.7525fec6.akpm@linux-foundation.org>
In-Reply-To: <20080104155415.GC6007@linux.vnet.ibm.com>
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<20071231150843.GB27060@redhat.com>
	<20080103195201.GC6392@linux.vnet.ibm.com>
	<200801032242.01425.rjw@sisk.pl>
	<20080104122816.GF4514@linux.vnet.ibm.com>
	<20080104155415.GC6007@linux.vnet.ibm.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Cc: maneesh@linux.vnet.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, hbabu@us.ibm.com, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

On Fri, 4 Jan 2008 21:24:15 +0530 Dhaval Giani <dhaval@linux.vnet.ibm.com> wrote:

> On Fri, Jan 04, 2008 at 05:58:16PM +0530, Dhaval Giani wrote:
> > On Thu, Jan 03, 2008 at 10:42:00PM +0100, Rafael J. Wysocki wrote:
> > > On Thursday, 3 of January 2008, Dhaval Giani wrote:
> > > > On Mon, Dec 31, 2007 at 10:08:43AM -0500, Vivek Goyal wrote:
> > > > > On Sat, Dec 29, 2007 at 11:11:13AM +0530, Dhaval Giani wrote:
> > > > > > On Fri, Dec 28, 2007 at 09:27:39AM -0500, Vivek Goyal wrote:
> > > > > > > On Fri, Dec 28, 2007 at 06:15:32PM +0530, Dhaval Giani wrote:
> > > > > > > > Hi Vivek,
> > > > > > > > 
> > 
> > I've no clue what I managed to do wrong last night, probably tried to boot
> > 2.6.24-rc6-mm1 thinking it was 2.6.24-rc6. 2.6.24-rc6 boots, but -mm
> > does not. Sorry for the noise.
> > 
> 
> So I went ahead and bisected -mm, and the culprit is git-x86. It boots
> fine before it, but with git-x86 applied, it fails to boot.
> 
> Ingo/Thomas, could you please point me to the git-x86 tree so that I can
> bisect it?

Every git-foo.patch in -mm identifies where it came from in its changelog.

The first few lines of
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc6/2.6.24-rc6-mm1/broken-out/git-x86.patch
are:

GIT 27197ba67cbaa0e22598a10c82b10dacb1309ed8 irqs_disabled

git+ssh://master.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git#mm



I'm not sure what the "irqs_disabled\n\n" is doing there: maybe I added it
by mistake.  2.6.24-rc5-mm1 correctly had

GIT b668e28b74558b3a8277b5fde363ae5f803b36f0 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git#mm

But still.  The git URL is always there.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
