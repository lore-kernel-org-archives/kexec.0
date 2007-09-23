Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from barikada.upol.cz ([158.194.242.200])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IZYYF-0006pL-5P
	for kexec@lists.infradead.org; Sun, 23 Sep 2007 16:59:41 -0400
Date: Sun, 23 Sep 2007 23:15:17 +0200
Subject: Re: [patch 1/7] Extended crashkernel command line
Message-ID: <20070923211517.GU24301@flower.upol.cz>
References: <20070920171845.774383000@stravinsky.suse.de>
	<20070920171846.062209000@stravinsky.suse.de>
	<E1IZEAi-00051i-23@flower> <20070923201943.GA5272@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070923201943.GA5272@suse.de>
From: Oleg Verych <olecom@flower.upol.cz>
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
To: Bernhard Walle <bwalle@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Sun, Sep 23, 2007 at 10:19:43PM +0200, Bernhard Walle wrote:
[]
> >  +int __init get_crashkernel_params(u64 *memsize, u64 *addrbase, char *cmdline, u64 ram);
> 
> Andrew, what's your opinion on this? Whould I resend the patch with
> shorter type names?

Also, maybe it will be better to extend linux/lib/cmdline.c->{get_range(), get_range()}
to handle that stuff? And maybe new functionality can be built up-on the current one: 

- crashkernel=512M-2G:64M,2G-:128M@offset
+ crashkernel=512M-2G,64M,2G-,128M,,offset
?

OK, OK, you are already using and maintaining new syntax, but still.
_____
(`Mail-Followup-To' ignored)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
