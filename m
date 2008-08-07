Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR1h4-0007Xu-TW
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 09:22:03 +0000
Date: Thu, 7 Aug 2008 11:22:02 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 3/6] kexec jump: remove duplication of
	kexec_restart_prepare()
Message-ID: <20080807092202.GD372@atrey.karlin.mff.cuni.cz>
References: <1218099928.5164.34.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218099928.5164.34.camel@caritas-dev.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

> Call kernel_restart_prepare() in kernel_kexec() instead of duplicating
> the code.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
