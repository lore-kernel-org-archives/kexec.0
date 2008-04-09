Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JjZRo-0005vl-Pd
	for kexec@lists.infradead.org; Wed, 09 Apr 2008 12:30:41 +0000
Date: Wed, 9 Apr 2008 08:30:28 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Message-ID: <20080409123028.GC15469@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080409093444.GA6957@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080409093444.GA6957@ucw.cz>
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
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Wed, Apr 09, 2008 at 11:34:45AM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is a minimal patch with only the essential features. All
> > additional features are split out and can be discussed later. I think
> > it may be easier to get consensus on this minimal patch.
> 
> 
> Eric, can we get some reviewing/merging going on? Patches seem pretty
> clean to me, and I do not think holding them outside mainline will
> help them... they will only get bigger and harder to merge :-(.
> 

Pavel, I think Huang is working on v10 based on feedback last time. So
probably we can get into line by line review in next version.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
