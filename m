Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1M2AWR-0003Ai-QV
	for kexec@lists.infradead.org; Thu, 07 May 2009 20:48:58 +0000
Date: Thu, 7 May 2009 13:45:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 13265] New: Crashdump feature totally broken
	with CONFIG_KEXEC_JUMP
Message-Id: <20090507134529.e14d6829.akpm@linux-foundation.org>
In-Reply-To: <bug-13265-10286@http.bugzilla.kernel.org/>
References: <bug-13265-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, tstarling@wikimedia.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Thu, 7 May 2009 13:29:41 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13265
> 
>            Summary: Crashdump feature totally broken with
>                     CONFIG_KEXEC_JUMP
>            Product: Platform Specific/Hardware
>            Version: 2.5
>     Kernel Version: 2.6.30rc4
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: i386
>         AssignedTo: platform_i386@kernel-bugs.osdl.org
>         ReportedBy: tstarling@wikimedia.org
>         Regression: No
> 
> 
> I loaded a crash kernel into a freshly-built 2.6.30rc4 instance using the
> Ubuntu scripts, and then triggered a crash with echo c > /proc/sysrq-trigger.
> The result was a kernel oops due to a null pointer deference in
> machine_kexec_32.c around line 197:
> 
> #ifdef CONFIG_KEXEC_JUMP
>     if (kexec_image->preserve_context)
> 
> kexec_image is NULL in this situation because kexec_crash_image (a.k.a. the
> image parameter) is meant to be used instead. I tracked down the commit for
> you:
> 
> <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3122c331190e9d1622bf1c8cf6ce3b17cca67c9e>
> 
> Presumably the feature has been broken since that time.
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
