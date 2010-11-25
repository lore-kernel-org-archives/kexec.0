Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.sysgo.com ([195.145.229.155])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PLWMq-0001yK-E8
	for kexec@lists.infradead.org; Thu, 25 Nov 2010 07:35:45 +0000
Date: Thu, 25 Nov 2010 08:35:37 +0100
From: Pavel Machek <pma@sysgo.com>
Subject: Re: [PATCH] kdump: update kexec-tools URL and Vivek's email
Message-ID: <20101125073537.GB3817@pma.sysgo.com>
References: <1290648612-14964-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1290648612-14964-1-git-send-email-horms@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>, Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>, Jiri Kosina <trivial@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On Thu 2010-11-25 10:30:12, Simon Horman wrote:
> Signed-off-by: Simon Horman <horms@verge.net.au>

Thanks!

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
>  
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
