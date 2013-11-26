Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlP6k-000680-73
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 20:19:42 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 0/3] makedumpfile: Xen fixes
Date: Tue, 26 Nov 2013 21:18:46 +0100
Message-Id: <1385497129-19501-1-git-send-email-daniel.kiper@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, david.vrabel@citrix.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xen.org

Hi,

This patch series contains following makedumpfile Xen fixes:
  - makedumpfile/xen: Move Xen crash dump check,
  - makedumpfile/xen: Disable cyclic mode for every Xen crash dump,
  - makedumpfile/xen: Fail immediately if dump level is invalid.

All patches were tested with Xen versions up to latest unstable.

Please apply.

Daniel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
