Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JTuhy-0004Sb-GB
	for kexec@lists.infradead.org; Tue, 26 Feb 2008 07:58:38 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 9BDDC31360
	for <kexec@lists.infradead.org>; Tue, 26 Feb 2008 08:58:35 +0100 (CET)
Date: Tue, 26 Feb 2008 08:58:35 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Fix compilation warning
Message-ID: <20080226075834.GA3662@suse.de>
References: <20080220080755.GB5542@suse.de>
	<20080221092153.GB15981@verge.net.au>
	<20080221092832.GA22609@suse.de>
	<20080222090239.GA25249@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080222090239.GA25249@verge.net.au>
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
To: kexec@lists.infradead.org

* Simon Horman <horms@verge.net.au> [2008-02-22 10:02]:
> On Thu, Feb 21, 2008 at 10:28:33AM +0100, Bernhard Walle wrote:
> > * Simon Horman <horms@verge.net.au> [2008-02-21 10:21]:
> > > On Wed, Feb 20, 2008 at 09:07:55AM +0100, Bernhard Walle wrote:
> > > > This patch fixes following compilation warning:
> > > > 
> > > > purgatory/purgatory.c:21: warning: passing argument 2 of 'sha256_update' makes pointer from integer without a cast
> > > > 
> > > 
> > > Thanks Bernhard, I have queued that up.
> > > Although I notice that on arm the warning turns into
> > > 
> > > purgatory/purgatory.c: In function 'verify_sha256_digest':
> > > purgatory/purgatory.c:21: warning: cast to pointer from integer of different size
> > 
> > Isn't this the case on every 32 bit system?
> 
> Yes, now you mention it, I expect so. I guess its not a problem.

But you didn't merge the patch. ;) Here's a version that should not
give any warnings ...

----------------------------

This patch fixes following compilation warning:

purgatory/purgatory.c:21: warning: passing argument 2 of 'sha256_update' makes pointer from integer without a cast


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 purgatory/purgatory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -18,7 +18,7 @@ void verify_sha256_digest(void)
 	sha256_starts(&ctx);
 	end = &sha256_regions[sizeof(sha256_regions)/sizeof(sha256_regions[0])];
 	for(ptr = sha256_regions; ptr < end; ptr++) {
-		sha256_update(&ctx, ptr->start, ptr->len);
+		sha256_update(&ctx, (uint8_t *)((uintptr_t)ptr->start), ptr->len);
 	}
 	sha256_finish(&ctx, digest);
 	if (memcmp(digest, sha256_digest, sizeof(digest)) != 0) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
