Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22c.google.com ([2607:f8b0:400e:c03::22c])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bSHly-0002ou-SR
 for kexec@lists.infradead.org; Wed, 27 Jul 2016 05:52:52 +0000
Received: by mail-pa0-x22c.google.com with SMTP id fi15so6975871pac.1
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 22:52:30 -0700 (PDT)
Date: Wed, 27 Jul 2016 14:57:52 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v1 0/4] arm64 kexec-tools patches
Message-ID: <20160727055751.GD2363@linaro.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <20160726230526.GD28591@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160726230526.GD28591@verge.net.au>
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
Cc: Geoff Levand <geoff@infradead.org>, Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Simon,

On Wed, Jul 27, 2016 at 08:05:27AM +0900, Simon Horman wrote:
> Hi Geoff.
> 
> On Tue, Jul 19, 2016 at 11:28:13PM +0000, Geoff Levand wrote:
> > This series adds the core support for kexec re-boot on ARM64.
> > 
> > Linux kernel support for kexec reboot [1] has been merged to the ARM64
> > for-next/core branch with the expectation that it will be included in the v4.8
> > stable kernel release.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html
> 
> There seems to have been quite a bit of discussion of this patchset.

This patchset consists of Geoff's kexec support and my kdump support.
Since the former has already been queued in arm64 subtree's for-next
branch, it will go into v4.8.

So please note it is solely my kdump patches that is under reviews now
as v23[1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445558.htmlk

Thanks,
-Takahiro AKASHI

> I am of a mind to release kexec-tools v2.0.12-rc1 (and thus v2.0.12)
> without these changes as the v4.7 kernel is already out and that
> is the timing I had in mind for kexec-tools v2.0.12 (the lateness on
> my shoulders).
> 
> The implication is the arm64 patches would likely end up in the v2.0.13
> release of kexec-tools which I aim to release around the time of the v4.9
> kernel.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
