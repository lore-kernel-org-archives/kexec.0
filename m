Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f955m-0006iw-Bj
 for kexec@lists.infradead.org; Thu, 19 Apr 2018 08:39:06 +0000
Date: Thu, 19 Apr 2018 10:38:45 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec: Add --no-checks option
Message-ID: <20180419083845.qmdol6a5xm57vry7@verge.net.au>
References: <1445469125.30908.105.camel@infradead.org>
 <fc68e396-1eab-7cc3-fcbd-01b03e5967cb@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc68e396-1eab-7cc3-fcbd-01b03e5967cb@infradead.org>
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
Cc: James Morse <james.morse@arm.com>, Kostiantyn Iarmak <kiarmak@cisco.com>, kexec@lists.infradead.org, Petitboot@lists.ozlabs.org

On Wed, Apr 11, 2018 at 11:30:48AM -0700, Geoff Levand wrote:
> Add a new option --no-checks to kexec that allows for a fast
> reboot by avoiding the purgatory integrity checks.  This option is
> intended for use by kexec based bootloaders that load a new
> image and then immediately transfer control to it.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> Hi Simon,
> 
> On 10/21/2015 04:12 PM, Geoff Levand wrote:
> > Hi Simon,
> > 
> > It was reported that on some systems where purgatory is running
> > without caches enabled the sha256 calculations would take several
> > minutes.  For bootloaders that just load a new image and
> > immediately jump into it the loss of the integrity check is worth
> > the increase in boot speed.  Please consider.
> 
> There seems to be continued interest in faster kexec re-boot times
> on arm64 systems so I rebased my old patch and renamed the
> option from '--lite' to '--no-checks'.  Please consider.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
