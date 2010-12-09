Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PQq6s-0007xB-2u
	for kexec@lists.infradead.org; Thu, 09 Dec 2010 23:41:19 +0000
Date: Thu, 9 Dec 2010 15:40:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Update MCP55 quirk to not affect non HyperTransport
	variants
Message-Id: <20101209154041.8a54dba8.akpm@linux-foundation.org>
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
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

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
> 
> Reported-by: Mathieu B__rard <mathieu@mberard.eu>
> CC: linux-pci@vger.kernel.org
> CC: kexec@lists.infradead.org
> CC: Vivek Goyal <vgoyal@redhat.com>
> CC: Jesse Barnes <jbarnes@virtuousgeek.org>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

That needed a Cc:<stable@kernel.org> as well.  Please don't forget to
remember -stable.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
