Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UWyXl-0007Ja-R3
 for kexec@lists.infradead.org; Tue, 30 Apr 2013 00:35:42 +0000
Date: Tue, 30 Apr 2013 09:35:11 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: cleanup: make add_backup_segments static
Message-ID: <20130430003511.GB14868@verge.net.au>
References: <517B719F.6030503@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <517B719F.6030503@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Sat, Apr 27, 2013 at 02:35:11PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> The function add_backup_segments is only called by my_load and
> they are in the same file. So unnecessary to export it. Make it
> static.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
