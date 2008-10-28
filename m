Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KurwP-0007zB-UN
	for kexec@lists.infradead.org; Tue, 28 Oct 2008 17:01:14 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by netops-testserver-3.corp.sgi.com (Postfix) with ESMTP id 735C1908A3
	for <kexec@lists.infradead.org>; Tue, 28 Oct 2008 10:01:12 -0700 (PDT)
Message-ID: <49074527.7050806@sgi.com>
Date: Tue, 28 Oct 2008 10:00:23 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: CORE_DUMP_DEFAULT_ELF_HEADERS
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,

I found a new config CORE_DUMP_DEFAULT_ELF_HEADERS in
2.6.28-rc2 for "Write ELF core dumps with partial segments".

It is default to 'N'. What is the recommended setting for
this config flag in the kdump world?

Regards,
jay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
