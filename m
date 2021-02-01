Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410049.outbound.protection.outlook.com
 ([40.107.141.49] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6OF7-00047w-OW
 for kexec@lists.infradead.org; Mon, 01 Feb 2021 01:43:07 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH] makedumpfile: Fix a compile error on Debian with pthread
Date: Mon, 1 Feb 2021 01:42:54 +0000
Message-ID: <OSBPR01MB19911206BBDE1223B48CF5B6DDB69@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20210130184920.1385887-1-jiang.wang@bytedance.com>
In-Reply-To: <20210130184920.1385887-1-jiang.wang@bytedance.com>
Content-Language: ja-JP
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
To: Jiang Wang <jiang.wang@bytedance.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

-----Original Message-----
> From: "jiang.wang" <jiang.wang@bytedance.com>
> 
> On Debian 10, make reports errors about undefined reference to
> `pthread_rwlock_tryrdlock'. To fix it, put ldw before lpthread
> in the Makefile.
> 
> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index cb6bd42..010d447 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -68,7 +68,7 @@ endif
>  CFLAGS += -DUSESNAPPY
>  endif
> 
> -LIBS := -lpthread $(LIBS)
> +LIBS := $(LIBS) -lpthread
> 
>  try-run = $(shell set -e;		\
>  	TMP=".$$$$.tmp";		\
> --
> 2.11.0

Thanks for the patch, applied.
https://github.com/makedumpfile/makedumpfile/commit/01b4bd354c4a845c160d14487a93270cd1e22031

Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
