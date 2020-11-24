Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khVpF-000340-Kf
 for kexec@lists.infradead.org; Tue, 24 Nov 2020 10:45:35 +0000
Received: by mail-wm1-f72.google.com with SMTP id j62so1029221wma.4
 for <kexec@lists.infradead.org>; Tue, 24 Nov 2020 02:45:29 -0800 (PST)
From: Julien Thierry <jthierry@redhat.com>
Subject: [MAKDUMPFILE PATCH 0/2] Get stats without writing dumpfile
Date: Tue, 24 Nov 2020 10:45:23 +0000
Message-Id: <20201124104525.1070885-1-jthierry@redhat.com>
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
Cc: bhsharma@redhat.com, Julien Thierry <jthierry@redhat.com>, k-hagio-ab@nec.com, lijiang@redhat.com

Hi,

This series is a follow up to the --vmcore-size proposal[1].

The goal is to be able to obtain informations about the dumpfile without
actually generating it. Instead of the --vmcore-size approach, we add
two different options, one allowing to run makedumpfil without writting
the dumpfile, and another to explicitly enable stat displaying.

[1] https://www.spinics.net/lists/kexec/msg26058.html

Cheers,

Julien

-->

Julien Thierry (2):
  Add option to prevent writing the dumpfile
  Add shorthand option to show report stats

 makedumpfile.8 | 10 ++++++++++
 makedumpfile.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.h |  3 +++
 print_info.c   |  6 ++++++
 4 files changed, 61 insertions(+), 3 deletions(-)

--
2.25.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
