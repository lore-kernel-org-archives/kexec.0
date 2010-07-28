Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OeEd0-0007Ah-BI
	for kexec@lists.infradead.org; Wed, 28 Jul 2010 21:57:31 +0000
Message-ID: <4C50A7AD.8040902@zytor.com>
Date: Wed, 28 Jul 2010 14:57:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: In place kexec
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
To: Eric Biederman <ebiederm@xmission.com>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

We are getting a claim that the qla driver corrupts memory after a
kexec, apparently due to a DMA engine left running in the before-kernel.

For an in-place kexec (as opposed to a crash dump kexec, where we switch
into dedicated memory), what shutdown paths get executed?

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
