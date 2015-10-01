Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZhTgl-0003TB-47
 for kexec@lists.infradead.org; Thu, 01 Oct 2015 02:33:43 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Date: Thu, 1 Oct 2015 02:33:18 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445499CD11@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <20150930115548.GI2881@worktop.programming.kicks-ass.net>
In-Reply-To: <20150930115548.GI2881@worktop.programming.kicks-ass.net>
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
To: 'Peter Zijlstra' <peterz@infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric
 W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> On Fri, Sep 25, 2015 at 08:28:11PM +0900, Hidehiro Kawai wrote:
> > This patch introduces new boot option "noextnmi" which disables
> > external NMI.  This option is useful for the dump capture kernel
> > so that an HA application or administrator wouldn't mistakenly
> > shoot down the kernel by NMI.
> 
> So that they can get really stuck when the crash kernel crashes, right?
> ;-)

No, it is different from my intention.

`mistakenly' in the above means; they issue NMI due to a misconception
that the monitored host is stuck in the 1st kernel while it is actually
taking a crash dump in the 2nd kernel.  To avoid this kind of accident,
there is a tool such as fence_kdump which notifies "I'm taking a crash
dump, so don't send NMI" to the HA clustering software.  However, there
is a time window between kernel panic and the notification.

"noextnmi" allows users to avoid this kind of accident all the time of
2nd kernel.

Regards,


Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
