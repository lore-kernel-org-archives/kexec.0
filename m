Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yhhka-0000MU-VX
 for kexec@lists.infradead.org; Mon, 13 Apr 2015 17:02:22 +0000
Received: by qkx62 with SMTP id 62so189296558qkx.0
 for <kexec@lists.infradead.org>; Mon, 13 Apr 2015 10:01:59 -0700 (PDT)
Date: Mon, 13 Apr 2015 13:01:56 -0400
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] kexec: remove ordering constraints from -x
 (--no-ifdown) and -y (--no-sync)
Message-ID: <20150413170156.GH2596@htj.duckdns.org>
References: <20150326191608.GE1953@htj.duckdns.org>
 <20150326191644.GF1953@htj.duckdns.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150326191644.GF1953@htj.duckdns.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Chris Mason <clm@fb.com>, kexec@lists.infradead.org

On Thu, Mar 26, 2015 at 03:16:44PM -0400, Tejun Heo wrote:
> From 81b5889b49f0f2448c3e9543c5c936d52348910c Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Thu, 26 Mar 2015 15:11:09 -0400
> 
> Currently, the two options must be the last ones to be honored;
> otherwise, they can get silently ignored and both the manpage and help
> text point it out.  This is error-prone and trivial to fix.  There
> isn't much point in pointing something out in documentation when the
> peculiarity can be removed with four lines of extra code.
> 
> Update option handling so that the two arguments are honored
> regardless of their positions.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Ping?

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
