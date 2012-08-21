Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T3qNf-0002nJ-9b
 for kexec@lists.infradead.org; Tue, 21 Aug 2012 15:28:35 +0000
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 1660DA3DDD
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2012 17:28:32 +0200 (CEST)
Resent-To: kexec@lists.infradead.org
Resent-Message-ID: <201208211728.31479.ptesarik@suse.cz>
Message-Id: <20120821084451.587187471@azariah.suse.cz>
Date: Tue, 21 Aug 2012 10:44:51 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [patch 0/9] Support Xen versions up to xen-4.1
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Petr Tesarik <ptesarik@suse.cz>, Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>

Hello everybody,

I have finally found the time to augment my patch set with the previous
work done by Norbert Trapp and clean it up. I didn't include Norbert's
performance improvements, because I believe they constitute an independent
change (and we may even want to add generic infrastructure to be used by
all architectures).

I have tested this patch set with:

  - Xen-3.2.3 - WORKS
  - Xen-4.0.1 - WORKS (only with --xen-syms)
  - Xen-4.0.2 - WORKS
  - Xen-4.1.2 - WORKS

Filtering free pages doesn't work (even after I manually provide the
missing "max_pfn" symbol), but that seems unrelated, so I'm going to
address it in a subsequent patch set.

Petr Tesarik
SUSE Linux




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
