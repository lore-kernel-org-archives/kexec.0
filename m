Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1T5Z-0005CO-SK
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 05:57:58 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V5 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Date: Wed, 25 Nov 2015 05:57:34 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454A2A444@GSjpTKYDCembx31.service.hitachi.net>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093646.4285.62259.stgit@softrs> <20151124104853.GC3785@pd.tnic>
 <20151124193700.GB6100@home.goodmis.org>
In-Reply-To: <20151124193700.GB6100@home.goodmis.org>
Content-Language: ja-JP
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
To: 'Steven Rostedt' <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> On Tue, Nov 24, 2015 at 11:48:53AM +0100, Borislav Petkov wrote:
> >
> > > +	 */
> > > +	while (!raw_spin_trylock(&nmi_reason_lock))
> > > +		poll_crash_ipi_and_callback(regs);
> >
> > Waaait a minute: so if we're getting NMIs broadcasted on every core but
> > we're *not* crash dumping, we will run into here too. This can't be
> > right. :-\
> 
> This only does something if crash_ipi_done is set, which means you are killing
> the box. But perhaps a comment that states that here would be useful, or maybe
> just put in the check here. 

OK, I'll add more comments around this.

> There's no need to make it depend on SMP, as
> raw_spin_trylock() will turn to just ({1}) for UP, and that code wont even be
> hit.

I'll integrate these SMP and UP versions with a comment about
that.

Regards,
--
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
