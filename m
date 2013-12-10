Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-x22e.google.com ([2607:f8b0:4003:c02::22e])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqBmT-0000Ms-BT
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 01:06:34 +0000
Received: by mail-oa0-f46.google.com with SMTP id o6so4785041oag.19
 for <kexec@lists.infradead.org>; Mon, 09 Dec 2013 17:06:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52A66190.9060907@zytor.com>
References: <20131210001620.GA7938@www.outflux.net>
 <52A66190.9060907@zytor.com>
Date: Mon, 9 Dec 2013 17:06:10 -0800
Message-ID: <CAGXu5jKkCNWQKH-Ozm72C3aY_NBzRdNo2GmqKbVVJds5xs=SXg@mail.gmail.com>
Subject: Re: [PATCH v2] kexec: add sysctl to disable kexec
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Mel Gorman <mgorman@suse.de>

On Mon, Dec 9, 2013 at 4:34 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 12/09/2013 04:16 PM, Kees Cook wrote:
>> For general-purpose (i.e. distro) kernel builds it makes sense to build with
>> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
>> with kexec. However, in the face of trying to lock down a system with such
>> a kernel, there needs to be a way to disable kexec (much like module loading
>> can be disabled). Without this, it is too easy for the root user to modify
>> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are set.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Rik van Riel <riel@redhat.com>
>
> So the logic is to load a crashkernel and then lock down the machine
> before services, networking etc. are enabled?

Right, or to just turn it off at boot time if kexec will not be used at all.

-Kees

-- 
Kees Cook
Chrome OS Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
