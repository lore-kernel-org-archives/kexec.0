Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f49.google.com ([209.85.213.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQ4n6-0008Ih-Lo
 for kexec@lists.infradead.org; Mon, 14 Nov 2011 22:14:13 +0000
Received: by ywp31 with SMTP id 31so5600192ywp.36
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2011 14:14:11 -0800 (PST)
Date: Tue, 15 Nov 2011 08:44:02 +1030
From: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/3] kexec-tools: powerpc: Fix 64bit optimize for size
 (gcc -Os) build
Message-ID: <20111114221402.GJ14325@bubble.grove.modra.org>
References: <20111114185329.19ddc2b4@kryten>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111114185329.19ddc2b4@kryten>
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

On Mon, Nov 14, 2011 at 06:53:29PM +1100, Anton Blanchard wrote:
> 
> commit 46b2d0b8a719 (kexec/powerpc fix optimization for size (gcc -Os)
> build) added out of line GPR save/restore handlers for 32bit -Os
> builds. This patch adds the handlers for 64bit builds.

The linker is supposed to add these functions magically on final link
for powerpc64.  Um, I suppose you're doing something horrible with
kexec, ld -r instead of normal final link at a guess?

-- 
Alan Modra
Australia Development Lab, IBM

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
