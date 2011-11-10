Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from canuck.infradead.org ([2001:4978:20e::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ROKSV-0001cT-Bt
 for kexec@lists.infradead.org; Thu, 10 Nov 2011 02:33:43 +0000
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
 by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1ROKSU-0002Jg-FY
 for kexec@lists.infradead.org; Thu, 10 Nov 2011 02:33:43 +0000
Date: Thu, 10 Nov 2011 11:33:34 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kdump: kill redundant code
Message-ID: <20111110023333.GL9202@verge.net.au>
References: <20111109070452.GA25768@darkstar.nay.redhat.com>
 <20111109152012.GA12537@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111109152012.GA12537@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On Wed, Nov 09, 2011 at 10:20:13AM -0500, Vivek Goyal wrote:
> On Wed, Nov 09, 2011 at 03:04:52PM +0800, Dave Young wrote:
> > in while loop below, hole_end > crashk_res.end is impossible:
> > while (hole_end <= crashk_res.end) {
> > 	[snip]
> > }
> > Killing the check code here
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> 
> Makes sense.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Indeed it does. I wonder if this was always so redundant.

Acked-by: Simon Horman <horms@verge.net.au>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
