Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj7RS-0001ID-Rz
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 18:58:36 +0000
Date: Mon, 14 Jan 2019 13:58:32 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114180142.GO2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com> <20190111123300.GE4729@zn.tnic>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
 <20190114180142.GO2773@zn.tnic>
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
> On Mon, Jan 14, 2019 at 05:48:48PM +0000, Kazuhito Hagio wrote:
> > As for makedumpfile, it will be not impossible to remove the
> > init_uts_ns.name.relase (OSRELEASE), but some fixes are needed.
> > Because historically OSRELEASE has been a kind of a mandatory entry
> > in vmcoreinfo from the beginning of vmcoreinfo, so makedumpfile uses
> > its existence to check whether a vmcoreinfo is sane.
> 
> Well, init_uts_ns is exported in vmcoreinfo anyway - makedumpfile
> can simply test init_uts_ns.name.release just as well. And the
> "historically" argument doesn't matter because vmcoreinfo is not an ABI.
> 
> So makedumpfile needs to be changed to check that new export.
> 
> > Also, I think crash also will need to be fixed if it is removed.

Preferably it would be left as-is.  The crash utility has a "crash --osrelease vmcore"
option that only looks at the dumpfile header, and just dump the string.  With respect
to compressed kdumps, crash could alternatively look at the utsname data that is stored
in the diskdump_header.utsname field, but with ELF vmcores, there is no such back-up.
What's the problem with leaving it alone?

Dave


> 
> Yes, I'm expecting user tools to be fixed and then exports removed.
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
