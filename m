Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cW1GC-00064x-2Q
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 13:35:45 +0000
Date: Tue, 24 Jan 2017 14:35:17 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec: implemented XEN KEXEC STATUS to determine if
 an image is loaded
Message-ID: <20170124133517.GD28325@verge.net.au>
References: <1484931834-21060-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1484931834-21060-1-git-send-email-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, daniel.kiper@oracle.com, konrad.wilk@oracle.com, kexec@lists.infradead.org, xen-devel@lists.xenproject.org

On Fri, Jan 20, 2017 at 11:03:54AM -0600, Eric DeVolder wrote:
> Instead of the scripts having to poke at various fields we can
> provide that functionality via the -S parameter.
> 
> Returns 0 if the payload is loaded. Can be used in combination
> with -l or -p to get the state of the proper kexec image.
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
> Note: The corresponding Xen changes have been committed
> to the Xen staging branch. Follow this thread:
> https://lists.xenproject.org/archives/html/xen-devel/2017-01/msg01570.html

Hi,

this change seems worthwhile to me but am I correct in thinking that
it adds a new -S option that works both with and without Xen?
If so I'd like that reflected in the changelog.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
