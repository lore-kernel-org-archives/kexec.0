Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1blplt-0001eT-3q
 for kexec@lists.infradead.org; Mon, 19 Sep 2016 04:01:33 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v10 0/3] Documentation: add description of enable multi-cpus
 support for kdump
Date: Mon, 19 Sep 2016 12:01:02 +0800
Message-Id: <1474257665-8838-1-git-send-email-bhe@redhat.com>
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
To: corbet@lwn.net, akpm@linux-foundation.org
Cc: Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, dyoung@redhat.com

This is v10 post. In this patchset patch 1/3 is added to give more details
about nr_cpus and maxcpus in kernel-parameters.txt. This is suggested by
Jonathan since the description of them is unclear so that people can't see
what's the exact difference between them. Otherwise no big further change
for 2/3 and 3/3 which comprise the old post.

Please access below link to check the previous changelog.
https://lkml.org/lkml/2016/8/17/646

Baoquan He (1):
  docs: kernel-parameter : Improve the description of nr_cpus and
    maxcpus

Zhou Wenjian (2):
  Documentation: kdump: remind user of nr_cpus
  Documentation: kdump: add description of enable multi-cpus support

 Documentation/kdump/kdump.txt       |  9 +++++++++
 Documentation/kernel-parameters.txt | 20 +++++++++++++-------
 2 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
