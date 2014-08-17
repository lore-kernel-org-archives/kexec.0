Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from borg.tf-network.de ([62.75.218.204])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XJ7bp-00039n-5S
 for kexec@lists.infradead.org; Sun, 17 Aug 2014 21:03:25 +0000
Message-ID: <53F11882.3060803@whissi.de>
Date: Sun, 17 Aug 2014 23:02:58 +0200
From: "Thomas D." <whissi@whissi.de>
MIME-Version: 1.0
Subject: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
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
To: kexec@lists.infradead.org

Hi,

looks like kexec doesn't support kernels where

  CONFIG_RANDOMIZE_BASE=y

is set.


I already created a bug for Debian in June for this problem [1].

I am able to confirm the same problem with kexec 2.0.7 on Gentoo and
when building from source (943ba35f8143408d8ada9a24d0986663cc612df9).

Is this a known problem/limitation?

Is there anything I can help you with to get this fixed?

Thanks.


See also:
=========
[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=754288


-Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
