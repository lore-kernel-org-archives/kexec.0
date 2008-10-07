Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnCGt-0001gV-0Y
	for kexec@lists.infradead.org; Tue, 07 Oct 2008 13:06:39 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B005F45D36
	for <kexec@lists.infradead.org>; Tue,  7 Oct 2008 15:06:36 +0200 (CEST)
Date: Tue, 7 Oct 2008 15:06:36 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kdump: quad core Opteron
Message-ID: <20081007150636.287cc364@halley.suse.de>
In-Reply-To: <48EB5B68.8010401@in.ibm.com>
References: <48EB5B68.8010401@in.ibm.com>
Mime-Version: 1.0
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

* Chandru [2008-10-07 18:21]:
>
> kdump on a quad core Opteron blade machine doesn't give a complete 
> vmcore on the system.   All works well until we attempt to copy 
> /proc/vmcore to some target place ( disk , n/w ). The system immediately 
> resets without any OS messages after having copied few mb's of vmcore 
> file.  Problem also occurs with 2.6.27-rc8 and latest kexec-tools.  If 
> we pass 'mem=4G' as boot parameter to the first kernel, then kdump 
> succeeds in copying a readable vmcore to /var/crash.

Maybe extend the copy process to print out the address, and then look
at which address it crashes. Then look in the memory map, maybe there's
something special there.

Regards,
Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
