Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZzpXp-0004il-Uf
 for kexec@lists.infradead.org; Fri, 20 Nov 2015 17:32:22 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id D08288E6E3
 for <kexec@lists.infradead.org>; Fri, 20 Nov 2015 17:32:00 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH 0/4] [RFT] cleanup /chosen/linux,stdout-path warning
Date: Fri, 20 Nov 2015 12:31:50 -0500
Message-Id: <1448040714-19841-1-git-send-email-drjones@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On arm we get

"Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
from purgatory is diabled"

when loading a kexec kernel. There are three problems with this warning.

 1) two slashes after device-tree
 2) we should be also checking (and firstly) for /chosen/stdout-path,
    as linux,stdout-path is the deprecated node name. We may actually
    have the former on arm, allowing us to avoid this warning all together.
 3) "disabled" has a typo in it

This series addresses these three problems with the last three patches,
and the first patch removes a compiler warning.

I've added the RFT as these patches touch code shared with other
architectures, namely powerpc, but I only tested on arm.

Please keep me on CC, as I'm not subscribed to the kexec mailing list.

Thanks,
drew

Andrew Jones (4):
  uImage: cleanup some warnings
  kexec/fs2dt: s/diabled/disabled/
  kexec/fs2dt: cleanup pathname
  kexec/fs2dt: check for /chosen/stdout-path first

 kexec/arch/arm/kexec-uImage-arm.c |  3 ++-
 kexec/arch/ppc/kexec-uImage-ppc.c |  5 +++--
 kexec/arch/sh/kexec-uImage-sh.c   |  3 ++-
 kexec/fs2dt.c                     | 26 ++++++++++++++------------
 4 files changed, 21 insertions(+), 16 deletions(-)

-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
