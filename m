Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ee5H5-0004vt-5z
 for kexec@lists.infradead.org; Tue, 23 Jan 2018 20:34:32 +0000
Date: Tue, 23 Jan 2018 21:34:08 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 1/2] kexec-tools: Call dlclose() from within
 __xc_interface_close()
Message-ID: <20180123203408.GP4675@olila.local.net-space.pl>
References: <1516734771-14795-1-git-send-email-eric.devolder@oracle.com>
 <1516734771-14795-2-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1516734771-14795-2-git-send-email-eric.devolder@oracle.com>
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
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Tue, Jan 23, 2018 at 01:12:50PM -0600, Eric DeVolder wrote:
> This patch is a follow-on to commit 43d3932e "kexec-tools: Perform
> run-time linking of libxenctrl.so". This patch addresses feedback
> from Daniel Kiper.
>
> In the original patch, the call to dlclose() was omitted, in contrast
> to the description in the commit message. This patch inserts the call.
> Note that this dynamic linking feature is dependent upon the proper
> operation of the RTLD_NODELETE flag to dlopen(), which does work as
> advertised on Linux (otherwise the call to dlclose() should be omitted).
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
