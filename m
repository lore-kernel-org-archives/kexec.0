Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OZeoX-0003mW-63
	for kexec@lists.infradead.org; Fri, 16 Jul 2010 06:54:29 +0000
Date: Fri, 16 Jul 2010 15:54:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: export kexec.h to userspace
Message-ID: <20100716065424.GA20761@verge.net.au>
References: <20100619132235.GA24200@basil.fritz.box>
	<20100619182419.GA22079@merkur.ravnborg.org>
	<20100619195345.GT18946@basil.fritz.box>
	<20100620082315.GA23188@merkur.ravnborg.org>
	<m1bpb6ozef.fsf@fess.ebiederm.org>
	<20100620092333.GA10987@basil.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100620092333.GA10987@basil.fritz.box>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, akpm@linux-foundation.org, Sam Ravnborg <sam@ravnborg.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Sun, Jun 20, 2010 at 11:23:34AM +0200, Andi Kleen wrote:
> > Can we please do this the other way around and create a kexec_user.h?
> > Having a an xxx_user.h is a pattern we already have in the kernel.
> > I can't find a signle xxxx_kernel.h
> 
> If you do that you have to change the man page.
> 
> Or just keep my simple patch.

It seems more logical to me to update the documentation -
its new documentation, isn't it?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
