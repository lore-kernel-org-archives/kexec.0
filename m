Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OzocV-0004dr-Ng
	for kexec@lists.infradead.org; Sun, 26 Sep 2010 10:38:12 +0000
Date: Sun, 26 Sep 2010 06:37:53 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1734560070.1994601285497473017.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4C9EEE98.7020906@kernel.org>
Subject: Re: kexec load failure introduced by "x86, memblock: Replace
	e820_/_early string with memblock_"
MIME-Version: 1.0
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-next <linux-next@vger.kernel.org>, kexec <kexec@lists.infradead.org>, "H. Peter Anvin" <hpa@zytor.com>


----- "Yinghai Lu" <yinghai@kernel.org> wrote:

> On 09/25/2010 11:55 PM, CAI Qian wrote:
> >>
> >> are you kexec from 2.6.35+ to 2.6.36-rc3+?
> > No, both kernels were the same version. I am sorry the above logs
> were misleading that were copy-and-pasted from different kernel
> versions.
> 
> can you check tip instead of next tree?
I am wondering which patches there do you think would make the regression go away?
> 
> Yinghai
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
