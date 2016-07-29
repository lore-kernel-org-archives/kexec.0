Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 29 Jul 2016 09:31:30 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v1 0/4] arm64 kexec-tools patches
Message-ID: <20160729003130.GB14228@verge.net.au>
References: <cover.1468970114.git.geoff@infradead.org>
 <20160726230526.GD28591@verge.net.au>
 <1469729354.16559.30.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1469729354.16559.30.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Pratyush Anand <panand@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, Jul 28, 2016 at 11:09:14AM -0700, Geoff Levand wrote:
> Hi Simon,
> 
> On Wed, 2016-07-27 at 08:05 +0900, Simon Horman wrote:
> 
> > There seems to have been quite a bit of discussion of this patchset.
> > 
> > I am of a mind to release kexec-tools v2.0.12-rc1 (and thus v2.0.12)
> > without these changes as the v4.7 kernel is already out and that
> > is the timing I had in mind for kexec-tools v2.0.12 (the lateness on
> > my shoulders).
> > 
> > The implication is the arm64 patches would likely end up in the v2.0.13
> > release of kexec-tools which I aim to release around the time of the v4.9
> > kernel.
> 
> OK, this seems reasonable.  Early users can build from your sources
> once the patches are merged if they need support.

Thanks, I will go ahead with that plan.

N.B.: I mixed up the kexec-tools release numbers, they should all be +1.
It is v2.0.13 that is coming soon and v2.0.14 somewhat latter.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
