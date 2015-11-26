Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1m6v-0005EJ-Cx
 for kexec@lists.infradead.org; Thu, 26 Nov 2015 02:16:38 +0000
Date: Thu, 26 Nov 2015 11:16:14 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/1] Improve device tree directory sorting
Message-ID: <20151126021614.GA30297@verge.net.au>
References: <1448417830-48786-2-git-send-email-curt@cumulusnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1448417830-48786-2-git-send-email-curt@cumulusnetworks.com>
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
To: Curt Brune <curt@cumulusnetworks.com>
Cc: kexec@lists.infradead.org

On Tue, Nov 24, 2015 at 06:17:10PM -0800, Curt Brune wrote:
> Previously when sorting the device tree directory entries, if both
> device tree entries contained the '@' character then comparison was
> made based on the length of the strings.
> 
> This did not work in all cases and could result in odd orderings.
> 
> This patch modifies the comparison function for the case when both
> strings contain the '@' character.
> 
> First a lexical comparison is made between the prefix portions of the
> strings *before* the '@' character.
> 
> Next, if the prefixes are equal, the lengths of the suffixes *after*
> the '@' character are compared.  This preserves the intent of the
> original code.
> 
> Next, if the suffix lengths are equal, a lexical comparison of the
> suffixes is made.
> 
> This is still not strictly correct, as ideally the portion after the
> '@' should be compared numerically.  However, determining what base to
> use for all case is difficult.
> 
> Signed-off-by: Curt Brune <curt@cumulusnetworks.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
