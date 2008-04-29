Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JqdL8-0006pW-LY
	for kexec@lists.infradead.org; Tue, 29 Apr 2008 00:04:59 +0000
Date: Tue, 29 Apr 2008 10:04:52 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/1] Allow building for ppc32 platforms.
Message-ID: <20080429000449.GA7539@verge.net.au>
References: <3146e524987d7843732ce3885174ed91a9e80567.1209425237.git.tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3146e524987d7843732ce3885174ed91a9e80567.1209425237.git.tony@bakeyournoodle.com>
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
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: Kexec testing list <kexec@lists.infradead.org>

On Tue, Apr 29, 2008 at 09:28:09AM +1000, Tony Breeds wrote:
> Currently any ppc32 compile will error out with "Please, fix this for
> your platform".  While this is a great way to encourage people to update
> the code it seesm to be a disinsentive for distros to package
> kexec-tools for powerpc (incl. 64-bit).
> 
> Make get_memory_ranges() do the right thing in the GameCube case and
> fail at runtime for all other ppc32 cases.

Thanks Tony, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
