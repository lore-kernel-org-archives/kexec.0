Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1eeGXv-0004Qj-Mv
 for kexec@lists.infradead.org; Wed, 24 Jan 2018 08:36:41 +0000
Date: Wed, 24 Jan 2018 09:36:11 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/2] kexec-tools: Make xc_dlhandle static
Message-ID: <20180124083611.2iqfgqke4plmw4i3@verge.net.au>
References: <1516734771-14795-1-git-send-email-eric.devolder@oracle.com>
 <1516734771-14795-3-git-send-email-eric.devolder@oracle.com>
 <20180123205914.GQ4675@olila.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180123205914.GQ4675@olila.local.net-space.pl>
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

On Tue, Jan 23, 2018 at 09:59:14PM +0100, Daniel Kiper wrote:
> On Tue, Jan 23, 2018 at 01:12:51PM -0600, Eric DeVolder wrote:
> > This patch is a follow-on to commit 43d3932e "kexec-tools: Perform
> > run-time linking of libxenctrl.so". This patch addresses feedback
> > from Daniel Kiper.
> >
> > This patch implements Daniel's suggestion to make the
> > xc_dlhandle variable static.
> >
> > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> Just two nitpicks... Otherwise you can add
> 
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Eric, please address Daniel's review and repost this patch as appropriate.
There is no need to repost patch 1/2 as I've applied it.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
