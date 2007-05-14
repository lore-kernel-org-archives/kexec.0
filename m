Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=outbound2-dub-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hnfxd-0008Fa-6d
	for kexec@lists.infradead.org; Mon, 14 May 2007 15:12:02 -0400
Message-ID: <4648B3C4.6000506@am.sony.com>
Date: Mon, 14 May 2007 12:08:52 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: [patch v3] kexec fix ppc64 device-tree mem node
References: <20070507235727.631477448@am.sony.com>>	<463FBE38.5090901@am.sony.com>	<46413472.8000304@am.sony.com>
	<46424CA7.8060204@am.sony.com>
In-Reply-To: <46424CA7.8060204@am.sony.com>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

Hi Simon.

Geoff Levand wrote:
> Subject: kexec fix ppc64 device-tree mem node
> 
> Change the ppc64 device-tree memory node name spec to match the allowable names
> specified in the booting-without-of document.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
> Version 2, Changed to look for 'memory', or 'memory@' nodes.
> Version 3, Fixed missing 'if' in get_base_ranges().
> 
>  kexec/arch/ppc64/crashdump-ppc64.c |    3 ++-
>  kexec/arch/ppc64/kexec-ppc64.c     |   14 +++++++++-----
>  2 files changed, 11 insertions(+), 6 deletions(-)

There are currently no outstanding issues with this, so
I would like it to get merged in. It is needed to support
kexec on the PS3 game console.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
