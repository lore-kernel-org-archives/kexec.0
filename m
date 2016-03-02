Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aauRn-0005I9-C1
 for kexec@lists.infradead.org; Wed, 02 Mar 2016 00:15:25 +0000
Date: Wed, 2 Mar 2016 09:14:58 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH update] kexec/fs2dt.c: wrong dt node fix
Message-ID: <20160302001458.GD17986@verge.net.au>
References: <20160226115755.GA10986@dhcp-128-65.nay.redhat.com>
 <20160226133920.5ffzizkxxsp4jggl@hawk.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160226133920.5ffzizkxxsp4jggl@hawk.localdomain>
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
To: Andrew Jones <drjones@redhat.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>

On Fri, Feb 26, 2016 at 02:39:20PM +0100, Andrew Jones wrote:
> On Fri, Feb 26, 2016 at 07:57:55PM +0800, Dave Young wrote:
> > 2nd kernel hangs early because of a regression caused by below commit:
> > commit 68262155d8c661586b809bc5301a7dff1c378137
> > Author: Andrew Jones <drjones@redhat.com>
> > Date:   Fri Nov 20 12:31:53 2015 -0500
> > 
> >     kexec/fs2dt: cleanup pathname
> >     
> >     putnode() will add the trailing '/', avoid having two. Also
> >     pathstart is unused, get rid of it.
> >     
> >     Signed-off-by: Andrew Jones <drjones@redhat.com>
> >     Signed-off-by: Simon Horman <horms@verge.net.au>
> > 
> > The actual purpose of the commit is to avoid double slash in pathname.
> > But unfortunately in function putnode() we have below magics to get the node
> > name:
> > 	basename = strrchr(pathname,'/') + 1;
> > 	...
> > 	strcpy((void *)dt, *basename ? basename : "");
> > 	...
> > 	strcat(pathname, "/");
> > 
> > We treat none zero basename as a node name, then concat a slash to open the
> > directory for later property handling.
> > pathname originally was "/proc/device-tree/" so for the first run of putnode
> > it will cause double slashes. With the commit above mentioned there are no
> > double slashes but we will copy "device-tree" to dt. Thus kexec kernel is not
> > happy..
> > 
> > Instead let's fix it by only concating slash when the basenanme is not empty
> > and restore the initial value of pathname as "/proc/device-tree/"
> > 
> > Note: I only reproduce the issue with loading older kernel like 3.10 in RHEL. I do
> > not see the problem in new kernels in Fedora.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> 
> Err.. sorry I missed that strrchr() for the basename.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
