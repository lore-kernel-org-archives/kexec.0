Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgBvF-00083Z-UD
	for kexec@lists.infradead.org; Mon, 31 Mar 2008 04:47:06 +0000
Date: Mon, 31 Mar 2008 13:24:57 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH 0/4] extract vmcoreinfo from /proc/vmcore for Xen
In-Reply-To: <20070928090647.6EA9.ODA@valinux.co.jp>
References: <20070928090647.6EA9.ODA@valinux.co.jp>
Message-Id: <20080331125116.DDC7.ODA@valinux.co.jp>
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

This is for xen-3.2.0.

[PATCH 1/4] patch for xen hypervisor (xen-3.2.0)
[PATCH 2/4] patch for linux (linux-2.6.18-xen-3.2.0)
[PATCH 3/4] patch for kexec-tools (kexec-tools-testing-20080324)
[PATCH 4/4] patch for makedumpfile (makedumpfile-1.2.4)

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

note: makedumpfile command and crash command needs some fixes for
  xen-3.2.0 (which are independent of vmcoreinfo). I will post
  these fixes near future.

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
