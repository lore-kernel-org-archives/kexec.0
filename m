Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hv9Gy-0000v2-Ln
	for kexec@lists.infradead.org; Mon, 04 Jun 2007 05:54:50 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 2903B12533
	for <kexec@lists.infradead.org>; Mon,  4 Jun 2007 11:54:35 +0200 (CEST)
Date: Mon, 4 Jun 2007 11:54:34 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: kexec on PS3
Message-ID: <20070604095433.GB29457@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Stefan Assmann <sassmann@suse.de>

Hello,

At http://www.powerdeveloper.org/platforms/cell/playstation there are
some patches that are required for kexec-tools to use kdump on the
Play Station 3. Wouldn't it make sense to merge them in kexec-tools
testing?

kexec-tools-1.101-bootargs-align.patch is already discussed here in
the thread "kexec ppc64: fix misaligned cmdline". But what about
kexec-tools-1.101-ps3-rmo_top-max.patch and
kexec-tools-1.101-align-dtstruct.patch?

I'm not the author, and I don't know how to contact the author of that
patches, but I'd like to see them in mainline kexec-tools.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
