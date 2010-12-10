Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from oproxy1-pub.bluehost.com ([66.147.249.253])
	by canuck.infradead.org with smtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PR9eN-0006ZZ-2n
	for kexec@lists.infradead.org; Fri, 10 Dec 2010 20:33:12 +0000
Date: Fri, 10 Dec 2010 12:32:03 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Update MCP55 quirk to not affect non HyperTransport
	variants
Message-ID: <20101210123203.3b3b9c1c@jbarnes-desktop>
In-Reply-To: <1291819668-15624-1-git-send-email-nhorman@tuxdriver.com>
References: <1291819668-15624-1-git-send-email-nhorman@tuxdriver.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On Wed,  8 Dec 2010 09:47:48 -0500
Neil Horman <nhorman@tuxdriver.com> wrote:

> I wrote this quirk awhile ago to properly setup MCP55 chips on hypertransport
> busses so that interrupts reached whatever cpu happend to boot the kdump kernel.
> while that works well, it was recently shown to me that a a non-hypertransport
> variant of the MCP55 exists, and on those system the register that this quirk
> manipulates causes hangs if you write to it.  Since the quirk was only meant to
> handle errors found on MCP55 chips that have a HT interface, this patch adds a
> filter to make sure the chip is an HT capable before making the needed register
> adjustment.  This lets the broken MCP55s work with kdump while not breaking the
> non-HT variants.
> 
> Resolves https://bugzilla.kernel.org/show_bug.cgi?id=23952
> 
> Tested successfully by the reporter and myself.

Applied to my for-linus branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
