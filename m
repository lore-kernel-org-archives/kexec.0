Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f177.google.com ([209.85.213.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQ53N-0008QN-9c
 for kexec@lists.infradead.org; Mon, 14 Nov 2011 22:31:01 +0000
Received: by yenl9 with SMTP id l9so6816980yen.36
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2011 14:31:00 -0800 (PST)
Date: Tue, 15 Nov 2011 09:00:38 +1030
From: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/3] kexec-tools: powerpc: Fix 64bit optimize for size
 (gcc -Os) build
Message-ID: <20111114223036.GK14325@bubble.grove.modra.org>
References: <20111114185329.19ddc2b4@kryten>
 <20111114221402.GJ14325@bubble.grove.modra.org>
 <20111115092406.31df5f9e@kryten>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111115092406.31df5f9e@kryten>
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
To: Anton Blanchard <anton@samba.org>
Cc: Michael Neuling <mikey@neuling.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>, Matt Evans <matt@ozlabs.org>

On Tue, Nov 15, 2011 at 09:24:06AM +1100, Anton Blanchard wrote:
> I wonder why we aren't building and linking an -fpic object, wouldn't
> it make the relocation code much simpler?

No, powerpc64 is PIC anyway.

-- 
Alan Modra
Australia Development Lab, IBM

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
