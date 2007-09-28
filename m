Return-path: <kexec-bounces@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ib42z-0003YC-1C
	for kexec@lists.infradead.org; Fri, 28 Sep 2007 01:49:41 +0100
Date: Fri, 28 Sep 2007 09:49:01 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [makedumpfile] extract vmcoreinfo from /proc/vmcore for Xen
Message-Id: <20070928090647.6EA9.ODA@valinux.co.jp>
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
Errors-To: kexec-bounces@lists.infradead.org
To: kexec@lists.infradead.org
Cc: xen-devel@lists.xensource.com

Hi,

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

I'd like to support the "extract vmcoreinfo from /proc/vmcore"
function for the Xen extraction too.

I think a way of supporting this as follows:

* The hypervisor makes its vmcoreinfo at the initialize.
* add a new hypervisor call to get the hypervisor's vmcoreinfo.
  The hypercall would be a subcommand of the kexec hypercall.
* dom-0 exposes the hypervisor's vmcoreinfo via 
  /sys/hypervisor/vmcoreinfo
* kexec-tool looks /sys/hypervisor/vmcoreinfo and makes an elf-note
  according it

Any comments or suggestions are welcome before I will start to
implement it.

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
