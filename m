Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eeQhB-0007Ds-31
 for kexec@lists.infradead.org; Wed, 24 Jan 2018 19:26:56 +0000
Date: Wed, 24 Jan 2018 20:26:32 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v4] kexec-tools: Make xc_dlhandle static
Message-ID: <20180124192632.GW4675@olila.local.net-space.pl>
References: <1516821621-27139-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1516821621-27139-1-git-send-email-eric.devolder@oracle.com>
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

On Wed, Jan 24, 2018 at 01:20:21PM -0600, Eric DeVolder wrote:
> This patch is a follow-on to commit 894bea93 "kexec-tools: Perform
> run-time linking of libxenctrl.so". This patch addresses feedback
> from Daniel Kiper.
>
> This patch implements Daniel's suggestion to make the
> xc_dlhandle variable static, insert missing 'extern'
> qualifier for the new __xc() wrappers, and correct some
> style issues.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
