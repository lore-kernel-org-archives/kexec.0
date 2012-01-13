Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RlcEM-0003Ql-Py
 for kexec@lists.infradead.org; Fri, 13 Jan 2012 08:11:25 +0000
Subject: Re: [PATCH][makedumpfile] Fix compilation error in sadump_info.h
In-reply-to: <20120113065726.13214.80477.stgit@suzukikp.in.ibm.com>
Message-Id: <20120113170846tachibana@mail.jp.nec.com>
References: <20120113065726.13214.80477.stgit@suzukikp.in.ibm.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Fri, 13 Jan 2012 17:08:46 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: kexec-ml <kexec@lists.infradead.org>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>

Hi Poulose,

On 2012/01/13 12:27:50 +0530, "Suzuki K. Poulose" <suzuki@in.ibm.com> wrote:
> While compiling the makedumpfile-1.4.1 I got the following error :

Thank you for the fix.
I got the same report from Michael Holzheu.

<http://lists.infradead.org/pipermail/kexec/2012-January/005940.html>


Thanks.
tachibana

> 
> In file included from makedumpfile.c:21:
> sadump_info.h:86: error: expected identifier or ‘(’ before ‘{’ token
> 
> 
> This patch fixes the compilation error in sadump_info.h
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> ---
> 
>  sadump_info.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sadump_info.h b/sadump_info.h
> index 1f74ee5..c4824be 100644
> --- a/sadump_info.h
> +++ b/sadump_info.h
> @@ -82,7 +82,7 @@ static inline int sadump_initialize_bitmap_memory(void)
>  	return FALSE;
>  }
>  
> -static inline int sadump_num_online_cpus(void);
> +static inline int sadump_num_online_cpus(void)
>  {
>  	return 0;
>  }
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
