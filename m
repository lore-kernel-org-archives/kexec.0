Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jgroq-0006eG-4c
	for kexec@lists.infradead.org; Wed, 02 Apr 2008 01:31:16 +0000
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	m321VDw9018078 for <kexec@lists.infradead.org> (envelope-from
	takebe_akio@jp.fujitsu.com); Wed, 2 Apr 2008 10:31:13 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 188F41B801E
	for <kexec@lists.infradead.org>; Wed,  2 Apr 2008 10:31:13 +0900 (JST)
Received: from s7.gw.fujitsu.co.jp (s7.gw.fujitsu.co.jp [10.0.50.97])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DF8172DC01E
	for <kexec@lists.infradead.org>; Wed,  2 Apr 2008 10:31:12 +0900 (JST)
Received: from s7.gw.fujitsu.co.jp (s7 [127.0.0.1])
	by s7.gw.fujitsu.co.jp (Postfix) with ESMTP id CBDB6161C00B
	for <kexec@lists.infradead.org>; Wed,  2 Apr 2008 10:31:12 +0900 (JST)
Received: from fjm506.ms.jp.fujitsu.com (fjm506.ms.jp.fujitsu.com
	[10.56.99.86])
	by s7.gw.fujitsu.co.jp (Postfix) with ESMTP id 5A0C5161C009
	for <kexec@lists.infradead.org>; Wed,  2 Apr 2008 10:31:12 +0900 (JST)
Received: from fjmscan501.ms.jp.fujitsu.com (fjmscan501.ms.jp.fujitsu.com
	[10.56.99.141])by fjm506.ms.jp.fujitsu.com with ESMTP id
	m321Us0L007816
	for <kexec@lists.infradead.org>; Wed, 2 Apr 2008 10:30:54 +0900
From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: Re: [Patch] fix error case of xen
Date: Wed, 02 Apr 2008 10:28:47 +0900
MIME-Version: 1.0
In-Reply-To: <47F1D054.9080307@mxs.nes.nec.co.jp>
References: <A7C89354154DF3takebe_akio@jp.fujitsu.com>
	<47F1D054.9080307@mxs.nes.nec.co.jp>
Message-Id: <ACC89460E5F00Dtakebe_akio@jp.fujitsu.com>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Akio Takebe <takebe_akio@jp.fujitsu.com>, kexec-ml <kexec@lists.infradead.org>

Hi, Ohmichi-san

>
>> -		return handle_xen();
>> +		if (!handle_xen())
>> +			goto out;
>
>I guess that the above code is not enough. If handle_xen() succeeds,
>it should return TRUE instead of COMPLETED like the attached patch, right ?

You're right!
Your patch looks good, thank you very much for your review.

Best Regards,

Akio Takebe


>
>
>Thanks
>Ken'ichi Ohmichi
>
>Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>
>Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
>---
>diff -puN backup/v1.2.5/makedumpfile.c makedumpfile/makedumpfile.c
>--- backup/v1.2.5/makedumpfile.c	2008-03-28 11:54:48.000000000 +0900
>+++ makedumpfile/makedumpfile.c	2008-04-01 14:32:03.000000000 +0900
>@@ -5855,7 +5855,7 @@ handle_xen()
> 	MSG("\n");
> 	MSG("The dumpfile is saved to %s.\n", info->name_dumpfile);
> 
>-	return COMPLETED;
>+	return TRUE;
> out:
> 	return FALSE;
> #endif
>@@ -6146,7 +6146,8 @@ main(int argc, char *argv[])
> 			goto out;
> 		}
> 		info->dump_level |= DL_EXCLUDE_XEN;
>-		return handle_xen();
>+		if (!handle_xen())
>+			goto out;
> 
> 	} else if (info->flag_rearrange) {
> 		if (!open_files_for_rearranging_dumpdata())


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
