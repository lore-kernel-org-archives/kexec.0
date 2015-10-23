Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZpStQ-0004J0-Tu
 for kexec@lists.infradead.org; Fri, 23 Oct 2015 03:19:49 +0000
Date: Fri, 23 Oct 2015 11:19:17 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec-tools: do not copy 1st kernel root= param in fs2dt.c
Message-ID: <20151023031917.GE11227@dhcp-129-115.nay.redhat.com>
References: <20151009055722.GA6248@dhcp-129-237.nay.redhat.com>
 <20151016013331.GB20667@verge.net.au>
 <20151019082246.GC31886@dhcp-129-115.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151019082246.GC31886@dhcp-129-115.nay.redhat.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: jstodola@redhat.com, kexec@lists.infradead.org

Hi, Simon

> 
> > 
> > Also, won't this affect other architectures that use DT.
> > I'm thinking about ARM. If so it might be good to tweak the changelog.
> 
> arm also uses the function, but I need verify the behavior. Will tune the changelog
> after I confirming it.

kexec on arm will have same problem when there's no external dtb being passed.
But kexec kernel failed to start up during my test there may be other problems.

I will work out a new patch for new option about skip adding root= from 1st kernel.

BTW, there's also a problem with external dtb --dtb option, I sent a patch to
revert the mmap patch from Michael, please review.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
