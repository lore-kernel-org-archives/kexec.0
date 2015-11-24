Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]
 helo=cdptpa-oedge-vip.email.rr.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1JPP-0001QZ-TG
 for kexec@lists.infradead.org; Tue, 24 Nov 2015 19:37:48 +0000
Date: Tue, 24 Nov 2015 14:37:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [V5 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Message-ID: <20151124193700.GB6100@home.goodmis.org>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093646.4285.62259.stgit@softrs>
 <20151124104853.GC3785@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151124104853.GC3785@pd.tnic>
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
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Nov 24, 2015 at 11:48:53AM +0100, Borislav Petkov wrote:
> 
> > +	 */
> > +	while (!raw_spin_trylock(&nmi_reason_lock))
> > +		poll_crash_ipi_and_callback(regs);
> 
> Waaait a minute: so if we're getting NMIs broadcasted on every core but
> we're *not* crash dumping, we will run into here too. This can't be
> right. :-\

This only does something if crash_ipi_done is set, which means you are killing
the box. But perhaps a comment that states that here would be useful, or maybe
just put in the check here. There's no need to make it depend on SMP, as
raw_spin_trylock() will turn to just ({1}) for UP, and that code wont even be
hit.

-- Steve


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
