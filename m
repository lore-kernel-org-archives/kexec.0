Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hePzE-00056i-GR
 for kexec@lists.infradead.org; Fri, 21 Jun 2019 20:18:17 +0000
Received: by mail-io1-xd44.google.com with SMTP id e3so4200839ioc.12
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2019 13:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com>
 <20190621064340.GB4528@localhost.localdomain>
In-Reply-To: <20190621064340.GB4528@localhost.localdomain>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 21 Jun 2019 13:18:03 -0700
Message-ID: <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
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
To: Dave Young <dyoung@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Linux API <linux-api@vger.kernel.org>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, LSM List <linux-security-module@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>

On Thu, Jun 20, 2019 at 11:43 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 03/26/19 at 11:27am, Matthew Garrett wrote:
> > From: Jiri Bohac <jbohac@suse.cz>
> >
> > When KEXEC_SIG is not enabled, kernel should not load images through
> > kexec_file systemcall if the kernel is locked down.
> >
> > [Modified by David Howells to fit with modifications to the previous patch
> >  and to return -EPERM if the kernel is locked down for consistency with
> >  other lockdowns. Modified by Matthew Garrett to remove the IMA
> >  integration, which will be replaced by integrating with the IMA
> >  architecture policy patches.]
> >
> > Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> > cc: kexec@lists.infradead.org
> > ---
> >  kernel/kexec_file.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 67f3a866eabe..a1cc37c8b43b 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >               }
> >
> >               ret = 0;
> > +
> > +             if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)) {
> > +                     ret = -EPERM;
> > +                     goto out;
> > +             }
> > +
>
> Checking here is late, it would be good to move the check to earlier
> code around below code:
>         /* We only trust the superuser with rebooting the system. */
>         if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>                 return -EPERM;

I don't think so - we want it to be possible to load images if they
have a valid signature.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
