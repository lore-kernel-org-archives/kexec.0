Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sjfzv-0001cw-3B
 for kexec@lists.infradead.org; Wed, 27 Jun 2012 00:20:43 +0000
Date: Wed, 27 Jun 2012 09:20:38 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] Fix format strings of die()
Message-ID: <20120627002038.GC7524@verge.net.au>
References: <1340733223-25382-1-git-send-email-aleksey.makarov@gmail.com>
 <1340733223-25382-2-git-send-email-aleksey.makarov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1340733223-25382-2-git-send-email-aleksey.makarov@gmail.com>
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
To: Aleksey Makarov <aleksey.makarov@gmail.com>
Cc: kexec@lists.infradead.org

On Wed, Jun 27, 2012 at 12:53:43AM +0700, Aleksey Makarov wrote:
> One of them caused crash when user specifies a file that does not
> exist.
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@gmail.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
