Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PLc0l-0006W7-FC
	for kexec@lists.infradead.org; Thu, 25 Nov 2010 13:37:20 +0000
Date: Thu, 25 Nov 2010 14:37:12 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] kdump: update kexec-tools URL and Vivek's email
In-Reply-To: <1290648612-14964-1-git-send-email-horms@verge.net.au>
Message-ID: <alpine.LNX.2.00.1011251437030.18801@pobox.suse.cz>
References: <1290648612-14964-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pma@sysgo.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 25 Nov 2010, Simon Horman wrote:

> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  Documentation/kdump/kdump.txt |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index cab61d8..7a9e0b4 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -65,18 +65,21 @@ Install kexec-tools
>  
>  2) Download the kexec-tools user-space package from the following URL:
>  
> -http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools.tar.gz
> +http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
>  
>  This is a symlink to the latest version.
>  
>  The latest kexec-tools git tree is available at:
>  
> -git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git
> -or
> -http://www.kernel.org/git/?p=linux/kernel/git/horms/kexec-tools.git
> +git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> +and
> +http://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> +
> +There is also a gitweb interface available at
> +http://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
>  
>  More information about kexec-tools can be found at
> -http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/README.html
> +http://www.kernel.org/pub/linux/utils/kernel/kexec/README.html
>  
>  3) Unpack the tarball with the tar command, as follows:
>  
> @@ -439,6 +442,6 @@ To Do
>  Contact
>  =======
>  
> -Vivek Goyal (vgoyal@in.ibm.com)
> +Vivek Goyal (vgoyal@redhat.com)
>  Maneesh Soni (maneesh@in.ibm.com)

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
