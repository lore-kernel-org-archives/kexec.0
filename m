Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KFrvl-0000UD-7j
	for kexec@lists.infradead.org; Mon, 07 Jul 2008 14:43:05 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8CEAD45A2A
	for <kexec@lists.infradead.org>; Mon,  7 Jul 2008 16:43:02 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: Parse /sys/firmware/memmap
Date: Mon,  7 Jul 2008 16:43:39 +0200
Message-Id: <1215441822-13820-1-git-send-email-bwalle@suse.de>
In-Reply-To: <20080707070621.GD788@verge.net.au>
References: <20080707070621.GD788@verge.net.au>
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

My patch series again (without the already applied patches).
Diff to last change: Define ULLONG_MAX if not already defined.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
