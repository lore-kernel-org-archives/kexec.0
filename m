Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f46.google.com ([209.85.167.46])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKFhm-008c22-7i
 for kexec@lists.infradead.org; Thu, 11 Mar 2021 07:26:00 +0000
Received: by mail-lf1-f46.google.com with SMTP id e7so38128307lft.2
 for <kexec@lists.infradead.org>; Wed, 10 Mar 2021 23:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20210205081559.15956-1-fede@evolware.org>
 <4501fa78-355d-eb7c-69c4-5665620aa1a1@redhat.com>
In-Reply-To: <4501fa78-355d-eb7c-69c4-5665620aa1a1@redhat.com>
From: Federico Pellegrin <fede@evolware.org>
Date: Thu, 11 Mar 2021 08:25:45 +0100
Message-ID: <CAM6O0Zhz9N-Jd8ykjhwDMSt66nxHMd+zikKjFaZKiJFC=kOJ2Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] kexec-tools: fix build on pre 4.4 kernels
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
To: Kairui Song <kasong@redhat.com>
Cc: kexec@lists.infradead.org

Hello,
Just pinging on this... not sure if I need to do something else to get
it merged, please just let me know.

Thanks,
Federico

Il giorno mar 23 feb 2021 alle ore 11:32 Kairui Song
<kasong@redhat.com> ha scritto:
>
> On 2/5/21 4:15 PM, Federico Pellegrin wrote:
> > kexec build will fail on older kernels (pre 4.4) as the define
> > VIDEO_CAPABILITY_64BIT_BASE was not present at that time.
> >
> > This patch adds it, as per linux/include/uapi/linux/screen_info.h,
> > if not present.
> >
> > Signed-off-by: Federico Pellegrin <fede@evolware.org>
> > ---
> >   kexec/arch/i386/x86-linux-setup.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> > index 76e1185..ab54a4a 100644
> > --- a/kexec/arch/i386/x86-linux-setup.c
> > +++ b/kexec/arch/i386/x86-linux-setup.c
> > @@ -37,6 +37,10 @@
> >   #include "x86-linux-setup.h"
> >   #include "../../kexec/kexec-syscall.h"
> >
> > +#ifndef VIDEO_CAPABILITY_64BIT_BASE
> > +#define VIDEO_CAPABILITY_64BIT_BASE (1 << 1) /* Frame buffer base is 64-bit */
> > +#endif
> > +
> >   void init_linux_parameters(struct x86_linux_param_header *real_mode)
> >   {
> >       /* Fill in the values that are usually provided by the kernel. */
>
> Thanks for the fix, I didn't notice pre 4.4 kernels don't have this defined
> when I submitted that patch.
>
> Reviewed-by: Kairui Song <kasong@redhat.com>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
