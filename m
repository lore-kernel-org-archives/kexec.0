Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YtDNV-0004iJ-NO
 for kexec@lists.infradead.org; Fri, 15 May 2015 11:02:07 +0000
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
 [10.134.21.209])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id E75D4AC062E
 for <kexec@lists.infradead.org>; Fri, 15 May 2015 20:01:38 +0900 (JST)
Subject: [PATCH v3 0/2] kernel/panic/kexec: fix "crash_kexec_post_notifiers"
 option issue in oops path
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Fri, 15 May 2015 20:01:38 +0900
Message-ID: <20150515105953.8431.65220.stgit@localhost6.localdomain6>
MIME-Version: 1.0
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
To: akpm@linux-foundation.org, ebiederm@xmission.com, vgoyal@redhat.com, mingo@kernel.org
Cc: masami.hiramatsu.pt@hitachi.com, hidehiro.kawai.ez@hitachi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bhe@redhat.com

This patch set fixes a bug introduced in the commit
f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45.

For the v2 discussion, please follow the following thread:

  http://thread.gmane.org/gmane.linux.kernel/1902488

The v3 patch newly adds a patch suggested by Ingo Molnar.

---

HATAYAMA Daisuke (2):
      kernel/panic: call the 2nd crash_kexec() only if crash_kexec_post_notifiers is enabled
      kernel/panic/kexec: fix "crash_kexec_post_notifiers" option issue in oops path


 include/linux/kernel.h |    3 +++
 kernel/kexec.c         |   11 +++++++++++
 kernel/panic.c         |    5 +++--
 3 files changed, 17 insertions(+), 2 deletions(-)

--
Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
