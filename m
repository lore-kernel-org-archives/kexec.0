Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGBMk-00065A-9z
	for kexec@lists.infradead.org; Tue, 08 Jul 2008 11:28:14 +0000
Date: Tue, 8 Jul 2008 13:28:51 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Use progress bar also for bitmap creation
Message-ID: <20080708132851.5f31c023@halley.suse.de>
In-Reply-To: <4872C6C4.5040909@mxs.nes.nec.co.jp>
References: <20080626143721.GA12486@suse.de>
	<4864B595.8040205@mxs.nes.nec.co.jp>
	<48718477.3020406@mxs.nes.nec.co.jp>
	<20080707165317.7cd320aa@halley.suse.de>
	<4872C6C4.5040909@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: jlan@sgi.com, kexec@lists.infradead.org

* Ken'ichi Ohmichi [2008-07-08 10:45]:
> Bernhard Walle wrote:
> > * Ken'ichi Ohmichi [2008-07-07 11:50]:
> >> Ken'ichi Ohmichi wrote:
> >>> Hi Bernhard,
> >>>
> >>> Thank you for your patch.
> >>> I like this idea :-)
> >>>
> >>> I am busy now, and I will consider the patch well the next week.
> >> Thank you for the patch, and sorry for my late response.
> >>
> >> I added the progress bar for excluding free pages to your patch.
> >> Could you please check the attached patch ?
> >> If there is no problem in the attached patch, I will release the
> >> next release with this patch.
> > 
> > That patch does not apply any more to the latest release. Maybe you can
> > send me your whole tarball?
> 
> Sorry for wasting your time.
> OK, I'll send you tarball later.
> In the other way, you can get it by the following command:
> cvs -z3 -d:pserver:anonymous@makedumpfile.cvs.sourceforge.net:/cvsroot/makedumpfile co -r DEVEL -P makedumpfile

Ah, cool, didn't know that a public CVS exists. :)
Yes, that works without problems here and it looks nice.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
