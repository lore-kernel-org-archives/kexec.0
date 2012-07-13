Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SpZSD-0005Ov-PO
 for kexec@lists.infradead.org; Fri, 13 Jul 2012 06:34:37 +0000
Date: Fri, 13 Jul 2012 15:34:12 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec: simply pass LINUX_REBOOT_CMD_KEXEC to reboot
Message-ID: <20120713063412.GG19512@verge.net.au>
References: <1337705987-16541-1-git-send-email-max@stro.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1337705987-16541-1-git-send-email-max@stro.at>
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
To: maximilian attems <max@stro.at>
Cc: klibc@zytor.com, kexec@lists.infradead.org

On Tue, May 22, 2012 at 06:59:47PM +0200, maximilian attems wrote:
> While trying to port kexec cleanly to klibc,
> came across this syscall usage for reboot(2).
> Calling reboot directly simplifies the code.
> 
> Signed-off-by: maximilian attems <max@stro.at>

Thanks, applied.

Sorry for not doing so earlier.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
