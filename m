Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E8DC43334
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 17:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hOROtyQ+bjfPkBPYGuYSuikqZbFaeqW+HMgYn3KSzJ4=; b=40kLi9nvIf0Z1SnBygZPIbJrc4
	G4TXjjUjIj7i0BdQYCxradH1O5Us68PolDCqoFCoGU7yQObV0O+qPIHdiInA+AQoapz4FORK+iB+/
	tuGZnn9o6n7SD/DBl9Pdic6vE1MwS4fG1xhxa5cZcpn/xzkviCY6HK+QYJb9h3GnLjS6IwBLST4Iy
	0YU0J6+kDBsJl1iVKXY3IrylKY1dngpQFS0iBZQi1skjxHhx/KePHTTL1rxWzlWu0QLwokBO843Yf
	mnirbm8qeuZ/IDoxLOFuqPsoFzygvm1Rjw387+KKNjcy2qhgUcDgzodClGbcnJ5BVAgXf1mUwvwf4
	9wCxRGxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG1Vb-00FrlC-Kn; Mon, 25 Jul 2022 17:04:43 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG1VY-00Frhy-NN
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 17:04:42 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:34794)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1oG1VW-00DJGN-Hv; Mon, 25 Jul 2022 11:04:38 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:60902 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1oG1VV-000BTE-CQ; Mon, 25 Jul 2022 11:04:38 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Masahiro Yamada <masahiroy@kernel.org>,  Michal Marek
 <michal.lkml@markovi.net>,  Nick Desaulniers <ndesaulniers@google.com>,
  "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,  Michael Roth
 <michael.roth@amd.com>,  Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>,  Nathan Chancellor
 <nathan@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Sean
 Christopherson <seanjc@google.com>,  Joerg Roedel <jroedel@suse.de>,  Mark
 Rutland <mark.rutland@arm.com>,  Kees Cook <keescook@chromium.org>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-kbuild@vger.kernel.org
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
Date: Mon, 25 Jul 2022 12:04:30 -0500
In-Reply-To: <20220725083904.56552-1-huangjie.albert@bytedance.com> (Albert
	Huang's message of "Mon, 25 Jul 2022 16:38:52 +0800")
Message-ID: <8735epf7j5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1oG1VV-000BTE-CQ;;;mid=<8735epf7j5.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/2kczJ4XYA0lOcB5AL9pRg/30yBi3yeu0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/4] faster kexec reboot
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_100440_807463_8C01B2C5 
X-CRM114-Status: GOOD (  32.98  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Albert Huang <huangjie.albert@bytedance.com> writes:

> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>
> In many time-sensitive scenarios, we need a shorter time to restart 
> the kernel. However, in the current kexec fast restart code, there 
> are many places in the memory copy operation, verification operation 
> and decompression operation, which take more time than 500ms. Through 
> the following patch series. machine_kexec-->start_kernel only takes
> 15ms

Is this a tiny embedded device you are taking the timings of?

How are you handling driver shutdown and restart?  I would expect those
to be a larger piece of the puzzle than memory.

My desktop can do something like 128GiB/s.  Which would suggest that
copying 128MiB of kernel+initrd would take perhaps 10ms.  The SHA256
implementation may not be tuned so that could be part of the performance
issue.  The SHA256 hash has a reputation for having fast
implementations.  I chose SHA256 originally simply because it has more
bits so it makes the odds of detecting an error higher.


If all you care about is booting a kernel as fast as possible it make
make sense to have a large reserved region of memory like we have for
the kexec on panic kernel.  If that really makes sense I recommend
adding a second kernel command line option and a reserving second region
of reserved memory.  That makes telling if the are any conflicts simple.


I am having a hard time seeing how anyone else would want these options.
Losing megabytes of memory simply because you might reboot using kexec
seems like the wrong side of a trade-off.

The CONFIG_KEXEC_PURGATORY_SKIP_SIG option is very misnamed.  It is not
signature verification that is happening it is a hash verification.
There are not encrypted bits at play.  Instead there is a check to
ensure that the kernel has not been corrupted by in-flight DMA that some
driver forgot to shut down.

So you are building a version of kexec that if something goes wrong it
could very easily eat your data, or otherwise do some very bad things
that are absolutely non-trivial to debug.

That the decision to skip the sha256 hash that prevents corruption is
happening at compile time, instead of at run-time, will guarantee the
option is simply not available on any general purpose kernel
configuration.  Given how dangerous it is to skip the hash verification
it is probably not a bad thing overall, but it is most definitely
something that will make maintenance more difficult.


If done well I don't see why anyone would mind a uncompressed kernel
but I don't see what the advantage of what you are doing is over using
vmlinux is the build directory.  It isn't a bzImage but it is the
uncompressed kernel.

As I proof of concept I think what you are doing goes a way to showing
that things can be improved.  My overall sense is that improving things
the way you are proposing does not help the general case and simply adds
to the maintenance burden.

Eric

>
> How to measure time:
>
> c code:
> uint64_t current_cycles(void)
> {
>     uint32_t low, high;
>     asm volatile("rdtsc" : "=a"(low), "=d"(high));
>     return ((uint64_t)low) | ((uint64_t)high << 32);
> }
> assembly code:
>        pushq %rax
>        pushq %rdx
>        rdtsc
>        mov   %eax,%eax
>        shl   $0x20,%rdx
>        or    %rax,%rdx
>        movq  %rdx,0x840(%r14)
>        popq  %rdx
>        popq  %rax
> the timestamp may store in boot_params or kexec control page, so we can
> get the all timestamp after kernel boot up.
>
> huangjie.albert (4):
>   kexec: reuse crash kernel reserved memory for normal kexec
>   kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
>   x86: Support the uncompressed kernel to speed up booting
>   x86: boot: avoid memory copy if kernel is uncompressed
>
>  arch/x86/Kconfig                   | 10 +++++++++
>  arch/x86/boot/compressed/Makefile  |  5 ++++-
>  arch/x86/boot/compressed/head_64.S |  8 +++++--
>  arch/x86/boot/compressed/misc.c    | 35 +++++++++++++++++++++++++-----
>  arch/x86/purgatory/purgatory.c     |  7 ++++++
>  include/linux/kexec.h              |  9 ++++----
>  include/uapi/linux/kexec.h         |  2 ++
>  kernel/kexec.c                     | 19 +++++++++++++++-
>  kernel/kexec_core.c                | 16 ++++++++------
>  kernel/kexec_file.c                | 20 +++++++++++++++--
>  scripts/Makefile.lib               |  5 +++++
>  11 files changed, 114 insertions(+), 22 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
