Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1ec51e-0005a8-Bw
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 07:54:26 +0000
Date: Thu, 18 Jan 2018 08:53:44 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4] kexec-tools: Perform run-time linking of libxenctrl.so
Message-ID: <20180118075344.i4dwybgdlpnmomkc@verge.net.au>
References: <1516207141-31590-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1516207141-31590-1-git-send-email-eric.devolder@oracle.com>
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
Cc: andrew.cooper3@citrix.com, daniel.kiper@oracle.com, xen-devel@lists.xen.org, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Wed, Jan 17, 2018 at 10:39:01AM -0600, Eric DeVolder wrote:
> When kexec is utilized in a Xen environment, it has an explicit
> run-time dependency on libxenctrl.so. This dependency occurs
> during the configure stage and when building kexec-tools.

...

Thanks for addressing this and thanks doubly for the very comprehensive
changelog.

Applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
