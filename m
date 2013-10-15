Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-x22a.google.com ([2607:f8b0:400e:c02::22a])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWAqt-0003lT-0Z
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 20:04:24 +0000
Received: by mail-pd0-f170.google.com with SMTP id x10so9403762pdj.15
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 13:03:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8761sy1gmb.fsf@xmission.com>
References: <1381859307-11932-1-git-send-email-geert@linux-m68k.org>
 <1381859307-11932-2-git-send-email-geert@linux-m68k.org>
 <8761sy1gmb.fsf@xmission.com>
Date: Tue, 15 Oct 2013 22:03:58 +0200
Message-ID: <CAMuHMdWfk5awf3ycuY0ULyzk-8gc209p0DGDXwYEM2si6KpCuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kexec: Add debug printing of kimage table entries
From: Geert Uytterhoeven <geert@linux-m68k.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Oct 15, 2013 at 9:25 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> Print a list of pages to be copied if debugging is enabled.
>> Consecutive entries are merged to reduce screen clutter.
>
> Why is this desirable?
>
> I can understand this as debugging code to understand what is happening,
> but why would we want to maintain this print statement long term?

Because the next person who ports kexec to a new platform may need it,
so he doesn't have to reimplement the wheel?

It's disabled by default.

It also serves as documentation for the indirection page.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
