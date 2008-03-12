Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.tuxonice.net ([67.207.135.122])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZEOx-0004Bj-Hv
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 00:00:59 +0000
Subject: Re: [PATCH -mm] kexec jump -v9
From: Nigel Cunningham <nigel@nigel.suspend2.net>
In-Reply-To: <20080311232415.GA26320@elf.ucw.cz>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com> <20080311232415.GA26320@elf.ucw.cz>
Date: Wed, 12 Mar 2008 11:00:42 +1100
Message-Id: <1205280042.764.28.camel@nigel-laptop>
Mime-Version: 1.0
Reply-To: nigel@nigel.suspend2.net
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
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hi.

On Wed, 2008-03-12 at 00:24 +0100, Pavel Machek wrote: 
> ...OTOH this is probably only chance to eliminate freezer from
> swsusp...

I think eliminating the freezer and having reliable hibernation under
load look like incompatible goals at the moment. Do you see that as 'not
a problem' or have some idea on how that issue can be addressed?

Regards,

Nigel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
