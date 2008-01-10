Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JCrfC-00048p-RM
	for kexec@lists.infradead.org; Thu, 10 Jan 2008 07:17:26 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id EC07B2F546
	for <kexec@lists.infradead.org>; Thu, 10 Jan 2008 08:17:14 +0100 (CET)
Date: Thu, 10 Jan 2008 08:17:14 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: x86_64 kernel relocation question
Message-ID: <20080110071714.GA14737@suse.de>
References: <8B2A78E5-2911-4F96-91AD-BEE846B76B4A@lanl.gov>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8B2A78E5-2911-4F96-91AD-BEE846B76B4A@lanl.gov>
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

* kevint <kevint@lanl.gov> [2008-01-10 01:45]:
>
> I am relatively new to kexec, and am running into some problems with 
> relocations when I try to use kexec to load several different X86_64 
> kernels.  I think this is the correct list to post to, but please point me 
> in the right direction if it isn't.
>
> Here is some of the information on my test environment:
>
> $ kexec --version
> kexec-tools-testing 20071030 released 30th October 2007
>
> $ uname -r
> 2.6.21.5

Just to make sure, is CONFIG_RELOCATABLE set?

> $ kexec -l /tmp/vmlinuz
> Unhandled rela relocation: 4258616
>
> I noticed this line in the source file, 
> kexec/arch/x86_64/kexec-elf-rel-x86_64.c:
>
> die("Unhandled rela relocation: %lu\n", reloc_name(r_type));
>
> I figured %lu should be %s, so I changed it, and got the following output:

Can you make a patch and send it to this list so that it get fixed in
kexec-tools-testing? Cc Simon Horman <horms@verge.net.au>, the
maintainer.



        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
