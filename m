Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSGV6-00CfOw-Gb
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 09:54:05 +0000
Date: Fri, 2 Apr 2021 11:53:55 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/1] kexec-tools: fix build on pre 4.4 kernels
Message-ID: <20210402095355.GA18086@vergenet.net>
References: <20210205081559.15956-1-fede@evolware.org>
 <4501fa78-355d-eb7c-69c4-5665620aa1a1@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4501fa78-355d-eb7c-69c4-5665620aa1a1@redhat.com>
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
Cc: Federico Pellegrin <fede@evolware.org>, kexec@lists.infradead.org

On Tue, Feb 23, 2021 at 06:32:39PM +0800, Kairui Song wrote:
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
> > +#ifndef VIDEO_CAPABILITY_64BIT_BASE
> > +#define VIDEO_CAPABILITY_64BIT_BASE (1 << 1)	/* Frame buffer base is 64-bit */
> > +#endif
> > +
> >   void init_linux_parameters(struct x86_linux_param_header *real_mode)
> >   {
> >   	/* Fill in the values that are usually provided by the kernel. */
> 
> Thanks for the fix, I didn't notice pre 4.4 kernels don't have this defined
> when I submitted that patch.
> 
> Reviewed-by: Kairui Song <kasong@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
