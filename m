Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f65.google.com ([209.85.166.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goJh3-0002h5-1m
 for kexec@lists.infradead.org; Tue, 29 Jan 2019 03:04:11 +0000
Received: by mail-io1-f65.google.com with SMTP id s8so15320713iob.13
 for <kexec@lists.infradead.org>; Mon, 28 Jan 2019 19:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20190128105045.30565-1-kasong@redhat.com>
 <20190128105944.fwm57pnbyvkap5fo@verge.net.au>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567378@BPXM09GP.gisp.nec.co.jp>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035673D1@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035673D1@BPXM09GP.gisp.nec.co.jp>
From: Kairui Song <kasong@redhat.com>
Date: Tue, 29 Jan 2019 11:03:56 +0800
Message-ID: <CACPcB9d5tKZC5Rs_gSThNGsOda0HTRoh6zrMjRCn9pUyqrW5Ug@mail.gmail.com>
Subject: Re: [PATCH] makedumpfile: honor the CFLAGS from environment variables
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>

On Tue, Jan 29, 2019 at 6:33 AM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> On 1/28/2019 4:51 PM, Kazuhito Hagio wrote:
> > On 1/28/2019 5:59 AM, Simon Horman wrote:
> > > On Mon, Jan 28, 2019 at 06:50:45PM +0800, Kairui Song wrote:
> > > > This make it easier for passing extra cflags, for example hardening
> > > > flags could be passed in with enviroment variable.
> > > >
> > > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > >
> > > Thanks, I like this a lot.
> > >
> > > I would like to wake a little to see if there is review from
> > > others before applying this.
> >
> > I like this, too, and sorry to steal this... :-)
> >
> > >
> > > > ---
> > > >  Makefile | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 612b9d0..b511a78 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -8,11 +8,11 @@ ifeq ($(strip $CC),)
> > > >  CC       = gcc
> > > >  endif
> > > >
> > > > -CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> > > > -   -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
> > > > -   -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
> > > > -CFLAGS_ARCH      = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> > > > -             -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
> > > > +CFLAGS_ARCH = $(CFLAGS) -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
> > > > +       -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
> >
> > This expands the whole CFLAGS in advance and duplicates some flags,
> > so we can use ":=" instead of "=" for CFLAGS_ARCH ?
> > If this is fine, I'll fix it when mergiKazuhito Hagio <k-hagio@ab.jp.nec.com>ng.
>
> or it might be good to remove some redundant flags like this
> at this opportunity.
>
> CFLAGS_BASE := $(CFLAGS) -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
>                 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
> CFLAGS      := $(CFLAGS_BASE) -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
> CFLAGS_ARCH := $(CFLAGS_BASE)

Thanks for the suggestion, it is a good idea, simplifies the CFLAGS definition.
Will send a V2 update.

--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
