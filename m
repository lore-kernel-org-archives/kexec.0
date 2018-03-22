Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eyr2y-0002h1-Mu
 for kexec@lists.infradead.org; Thu, 22 Mar 2018 03:37:50 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] Kexec_file: Load kernel at top of system ram
Date: Thu, 22 Mar 2018 11:37:20 +0800
Message-Id: <20180322033722.9279-1-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: prudo@linux.vnet.ibm.com, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, takahiro.akashi@linaro.org, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

The current kexec_file ignores kexec_buf.top_down value when call
arch_kexec_walk_mem() to allocate memory for loading kernel/initrd
stuffs. This is not supposed to be what kexec_buf.top_down is used
for.

In patch 0001, introduce a new function walk_system_ram_res_rev()
which is a variant of walk_system_ram_res(), walks through resources
of System RAM from top to down. And patch 0001 is picked from AKASHI's
patchset which adds arm64 kexec_file support. His next round of post
won't need walk_system_ram_res_rev any more, so I take it into this
patchset and use it in patch 0002.

In patch 0002, check kexec_buf.top_down in arch_kexec_walk_mem(),
if its value is 'true', call walk_system_ram_res_rev(). Otherwise
call walk_system_ram_res().

AKASHI Takahiro (1):
  resource: add walk_system_ram_res_rev()

Baoquan He (1):
  kexec_file: Load kernel at top of system RAM if required

 include/linux/ioport.h |  3 +++
 kernel/kexec_file.c    |  2 ++
 kernel/resource.c      | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
