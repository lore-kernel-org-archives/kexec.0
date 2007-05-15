Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hnond-0004FF-If
	for kexec@lists.infradead.org; Tue, 15 May 2007 00:38:18 -0400
Date: Tue, 15 May 2007 13:38:04 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch v3] kexec fix ppc64 device-tree mem node
Message-ID: <20070515043802.GA13708@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE38.5090901@am.sony.com> <46413472.8000304@am.sony.com>
	<46424CA7.8060204@am.sony.com> <4648B3C4.6000506@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4648B3C4.6000506@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

On Mon, May 14, 2007 at 12:08:52PM -0700, Geoff Levand wrote:
> Hi Simon.
> 
> Geoff Levand wrote:
> > Subject: kexec fix ppc64 device-tree mem node
> > 
> > Change the ppc64 device-tree memory node name spec to match the allowable names
> > specified in the booting-without-of document.
> > 
> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> > ---
> > Version 2, Changed to look for 'memory', or 'memory@' nodes.
> > Version 3, Fixed missing 'if' in get_base_ranges().
> > 
> >  kexec/arch/ppc64/crashdump-ppc64.c |    3 ++-
> >  kexec/arch/ppc64/kexec-ppc64.c     |   14 +++++++++-----
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> There are currently no outstanding issues with this, so
> I would like it to get merged in. It is needed to support
> kexec on the PS3 game console.

Sure, I have applied it now.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
