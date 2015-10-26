Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZqZSp-0007rd-Et
 for kexec@lists.infradead.org; Mon, 26 Oct 2015 04:32:56 +0000
Date: Mon, 26 Oct 2015 13:32:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: do not copy 1st kernel root= param in fs2dt.c
Message-ID: <20151026043233.GC2411@verge.net.au>
References: <20151009055722.GA6248@dhcp-129-237.nay.redhat.com>
 <20151016013331.GB20667@verge.net.au>
 <20151019082246.GC31886@dhcp-129-115.nay.redhat.com>
 <20151023031917.GE11227@dhcp-129-115.nay.redhat.com>
 <20151023092319.GF11227@dhcp-129-115.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151023092319.GF11227@dhcp-129-115.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: jstodola@redhat.com, kexec@lists.infradead.org

On Fri, Oct 23, 2015 at 05:23:19PM +0800, Dave Young wrote:
> On 10/23/15 at 11:19am, Dave Young wrote:
> > Hi, Simon
> > 
> > > 
> > > > 
> > > > Also, won't this affect other architectures that use DT.
> > > > I'm thinking about ARM. If so it might be good to tweak the changelog.
> > > 
> > > arm also uses the function, but I need verify the behavior. Will tune the changelog
> > > after I confirming it.
> > 
> > kexec on arm will have same problem when there's no external dtb being passed.
> > But kexec kernel failed to start up during my test there may be other problems.
> > 
> > I will work out a new patch for new option about skip adding root= from 1st kernel.
> 
> Simon, for the new option, I'm thinking to create a "--dt-no-old-root". It can be
> a general option, or arch dependent one for arm and ppc64. What do you prefer?

Lets just make it arch dependent if it only changes the behaviour
on some architectures. The name sounds good to me.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
