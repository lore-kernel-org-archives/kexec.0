Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]
	helo=outbound3-cpk-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HwKhi-0003iW-6W
	for kexec@lists.infradead.org; Thu, 07 Jun 2007 12:19:23 -0400
Message-ID: <46682FFB.7000000@am.sony.com>
Date: Thu, 07 Jun 2007 09:19:07 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline
References: <25445.1180941825@neuling.org>	<8f5d8a214e9042b0c556ac7256928a52@bga.com>	<26608.1180950136@neuling.org>
	<10188.1181179162@neuling.org>
In-Reply-To: <10188.1181179162@neuling.org>
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
To: Michael Neuling <mikey@neuling.org>
Cc: dwmw2@infradead.org, kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org, horms@verge.net.au, Santhosh Rao <sonny@burdell.org>

Michael Neuling wrote:
> If the cmdline changes between boots, we can get misalignment of the
> bootargs entry, which in turn corrupts our device tree blob and hence
> kills our kexec boot.  Also, if there was no /chosen/bootargs
> previously, we'd never add a new one. 
> 
> This ignores the bootargs while parsing the tree and inserts it later. 
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Hi.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>

I tested this with PS3 and it works as expected.  I added it to my
ps3-kexec-tools.git.  With this patch mainline kexec will work
with the PS3.

I still have a work-in-progress patch started by David Woodhouse
to support building a 32 bit kexec executable for PPC64 platforms.
I don't have any definite plan to work on it though.

-Geoff









_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
