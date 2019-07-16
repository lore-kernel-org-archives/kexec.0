Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hnSvB-0003nQ-9r
 for kexec@lists.infradead.org; Tue, 16 Jul 2019 19:15:30 +0000
Received: by mail-lj1-f196.google.com with SMTP id m8so21061248lji.7
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2019 12:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <1563170576-13134-1-git-send-email-bhsharma@redhat.com>
 <20190716114942.7ufsup2eyco4pxax@verge.net.au>
In-Reply-To: <20190716114942.7ufsup2eyco4pxax@verge.net.au>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 17 Jul 2019 00:45:14 +0530
Message-ID: <CACi5LpPu2roLZPuOMfZ0_5CN7op+xfh1FkTS34smEq-+R_C17g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kexec/arm64: Add support for zlib compressed
 kernel images (Image.gz)
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
To: Simon Horman <horms@verge.net.au>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>

On Tue, Jul 16, 2019 at 5:19 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Mon, Jul 15, 2019 at 11:32:52AM +0530, Bhupesh Sharma wrote:
> > Changes since v1:
> > ----------------
> > (v1 can be viewed here: http://lists.infradead.org/pipermail/kexec/2019-July/023288.html)
> >  - Fixed the potential file descriptor leakage code legs pointed out by
> >    Simon.
> >  - Ran Valgrind to make sure no potential memory leakage issues are
> >    introduced by this patchset.
> >
> > This patchset adds the support for zlib compressed kernel images
> > (Image.gz) for arm64 kexec-tools.
> >
> > This was discussed a bit with the arm64 kernel maintainers (see [0]) and
> > after discussing the pros and cons of adding this support in
> > kernel-space v/s in user-space, we decided it makes more sense to add
> > this support to the user-space kexec-tools.
> >
> > Note that this series adds support for unsigned arm64 Image.gz files
> > only as signing an Image.gz type file is not a easy implementation from
> > kexec-tools p-o-v. Also even standard signing tools like sbsign fail to
> > recongize the Image.gz format:
> >
> >  $ sbsign --key certs/signing_key.pem  --cert certs/signing_key.pem Image.gz
> >    Invalid DOS header magic
> >
> > ... because that gzip file isn't a PE32+ that can be loaded by UEFI.
> > So I will work on the same in coming days and try to send a RFC
> > patchset for the same later on.
> >
> > [0]. http://lists.infradead.org/pipermail/kexec/2019-June/023156.html
>
> Thanks, applied for inclusion in v2.0.20.

Thanks Simon.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
