Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XJfOM-0005s2-9y
 for kexec@lists.infradead.org; Tue, 19 Aug 2014 09:07:46 +0000
Date: Tue, 19 Aug 2014 17:07:24 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
References: <53F11882.3060803@whissi.de>
 <20140818145718.GD4745@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140818145718.GD4745@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Thomas D." <whissi@whissi.de>, kexec@lists.infradead.org, Kees Cook <keescook@chromium.org>

On 08/18/14 at 10:57am, Vivek Goyal wrote:
> Hi Thomas,
> 
> I think kexec is broken with CONFIG_RANDOMIZE_BASE=y. Chao had raised
> this issue some time back when this option was introduced. I don't
> remember the details though that why it is broken.

The following fix the problem for kdump case:

commit 0d52644
Author: WANG Chao <chaowang@redhat.com>
Date:   Fri Mar 28 15:05:00 2014 +0800

    x86, kaslr: add alternative way to locate kernel text mapping area


For kexec case, it hangs in purgatory:

[  556.859384] kexec: Starting new kernel
I'm in purgatory

> 
> CCing Kees Cook. 
> 
> Kees, is there a quick fix to the issue. Sooner or later people will
> start enabling CONFIG_RANDOMIZE_BASE=y and broken kexec will be a
> big issue.
> 
> Thanks
> Vivek
>  
> On Sun, Aug 17, 2014 at 11:02:58PM +0200, Thomas D. wrote:
> > Hi,
> > 
> > looks like kexec doesn't support kernels where
> > 
> >   CONFIG_RANDOMIZE_BASE=y
> > 
> > is set.
> > 
> > 
> > I already created a bug for Debian in June for this problem [1].
> > 
> > I am able to confirm the same problem with kexec 2.0.7 on Gentoo and
> > when building from source (943ba35f8143408d8ada9a24d0986663cc612df9).
> > 
> > Is this a known problem/limitation?
> > 
> > Is there anything I can help you with to get this fixed?
> > 
> > Thanks.
> > 
> > 
> > See also:
> > =========
> > [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=754288
> > 
> > 
> > -Thomas
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
