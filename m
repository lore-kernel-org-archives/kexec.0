Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vnp5x-0002AJ-Ph
 for kexec@lists.infradead.org; Tue, 03 Dec 2013 12:28:54 +0000
Date: Tue, 3 Dec 2013 21:28:28 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools/xen: Fix typo in __i386__ preprocessor
 identifier
Message-ID: <20131203122828.GF21976@verge.net.au>
References: <1385487757-18378-1-git-send-email-andrew.cooper3@citrix.com>
 <20131126194910.GD25648@olila.local.net-space.pl>
 <529DABDE.4020304@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529DABDE.4020304@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Xen-devel <xen-devel@lists.xen.org>

On Tue, Dec 03, 2013 at 10:01:02AM +0000, Andrew Cooper wrote:
> On 26/11/13 19:49, Daniel Kiper wrote:
> > On Tue, Nov 26, 2013 at 05:42:37PM +0000, Andrew Cooper wrote:
> >> This typo was introduced in c/s c0b4a3f95dd80256cc6d7084436235e69b4933fb
> >>
> >> It prevents a 32bit build of kexec from loading a 32bit crash image.
> >>
> >> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> >> CC: David Vrabel <david.vrabel@citrix.com>
> >> CC: Daniel Kiper <daniel.kiper@oracle.com>
> >> CC: Simon Horman <horms@verge.net.au>
> >> CC: kexec@lists.infradead.org
> > Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> >
> > Daniel
> 
> Ping?

Thanks, I had missed this.
I have applied it now.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
