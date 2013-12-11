Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vqnyb-00039J-9b
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 17:53:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20131210001620.GA7938@www.outflux.net>
Date: Wed, 11 Dec 2013 09:52:55 -0800
In-Reply-To: <20131210001620.GA7938@www.outflux.net> (Kees Cook's message of
 "Mon, 9 Dec 2013 16:16:20 -0800")
Message-ID: <87vbyvxojs.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kexec: add sysctl to disable kexec
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
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Kees Cook <keescook@chromium.org> writes:

> For general-purpose (i.e. distro) kernel builds it makes sense to build with
> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
> with kexec. However, in the face of trying to lock down a system with such
> a kernel, there needs to be a way to disable kexec (much like module loading
> can be disabled). Without this, it is too easy for the root user to modify
> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are
> set.

So let me get this straight.  You object to what happens in sys_reboot
so you patch sys_kexec_load?

You give someone the privilege to boot whatever they want and yet you
don't want to support them booting whatever they want?

I'm sorry my brain is hurting trying to understand the logic of this
patch.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
