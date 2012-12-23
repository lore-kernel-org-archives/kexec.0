Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Tmflp-00012u-Ge
 for kexec@lists.infradead.org; Sun, 23 Dec 2012 07:14:50 +0000
Date: Sun, 23 Dec 2012 16:14:44 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-zImage-arm: simply cmdline-related DTB resizing
Message-ID: <20121223071440.GM26088@verge.net.au>
References: <1355959196-14500-1-git-send-email-swarren@wwwdotorg.org>
 <50D27175.7030006@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50D27175.7030006@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: Sven Neumann <neumann@teufel.de>, kexec@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Eric Biederman <ebiederm@xmission.com>, Stephen Warren <swarren@wwwdotorg.org>

On Thu, Dec 20, 2012 at 10:01:25AM +0800, Daniel Mack wrote:
> On 12/20/2012 07:19 AM, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > When resizing a dtb to add the command-line, only resize the DTB once,
> > rather than once to add the /chosen node, and once to add the bootargs
> > property.
> > 
> > Also, simply add 1K of overhead (beyond strlen(cmdline)) to the buffer,
> > to avoid requiring precise knowledge of the size impact of the requested
> > FTB changes. In particular, some padding is performed when setting
> > property values, which was not accounted for in the current code, which
> > caused failures to set the bootargs values in some cases.
> > 
> > Cc: Daniel Mack <zonque@gmail.com>
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
