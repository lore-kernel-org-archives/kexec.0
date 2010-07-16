Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OZeVc-0007gr-4w
	for kexec@lists.infradead.org; Fri, 16 Jul 2010 06:34:57 +0000
Date: Fri, 16 Jul 2010 15:34:49 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec for powerpc mpc83xx processors
Message-ID: <20100716063449.GD2812@verge.net.au>
References: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
	<1278948593.9525.3.camel@localhost>
	<20100713025819.GA23313@verge.net.au>
	<AANLkTimEjIx1lh7YJHg7-WeKZYNFYve73vl8k_C5KvAR@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimEjIx1lh7YJHg7-WeKZYNFYve73vl8k_C5KvAR@mail.gmail.com>
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
Cc: Matthew McClintock <msm@freescale.com>, kexec@lists.infradead.org

On Fri, Jul 16, 2010 at 11:42:32AM +0530, krish wrote:
> Thanks for the announcement of new release.
> 
> I have successfully compiled for mpc83xx, but execution was failed with
> following message
> "Symbol: mem_size found cannot set".
> 
> The root cause behind it was that pul_stack and mem_size symbols are not
> defined in purgatory/arch/ppc/purgatory-ppc.c file.
> Correct me if i am wrong.
> 
> As i am new to git, I am going through the git user manual to sync with the
> latest sources and if possible to provide code changes in patch-format..

git diff would probably suffice if you want a two-word getting started guide :-)
Please provide an appropriate description and signed-off-by line with the patch.

Once you resolve this problem does kexec work?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
