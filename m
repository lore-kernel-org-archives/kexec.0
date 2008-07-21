Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KKudl-0003ML-E1
	for kexec@lists.infradead.org; Mon, 21 Jul 2008 12:37:21 +0000
Date: Mon, 21 Jul 2008 08:37:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump: Update kdump documentation as
	kexec-tools-resting has been renamed kexec-tools
Message-ID: <20080721123706.GA4451@redhat.com>
References: <20080719005835.GA19032@verge.net.au>
	<20080719011612.GA20745@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080719011612.GA20745@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Sat, Jul 19, 2008 at 11:16:14AM +1000, Simon Horman wrote:
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> --- 
> Reposting to Vivek's new email address
> 
> Index: linux-2.6/Documentation/kdump/kdump.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/kdump/kdump.txt	2008-07-19 10:27:50.000000000 +1000
> +++ linux-2.6/Documentation/kdump/kdump.txt	2008-07-19 10:51:57.000000000 +1000
> @@ -65,26 +65,26 @@ Install kexec-tools
>  
>  2) Download the kexec-tools user-space package from the following URL:
>  
> -http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools-testing.tar.gz
> +http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools.tar.gz
>  
> -This is a symlink to the latest version, which at the time of writing is
> -20061214, the only release of kexec-tools-testing so far. As other versions
> -are released, the older ones will remain available at
> -http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/
> +This is a symlink to the latest version.
>  
> -Note: Latest kexec-tools-testing git tree is available at
> +The latest kexec-tools git tree is available at:
>  
> -git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
> +git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git
>  or
> -http://www.kernel.org/git/?p=linux/kernel/git/horms/kexec-tools-testing.git;a=summary
> +http://www.kernel.org/git/?p=linux/kernel/git/horms/kexec-tools.git
> +
> +More information about kexec-tools can be found at
> +http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/README.html
>  
>  3) Unpack the tarball with the tar command, as follows:
>  
> -   tar xvpzf kexec-tools-testing.tar.gz
> +   tar xvpzf kexec-tools.tar.gz
>  
>  4) Change to the kexec-tools directory, as follows:
>  
> -   cd kexec-tools-testing-VERSION
> +   cd kexec-tools-VERSION
>  
>  5) Configure the package, as follows:

Looks Good. Thanks Simon.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
