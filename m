Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MnlYL-0006Ue-Cw
	for kexec@lists.infradead.org; Wed, 16 Sep 2009 03:51:39 +0000
Date: Wed, 16 Sep 2009 13:51:32 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: How to build the kexec too for ARM11 using the cross compiler.
Message-ID: <20090916035131.GO24467@verge.net.au>
References: <E99B4DCB8B5A0241832DBF4FCB7C813A7D0280@zch01exm27.fsl.freescale.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E99B4DCB8B5A0241832DBF4FCB7C813A7D0280@zch01exm27.fsl.freescale.net>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Lai Weilin-B04597 <B04597@freescale.com>
Cc: kexec@lists.infradead.org

On Wed, Sep 16, 2009 at 11:06:34AM +0800, Lai Weilin-B04597 wrote:
> Hi,
> I am trying to build kexec tool for ARM11.  I can't see any doc that
> helps to configure. The cross compiler is used, and I tried the
> following configure option, 
> ./configure arm --prefix=/usr --build=arm-none-linux-gnueabi
> --host=i686-pc-linux-gnu --target=arm-none-linux-gnueabi
> but failed.
> Anyone can help ?

Hi,

When cross-compiling for arm the following works for me:

autoheader
autoconf
./configure --host=arm-unknown-linux-gnu

In what way is what you are trying failing?
And are you trying to build natively or cross-compile?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
