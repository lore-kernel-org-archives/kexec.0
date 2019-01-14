Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8WF-0007DS-IS
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 20:07:37 +0000
Date: Mon, 14 Jan 2019 15:07:33 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114195940.GS2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190111123300.GE4729@zn.tnic>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
 <20190114180142.GO2773@zn.tnic>
 <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com>
 <20190114192144.GQ2773@zn.tnic>
 <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com>
 <20190114195940.GS2773@zn.tnic>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org



----- Original Message -----
> On Mon, Jan 14, 2019 at 02:36:47PM -0500, Dave Anderson wrote:
> > There's no reading of the dumpfile's memory involved, and that being the case,
> > the vmlinux file is not utilized.  That's the whole point of the crash option, i.e.,
> > taking a vmcore file, and trying to determine what kernel should be used
> > with it:
> > 
> >   $ man crash
> >   ...
> >        --osrelease dumpfile
> >               Display the OSRELEASE vmcoreinfo string from a kdump dumpfile header.
> 
> I don't understand - if you have the vmcoreinfo (which I assume is part
> of the vmcore, yes, no?) you can go and dig out the kernel version from
> it, no?
> 
> Why should you not utilize the vmcore file?

That's what it *does* utilize -- it takes a standalone vmcore dumpfile, and 
pulls out the OSRELEASE string from it, so that a user can determine what
vmlinux file should be used with that vmcore for normal crash analysis.

Dave

> 
> (I'm most likely missing something.)
> 
> > Well, I just don't agree that the OSRELEASE item is "frivolous". It's
> > been in place, and depended upon, for many years.
> 
> Yeah, no. The ABI argument is moot in this case as in the last couple
> of months people have been persuading me that vmcoreinfo is not ABI. So
> you guys need to make up your mind what is it. And if it is an ABI, it
> wasn't documented anywhere.
> 
> --
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
