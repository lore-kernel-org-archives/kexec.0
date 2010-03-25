Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NuvxI-0004kf-VV
	for kexec@lists.infradead.org; Thu, 25 Mar 2010 22:55:17 +0000
Date: Fri, 26 Mar 2010 09:54:29 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Fix unused return value warning for fread
Message-ID: <20100325225429.GE5125@verge.net.au>
References: <78968d16b4ea65b185019732d0af5888ef070358.1269006846.git.ameya.palande@nokia.com>
	<20100324113118.GI10098@verge.net.au>
	<1269516233.2121.3.camel@sanganak>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1269516233.2121.3.camel@sanganak>
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
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Mar 25, 2010 at 01:23:53PM +0200, Ameya Palande wrote:
> On Wed, 2010-03-24 at 12:31 +0100, ext Simon Horman wrote:
> > On Fri, Mar 19, 2010 at 03:55:04PM +0200, Ameya Palande wrote:
> > > From: Ameya Palande <ameya.palande@nokia.com>
> > > 
> > > Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> > 
> > Thanks, applied.
> > 
> > BTW, which gcc and CFLAGS were you using to see that warning?
> > 
> 
> I guess -Werror and gcc > 4 (I don't know exact version since I was
> compiling it for arm on a build server).

Thanks. Though I don't seem to see them here with a similar (though non-arm)
setup.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
