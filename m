Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj9Aa-0004Uk-0c
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 20:49:17 +0000
Date: Mon, 14 Jan 2019 15:49:14 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1862896935.69778880.1547498954956.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114203500.GU2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190114192144.GQ2773@zn.tnic>
 <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com>
 <20190114195940.GS2773@zn.tnic>
 <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com>
 <20190114201812.GT2773@zn.tnic>
 <221183717.69773903.1547497592624.JavaMail.zimbra@redhat.com>
 <20190114203500.GU2773@zn.tnic>
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
> On Mon, Jan 14, 2019 at 03:26:32PM -0500, Dave Anderson wrote:
> > No.  It needs *both* the vmlinux file and the vmcore file in order to read
> > kernel
> > virtual memory, so just having a kernel virtual address is insufficient.
> > 
> > So it's a chicken-and-egg situation.  This particular --osrelease option is used
> > to determine *what* vmlinux file would be required for an actual crash analysis
> > session.
> 
> Ok, that makes sense. I could've used that explanation when reviewing
> the documentation. Do you mind skimming through this:
> 
> https://lkml.kernel.org/r/20190111145650.GG4729@zn.tnic
> 
> in case we've missed explaining relevant usage - like that above - of
> some of the vmcoreinfo members?

Yeah, I've been watching the thread, and the document looks fine to me.
It's just that when I saw the discussion of this one being removed that
I felt the need to respond...  ;-)

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
