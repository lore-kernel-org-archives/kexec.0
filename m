Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hg9Kn-0002ug-HF
	for kexec@lists.infradead.org; Mon, 23 Apr 2007 20:56:47 -0400
Date: Tue, 24 Apr 2007 09:56:35 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Update the list information for kexec and kdump
Message-ID: <20070424005634.GD11736@verge.net.au>
References: <20070423083936.GI4272@verge.net.au>
	<m13b2rvuge.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m13b2rvuge.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@in.ibm.com>, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>

On Mon, Apr 23, 2007 at 12:04:01PM -0600, Eric W. Biederman wrote:
> Simon Horman <horms@verge.net.au> writes:
> 
> > Update the list information for kexec and kdump
> >
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > --- 
> > Is it too early for this change?
> 
> It looks like the new list is working, and isn't likely to get overwhelmed
> with spam.  I don't know if everyone has switched over yet but we can
> certainly update MAINTAINERS. 

Last time I checked there were 28 people in the kexec@ list.
This isn't everyone, but it is getting there.

May I add an Acked-by you ?

> Eric
> 
> > Index: linux-2.6/MAINTAINERS
> > ===================================================================
> > --- linux-2.6.orig/MAINTAINERS	2007-04-23 17:34:30.000000000 +0900
> > +++ linux-2.6/MAINTAINERS	2007-04-23 17:34:47.000000000 +0900
> > @@ -1951,7 +1951,7 @@ P:	Vivek Goyal
> >  M:	vgoyal@in.ibm.com
> >  P:	Haren Myneni
> >  M:	hbabu@us.ibm.com
> > -L:	fastboot@lists.osdl.org
> > +L:	kexec@lists.infradead.org
> >  L:	linux-kernel@vger.kernel.org
> >  W:	http://lse.sourceforge.net/kdump/
> >  S:	Maintained
> > @@ -2001,7 +2001,7 @@ P:	Eric Biederman
> >  M:	ebiederm@xmission.com
> >  W:	http://www.xmission.com/~ebiederm/files/kexec/
> >  L:	linux-kernel@vger.kernel.org
> > -L:	fastboot@lists.osdl.org
> > +L:	kexec@lists.infradead.org
> >  S:	Maintained
> >  
> >  KPROBES

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
