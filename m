Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cC2fF-0008Ve-L2
 for kexec@lists.infradead.org; Wed, 30 Nov 2016 11:03:02 +0000
Date: Wed, 30 Nov 2016 12:02:33 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] purgatory: Change default sha256 optimization to -O2
Message-ID: <20161130110233.GA31616@verge.net.au>
References: <32a52ca4-8741-e0e6-92c1-6b9583fa479b@infradead.org>
 <20161124075355.GC13096@verge.net.au>
 <CAHB_GupOJfW+1p9F9Ybuvz_VZ0Shs4OZyxLHm1cX-5svQk-oOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHB_GupOJfW+1p9F9Ybuvz_VZ0Shs4OZyxLHm1cX-5svQk-oOQ@mail.gmail.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, Kexec Mailing List <kexec@lists.infradead.org>

On Mon, Nov 28, 2016 at 11:14:38AM +0530, Pratyush Anand wrote:
> On Thu, Nov 24, 2016 at 1:23 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Nov 23, 2016 at 09:57:09AM -0800, Geoff Levand wrote:
> >> Change the default purgatory sha256 code optimization from -O0 to -O2, and add a
> >> new arch specific makefile variable $(ARCH)_PURGATORY_SHA256_CFLAGS which can
> >> over ride this default.  Set ia64_PURGATORY_SHA256_CFLAGS to -O0 to retain the
> >> previous optimization level for ia64.
> >>
> >> The purgatory sha256 code needs the be built with -O0 for the  ia64
> >> architecture.  Currently this code is built with -O0 for all architectures,
> >> which slows down the calculations for architectures which could otherwise
> >> use -O2.
> >
> > Could you give an indication of the performance improvement you expect,
> > e.g. on arm64?
> >
> 
> It takes around 20 second to verify SHA in purgatory when vmlinuz
> image is around 13MB and initramfs is around 30M with -O2 enables.
> Otherwise, it takes more than 2 minutes.

Thanks.

This patch doesn't seem to apply against the master branch.
I'm wondering if you or Geoff could:

1. Rebase the patch
2. Include some text about the performance improvement.
   Something like what is above would be fine from my pov.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
