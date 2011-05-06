Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QIQs0-0002i7-8B
	for kexec@lists.infradead.org; Fri, 06 May 2011 19:39:25 +0000
Date: Fri, 6 May 2011 21:39:16 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] add hook to read_from_oldmem() to check for non-ram pages
Message-ID: <20110506193916.GA26129@aepfle.de>
References: <20110407095646.GA30788@aepfle.de>
	<20110503190806.GA12485@aepfle.de>
	<20110505142551.b4d2d95a.akpm@linux-foundation.org>
	<20110506105545.GA16945@aepfle.de>
	<20110506123019.80461d5d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110506123019.80461d5d.akpm@linux-foundation.org>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, May 06, Andrew Morton wrote:

> So as your module will have a reference to vmcore.c's register and unregister
> functions, nothing needs to be done: the presence of the client module alone
> will pin the vmcore.c module.

I meant the other way around. Keep /proc/vmcore open and read from it,
then try to rmmod foo.ko which provides fn().

Olaf

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
