Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HvA8g-0001VI-7p
	for kexec@lists.infradead.org; Mon, 04 Jun 2007 06:50:20 -0400
From: Michael Neuling <mikey@neuling.org>
Subject: Re: kexec on PS3 
In-reply-to: <20070604095433.GB29457@suse.de> 
References: <20070604095433.GB29457@suse.de>
Date: Mon, 04 Jun 2007 20:50:14 +1000
Message-ID: <7629.1180954214@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Assmann <sassmann@suse.de>, kexec@lists.infradead.org

> At http://www.powerdeveloper.org/platforms/cell/playstation there are
> some patches that are required for kexec-tools to use kdump on the
> Play Station 3. Wouldn't it make sense to merge them in kexec-tools
> testing?

Yes.

> kexec-tools-1.101-bootargs-align.patch is already discussed here in
> the thread "kexec ppc64: fix misaligned cmdline". But what about
> kexec-tools-1.101-ps3-rmo_top-max.patch and
> kexec-tools-1.101-align-dtstruct.patch?

This doesn't fix the problem mentioned by Milton.  

> I'm not the author, and I don't know how to contact the author of that
> patches, but I'd like to see them in mainline kexec-tools.

Bugger.  It would make sense to merge them, especially since they are
fixing generic powerpc problems.

If you can get a signed off by the author, that would be awesome!

Mikey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
