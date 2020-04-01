Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJcfF-00032R-Am
 for kexec@lists.infradead.org; Wed, 01 Apr 2020 12:40:14 +0000
Date: Wed, 1 Apr 2020 14:40:09 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [v2 0/2] Fix --kexec-syscall-auto on s390x
Message-ID: <20200401124009.GB29376@vergenet.net>
References: <20200313140929.29551-1-ptesarik@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200313140929.29551-1-ptesarik@suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec mailing list <kexec@lists.infradead.org>

On Fri, Mar 13, 2020 at 03:09:27PM +0100, Petr Tesarik wrote:
> From: Petr Tesarik <ptesarik@suse.com>
> 
> As noticed by Raymund Will, kexec -la does not work on kernels without
> the kexec_file_load(2) syscall, revealing some shortcomings in the
> automatic syscall selection.
> 
> Petr Tesarik (2):
>   kexec-tools: Fix kexec_file_load(2) error handling
>   kexec-tools: Reset getopt before falling back to legacy syscall
> 
>  kexec/kexec.c | 120 ++++++++++++++++++++++++++++++++--------------------------

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
