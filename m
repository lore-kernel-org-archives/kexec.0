Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R5uvk-00008C-Br
	for kexec@lists.infradead.org; Tue, 20 Sep 2011 07:39:49 +0000
Received: from joe.akashicho.tokyo.vergenet.net
	(joe.akashicho.tokyo.vergenet.net
	[IPv6:2001:470:f44f:403:1ec1:deff:fe98:754d])
	by kirsty.vergenet.net (Postfix) with ESMTP id 1AF8724051
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 17:39:40 +1000 (EST)
Date: Tue, 20 Sep 2011 16:39:38 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools on github
Message-ID: <20110920073937.GA6415@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

as kernel.org is down I have push the kexec-tools tree to github.
It is available at:

	git://github.com/horms/kexec-tools.git

The push includes the following changes which I applied after kernel.org
became unavailable:

	6b8a0f7 kexec-tools: s390: Find correct address for ramdisk
	3ca990e kexec-tools: Add --append option for s390
	0ee3b4c Use unsigned char buffers in uImage loader

It is my intention to use this tree on github until kernel.org becomes
available again. I will post a further announcement at that time.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
