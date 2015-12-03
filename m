Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a4JYs-0007Yo-V4
 for kexec@lists.infradead.org; Thu, 03 Dec 2015 02:23:59 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V5 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Date: Thu, 3 Dec 2015 02:23:32 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454A3CDD3@GSjpTKYDCembx31.service.hitachi.net>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093646.4285.62259.stgit@softrs>
In-Reply-To: <20151120093646.4285.62259.stgit@softrs>
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
To: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= <hidehiro.kawai.ez@hitachi.com>, Jonathan Corbet <corbet@lwn.net>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Steven Rostedt' <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>

> @@ -357,7 +358,15 @@ static void default_do_nmi(struct pt_regs *regs)
>  	}
> 
>  	/* Non-CPU-specific NMI: NMI sources can be processed on any CPU */
> -	raw_spin_lock(&nmi_reason_lock);
> +
> +	/*
> +	 * Another CPU may be processing panic routines with holding
> +	 * nmi_reason_lock.  Check IPI issuance from the panicking CPU
> +	 * and call the callback directly.
> +	 */
> +	while (!raw_spin_trylock(&nmi_reason_lock))
> +		poll_crash_ipi_and_callback(regs);
> +
>  	reason = x86_platform.get_nmi_reason();

I noticed this logic is unneeded until applying PATCH 4/4.
Currently, unknown NMI can be broadcast to all CPUs, but in that case,
panic()/nmi_panic() are called after releasing nmi_reason_lock.
So CPUs can't loop infinitely here.

PATCH 4/4 allows us to broadcast external NMIs to all CPUs, and it
causes infinite loop in raw_spin_lock(&nmi_reason_lock).  So the above
changes are needed.

I'll move these chagnes to a later patch in the next version.

Thanks,

--
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
