Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QIQjK-0002db-33
	for kexec@lists.infradead.org; Fri, 06 May 2011 19:30:27 +0000
Date: Fri, 6 May 2011 12:30:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] add hook to read_from_oldmem() to check for non-ram pages
Message-Id: <20110506123019.80461d5d.akpm@linux-foundation.org>
In-Reply-To: <20110506105545.GA16945@aepfle.de>
References: <20110407095646.GA30788@aepfle.de>
	<20110503190806.GA12485@aepfle.de>
	<20110505142551.b4d2d95a.akpm@linux-foundation.org>
	<20110506105545.GA16945@aepfle.de>
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

On Fri, 6 May 2011 12:55:46 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> Should the called code increase/decrease the modules refcount instead?
> I remember there was some MODULE_INC/MODULE_DEC macro (cant remember the
> exact name) at some point. What needs to be done inside the module to
> prevent an unload while its still in use? Is it __module_get/module_put
> for each call of fn()? 

A try_module_get(THIS_MODULE) in the register function will do the trick.
However it's unneeded.  Documentation/DocBook/kernel-hacking.tmpl tells us

try_module_get() module_put()

    These manipulate the module usage count, to protect against
    removal (a module also can't be removed if another module uses one
    of its exported symbols: see below).  Before calling into module
    code, you should call <function>try_module_get()</function> on
    that module: if it fails, then the module is being removed and you
    should act as if it wasn't there.  Otherwise, you can safely enter
    the module, and call <function>module_put()</function> when you're
    finished.

So as your module will have a reference to vmcore.c's register and unregister
functions, nothing needs to be done: the presence of the client module alone
will pin the vmcore.c module.

However it's all moot, because the fs/proc/vmcore.c code cannot
presently be built as a module and it's rather unlikely that it ever
will be.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
