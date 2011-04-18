Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QBjMh-0000am-TV
	for kexec@lists.infradead.org; Mon, 18 Apr 2011 07:59:24 +0000
Date: Mon, 18 Apr 2011 15:59:17 +0800
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec: fix the missing i386 part in commit 1100580b05e
Message-ID: <20110418075917.GB3720@verge.net.au>
References: <1303028945-15298-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1303028945-15298-1-git-send-email-amwang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Amerigo Wang <amwang@redhat.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Sun, Apr 17, 2011 at 04:29:05PM +0800, Amerigo Wang wrote:
> Vivek pointed out that I missed the i386 part in this commit,
> 
> 	commit 1100580b05e3fdfe648d9be8617d962b11f4b88b
> 	Author: Amerigo Wang <amwang@redhat.com>
> 	Date:   Thu Mar 3 00:10:43 2011 +0800
> 
> 	    get the backup area dynamically
> 
> Yes. The customer who reported that bug definitely only
> tested it on x86_64. Now make it complete.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
