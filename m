Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UjREW-00029q-6c
 for kexec@lists.infradead.org; Mon, 03 Jun 2013 09:39:21 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
 (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r539cv3G007876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 3 Jun 2013 05:38:58 -0400
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] change/add help message of options
Date: Mon,  3 Jun 2013 17:38:37 +0800
Message-Id: <cover.1370252057.git.bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>

Currently, help message of several options are missed or not correct,
change/add it in this patchset.

Options not present in help:
* --entry

Options not present in man:
* --entry
* --load-jump-back-helper
* --load-preserve-context
* --reuseinitrd 

Options not correct in man:
* --debug

Baoquan He (3):
  kexec man page change for debug option
  add description for entry option in help and man page
  add missed options to man page

 kexec/kexec.8 |   19 ++++++++++++++++---
 kexec/kexec.c |    4 ++++
 2 files changed, 20 insertions(+), 3 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
