Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuzGj-00031t-74
	for kexec@lists.infradead.org; Wed, 29 Oct 2008 00:50:45 +0000
Message-ID: <4907B32F.4030009@sgi.com>
Date: Tue, 28 Oct 2008 17:49:51 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: [IA64] kdump failed to produce vmcore in 2.6.28-rc2
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Booting up a 2.6.28-rc2 kdump kernel, i observed these
messages at console:

  Warning: Core image elf header not found
  Kdump: vmcore not initialized

It was a default configuration with a new config flag
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS set to 'y'.

The machine worked fine with 2.6.27.

Regards,
jay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
