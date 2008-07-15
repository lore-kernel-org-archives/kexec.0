Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIcrD-0002YY-UM
	for kexec@lists.infradead.org; Tue, 15 Jul 2008 05:13:48 +0000
Subject: Re: [PATCH -mm 2/2] kexec jump -v12: save/restore device state
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20080714134805.GD16673@redhat.com>
References: <1215401124.4660.5.camel@caritas-dev.intel.com>
	<20080714134805.GD16673@redhat.com>
Date: Tue, 15 Jul 2008 13:19:04 +0800
Message-Id: <1216099144.22944.35.camel@caritas-dev.intel.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

Hi, Vivek,

On Mon, 2008-07-14 at 09:48 -0400, Vivek Goyal wrote:
[...]
> You have cited various possible use cases of this patchset. Which is
> the specific feature you are planning to use?

I think two features are useful:

1. Kexec based hibernation
2. Do kdump then continue

> Thinking more about it, what's the compelling feature out of this list
> which makes this patchset a strong candidate for inclusion?
> 
> Regarding hibernation, Rafael does not think this is the way to go 
> for future.

I think kexec based hibernation can be a better hibernation scheme, at
least more code sharing.

Best Regards,
Huang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
