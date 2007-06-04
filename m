Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]
	helo=outbound1-cpk-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HvIE8-0002h9-2D
	for kexec@lists.infradead.org; Mon, 04 Jun 2007 15:28:37 -0400
Message-ID: <466467D5.4020209@am.sony.com>
Date: Mon, 04 Jun 2007 12:28:21 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: kexec on PS3
References: <20070604095433.GB29457@suse.de>
In-Reply-To: <20070604095433.GB29457@suse.de>
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
To: kexec@lists.infradead.org, Stefan Assmann <sassmann@suse.de>
Cc: miltonm@bga.com

Bernhard Walle wrote:
> Hello,
> 
> At http://www.powerdeveloper.org/platforms/cell/playstation there are
> some patches that are required for kexec-tools to use kdump on the
> Play Station 3. Wouldn't it make sense to merge them in kexec-tools
> testing?

That stuff is old and out of date.  Please ignore it, or better, ask
the admin to remove it.

> kexec-tools-1.101-bootargs-align.patch is already discussed here in
> the thread "kexec ppc64: fix misaligned cmdline". But what about
> kexec-tools-1.101-ps3-rmo_top-max.patch and
> kexec-tools-1.101-align-dtstruct.patch?

That stuff is also old and out of date.

> I'm not the author, and I don't know how to contact the author of that
> patches, 

Please see http://www.kernel.org/pub/linux/kernel/people/geoff/cell/README

but I'd like to see them in mainline kexec-tools.

Most PS3 support is in the mainline kexec-tools.  There is one outstanding
patch that is needed for PS3, but it was NACKed by Milton when I submitted
it, and I haven't had time to re-work it.  Please see:

http://lists.infradead.org/pipermail/kexec/2007-May/000116.html

Feel free to make the suggested changes.

-Geoff





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
