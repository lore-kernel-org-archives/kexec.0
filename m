Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T4w5M-0002Zi-S1
 for kexec@lists.infradead.org; Fri, 24 Aug 2012 15:46:13 +0000
Subject: [PATCHv3 0/9] Support Xen versions up to xen-4.1
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 24 Aug 2012 17:46:09 +0200
MIME-Version: 1.0
Message-Id: <201208241746.09400.ptesarik@suse.cz>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>

Hello everybody,

this is version 3 of my patch set. I'm very much indebted to Norbert
Trapp for his extensive testing of my previous patch set, which
revealed that Xen hypervisor static data was not kept with the previous
version of the patch set.

I could also add the performance improvements, but I'm afraid it would
make for an incremental patch, so let's wait until the filtering is
finally right.

I have re-tested this patch set with the same result as v2:

  - Xen-3.2.3 - WORKS
  - Xen-4.0.1 - WORKS (only with --xen-syms)
  - Xen-4.0.2 - WORKS
  - Xen-4.1.2 - WORKS

Filtering free pages (-d16 and above) doesn't work (even after I manually
provided the missing "max_pfn" symbol), but that seems unrelated, so I'm
going to address it in a subsequent patch set.

Norbert, if you test these patches, please send your comments to the
mailing list.

Atsushi-san, if the patch set passes Norbert's testing, what else do you
need to accept the changes in upstream?

Regards,
Petr Tesarik
SUSE Linux



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
