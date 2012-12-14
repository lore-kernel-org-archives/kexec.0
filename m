Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vwp2514.webpack.hosteurope.de ([2a01:488:42:1000:57e6:2a18::])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjRRU-0008TP-7d
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 09:20:29 +0000
Message-ID: <1355476821.1341.10.camel@sven>
Subject: Re: [PATCH] kexec-zImage-arm: add code to support --command-line
 along with --dtb
From: Sven Neumann <s.neumann@raumfeld.com>
Date: Fri, 14 Dec 2012 10:20:21 +0100
In-Reply-To: <1355405734-19630-1-git-send-email-zonque@gmail.com>
References: <1355405734-19630-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: matthew.leach@arm.com, horms@verge.net.au, Daniel Mack <zonque@gmail.com>

Hi,

On Thu, 2012-12-13 at 14:35 +0100, Daniel Mack wrote:
> If --dtb is called together with --command-line, we need to modify the
> binary dtb buffer. Luckily, we have libfdt functions available, so this
> is straight forward.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Tested-by: Sven Neumann <s.neumann@raumfeld.com>

Works fine for us. Please include this upstream as we rely on this
functionality to be present.


Regards,
Sven



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
