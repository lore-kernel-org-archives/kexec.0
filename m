Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGsS1-0007eo-Fl
	for kexec@lists.infradead.org; Thu, 10 Jul 2008 09:28:33 +0000
Date: Thu, 10 Jul 2008 11:29:12 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Future of kexec-tools-testing
Message-ID: <20080710112912.21641167@halley.suse.de>
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
Cc: Simon Horman <horms@verge.net.au>

Hi,

SUSE uses now kexec-tools-testing releases since about one year and
we never had severe problems (compared to other software). It's well
maintained (thanks Simon!), gets frequent releases, patches are
accepted, so:

 - I would suggest that kexec-tools-testing could be renamed to
   kexec-tools somewhere in the future since kexec-tools is not
   maintained any more by Eric. It only causes confusion since
   some distributions still use kexec-tools (the original ones)
   with lots of patches.

   I think current IA64 versions even do not work with kexec-tools
   since there were some incompatible changes related to the
   position of ELF core headers.

 - I would suggest that kexec-tools gets normal release numbers.
   The date releases are quite bad for package managers since it's
   not possible to go back (in terms of a clean update path)
   from something like 20080101 to 1.5 since 2008 is always greater.

   Currently SUSE ships still the old 1.101 version and the real
   release is only visible in the changelog. Of course it's possible to
   do something like 1.101+20080101, but it's nasty.

If I could help out doing some work to help to get that done, then just
tell me.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
