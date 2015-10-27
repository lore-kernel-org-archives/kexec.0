Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zr08S-0000Rj-JD
 for kexec@lists.infradead.org; Tue, 27 Oct 2015 09:01:41 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Date: Tue, 27 Oct 2015 09:01:15 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A844549DC280@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <20151027084622.GA5141@dhcp-128-28.nay.redhat.com>
In-Reply-To: <20151027084622.GA5141@dhcp-128-28.nay.redhat.com>
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
To: 'Baoquan He' <bhe@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hi,

> I just have a look at this thread. I am wondering why we don't use
> existing is_kdump_kernel() directly to disable external NMI if it's
> in kdump kernel. Then no need to introduce another boot option "noextnmi"
> which is used only for kdump kernel.

As I stated in another mail, there is a case where we don't want to
mask external NMIs in the second kernel.  So, we need some
configurable way.  Please see the following quotation.

> We souldn't enable this feature silently.  Some users wouldn't like
> to enable this feature.  For example, a user enables a watchdog timer
> which raises an external NMI when the counter is not reset for a
> specific duration.  Then, the second kernel hangs up while saving
> crash dump, and NMI is delivered to the CPU.  The kernel gets panic
> due to the NMI, prints some information to the display and serial
> console, and then automatically reboot.  In this case, users don't
> want to block external NMIs.

Regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
