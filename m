Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KqslC-0005oT-20
	for kexec@lists.infradead.org; Fri, 17 Oct 2008 17:05:10 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 5033D42998
	for <kexec@lists.infradead.org>; Fri, 17 Oct 2008 19:09:00 +0200 (CEST)
Date: Fri, 17 Oct 2008 19:05:05 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kexec/kdump produces incomplete dump files with kernel 2.6.20 +
	CONFIG_HIGHMEM64G
Message-ID: <20081017190505.00e5a818@kopernikus.site>
In-Reply-To: <306593678.1592141224260384037.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
References: <306593678.1592141224260384037.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
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

* Dave Anderson <anderson@redhat.com> [2008-10-17 12:19]:
> >
> > Do you use the same kernel as the running kernel as capture kernel?
> 
> If I may butt in here -- Kevin's capture kernel is "standard" 3GB/1GB
> kernel, whereas his primary kernel is his 1GB/3GB kernel.

Well, without following the thread, I had a similar error and in my
case it was that PAE was missing in the capture kernel. That's why I
asked. I think that is wrong here, but I still wanted to mention that
case (and I don't have time to read all the mails related to that topic
in the crash mailing list, sorry).


Regards,
Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
