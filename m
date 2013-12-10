Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from qmta04.emeryville.ca.mail.comcast.net
 ([2001:558:fe2d:43:76:96:30:40])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqB3s-0007hA-Jf
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 00:20:29 +0000
Message-ID: <1386634788.24817.46.camel@rhapsody>
Subject: Re: [PATCH] kexec: add sysctl to disable kexec
From: Khalid Aziz <khalid@gonehiking.org>
Date: Mon, 09 Dec 2013 17:19:48 -0700
In-Reply-To: <20131209233829.GA3501@www.outflux.net>
References: <20131209233829.GA3501@www.outflux.net>
Mime-Version: 1.0
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
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Mel Gorman <mgorman@suse.de>

On Mon, 2013-12-09 at 15:38 -0800, Kees Cook wrote:
> For general-purpose (i.e. distro) kernel builds it makes sense to build with
> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
> with kexec. However, in the face of trying to lock down a system with such
> a kernel, there needs to be a way to disable kexec (much like module loading
> can be disabled). Without this, it is too easy for the root user to modify
> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are set.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Giving Sys admins more control to secure their system is a good idea.
This addition looks good to me.

--
Khalid


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
