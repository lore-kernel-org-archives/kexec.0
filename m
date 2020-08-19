Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400088.outbound.protection.outlook.com
 ([40.107.140.88] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8G6t-0003Yn-Au
 for kexec@lists.infradead.org; Wed, 19 Aug 2020 04:54:04 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH] README: Add the necessary method about elfutils
Date: Wed, 19 Aug 2020 04:53:45 +0000
Message-ID: <OSBPR01MB1991860E58DB2EC742311EF8DD5D0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <1597745423-10295-1-git-send-email-hejinyang@loongson.cn>
In-Reply-To: <1597745423-10295-1-git-send-email-hejinyang@loongson.cn>
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
To: Jinyang He <hejinyang@loongson.cn>
Cc: kexec-ml <kexec@lists.infradead.org>

-----Original Message-----
> In dwarf_info.c: 20, #include <elfutils/libdwfl.h>
> 
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
>  README | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/README b/README
> index f83717f..f69fe43 100644
> --- a/README
> +++ b/README
> @@ -18,6 +18,7 @@
>       #
>       # mkdir /usr/local/include/elfutils/
>       # cp ./libdw/libdw.h   /usr/local/include/elfutils/libdw.h
> +     # cp ./libdwfl/libdwfl.h /usr/local/include/elfutils/libdwfl.h

That's right, applied.

Thanks,
Kazu


>       # cp ./libdw/dwarf.h   /usr/local/include/dwarf.h
>       # cp ./libelf/libelf.h /usr/local/include/libelf.h
>       # cp ./libelf/gelf.h   /usr/local/include/gelf.h
> --
> 2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
