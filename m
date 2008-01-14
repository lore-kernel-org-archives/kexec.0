Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JEPfN-0007L3-8O
	for kexec@lists.infradead.org; Mon, 14 Jan 2008 13:48:02 +0000
Received: from localhost (adsl-065-013-154-094.sip.rdu.bellsouth.net
	[65.13.154.94]) (authenticated bits=0)
	by ra.tuxdriver.com (8.14.0/8.13.7) with ESMTP id m0EDh468031315
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <kexec@lists.infradead.org>; Mon, 14 Jan 2008 08:43:49 -0500
Date: Mon, 14 Jan 2008 08:43:03 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Kexec command line length
Message-ID: <20080114134303.GA947@hmsreliant.think-freely.org>
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

Hey all-
	Regarding this bug:
	http://bugzilla.kernel.org/show_bug.cgi?id=9641
	I'd like to look into putting together a patch for it, and wanted to
solicit comments for the best way to go about doing it.  Currently I've got it
fixed up in the Red Hat tree by bumping COMMAND_LINE_SIZE to 2048 and
eliminating the reserved buffer of the x86_linux_faked_param_header, which works
well, but isn't backwards compatible as Bernhard pointed out.  Given that extra
constraint, I thought it woudl e best to unify the command line and reserved
buffers in x86_linux_faked_param_header to one contiguour 2048 byte block and
maintain a separate variable that defines the command line length based on a
parsing of the UTS_VERSION.  Does that sound reasonable to everyone, or is there
a better way that someone has in mind?

Regards
Neil


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
