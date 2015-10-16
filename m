Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zmtu9-0002k2-K5
 for kexec@lists.infradead.org; Fri, 16 Oct 2015 01:33:58 +0000
Date: Fri, 16 Oct 2015 10:33:31 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: do not copy 1st kernel root= param in fs2dt.c
Message-ID: <20151016013331.GB20667@verge.net.au>
References: <20151009055722.GA6248@dhcp-129-237.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151009055722.GA6248@dhcp-129-237.nay.redhat.com>
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

Hi Dave,

On Fri, Oct 09, 2015 at 01:57:22PM +0800, Dave Young wrote:
> Jan Stodola <jstodola@redhat.com> reported ppc64 root= is always added in kexec
> kernel cmdline. But sometimes we need boot without root= for example we use
> kexec to boot into installation initramfs image like below:
> kexec --load vmlinuz --initrd=initrd.img --command-line=\
> "inst.repo=http://<server>/<path>/Server/ppc64le/os/"
> 
> While creating dtb, in case there's no root= in user provided cmdline params 
> kexec-tools will find the original root= param used in 1st kernel and pass it
> to 2nd kernel. This caused that user have no way to remove root= cmdline.
> 
> Dropping that part of code so that one can get chance to kexec into 2nd kernel
> without root= param. One can still provide root= in --command-line=""

I'm a little concerned about the backwards-compatibility implications of
this change. Though I agree the new behaviour is entirely sane perhaps
it should be activated via a new command line option.

Also, won't this affect other architectures that use DT.
I'm thinking about ARM. If so it might be good to tweak the changelog.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
