Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sh8I0-0004fA-Pm
 for kexec@lists.infradead.org; Tue, 19 Jun 2012 23:56:53 +0000
Date: Wed, 20 Jun 2012 08:56:46 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: KDUMP on ARM 2.6.29
Message-ID: <20120619235646.GE25388@verge.net.au>
References: <89F185D227E3A946B43C424153BAE2B05D2D4B@048-CH1MPN1-078.048d.mgd.msft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <89F185D227E3A946B43C424153BAE2B05D2D4B@048-CH1MPN1-078.048d.mgd.msft.net>
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
To: nandu.ahmed@accenture.com
Cc: kexec@lists.infradead.org

On Tue, Jun 19, 2012 at 04:07:13PM +0000, nandu.ahmed@accenture.com wrote:
> Is Kdump onARM supported ? Which kernel mainline are they supported. Any
> information available?  I am trying to port Kdump on my ARM
> board/emulator with SMP enabled but haven't got any clue if this is
> supported. I have not came across any evidence to show Kdump supported on
> Arm but have seen few mentions having using Kdump on ARM platfomrm in
> public forums. Any help would be highly appreciated.

Hi Nandu,

My advice is to try with SMP disabled and then take things from there.

I believe that Will Deacon did some work on ARM SMP kexec that was
included in the 3.2 kernel. It depends on CPU hotplug working which
you should be able to verify independent of Kexec.

I am unsure of the status of Kdump on ARM but I suspect it
is similar if not the same as that of Kexec.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
