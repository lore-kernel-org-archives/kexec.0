Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]
	helo=TX2EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OZmXG-0007OZ-6B
	for kexec@lists.infradead.org; Fri, 16 Jul 2010 15:09:11 +0000
Subject: Re: kexec for powerpc mpc83xx processors
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <AANLkTimEjIx1lh7YJHg7-WeKZYNFYve73vl8k_C5KvAR@mail.gmail.com>
References: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
	<1278948593.9525.3.camel@localhost>
	<20100713025819.GA23313@verge.net.au>
	<AANLkTimEjIx1lh7YJHg7-WeKZYNFYve73vl8k_C5KvAR@mail.gmail.com>
Date: Fri, 16 Jul 2010 10:08:35 -0500
Message-ID: <1279292915.4556.0.camel@localhost>
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
To: krish <radhakrishna.p@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Fri, 2010-07-16 at 11:42 +0530, krish wrote:
> Thanks for the announcement of new release.
> 
> I have successfully compiled for mpc83xx, but execution was failed
> with following message
> "Symbol: mem_size found cannot set".
> 
> The root cause behind it was that pul_stack and mem_size symbols are
> not defined in purgatory/arch/ppc/purgatory-ppc.c file.
> Correct me if i am wrong.
> 
> As i am new to git, I am going through the git user manual to sync
> with the latest sources and if possible to provide code changes in
> patch-format..

My patches to the list recently should address those issues.

-M



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
