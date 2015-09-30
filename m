Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 30 Sep 2015 13:55:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Message-ID: <20150930115548.GI2881@worktop.programming.kicks-ass.net>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150925112811.4258.54494.stgit@softrs>
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
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Sep 25, 2015 at 08:28:11PM +0900, Hidehiro Kawai wrote:
> This patch introduces new boot option "noextnmi" which disables
> external NMI.  This option is useful for the dump capture kernel
> so that an HA application or administrator wouldn't mistakenly
> shoot down the kernel by NMI.

So that they can get really stuck when the crash kernel crashes, right?
;-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
