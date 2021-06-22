Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400050.outbound.protection.outlook.com
 ([40.107.140.50] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvWc4-005SRb-Be
 for kexec@lists.infradead.org; Tue, 22 Jun 2021 02:58:12 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [makedumpfile PATCH] check for invalid physical address of
 /proc/kcore when make ELF format dumpfile
Date: Tue, 22 Jun 2021 02:57:59 +0000
Message-ID: <TYYPR01MB6777B37F38512D788D600E4DDD099@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210618102803.1042547-1-ltao@redhat.com>
In-Reply-To: <20210618102803.1042547-1-ltao@redhat.com>
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
To: Tao Liu <ltao@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

-----Original Message-----
> Previously when executing makedumpfile with -E option against /proc/kcore,
> makedumpfile will fail:
> 
>     $ sudo makedumpfile -E -d 31 /proc/kcore vmcore
>     ...
>     write_elf_load_segment: Can't convert physaddr(ffffffffffffffff) to an
>     offset.
> 
>     makedumpfile Failed.
> 
> It's because /proc/kcore contains PT_LOAD program headers which have
> physaddr(ffffffffffffffff). With -E option, makedumpfile will try to convert
> the physaddr to an offset and fails.
> 
> In this patch, let's skip the PT_LOAD program headers which have such physaddr.
> 
> Signed-off-by: Tao Liu <ltao@redhat.com>

Thanks, applied with adjusting to the previous similar patch.
https://github.com/makedumpfile/makedumpfile/commit/9a6f589d99dcef114c89fde992157f5467028c8f

Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
