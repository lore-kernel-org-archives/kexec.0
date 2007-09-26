Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IabTL-00072s-0S
	for kexec@lists.infradead.org; Wed, 26 Sep 2007 14:18:58 -0400
Date: Wed, 26 Sep 2007 20:18:51 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 1/7] Extended crashkernel command line
Message-ID: <20070926181851.GA29815@suse.de>
References: <20070925182257.900701776@strauss.suse.de>
	<20070925182258.175348676@strauss.suse.de>
	<E1IaHPU-00089b-Bc@flower> <20070926161602.GA26909@suse.de>
	<20070926181843.GB24301@flower.upol.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070926181843.GB24301@flower.upol.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, "Bernhard Walle (in kexec list)" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org

* Oleg Verych <olecom@flower.upol.cz> [2007-09-26 20:18]:
> 
> I was thinking about errors in YaST or typos in bootloader config, that
> may appear sometimes. And kernel must tolerate this kind of userspace
> input to be more reliable. But you know better, i just am waving hands.

Of course the kernel must be able to handle them -- outputting an
error message that can be read by the user and not crashing. But I
don't expect that the kernel then reservate crash memory by guessing
of values.



Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
