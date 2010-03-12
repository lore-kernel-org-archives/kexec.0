Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NqDRH-0005gp-5v
	for kexec@lists.infradead.org; Fri, 12 Mar 2010 22:34:39 +0000
Date: Sat, 13 Mar 2010 09:34:18 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Replace obsolate Copyright tag in rpm spec
Message-ID: <20100312223418.GF3301@verge.net.au>
References: <aad0905ccdeabca832e9fa051d0e9a3765142df4.1268417835.git.ameya.palande@nokia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aad0905ccdeabca832e9fa051d0e9a3765142df4.1268417835.git.ameya.palande@nokia.com>
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
To: Ameya Palande <ameya.palande@nokia.com>
Cc: kexec@lists.infradead.org

On Fri, Mar 12, 2010 at 08:19:32PM +0200, Ameya Palande wrote:
> From: Ameya Palande <ameya.palande@nokia.com>
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>

Thanks, applied.

> ---
>  kexec-tools.spec.in |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kexec-tools.spec.in b/kexec-tools.spec.in
> index 6605cbb..2aa1310 100644
> --- a/kexec-tools.spec.in
> +++ b/kexec-tools.spec.in
> @@ -2,7 +2,7 @@ Summary: Load one kernel from another
>  Name: kexec-tools
>  Version: 
>  Release: 0
> -Copyright: GPL
> +License: GPL
>  Group: Development/Tools
>  Source0:%{name}-%{version}.tar.gz
>  Packager: Eric Biederman <ebiederman@xmission.com>
> -- 
> 1.6.3.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
