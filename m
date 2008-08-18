Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KUz5S-0002IY-GL
	for kexec@lists.infradead.org; Mon, 18 Aug 2008 07:23:35 +0000
From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] Explicitly use BUILD_CC and TARGET_CC
Date: Mon, 18 Aug 2008 17:19:48 +1000
References: <1219030410.884068.167991623519.1.gpush@pingu>
	<20080818071037.GA5029@verge.net.au>
In-Reply-To: <20080818071037.GA5029@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200808181519.48759.jk@ozlabs.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

Hi Horms,

> On some architectures, such as ia64, PURGATORY_SRCS can include .S
> files. Prehaps we need PURGATORY_C_SRCS and PURGATORY_ASM_SRCS ?

That should be fine: we just add a rule for %.o: %.S

> I think that you need $(TARGET_CC) -c here.
> Also above for purgatory/sha256.o if that target is to remain
> separate.

Good point. New patch coming.


Jeremy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
