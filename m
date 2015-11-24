Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1KTK-0008NZ-Rt
 for kexec@lists.infradead.org; Tue, 24 Nov 2015 20:45:55 +0000
Date: Tue, 24 Nov 2015 15:45:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [V5 PATCH 1/4] panic/x86: Fix re-entrance problem due to panic
 on NMI
Message-ID: <20151124154528.45203352@gandalf.local.home>
In-Reply-To: <20151124202712.GA23063@dhcp22.suse.cz>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093644.4285.9349.stgit@softrs>
 <20151124150510.GA6100@home.goodmis.org>
 <20151124202712.GA23063@dhcp22.suse.cz>
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
To: Michal Hocko <mhocko@kernel.org>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, 24 Nov 2015 21:27:13 +0100
Michal Hocko <mhocko@kernel.org> wrote:


> > What happens if:
> > 
> > 	CPU 0:				CPU 1:
> > 	------				------
> > 	nmi_panic();
> > 
> > 					nmi_panic();
> > 					<external nmi>
> > 					nmi_panic();  
> 
> I thought that nmi_panic is called only from the nmi context. If so how
> can we get a nested NMI like that?

Nevermind. I was thinking the external NMI could nest, but I'm guessing
it cant. Anyway, the patches later on modify this code which checks for
something other than != this_cpu, which makes this issue mute even if
it could nest.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
