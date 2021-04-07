Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lUDp1-005pw3-H9
 for kexec@lists.infradead.org; Wed, 07 Apr 2021 19:26:51 +0000
Received: from madeliefje.horms.nl (tulip.horms.nl [83.161.246.101])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 19E8B25BEFC
 for <kexec@lists.infradead.org>; Thu,  8 Apr 2021 05:26:24 +1000 (AEST)
Date: Wed, 7 Apr 2021 21:26:21 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH kexec-tools 0/7] build enhancements and GitHub workflow
Message-ID: <20210407192621.GA30418@vergenet.net>
References: <20210402101737.1886-1-horms@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210402101737.1886-1-horms@verge.net.au>
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
To: kexec@lists.infradead.org

On Fri, Apr 02, 2021 at 12:17:30PM +0200, Simon Horman wrote:
> This series aimes to:
> 
> 1. Allow creation of dist tarball without self-referential hard links
> 2. Add a distckeck target
> 3. Add a GitHub workflow which to performs basic build testing
> 
> A sample run of the workflow can be seen here
> https://github.com/horms/kexec-tools/actions/runs/711376088

Series applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
