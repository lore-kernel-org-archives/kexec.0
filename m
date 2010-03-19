Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nsdfs-0007vS-Qx
	for kexec@lists.infradead.org; Fri, 19 Mar 2010 14:59:49 +0000
Date: Fri, 19 Mar 2010 10:59:42 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] kexec-tools: Fix a typo in rpm spec description
Message-ID: <20100319145942.GT15159@redhat.com>
References: <dc79caccb36f1bf0dbd5b105cbd4e885ff79dd71.1269007108.git.ameya.palande@nokia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc79caccb36f1bf0dbd5b105cbd4e885ff79dd71.1269007108.git.ameya.palande@nokia.com>
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
Cc: horms@verge.net.au, kexec@lists.infradead.org

On Fri, Mar 19, 2010 at 03:58:52PM +0200, Ameya Palande wrote:
> From: Ameya Palande <ameya.palande@nokia.com>
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  kexec-tools.spec.in |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kexec-tools.spec.in b/kexec-tools.spec.in
> index 5eadece..ae91b73 100644
> --- a/kexec-tools.spec.in
> +++ b/kexec-tools.spec.in
> @@ -9,7 +9,7 @@ Packager: Eric Biederman <ebiederman@xmission.com>
>  BuildRoot: %{_tmppath}/%{name}
>  
>  %description
> -/sbin/kexec is a user space utiltity for loading another kernel
> +/sbin/kexec is a user space utilitity for loading another kernel

I believe the word you want is 'utility'. ;-)

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
