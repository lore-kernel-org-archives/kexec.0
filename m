Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqvEj-0006wx-3f
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 01:38:46 +0000
Message-ID: <52A912E3.1060802@cn.fujitsu.com>
Date: Thu, 12 Dec 2013 09:35:31 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] kexec: Add IND_FLAGS macro
References: <cover.1386807069.git.geoff@infradead.org>
 <3d9d024551c3c0e560d77f81926cb5774dda7067.1386807069.git.geoff@infradead.org>
In-Reply-To: <3d9d024551c3c0e560d77f81926cb5774dda7067.1386807069.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Paul Mackerras <paulus@samba.org>

Hello

On 12/12/2013 08:18 AM, Geoff Levand wrote:
> Add a new kexec preprocessor macro IND_FLAGS, which is the bitwise OR of
> all the possible kexec IND_ kimage_entry indirection flags.
> 
> Having this macro allows for simplified code in the prosessing of the
> kexec kimage_entry items.

Where? I didn't see any place you use this macro to help simplification.

Thanks
Zhang

> 
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> ---
>  include/linux/kexec.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index d78d28a..f755ec3 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -67,6 +67,7 @@ typedef unsigned long kimage_entry_t;
>  #define IND_INDIRECTION  0x2
>  #define IND_DONE         0x4
>  #define IND_SOURCE       0x8
> +#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
>  
>  struct kexec_segment {
>  	void __user *buf;
> 


-- 
Thanks.
Zhang Yanfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
