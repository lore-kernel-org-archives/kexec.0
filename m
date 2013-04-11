Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQGbV-00085p-Ft
 for kexec@lists.infradead.org; Thu, 11 Apr 2013 12:27:50 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Cleanups and passing memory ranges via e820 table instead of memmap=
Date: Thu, 11 Apr 2013 14:26:42 +0200
Message-Id: <1365683207-42425-1-git-send-email-trenn@suse.de>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

These patches are against latest kexec-tool master branch from:
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools

The cleanups are intended to do no functional change.

The patches got successfully tested on one platform.
Also the e820 passing should introduce no change.
Whether the memmap=exactmap ... is passed and the crash kernel makes up
the e820 table from memmap=X#Y and similar params or whether exactly the
same ranges are passed via e820 in bootloader structure directly should not
matter at all.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
