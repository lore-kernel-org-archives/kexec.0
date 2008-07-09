Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGXZ2-0003mq-5J
	for kexec@lists.infradead.org; Wed, 09 Jul 2008 11:10:24 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id E16C841631
	for <kexec@lists.infradead.org>; Wed,  9 Jul 2008 13:10:21 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: Parse /sys/firmware/memmap
Date: Wed,  9 Jul 2008 13:10:59 +0200
Message-Id: <1215601862-21748-1-git-send-email-bwalle@suse.de>
In-Reply-To: <20080709004138.GD13710@verge.net.au>
References: <20080709004138.GD13710@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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

Define ULLONG_MAX and define LLONG_MAX. Both now in the first patch.  The rest
is the same.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
