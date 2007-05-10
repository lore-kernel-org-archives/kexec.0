Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlxU3-0001S4-2N
	for kexec@lists.infradead.org; Wed, 09 May 2007 21:30:22 -0400
Date: Thu, 10 May 2007 10:30:10 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Handle maloc() failure in xen_get_nr_phys_cpus()
Message-ID: <20070510013008.GA27220@verge.net.au>
References: <20070509095609.44BAA4F7D7@tabatha.lab.ultramonkey.org>
	<1178707717.4742.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1178707717.4742.7.camel@localhost.localdomain>
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
To: Ian Campbell <Ian.Campbell@xensource.com>
Cc: kexec@lists.infradead.org

On Wed, May 09, 2007 at 11:48:37AM +0100, Ian Campbell wrote:
> On Wed, 2007-05-09 at 18:56 +0900, Simon Horman wrote:
> > Currently xen_get_nr_phys_cpus() doesn't write to xen_phys_notes if
> > allocation fails, but it doesn't return an error either, leaving
> > xen_phys_notes wide open to be accessed by other functions later.
> > 
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Looks good to me.
>
> Acked-by: Ian Campbell <ian.campbell@xensource.com>

Thanks, I've applied it now.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
