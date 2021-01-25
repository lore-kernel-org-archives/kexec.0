Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3xot-000796-Mu
 for kexec@lists.infradead.org; Mon, 25 Jan 2021 09:06:02 +0000
Received: by mail-io1-xd29.google.com with SMTP id y19so25050281iov.2
 for <kexec@lists.infradead.org>; Mon, 25 Jan 2021 01:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20210122074214.26583-1-bhe@redhat.com>
In-Reply-To: <20210122074214.26583-1-bhe@redhat.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Mon, 25 Jan 2021 17:05:44 +0800
Message-ID: <CAFgQCTuvh40hOUKS1MLnuUm_14JeKUg_c1rncAFmd1bRXML0xA@mail.gmail.com>
Subject: Re: [PATCH] kernel/kexec: remove the lock operation of
 system_transition_mutex
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
To: Baoquan He <bhe@redhat.com>
Cc: Rafael Wysocki <rafael@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org

On Fri, Jan 22, 2021 at 3:42 PM Baoquan He <bhe@redhat.com> wrote:
>
> Function kernel_kexec() is called with lock system_transition_mutex held
> in reboot system call. While inside kernel_kexec(), it will acquire
> system_transition_mutex agin. This will lead to dead lock.
>
> The dead lock should be easily triggered, it hasn't caused any failure
> report just because the feature 'kexec jump' is almost not used by anyone
> as far as I know. An inquiry can be made about who is using 'kexec jump'
> and where it's used. Before that, let's simply remove the lock operation
> inside CONFIG_KEXEC_JUMP ifdeffery scope.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  kernel/kexec_core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 80905e5aa8ae..a0b6780740c8 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1134,7 +1134,6 @@ int kernel_kexec(void)
>
>  #ifdef CONFIG_KEXEC_JUMP
>         if (kexec_image->preserve_context) {
> -               lock_system_sleep();
>                 pm_prepare_console();
>                 error = freeze_processes();
>                 if (error) {
> @@ -1197,7 +1196,6 @@ int kernel_kexec(void)
>                 thaw_processes();
>   Restore_console:
>                 pm_restore_console();
> -               unlock_system_sleep();
>         }
>  #endif
>
> --
> 2.17.2
>
Reviewed-by: Pingfan Liu <kernelfans@gmail.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
