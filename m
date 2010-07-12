Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from az33egw02.freescale.net ([192.88.158.103])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OYKxP-0001sa-Hn
	for kexec@lists.infradead.org; Mon, 12 Jul 2010 15:30:12 +0000
Subject: Re: kexec for powerpc mpc83xx processors
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
References: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
Date: Mon, 12 Jul 2010 10:29:53 -0500
Message-ID: <1278948593.9525.3.camel@localhost>
Mime-Version: 1.0
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
To: krish <radhakrishna.p@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Mon, 2010-07-12 at 11:52 +0530, krish wrote:
> I have changed subject to "mpc83xx" instead "mpc85xx", and continue
> compile error in this email.
> I will post new request for "support of kexec for mpc85xx", if
> required.

No this is fine, I'm just trying to make sure I understand exactly what
you are doing.

> 
> "Makefile.libfdt" file is not present in the package.
> 
> I have used following link to download package.
> http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-2.0.2-rc1.tar.gz 

It looks like this package is missing stuff. My only advice here is to
use git instead. I just tested GIT HEAD and the file is included and the
complication works. Can you give that a shot?

-M



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
