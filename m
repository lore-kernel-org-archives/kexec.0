Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqBIS-0008AO-TD
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 00:35:33 +0000
Message-ID: <52A66190.9060907@zytor.com>
Date: Mon, 09 Dec 2013 16:34:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kexec: add sysctl to disable kexec
References: <20131210001620.GA7938@www.outflux.net>
In-Reply-To: <20131210001620.GA7938@www.outflux.net>
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
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Mel Gorman <mgorman@suse.de>

On 12/09/2013 04:16 PM, Kees Cook wrote:
> For general-purpose (i.e. distro) kernel builds it makes sense to build with
> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
> with kexec. However, in the face of trying to lock down a system with such
> a kernel, there needs to be a way to disable kexec (much like module loading
> can be disabled). Without this, it is too easy for the root user to modify
> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are set.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Rik van Riel <riel@redhat.com>

So the logic is to load a crashkernel and then lock down the machine
before services, networking etc. are enabled?

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
