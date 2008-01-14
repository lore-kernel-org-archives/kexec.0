Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JERTM-00004w-7D
	for kexec@lists.infradead.org; Mon, 14 Jan 2008 15:43:45 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0EFeB8M008127
	for <kexec@lists.infradead.org>; Mon, 14 Jan 2008 10:40:11 -0500
Received: from hmsendeavour.rdu.redhat.com (hmsendeavour.rdu.redhat.com
	[172.16.57.156])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0EFeBxp024818
	for <kexec@lists.infradead.org>; Mon, 14 Jan 2008 10:40:11 -0500
Received: from hmsendeavour.rdu.redhat.com (localhost.localdomain [127.0.0.1])
	by hmsendeavour.rdu.redhat.com (8.14.1/8.13.8) with ESMTP id
	m0EFeBck019568
	for <kexec@lists.infradead.org>; Mon, 14 Jan 2008 10:40:11 -0500
Received: (from nhorman@localhost)
	by hmsendeavour.rdu.redhat.com (8.14.1/8.13.8/Submit) id m0EFeBnW019567
	for kexec@lists.infradead.org; Mon, 14 Jan 2008 10:40:11 -0500
Date: Mon, 14 Jan 2008 10:40:11 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Kexec command line length
Message-ID: <20080114154011.GD19304@hmsendeavour.rdu.redhat.com>
References: <20080114134303.GA947@hmsreliant.think-freely.org>
	<20080114145014.GA21412@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080114145014.GA21412@suse.de>
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

On Mon, Jan 14, 2008 at 03:50:15PM +0100, Bernhard Walle wrote:
> * Neil Horman <nhorman@tuxdriver.com> [2008-01-14 14:43]:
> > Hey all-
> > 	Regarding this bug:
> > 	http://bugzilla.kernel.org/show_bug.cgi?id=9641
> > 	I'd like to look into putting together a patch for it, and wanted to
> > solicit comments for the best way to go about doing it.  Currently I've got it
> > fixed up in the Red Hat tree by bumping COMMAND_LINE_SIZE to 2048 and
> > eliminating the reserved buffer of the x86_linux_faked_param_header, which works
> > well, but isn't backwards compatible as Bernhard pointed out.  Given that extra
> > constraint, I thought it woudl e best to unify the command line and reserved
> > buffers in x86_linux_faked_param_header to one contiguour 2048 byte block and
> > maintain a separate variable that defines the command line length based on a
> > parsing of the UTS_VERSION.  Does that sound reasonable to everyone, or is there
> > a better way that someone has in mind?
> 
> For bzImage we can take the size in the header (that's also better for
> the future).
> 

Ok, but thats just one case, what about the other 4 image types that we support?
Regards
Neil

> 
>         Bernhard
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
