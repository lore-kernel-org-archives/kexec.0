Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZIEj3-0004LC-Mu
 for kexec@lists.infradead.org; Thu, 23 Jul 2015 11:31:46 +0000
Received: by wibud3 with SMTP id ud3so214314943wib.0
 for <kexec@lists.infradead.org>; Thu, 23 Jul 2015 04:31:24 -0700 (PDT)
Date: Thu, 23 Jul 2015 13:25:33 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 0/3] x86: Fix panic vs. NMI issues
Message-ID: <20150723112532.GD9386@dhcp22.suse.cz>
References: <20150722021421.5155.74460.stgit@softrs>
 <20150723082514.GC9386@dhcp22.suse.cz>
 <55B0BDB7.2050809@hitachi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55B0BDB7.2050809@hitachi.com>
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
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu 23-07-15 19:11:03, Hidehiro Kawai wrote:
> Hi,
> 
> Thanks for the feedback.
> 
> (2015/07/23 17:25), Michal Hocko wrote:
> > Hi,
> > 
> > On Wed 22-07-15 11:14:21, Hidehiro Kawai wrote:
> >> When an HA cluster software or administrator detects non-response
> >> of a host, they issue an NMI to the host to completely stop current
> >> works and take a crash dump.  If the kernel has already panicked
> >> or is capturing a crash dump at that time, further NMI can cause
> >> a crash dump failure.
> >>
> >> To solve this issue, this patch set does two things:
> >>
> >> - Don't panic on NMI if the kernel has already panicked
> >> - Introduce "noextnmi" boot option which masks external NMI at the
> >>   boot time (supported only for x86)
> > 
> > I am currently debugging the same issue for our customer. Curiously
> > enough the issue happens on a Hitachi HW.
> 
> I found these issues by my white-box testing and source code
> reading.  So, they haven't happened on our customers yet, but
> possibly happen.
> 
> > I haven't posted my patch for an upstream review yet because I still
> > do not have a feedback but I believe your solution is unnecessarily
> > too complex. Unless I am missing something the following should be enough,
> > no?
> 
> Your patch solves some cases, but I think it wouldn't cover
> all cases where I want to solve.  How about the following cases?
> 
> 1) panic -> acquire panic_lock -> unknown NMI on this CPU ->
>    panic -> failed to acquire panic_lock -> infinite loop
> ==> no one processes kdump procedure. 

Ohh, I wasn't aware of panic_lock, 93e13a360ba3 ("kdump: fix
crash_kexec()/smp_send_stop() race in panic()") has been introduced in
3.3 and I was debugging this on 3.0 based kernel.

> 2) crash_kexec w/o entering panic -> acquire kexec_mutex ->
>    unknown NMI on this CPU -> panic -> crash_kexec ->
>    failed to acquire kexec_mutex -> return to panic -> smp_send_stop
> 
> Even if with your patch, case 2) causes infinite loop of
> try_crash_kexec and no one processes kdump procedure.

You are right - I have missed this case.
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
