Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK6xI-0007a7-IE
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 14:33:41 +0000
Date: Wed, 20 Aug 2014 10:33:15 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140820143315.GC16303@redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: "Thomas D." <whissi@whissi.de>, kexec@lists.infradead.org, Kees Cook <keescook@chromium.org>

On Tue, Aug 19, 2014 at 05:07:24PM +0800, WANG Chao wrote:
> On 08/18/14 at 10:57am, Vivek Goyal wrote:
> > Hi Thomas,
> > 
> > I think kexec is broken with CONFIG_RANDOMIZE_BASE=y. Chao had raised
> > this issue some time back when this option was introduced. I don't
> > remember the details though that why it is broken.
> 
> The following fix the problem for kdump case:
> 
> commit 0d52644
> Author: WANG Chao <chaowang@redhat.com>
> Date:   Fri Mar 28 15:05:00 2014 +0800
> 
>     x86, kaslr: add alternative way to locate kernel text mapping area
> 
> 
> For kexec case, it hangs in purgatory:
> 
> [  556.859384] kexec: Starting new kernel
> I'm in purgatory

Chao, 

Do you know why does it hang in purgatory in case of kexec?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
