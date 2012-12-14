Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TjVO4-0000FP-0p
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 13:33:12 +0000
Date: Fri, 14 Dec 2012 22:33:09 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-zImage-arm: add code to support --command-line
 along with --dtb
Message-ID: <20121214133309.GJ16382@verge.net.au>
References: <1355405734-19630-1-git-send-email-zonque@gmail.com>
 <1355476821.1341.10.camel@sven>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1355476821.1341.10.camel@sven>
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
To: Sven Neumann <s.neumann@raumfeld.com>
Cc: matthew.leach@arm.com, kexec@lists.infradead.org, Daniel Mack <zonque@gmail.com>

On Fri, Dec 14, 2012 at 10:20:21AM +0100, Sven Neumann wrote:
> Hi,
> 
> On Thu, 2012-12-13 at 14:35 +0100, Daniel Mack wrote:
> > If --dtb is called together with --command-line, we need to modify the
> > binary dtb buffer. Luckily, we have libfdt functions available, so this
> > is straight forward.
> > 
> > Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> Tested-by: Sven Neumann <s.neumann@raumfeld.com>
> 
> Works fine for us. Please include this upstream as we rely on this
> functionality to be present.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
