Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f178.google.com ([209.85.221.178])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MgaWo-0007qX-IJ
	for kexec@lists.infradead.org; Thu, 27 Aug 2009 08:40:23 +0000
Received: by qyk8 with SMTP id 8so583497qyk.2
	for <kexec@lists.infradead.org>; Thu, 27 Aug 2009 01:40:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090826105024.GC18761@verge.net.au>
References: <aec7e5c30908200614j68c1ad6ci7a3d8d1b9f98d08b@mail.gmail.com>
	<20090826063117.GB18761@verge.net.au>
	<aec7e5c30908260056w629fb2fp4be4c8660860f1c4@mail.gmail.com>
	<20090826105024.GC18761@verge.net.au>
Date: Thu, 27 Aug 2009 17:40:16 +0900
Message-ID: <aec7e5c30908270140x6d5a7225j105972a607fe26c5@mail.gmail.com>
Subject: Re: kexec-tools-2.0.1 and CFLAGS
From: Magnus Damm <magnus.damm@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On Wed, Aug 26, 2009 at 7:50 PM, Simon Horman<horms@verge.net.au> wrote:
> I think you are understanding it right, that the current code fails
> with no optimisation enabled because the unused function isn't optimised
> away. Is there a reason you need -O0? It seems that fixing this is probably
> more effort than its worth.

I don't really need -O0, just happened to pass in a custom CFLAGS
without -O2 to ./configure and then the code didn't compile. Now I
know that I should include -O2 in the CFLAGS to make sure the code
builds.

If it should be fixed or not is a different question. I'm perfectly
happy with things as-is!

Cheers,

/ magnus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
