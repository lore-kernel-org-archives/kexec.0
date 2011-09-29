Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from p02c11o147.mxlogic.net ([208.65.144.80])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R9Kxe-000620-GH
	for kexec@lists.infradead.org; Thu, 29 Sep 2011 18:03:56 +0000
From: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>
Subject: RE: kexec 2.0.2 MIPS
Date: Thu, 29 Sep 2011 18:03:42 +0000
Message-ID: <F9C551623D2CBB4C9488801D14F864C6077B3C@ex-mb1.corp.adtran.com>
References: <F9C551623D2CBB4C9488801D14F864C607154A@ex-mb1.corp.adtran.com>
	<20110920085133.GE15087@verge.net.au>
	<F9C551623D2CBB4C9488801D14F864C6072473@ex-mb1.corp.adtran.com>
	<20110921112837.GF17108@verge.net.au>
In-Reply-To: <20110921112837.GF17108@verge.net.au>
Content-Language: en-US
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: Maxim Uvarov <muvarov@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Matt Evans <matt@ozlabs.org>

> My bad, yes the idea is to check between 2.0.1 and 2.0.2.
> I will explain git bisect further down. However, it looking at the
> logs
> it strikes me that there was only one significant MIPS change
> between
> 2.0.1 and 2.0.2. So that seems like a likely culprit.
> 
> Could you try the following?
> 
> $ git clone git://github.com/horms/kexec-tools.git
> $ cd kexec-tools
> $ git checkout 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17^

Works.

> 
> Build and see if it works. If so could you then try?
> 
> $ git checkout 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17

Works.

> 
> Build and see if it works. If it does not then
> revision 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 starts to smell
> a lot like the cause of the problem you have observed.
> 
> 
> Git Bisect
> ----------
> 
> A git bisection works by doing a binary search over a set of
> commits
> in order to (hopefully) isolate which commit introduces a
> regression.
> 
> To this, the git commands are something along these lines:
> 
> $ git clone git://github.com/horms/kexec-tools.git
> $ cd kexec-tools
> $ git checkout v2.0.1

root@akennedy_lin:~/src/kexec/kexec-tools# git checkout v2.0.1
error: pathspec 'v2.0.1' did not match any file(s) known to git.
(yes, I run as root.  Have since 1994, so, please no holy wars.)

> 
> Build and confirm that it does work
> 
> $ git checkout v2.0.2
> 
> Build and confirm that it does not work.
> 
> Now we actually start the bisect
> 
> $ git bisect start
> $ git bisect bad v2.0.2
> $ git bisect good v2.0.1
> 
> Git should now select a revision between v2.0.1 and v2.0.2
> Test it and see if it works or not. If it does run
> 
> $ git bisect good
> If not run
> 
> $ git bisect bad
> 
> Git will now select another revision for you to test...

I have some time right now to test, so, when you can get
back to me I'll be able to continue.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
