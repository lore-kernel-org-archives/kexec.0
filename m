Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYrcs-0000JG-5Z
	for kexec@lists.infradead.org; Fri, 29 Aug 2008 00:14:06 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 525E78F8057
	for <kexec@lists.infradead.org>; Thu, 28 Aug 2008 17:14:05 -0700 (PDT)
Received: from kluge.engr.sgi.com (kluge.engr.sgi.com [192.102.96.102])
	by cthulhu.engr.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id
	m7T0E5Vw006415
	for <kexec@lists.infradead.org>; Thu, 28 Aug 2008 17:14:05 -0700
Message-ID: <48B73F4C.5030206@sgi.com>
Date: Thu, 28 Aug 2008 17:14:04 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: How do i see printf output from the purgatory code?
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

Specifically, an ia64.

I added printf() to purgatory-ia64.c, compiled, and executed
the kexec command from a shell window (ie, not from a script), but
i still did not see the printf i put in.

Thanks for help in advance!

- jay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
