Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBmh1-0006zy-GZ
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 08:19:04 +0000
Date: Tue, 24 Jun 2008 20:28:17 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/3] Use /proc/firmware_mem for x86 (e820)
Message-ID: <20080624182817.GI5642@ucw.cz>
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
	<1213977420-1555-3-git-send-email-bwalle@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1213977420-1555-3-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Greg KH <greg@kroah.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

Hi!

> This patch copies the E820 map very early, before the kernel applies various
> operations. That copy is used later to register only the BIOS-provided E820
> map later in the resource tree for /proc/firmware_mem.

It is not process related -> it should not go to /proc. Talk to Greg.

							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
