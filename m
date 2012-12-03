Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TfciN-0001qh-GP
 for kexec@lists.infradead.org; Mon, 03 Dec 2012 20:34:08 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1256454bkc.36
 for <kexec@lists.infradead.org>; Mon, 03 Dec 2012 12:34:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87r4np4jm1.fsf@xmission.com>
References: <87r4np4jm1.fsf@xmission.com>
Date: Mon, 3 Dec 2012 12:34:04 -0800
Message-ID: <CAE9FiQWvNYOfg1=uYYzdfoy5q6RnroNCVyqXRw2ffgLQp_UvFw@mail.gmail.com>
Subject: Re: [PATCH] kexec x86_64: Make purgatory relocatable anywhere in the
 64bit address space.
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
Cc: Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>

On Mon, Nov 19, 2012 at 8:56 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index ee1679c..e39adec 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -64,6 +64,7 @@ $(PURGATORY): $(PURGATORY_OBJS)
>         $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
>
>  #      $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
> +       $(STRIP) --strip-debug $@
>
>  echo::
>         @echo "PURGATORY_SRCS $(PURGATORY_SRCS)"

looks like configure does not set
STRIP in top Makefile

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
