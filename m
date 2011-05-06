Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QIR7u-0002nf-Ju
	for kexec@lists.infradead.org; Fri, 06 May 2011 19:55:54 +0000
Date: Fri, 6 May 2011 12:55:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] add hook to read_from_oldmem() to check for non-ram pages
Message-Id: <20110506125546.72d138ed.akpm@linux-foundation.org>
In-Reply-To: <20110506193916.GA26129@aepfle.de>
References: <20110407095646.GA30788@aepfle.de>
	<20110503190806.GA12485@aepfle.de>
	<20110505142551.b4d2d95a.akpm@linux-foundation.org>
	<20110506105545.GA16945@aepfle.de>
	<20110506123019.80461d5d.akpm@linux-foundation.org>
	<20110506193916.GA26129@aepfle.de>
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
To: Olaf Hering <olaf@aepfle.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, 6 May 2011 21:39:16 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> On Fri, May 06, Andrew Morton wrote:
> 
> > So as your module will have a reference to vmcore.c's register and unregister
> > functions, nothing needs to be done: the presence of the client module alone
> > will pin the vmcore.c module.
> 
> I meant the other way around. Keep /proc/vmcore open and read from it,
> then try to rmmod foo.ko which provides fn().
> 

The client foo.ko will need to prevent itself from being unloaded while
it's actively doing stuff, yes.  Typically that would be done in its
module_exit() function - wait for current activity to complete and
block new activity.  The "block new activity" thing should be automatic
because nobody has any more references to anything in the module.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
