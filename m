Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XJONW-0001Vm-Qk
 for kexec@lists.infradead.org; Mon, 18 Aug 2014 14:57:47 +0000
Date: Mon, 18 Aug 2014 10:57:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140818145718.GD4745@redhat.com>
References: <53F11882.3060803@whissi.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53F11882.3060803@whissi.de>
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
To: "Thomas D." <whissi@whissi.de>
Cc: kexec@lists.infradead.org, Kees Cook <keescook@chromium.org>, WANG Chao <chaowang@redhat.com>

Hi Thomas,

I think kexec is broken with CONFIG_RANDOMIZE_BASE=y. Chao had raised
this issue some time back when this option was introduced. I don't
remember the details though that why it is broken.

CCing Kees Cook. 

Kees, is there a quick fix to the issue. Sooner or later people will
start enabling CONFIG_RANDOMIZE_BASE=y and broken kexec will be a
big issue.

Thanks
Vivek
 
On Sun, Aug 17, 2014 at 11:02:58PM +0200, Thomas D. wrote:
> Hi,
> 
> looks like kexec doesn't support kernels where
> 
>   CONFIG_RANDOMIZE_BASE=y
> 
> is set.
> 
> 
> I already created a bug for Debian in June for this problem [1].
> 
> I am able to confirm the same problem with kexec 2.0.7 on Gentoo and
> when building from source (943ba35f8143408d8ada9a24d0986663cc612df9).
> 
> Is this a known problem/limitation?
> 
> Is there anything I can help you with to get this fixed?
> 
> Thanks.
> 
> 
> See also:
> =========
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=754288
> 
> 
> -Thomas
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
