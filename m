Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IZYd4-0006tB-DR
	for kexec@lists.infradead.org; Sun, 23 Sep 2007 17:04:39 -0400
Date: Sun, 23 Sep 2007 23:04:36 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 1/7] Extended crashkernel command line
Message-ID: <20070923210436.GA7601@suse.de>
References: <20070920171845.774383000@stravinsky.suse.de>
	<20070920171846.062209000@stravinsky.suse.de>
	<E1IZEAi-00051i-23@flower> <20070923201943.GA5272@suse.de>
	<20070923211517.GU24301@flower.upol.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070923211517.GU24301@flower.upol.cz>
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
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Oleg Verych <olecom@flower.upol.cz> [2007-09-23 23:15]:
> 
> - crashkernel=512M-2G:64M,2G-:128M@offset
> + crashkernel=512M-2G,64M,2G-,128M,,offset
> ?

I don't like this syntax.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
