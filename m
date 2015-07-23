Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZID2Z-0003F2-Aa
 for kexec@lists.infradead.org; Thu, 23 Jul 2015 09:43:48 +0000
Message-ID: <55B0B738.1050603@hitachi.com>
Date: Thu, 23 Jul 2015 18:43:20 +0900
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] x86/panic: Fix re-entrance problem due to panic on NMI
References: <20150722021421.5155.74460.stgit@softrs>
 <20150722021421.5155.9710.stgit@softrs>
 <20150723081528.GG25159@twins.programming.kicks-ass.net>
In-Reply-To: <20150723081528.GG25159@twins.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

(2015/07/23 17:15), Peter Zijlstra wrote:
> On Wed, Jul 22, 2015 at 11:14:21AM +0900, Hidehiro Kawai wrote:
>> +DEFINE_SPINLOCK(panic_lock);
> 
> At the very least this should be a raw spinlock, but wth aren't you
> using a simple atomic_xchg() ?

Thanks for the comment.

I just followed the current panic_lock implementation.
Using atomic_xchg() may be OK.  I'll try another version
with atomic_xchg().

Regards,
-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
