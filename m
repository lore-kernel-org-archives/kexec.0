Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RCD3T-0001qX-4Z
	for kexec@lists.infradead.org; Fri, 07 Oct 2011 16:13:48 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <kexec@lists.infradead.org> from <prasad@linux.vnet.ibm.com>;
	Fri, 7 Oct 2011 17:09:04 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p97GDHtR1839130
	for <kexec@lists.infradead.org>; Sat, 8 Oct 2011 03:13:17 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p97GDG6o028813
	for <kexec@lists.infradead.org>; Sat, 8 Oct 2011 03:13:17 +1100
Date: Fri, 7 Oct 2011 21:42:19 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111007161218.GA2297@in.ibm.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004140437.GA28306@redhat.com>
	<20111005071844.GB2235@in.ibm.com>
	<20111005152537.GB30146@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111005152537.GB30146@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, Valdis.Kletnieks@vt.edu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Borislav Petkov <bp@alien8.de>, crash-utility@redhat.com

On Wed, Oct 05, 2011 at 11:25:37AM -0400, Vivek Goyal wrote:
> On Wed, Oct 05, 2011 at 12:48:44PM +0530, K.Prasad wrote:
> > On Tue, Oct 04, 2011 at 10:04:37AM -0400, Vivek Goyal wrote:
> > > On Mon, Oct 03, 2011 at 01:02:03PM +0530, K.Prasad wrote:
> > > > There are certain types of crashes induced by faulty hardware in which
> > > > capturing crashing kernel's memory (through kdump) makes no sense (or sometimes
> > > > dangerous).
> > > > 
> > > > A case in point, is unrecoverable memory errors (resulting in fatal machine
> > > > check exceptions) in which reading from the faulty memory location from the
> > > > kexec'ed kernel will cause double fault and system reset (leaving no
> > > > information for the user).
> > > 
> > > Prasad,
> > > 
> > > I am just trying to remember what was wrong with Andi's approach of
> > > disable MCE while copying the dump?
> > >
> > 
> > Hi Vivek,
> > 	The behaviour upon a read operation on an UC memory location is
> > undefined and so we want to avoid it (previously discussed here:
> > http://article.gmane.org/gmane.linux.kernel/1146799).
> 
> > When we disable MCE and copy the dump, we will invariably read the faulty
> > memory location.
> 
> And how that is worse then not capturing a dump at all? Anyway, you said
> that in case of MCE vmcore is of no use and we don't want to capture it.
>

The problem, as pointed out by Borislav Petkov in a different mail, is that
we might end up capturing a vmcore containing corrupted data when the
same is not required for analysing the cause of the crash.

Of course, all this is assuming that reading the faulty memory with MCE
disabled is harmless. However, the effect of a read operation in this
case is undefined.

Thanks,
K.Prasad
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
