Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JcXjB-0002w4-3P
	for kexec@lists.infradead.org; Fri, 21 Mar 2008 03:15:34 +0000
Date: Fri, 21 Mar 2008 12:15:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] Use separate CPPFLAGS and LDFLAGS for purgatory
Message-ID: <20080321031524.GA20730@verge.net.au>
References: <1205908147.931964.895312651655.1.gpush@pokey>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1205908147.931964.895312651655.1.gpush@pokey>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: kexec@lists.infradead.org

On Wed, Mar 19, 2008 at 05:29:07PM +1100, Jeremy Kerr wrote:
> Currently, CPPFLAGS and LDFLAGS can 'leak' into the purgatory build
> from the main kexec/kexec object. Because of this, the purgatory
> is build with -lz, but we may not have a zlib present for the
> architecture of the purgatory object.
> 
> This change uses fresh CPPFLAGS and LDFLAGS for the purgatory object.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Thanks Jeremy, I have queued this up and will apply it after the next
release gets out the door.  Ditto for the other 2 patches in the series.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
