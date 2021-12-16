Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxgyJ-003Nod-17
 for kexec@lists.infradead.org; Thu, 16 Dec 2021 02:58:20 +0000
Received: by mail-io1-f70.google.com with SMTP id
 m6-20020a0566022e8600b005ec18906edaso22198864iow.6
 for <kexec@lists.infradead.org>; Wed, 15 Dec 2021 18:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20211210030735.53155-1-piliu@redhat.com>
 <20211210030735.53155-3-piliu@redhat.com>
 <20211215143512.4b0d745c@rhtmp>
In-Reply-To: <20211215143512.4b0d745c@rhtmp>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 16 Dec 2021 10:58:03 +0800
Message-ID: <CAF+s44RzmLG1HasRtHkcof-ymURceWrZXpsOrAPDrNx-FnN_aw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64/crashdump: unify routine to get page_offset
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
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, Dec 15, 2021 at 9:35 PM Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi Pinfang,
>
> On Fri, 10 Dec 2021 11:07:34 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > There are two funcs to get page_offset:
> >   get_kernel_page_offset()
> >   get_page_offset()
> >
> > Since get_kernel_page_offset() does not observe the kernel formula, and
> > remove it. Unify them in order to introduce 52-bits VA kernel more
> > easily in the coming patch.
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > ---
> >  kexec/arch/arm64/crashdump-arm64.c | 23 +----------------------
> >  kexec/arch/arm64/kexec-arm64.c     |  4 ++--
> >  kexec/arch/arm64/kexec-arm64.h     |  1 +
> >  3 files changed, 4 insertions(+), 24 deletions(-)
> >
> > diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
> > index a02019a..0a8d44c 100644
> > --- a/kexec/arch/arm64/crashdump-arm64.c
> > +++ b/kexec/arch/arm64/crashdump-arm64.c
>
> [...]
>
> > diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> > index 7373fa3..bd650e6 100644
> > --- a/kexec/arch/arm64/kexec-arm64.c
> > +++ b/kexec/arch/arm64/kexec-arm64.c
> > @@ -909,7 +909,7 @@ static int get_va_bits(void)
> >   * get_page_offset - Helper for getting PAGE_OFFSET
> >   */
> >
> > -static int get_page_offset(void)
> > +int get_page_offset(unsigned long *page_offset)
> >  {
> >       int ret;
> >
>
> The new page_offset is never used in this patch. There's still the line
> left with the global page_offset but that will cause a type miss-match
> (unsigend long vs unsigned log *). In the next patch you do the update
> (page_offset -> *page_offset) but in the meantime the code is broken.
>
I will fix it in V2.

Thanks,

Pingfan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
