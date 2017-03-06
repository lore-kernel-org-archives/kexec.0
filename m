Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1ckoAN-0002zO-QT
 for kexec@lists.infradead.org; Mon, 06 Mar 2017 08:38:53 +0000
Date: Mon, 6 Mar 2017 09:38:23 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] gitignore: add two generated files in purgatory
Message-ID: <20170306083823.GB11468@verge.net.au>
References: <1486765205-14336-1-git-send-email-eric.devolder@oracle.com>
 <20170213224618.GJ9543@olila.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170213224618.GJ9543@olila.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: andrew.cooper3@citrix.com, Eric DeVolder <eric.devolder@oracle.com>, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Mon, Feb 13, 2017 at 11:46:18PM +0100, Daniel Kiper wrote:
> On Fri, Feb 10, 2017 at 04:20:05PM -0600, Eric DeVolder wrote:
> > This patch adds the two generated files below to .gitignore.
> 
> Next time please add why it is needed. One sentence explanation is sufficient.
> 
> > purgatory/purgatory.map
> > purgatory/purgatory.ro.sym
> >
> > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> Otherwise:
> 
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
