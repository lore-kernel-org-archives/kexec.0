Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JEQh7-0003mv-L4
	for kexec@lists.infradead.org; Mon, 14 Jan 2008 14:53:54 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5292E2F9AF
	for <kexec@lists.infradead.org>; Mon, 14 Jan 2008 15:50:15 +0100 (CET)
Date: Mon, 14 Jan 2008 15:50:15 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Kexec command line length
Message-ID: <20080114145014.GA21412@suse.de>
References: <20080114134303.GA947@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080114134303.GA947@hmsreliant.think-freely.org>
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

* Neil Horman <nhorman@tuxdriver.com> [2008-01-14 14:43]:
> Hey all-
> 	Regarding this bug:
> 	http://bugzilla.kernel.org/show_bug.cgi?id=9641
> 	I'd like to look into putting together a patch for it, and wanted to
> solicit comments for the best way to go about doing it.  Currently I've got it
> fixed up in the Red Hat tree by bumping COMMAND_LINE_SIZE to 2048 and
> eliminating the reserved buffer of the x86_linux_faked_param_header, which works
> well, but isn't backwards compatible as Bernhard pointed out.  Given that extra
> constraint, I thought it woudl e best to unify the command line and reserved
> buffers in x86_linux_faked_param_header to one contiguour 2048 byte block and
> maintain a separate variable that defines the command line length based on a
> parsing of the UTS_VERSION.  Does that sound reasonable to everyone, or is there
> a better way that someone has in mind?

For bzImage we can take the size in the header (that's also better for
the future).


        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
