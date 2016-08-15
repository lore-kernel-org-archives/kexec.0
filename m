Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZ5wJ-0006FL-3O
 for kexec@lists.infradead.org; Mon, 15 Aug 2016 00:39:40 +0000
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v6 0/2] update the doc of kdump
Date: Mon, 15 Aug 2016 08:37:09 +0800
Message-ID: <1471221431-25032-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org, kexec@lists.infradead.org, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

v5->v6: replace "we" with "you"
v4->v5: move change log to cover letter
v3->v4: update the description of bring up SMP dump-capture kernel
v2->v3: add description of nr_cpus.
v1->v2: change nr_cpus to maxcpus


Zhou Wenjian (2):
  Documentation: kdump: remind user of nr_cpus
  Documentation: kdump: add description of enable multi-cpus support

 Documentation/kdump/kdump.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
1.8.3.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
