Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnYps-0005Bu-S7
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 19:07:14 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 0/2] kexec-tools: Minor Xen fixes and cleanups
Date: Mon,  2 Dec 2013 20:06:23 +0100
Message-Id: <1386011185-29350-1-git-send-email-daniel.kiper@oracle.com>
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
To: andrew.cooper3@citrix.com, david.vrabel@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, xen-devel@lists.xen.org

Hi,

This patch series contains following minor Xen fixes and cleanups for kexec-tools:
  - kexec-tools/xen: Do not call xc_interface_close() if xc_interface_open() failed,
  - kexec-tools/xen: Remove redundant include.

Please apply.

Daniel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
