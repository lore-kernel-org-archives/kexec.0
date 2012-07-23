Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat.scz.novell.com ([213.151.88.252] helo=nathan.suse.cz)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StHdQ-0001nb-DS
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 12:21:13 +0000
Message-Id: <20120723113244.751777873@suse.cz>
Date: Mon, 23 Jul 2012 13:32:44 +0200
From: ptesarik@suse.cz
Subject: [PATCH 0/8] makedumpfile: Xen4 support for SLES11
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
Cc: Petr Tesarik <ptesarik@suse.cz>

This patchset was created to allow using makedumpfile for Dom0 dumps in SLES11
SP1 and SP2. Most of the patches account for changes to the Xen hypervisor,
except the last one, which reflects that the "max_pfn" symbol is not exported
by the SLES kernel.

Petr Tesarik
SUSE Linux


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
