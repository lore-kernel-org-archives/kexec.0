Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UlxXd-0003na-1y
 for kexec@lists.infradead.org; Mon, 10 Jun 2013 08:33:29 +0000
Date: Mon, 10 Jun 2013 17:32:58 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/3] change/add help message of options
Message-ID: <20130610083258.GB1563@verge.net.au>
References: <cover.1370252057.git.bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1370252057.git.bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org

On Mon, Jun 03, 2013 at 05:38:37PM +0800, Baoquan He wrote:
> Currently, help message of several options are missed or not correct,
> change/add it in this patchset.
> 
> Options not present in help:
> * --entry
> 
> Options not present in man:
> * --entry
> * --load-jump-back-helper
> * --load-preserve-context
> * --reuseinitrd 
> 
> Options not correct in man:
> * --debug
> 
> Baoquan He (3):
>   kexec man page change for debug option
>   add description for entry option in help and man page
>   add missed options to man page
> 
>  kexec/kexec.8 |   19 ++++++++++++++++---
>  kexec/kexec.c |    4 ++++
>  2 files changed, 20 insertions(+), 3 deletions(-)

Thanks, all three patches applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
