Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnUJV-0006WS-NI
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 14:17:31 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 0/4] makedumpfile: Xen fixes and cleanups
Date: Mon,  2 Dec 2013 15:16:40 +0100
Message-Id: <1385993804-27721-1-git-send-email-daniel.kiper@oracle.com>
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

This is second version of patch series containing following
makedumpfile Xen fixes and cleanups:
  - makedumpfile/xen: Add cache_init() call to initial_xen(),
  - makedumpfile/xen: Disable cyclic mode for every Xen crash dump,
  - makedumpfile/xen: Fail immediately on every architecture if dump level is invalid,
  - makedumpfile/xen: Move cyclic mode check from initial() to initial_xen().

All patches were tested with Xen versions up to latest unstable.

Please apply.

Daniel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
