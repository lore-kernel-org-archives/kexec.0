Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqlGM-0006xp-IH
 for kexec@lists.infradead.org; Thu, 14 Apr 2016 17:41:08 +0000
Received: by mail-io0-x242.google.com with SMTP id s2so12031995iod.3
 for <kexec@lists.infradead.org>; Thu, 14 Apr 2016 10:40:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
References: <570F6D99.6090400@gmail.com>
 <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
Date: Thu, 14 Apr 2016 10:40:45 -0700
Message-ID: <CA+55aFwprUFh+cjB2fWmkMJ3Zgh6XSan0VO8Vr-80Qh0n0Rx+A@mail.gmail.com>
Subject: Re: Removal of the kernel code/data/bss resources does break
 kexec/kdump
From: Linus Torvalds <torvalds@linux-foundation.org>
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
To: Emrah Demir <ed@abdsec.com>
Cc: Freeman Zhang <freeman.zhang1992@gmail.com>, kexec@lists.infradead.org

On Thu, Apr 14, 2016 at 4:07 AM, Emrah Demir <ed@abdsec.com> wrote:
>
> Kees Cook proposed to write a %pK formatted patch. This would solve most of
> the problems.

Actually, %pK is horrible in /proc and /sys files, and does the wrong thing.

It uses the current creds for deciding what to do, which is exactly
the wrong thing (for all the usual reasons) for a file access from a
security standpoint. Sadly, almost every use of %pK gets this wrong.
Thankfully, it's much less of a problem for reads than for writes, but
it's still wrong.

A file access should use "file->f_cred", but the seq_file interface
sadly doesn't expose any way to do that.

I'll take a look, but it's non-trivial to get right. %pK turns out to
have been seriously mis-designed, and is basically almost always a
bug.

          Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
