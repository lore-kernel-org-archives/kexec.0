Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqAeM-00072b-MS
 for kexec@lists.infradead.org; Mon, 09 Dec 2013 23:54:07 +0000
Message-ID: <52A657EC.6080304@redhat.com>
Date: Mon, 09 Dec 2013 18:53:16 -0500
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: add sysctl to disable kexec
References: <20131209233829.GA3501@www.outflux.net>
In-Reply-To: <20131209233829.GA3501@www.outflux.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Mel Gorman <mgorman@suse.de>

On 12/09/2013 06:38 PM, Kees Cook wrote:
> For general-purpose (i.e. distro) kernel builds it makes sense to build with
> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
> with kexec. However, in the face of trying to lock down a system with such
> a kernel, there needs to be a way to disable kexec (much like module loading
> can be disabled). Without this, it is too easy for the root user to modify
> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are set.

Not everybody will be running with selinux, or another LSM security
policy, so having this simple knob probably makes sense.

OTOH, are the people who run without a fancy security people the
same people who are interested in locking down the system?

I guess I'll ack the patch, since I see no real downside to having
the knob...

> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Rik van Riel <riel@redhat.com>


-- 
All rights reversed

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
