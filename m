Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RYLLp-00054U-Gh
 for kexec@lists.infradead.org; Wed, 07 Dec 2011 17:32:15 +0000
Date: Wed, 07 Dec 2011 12:32:10 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [Crash-utility] [RFC] makedumpfile, crash: LZO compression support
Message-ID: <46c499bc-10b0-46ac-9cc8-9a83bde973b2@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20111207171833.7c84c0a1.kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>
Cc: d hatayama <d.hatayama@jp.fujitsu.com>, kexec@lists.infradead.org



----- Original Message -----
> Hello Hatayama-san,
> 
> > How about the patch adding compression/IO time report?
> > I intended it only for the presentation of this RFC.
> 
> I think the above patch was posted only for this discussion,
> and I won't merge it into the makedumpfile.
> 
> 
> > I'll post the corresponding patch in crash's side after crash 6.0.2 is
> > released, waiting for new configuration editing feature as Dave has explained.
> 
> If the Crash supports LZO compression, I'll merge the feature into
> the makedumpfile.

I suppose it's a chicken-and-egg situation, but despite the recent
addition of the extra-library build feature added to the crash
utility, I wasn't planning to accept LZO compression support until
it was first supported in makedumpfile.  And even with crash support,
it would still require a hand-rebuild of the crash utility sources.

If this is merged into makedumpfile and crash, will Fujitsu's next
step will be to try to make it non-optional?  I'm still not convinced
it's worth forcing the pre-installation of the additional packages
and library by default.  

Dave
 
> Thanks.
> KUMAGAI, Atsushi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
