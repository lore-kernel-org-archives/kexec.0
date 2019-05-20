Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ms.lwn.net ([45.79.88.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hSnwu-0003m8-AE
 for kexec@lists.infradead.org; Mon, 20 May 2019 19:27:53 +0000
Date: Mon, 20 May 2019 13:27:49 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: kdump: fix minor typo
Message-ID: <20190520132749.093c3c78@lwn.net>
In-Reply-To: <20190514161724.16604-1-cengizc@gmail.com>
References: <20190514161724.16604-1-cengizc@gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cengiz Can <cengizc@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

On Tue, 14 May 2019 19:17:25 +0300
Cengiz Can <cengizc@gmail.com> wrote:

> kdump.txt had a minor typo.
> 
> Signed-off-by: Cengiz Can <cengizc@gmail.com>
> ---
>  Documentation/kdump/kdump.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> index 51814450a7f8..3162eeb8c262 100644
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -410,7 +410,7 @@ Notes on loading the dump-capture kernel:
>  * Boot parameter "1" boots the dump-capture kernel into single-user
>    mode without networking. If you want networking, use "3".
>  
> -* We generally don' have to bring up a SMP kernel just to capture the
> +* We generally don't have to bring up a SMP kernel just to capture the

Applied, thanks.

jon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
