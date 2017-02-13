Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdPOS-0006Ux-9m
 for kexec@lists.infradead.org; Mon, 13 Feb 2017 22:46:54 +0000
Date: Mon, 13 Feb 2017 23:46:18 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH] gitignore: add two generated files in purgatory
Message-ID: <20170213224618.GJ9543@olila.local.net-space.pl>
References: <1486765205-14336-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1486765205-14336-1-git-send-email-eric.devolder@oracle.com>
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

On Fri, Feb 10, 2017 at 04:20:05PM -0600, Eric DeVolder wrote:
> This patch adds the two generated files below to .gitignore.

Next time please add why it is needed. One sentence explanation is sufficient.

> purgatory/purgatory.map
> purgatory/purgatory.ro.sym
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Otherwise:

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
