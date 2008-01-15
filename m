Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JEezL-0003wY-5d
	for kexec@lists.infradead.org; Tue, 15 Jan 2008 06:09:31 +0000
Subject: [PATCH -mm 0/2 -v2] kexec/i386: kexec page table code clean up
From: "Huang, Ying" <ying.huang@intel.com>
Date: Tue, 15 Jan 2008 14:05:42 +0800
Message-Id: <1200377142.3505.49.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <Ian.Campbell@citrix.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

This patchset cleans up page table setup code of kexec on i386.

This patchset is based on 2.6.24-rc5-mm1 and has been tested on i386
with/without PAE enabled.


v2:

- Rename some function names, such as alloc_page_tables ->
  machine_kexec_alloc_page_tables, etc.

- Cleanup error processing for machine_alloc_page_tables.


Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
