Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6i79-0002mB-E6
	for kexec@lists.infradead.org; Thu, 12 Jun 2008 08:24:59 +0000
Date: Thu, 12 Jun 2008 17:22:50 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH 0/2] extract vmcoreinfo from /proc/vmcore for Xen
Message-Id: <20080612165246.16CC.ODA@valinux.co.jp>
MIME-Version: 1.0
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
To: xen-devel@lists.xensource.com
Cc: kexec@lists.infradead.org

Hi,

The following patchset is to support extracting vmcoreinfo from
/proc/vmcore for Xen.

This is the up-port of the patchset I made for 3.2.0 and posted
the end of March.

[PATCH 1/2] patch for xen hypervisor (xen-unstable.hg)
[PATCH 2/2] patch for linux (linux-2.6.18-xen.hg)

--- background ----------------------------------------------------
* what the makedumpfile is:
  To shorten the size of the dumpfile and the time of creating the
  dumpfile, makedumpfile copies only the necessary pages for analysis
  to the dumpfile from /proc/vmcore. You can specify the kind of
  unnecessary pages with dump_level. If you want to shorten the size
  further, enable the compression of the page data.
* Xen extraction 
  makedumpfile also has a feature that extracting the part of
  xen hypervisor and domain-0 from /proc/vmcore taken under xen
  environment. In most cases under xen environment, it is enough to
  analyze a cause of system crash.
* extract vmcoreinfo from /proc/vmcore
  makedumpfile 1.2.0 supports to extract the vmcoreinfo data from
  /proc/vmcore and uses it for dump filtering. (for a vmcore taken
  under the native environment.)
------------------------------------------------------------------

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
