Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIvVJ-0001JB-Bt
	for kexec@lists.infradead.org; Wed, 16 Jul 2008 01:08:25 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by relay1.corp.sgi.com (Postfix) with ESMTP id D3A478F8074
	for <kexec@lists.infradead.org>; Tue, 15 Jul 2008 18:08:22 -0700 (PDT)
Message-ID: <487D49DC.8040209@sgi.com>
Date: Tue, 15 Jul 2008 18:07:40 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: problems in kdump kernel if 'maxcpus=1' not specified?
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

Are there known problems if you boot up kdump kernel with
multipl cpus?

It takes unacceptably long time to run makedumpfile in
saving dump at a huge memory system. In my testing it
took 16hr25min to run create_dump_bitmap() on a 1TB system.
Pfn's are processed sequentially with single cpu. We
certainly can use multipl cpus here ;)

Regards,
 - jay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
