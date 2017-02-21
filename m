Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cgGSI-00039c-KL
 for kexec@lists.infradead.org; Tue, 21 Feb 2017 19:50:37 +0000
Date: Tue, 21 Feb 2017 20:48:01 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2] gitignore: add two generated files in purgatory
Message-ID: <20170221194801.GB3484@olila.local.net-space.pl>
References: <1487693904-10324-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1487693904-10324-1-git-send-email-eric.devolder@oracle.com>
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

On Tue, Feb 21, 2017 at 10:18:24AM -0600, Eric DeVolder wrote:
> This patch adds the two generated files below to .gitignore,
> so that 'git status' does not complain about them.

This is not a problem. Do you have issues during 'git checkout'
or so? If yes then I think it is worth considering.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
