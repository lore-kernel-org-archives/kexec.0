Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fbbWB-0003Wk-Pc
 for kexec@lists.infradead.org; Sat, 07 Jul 2018 00:56:09 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1530871650-3582-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
 <CAGXu5jKrM_3ymnmcJ+AE1A3uVPDJykRj0z5B8sDoxM6zUnX-Rg@mail.gmail.com>
 <945be212-8e82-9dd8-930f-4e5c11dcae77@i-love.sakura.ne.jp>
Date: Fri, 06 Jul 2018 19:55:26 -0500
In-Reply-To: <945be212-8e82-9dd8-930f-4e5c11dcae77@i-love.sakura.ne.jp>
 (Tetsuo Handa's message of "Sat, 7 Jul 2018 08:35:28 +0900")
Message-ID: <87zhz3sw3l.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] uts: Don't randomize "struct uts_namespace".
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
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> I'm waiting for response from makedumpfile developers.
>
> But makedumpfile is a tool for saving kernel crash dump.
> If makedumpfile cannot work, we cannot use kernel crash dump.

I suspect the version string is comparable in size to the pointer to the
version string and as such would be a better candidate to include in the
handful of elf notes we provide for the mkdumpfile & it's ilk to bootstram.

I assume getting the kernel's version string will be enough to track
back to an individual vmlinux and figure out the layout of everything
else.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
