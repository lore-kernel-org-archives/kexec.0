Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KqjMS-0004Ki-LB
	for kexec@lists.infradead.org; Fri, 17 Oct 2008 07:03:00 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9432A4646F
	for <kexec@lists.infradead.org>; Fri, 17 Oct 2008 09:06:33 +0200 (CEST)
Date: Fri, 17 Oct 2008 09:02:53 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kexec/kdump produces incomplete dump files with kernel 2.6.20 +
	CONFIG_HIGHMEM64G
Message-ID: <20081017090253.3c7e60ba@kopernikus.site>
In-Reply-To: <28113A0489833849A1CF9EC16F421543464A62812E@GVW1097EXB.americas.hpqcorp.net>
References: <28113A0489833849A1CF9EC16F421543464A6279DA@GVW1097EXB.americas.hpqcorp.net>
	<1440009088.1218741224162685092.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
	<28113A0489833849A1CF9EC16F421543464A62812E@GVW1097EXB.americas.hpqcorp.net>
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

* "Worth, Kevin" <kevin.worth@hp.com> [2008-10-16 23:57]:
>
> Moving this back to the kexec mailing list because I think I now have more detail on this and Dave Anderson has confirmed that this doesn't really look like an issue with the program "crash", but rather an issue with the data inside the dump file (specifically the vmalloc'ed memory).

Do you use the same kernel as the running kernel as capture kernel?

Regards,
Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
