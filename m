Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cb8Pd-0005Ke-BD
 for kexec@lists.infradead.org; Tue, 07 Feb 2017 16:14:39 +0000
Date: Tue, 7 Feb 2017 17:14:08 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 12/12] kexec: Add option to get crash kernel region size
Message-ID: <20170207161408.GH13477@olila.local.net-space.pl>
References: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
 <1486410144-28595-13-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1486410144-28595-13-git-send-email-eric.devolder@oracle.com>
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
Cc: andrew.cooper3@citrix.com, dyoung@redhat.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Mon, Feb 06, 2017 at 01:42:24PM -0600, Eric DeVolder wrote:
> Here print_crashkernel_region_size() function is available on all archs (even
> if the functionality is not implemented on some). So, we can safely use it in
> arch independent code and export the functionality to the user space.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

I think that patch #11 and #12 should be merged into one thing
like it was in my original series.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
