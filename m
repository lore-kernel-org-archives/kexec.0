Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFG6G-0006cw-DY
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 08:00:13 +0000
Date: Fri, 9 Dec 2016 08:59:46 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: Fix initrd requierements
Message-ID: <20161209075941.GB30610@verge.net.au>
References: <1481127975-9156-1-git-send-email-mbrugger@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1481127975-9156-1-git-send-email-mbrugger@suse.com>
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
To: Matthias Brugger <mbrugger@suse.com>
Cc: geoff@infradead.org, panand@redhat.com, ard.biesheuvel@linaro.org, kexec@lists.infradead.org, catalin.marinas@arm.com

On Wed, Dec 07, 2016 at 05:26:15PM +0100, Matthias Brugger wrote:
> The initrd doesn't need to be aligend to 1 GB, which breaks kexec for system with
> RAM <= 1 GB. Instead the memory size between the kernel start rounded down to 1 GB
> and the end of the initrd rounded up to 1 GB can't be bigger then 32 GB.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
