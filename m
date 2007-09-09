Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IURu2-0005nO-EU
	for kexec@lists.infradead.org; Sun, 09 Sep 2007 14:53:06 -0400
Date: Sun, 9 Sep 2007 20:52:58 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [discuss] [patch 3/5] Use extended crashkernel command line on
	x86_64
Message-ID: <20070909185257.GA10600@suse.de>
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083914.951336895@strauss.suse.de>
	<86802c440709091027o32a63d11w629bad87abcc19c2@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86802c440709091027o32a63d11w629bad87abcc19c2@mail.gmail.com>
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
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: linux-arch@vger.kernel.org, discuss@x86-64.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>

* Yinghai Lu <yhlu.kernel@gmail.com> [2007-09-09 19:27]:
> >
> > +#ifdef CONFIG_KEXEC
> ...
> 
> CONFIG_KEXEC or CONFIG_CRASH_DUMP?

Good question. The crashkernel parameter was CONFIG_KEXEC before, and
I also wondered why, but I didn't change this because maybe there's
some reason I don't know.

Vivek, do you know why this was CONFIG_KEXEC?


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
