Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZwvw-0008Tw-6t
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 04:56:41 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so349878bkc.36
 for <kexec@lists.infradead.org>; Sat, 17 Nov 2012 20:56:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <876253sej9.fsf@xmission.com>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
Date: Sat, 17 Nov 2012 20:56:37 -0800
Message-ID: <CAE9FiQVfRHpoBoUyZssfE32wv7j3fD2skRL4UFXP=FBq7rrE1w@mail.gmail.com>
Subject: Re: [PATCH 3/8] add mem64_min/max control
From: Yinghai Lu <yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sat, Nov 17, 2012 at 8:47 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
>
>
> 64bit purgatory coming from kexec should be running with a page table
> that identity maps everything loaded by kexec and in practice all of
> memory.

there is lots of R_X86_64_32 and R_X86_64_32S for 64bit purgatory.

those come from global variables...could kill some by converting them static...

but still have some global string or ro data....

build one big file include all .S ?

>
> We should still be using that page table when we enter the new kernel.
>
> However then the 64bit kernel switches to it's own page tables.
>
> So after that point we potentially need early_ioremap, because the
> kernel's page tables may not have covered the boot_params.  Certainly we
> need to do something to ensure the kernels page table covers boot_params.

yes, I tested that and it works.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
