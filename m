Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJvN2-0002ac-2s
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 22:57:52 +0000
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <kexec@lists.infradead.org> from <haveblue@us.ibm.com>;
	Fri, 28 Oct 2011 16:57:47 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p9SMvQCg132228
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 16:57:26 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p9SMvQF9026853
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 16:57:26 -0600
Subject: Re: [PATCH] kdump: Add udev events for memory online/offline
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20111028154137.1aeb5a6c.akpm@linux-foundation.org>
References: <1319645292.3321.24.camel@br98xy6r>
	<20111026192449.GE355@redhat.com>
	<20111027073058.GA2422@osiris.boeblingen.de.ibm.com>
	<1319707965.2830.1.camel@br98xy6r>
	<20111028154137.1aeb5a6c.akpm@linux-foundation.org>
Date: Fri, 28 Oct 2011 15:57:16 -0700
Message-ID: <1319842636.23600.186.camel@nimitz>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, holzheu@linux.vnet.ibm.com, Vivek Goyal <vgoyal@redhat.com>

On Fri, 2011-10-28 at 15:41 -0700, Andrew Morton wrote:
> > +     } else if (!strncmp(buf, "offline", min((int)count, 7))) {
> >               ret = memory_block_change_state(mem, MEM_OFFLINE, MEM_ONLINE);
> > -
> > +             if (ret == 0)
> > +                     kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
> > +     }
> 
> ot: what on earth is up with that min() thing which
> Dave-who-doesn't-know-about-min_t added to the strncmp() calls?

My first reaction was, "that's not my code!", but git seems to disagree
with me.  So I'll go and blame it on being young and stupid in 2005.

Reading it, I also think it's probably buggy.

	echo -n "o" > state
 
would be interesting.  I think it'll fall in to the 'online' case.
While probably not that common, it's certainly unexpected.  I'll send a
patch to fix it up.

-- Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
