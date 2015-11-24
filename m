Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1FGv-0003KN-8V
 for kexec@lists.infradead.org; Tue, 24 Nov 2015 15:12:45 +0000
Date: Tue, 24 Nov 2015 10:12:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [V5 PATCH 1/4] panic/x86: Fix re-entrance problem due to panic
 on NMI
Message-ID: <20151124101218.6518a664@gandalf.local.home>
In-Reply-To: <20151124150510.GA6100@home.goodmis.org>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093644.4285.9349.stgit@softrs>
 <20151124150510.GA6100@home.goodmis.org>
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
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, 24 Nov 2015 10:05:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> cmpxchg(&panic_cpu, -1, 0) != 0
> 
> returns -1 for cpu 0, thus 0 != 0, and sets panic_cpu to 0

That was suppose to be "thus -1 != 0".

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
