Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KWKv2-0001Ki-4b
	for kexec@lists.infradead.org; Fri, 22 Aug 2008 00:54:24 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 5A10E8F80CF
	for <kexec@lists.infradead.org>; Thu, 21 Aug 2008 17:54:23 -0700 (PDT)
Received: from kluge.engr.sgi.com (kluge.engr.sgi.com [192.102.96.102])
	by cthulhu.engr.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id
	m7M0sNWM016789
	for <kexec@lists.infradead.org>; Thu, 21 Aug 2008 17:54:23 -0700
Message-ID: <48AE0E3E.20802@sgi.com>
Date: Thu, 21 Aug 2008 17:54:22 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Avoid 2.6.27-rc3 for IA64 kdump kernel
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
To: kexec@lists.infradead.org

The kdump kernel of 2.6.27-rc3 would panic at __free_pages_bootmem
on booting (IA64). It has been fixed in 2.6.27-rc4.

Just FYI so that you do not waste time scraching your head ;)

Cheers,
 - jay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
