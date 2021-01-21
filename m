Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-f42.google.com ([209.85.210.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2bAq-0000jq-SR
 for kexec@lists.infradead.org; Thu, 21 Jan 2021 14:43:01 +0000
Received: by mail-ot1-f42.google.com with SMTP id a109so1803147otc.1
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2021 06:43:00 -0800 (PST)
MIME-Version: 1.0
References: <20201118185917.GA433776@mwanda>
 <20210120093015.GE20161@MiWiFi-R3L-srv>
 <CAFgQCTubgqy3ANR_oPH9w_OZ1Mm0a0daWT7SAFhXx3QX+-vHBQ@mail.gmail.com>
In-Reply-To: <CAFgQCTubgqy3ANR_oPH9w_OZ1Mm0a0daWT7SAFhXx3QX+-vHBQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Jan 2021 15:42:46 +0100
Message-ID: <CAJZ5v0jgTyXQxPVQoM4nykk7gcWfNw9bXTQO8856vkYD8TJOCg@mail.gmail.com>
Subject: Re: [bug report] PM / reboot: Eliminate race between reboot and
 suspend
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
To: Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>, Linux PM <linux-pm@vger.kernel.org>

On Thu, Jan 21, 2021 at 10:14 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Wed, Jan 20, 2021 at 5:30 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > Hi,
> >
> > On 11/18/20 at 09:59pm, Dan Carpenter wrote:
> > > Hello Pingfan Liu,
> > >
> > > The patch 55f2503c3b69: "PM / reboot: Eliminate race between reboot
> > > and suspend" from Jul 31, 2018, leads to the following static checker
> > > warning:
> > >
> > >       kernel/power/main.c:27 lock_system_sleep()
> > >       warn: called with lock held.  '&system_transition_mutex'
> >
> > This is a good finding. I think we can simply remove the lock/unlock
> > pair of system_transition_mutex in kernel_kexec() function. The dead
> > lock should be easily triggered, but it hasn't caused any failure report
> > because the feature 'kexec jump' is almost not used by anyone as far as
> > I know. We may need to find out who is using it and where it's used
> > through an inquiry. Before that, we can just remove the lock operation
> > inside CONFIG_KEXEC_JUMP ifdeffery scope. Thanks.
> >
> >
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 80905e5aa8ae..a0b6780740c8 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1134,7 +1134,6 @@ int kernel_kexec(void)
> >
> >  #ifdef CONFIG_KEXEC_JUMP
> >         if (kexec_image->preserve_context) {
> > -               lock_system_sleep();
> >                 pm_prepare_console();
> >                 error = freeze_processes();
> >                 if (error) {
> > @@ -1197,7 +1196,6 @@ int kernel_kexec(void)
> >                 thaw_processes();
> >   Restore_console:
> >                 pm_restore_console();
> > -               unlock_system_sleep();
>
> This should work since the only caller syscall_reboot has already
> placed kernel_kexec() under the protection of system_transition_mutex.
>
> Thanks for the fix.
>
> Reviewed-by: Pingfan Liu <kernelfans@gmail.com>

OK, so can anyone please submit that patch formally (Cc linux-pm, please)?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
