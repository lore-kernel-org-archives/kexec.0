Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZJzpI-000632-8W
 for kexec@lists.infradead.org; Tue, 28 Jul 2015 08:01:28 +0000
Received: by wicgb10 with SMTP id gb10so144332041wic.1
 for <kexec@lists.infradead.org>; Tue, 28 Jul 2015 01:01:06 -0700 (PDT)
Date: Tue, 28 Jul 2015 10:01:03 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to panic
 on NMI
Message-ID: <20150728080103.GD24972@dhcp22.suse.cz>
References: <20150727015850.4928.87717.stgit@softrs>
 <20150727015850.4928.50289.stgit@softrs>
 <20150727143405.GF11317@dhcp22.suse.cz>
 <55B6E2A3.8070004@hitachi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55B6E2A3.8070004@hitachi.com>
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
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue 28-07-15 11:02:11, Hidehiro Kawai wrote:
[...]
> > Something like
> [...]
> > +void nmi_panic(const char *fmt, ...)
> 
> Since we can't directly pass variable arguments to a subroutine,

Sure, I was just too lazy to finish this as it was just an illustration
of the idea.

> we have to use a macro or do like this:
> 
> void nmi_panic(const char *msg)
> {
> ...
> 	panic("%s", msg);
> }
> 
> If there is no objection, I'm going to use a macro.

Your other patch needs panic_cpu externally visible so the macro should
be OK.
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
