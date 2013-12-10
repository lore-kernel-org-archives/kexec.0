Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-x22c.google.com ([2607:f8b0:4003:c01::22c])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqAzM-0007XO-TC
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 00:15:49 +0000
Received: by mail-ob0-f172.google.com with SMTP id gq1so4572345obb.17
 for <kexec@lists.infradead.org>; Mon, 09 Dec 2013 16:15:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52A657EC.6080304@redhat.com>
References: <20131209233829.GA3501@www.outflux.net>
 <52A657EC.6080304@redhat.com>
Date: Mon, 9 Dec 2013 16:15:24 -0800
Message-ID: <CAGXu5jKi=QeiN=Sipumwi1AR25=ciPC+KAe3XUUQkm31EDexsA@mail.gmail.com>
Subject: Re: [PATCH] kexec: add sysctl to disable kexec
From: Kees Cook <keescook@chromium.org>
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
To: Rik van Riel <riel@redhat.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Mel Gorman <mgorman@suse.de>

On Mon, Dec 9, 2013 at 3:53 PM, Rik van Riel <riel@redhat.com> wrote:
> On 12/09/2013 06:38 PM, Kees Cook wrote:
>> For general-purpose (i.e. distro) kernel builds it makes sense to build with
>> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
>> with kexec. However, in the face of trying to lock down a system with such
>> a kernel, there needs to be a way to disable kexec (much like module loading
>> can be disabled). Without this, it is too easy for the root user to modify
>> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are set.
>
> Not everybody will be running with selinux, or another LSM security
> policy, so having this simple knob probably makes sense.
>
> OTOH, are the people who run without a fancy security people the
> same people who are interested in locking down the system?
>
> I guess I'll ack the patch, since I see no real downside to having
> the knob...

Thanks! Yeah, there are cases of machines that are trying to be as
locked down as possible while still not having secure boot, etc. This
helps raise the bar for them.

>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Rik van Riel <riel@redhat.com>

Thanks! I'm sending a v2 since I spaced out on updating the sysctl docs.

-Kees

-- 
Kees Cook
Chrome OS Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
