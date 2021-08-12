Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEAxE-00AH6P-M6
 for kexec@lists.infradead.org; Thu, 12 Aug 2021 13:41:05 +0000
From: Philipp Rudo <prudo@redhat.com>
Subject: [PATCH 0/2] makedumpfile: fix two bugs with --dry-run
Date: Thu, 12 Aug 2021 15:39:38 +0200
Message-Id: <20210812133940.5370-1-prudo@redhat.com>
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
To: kexec@lists.infradead.org
Cc: k-hagio-ab@nec.com

Hi,

While playing with the --dry-run option I noticed two bugs. You can find the
fixes below.

Thanks
Philipp

Philipp Rudo (2):
  makedumpfile: Fix bad file descriptor error when using --dry-run
  makedumpfile: Fix --dry-run for incomplete dumps

 makedumpfile.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
