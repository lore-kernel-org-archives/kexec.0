Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 21 Aug 2015 01:18:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [V3 PATCH 2/4] panic/x86: Allow cpus to save registers even if
 they are looping in NMI context
Message-ID: <20150820231816.GH3161@worktop.event.rightround.com>
References: <20150806054543.25766.29590.stgit@softrs>
 <20150806054543.25766.5526.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150806054543.25766.5526.stgit@softrs>
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

On Thu, Aug 06, 2015 at 02:45:43PM +0900, Hidehiro Kawai wrote:
> When cpu-A panics on NMI just after cpu-B has panicked, cpu-A loops
> infinitely in NMI context.  Especially for x86, cpu-B issues NMI IPI
> to other cpus to save their register states and do some cleanups if
> kdump is enabled, but cpu-A can't handle the NMI and fails to save
> register states.
> 
> To solve thie issue, we wait for the timing of the NMI IPI, then
> call the NMI handler which saves register states.

Sorry, I don't follow, what?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
