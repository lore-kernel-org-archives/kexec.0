Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400073.outbound.protection.outlook.com
 ([40.107.140.73] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKwWt-0003BW-V6
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 04:37:21 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH 1/1] kdump: append uts_namespace.name offset to VMCOREINFO
Date: Wed, 23 Sep 2020 04:37:13 +0000
Message-ID: <OSBPR01MB1991B0822ACE45077105DD46DD380@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200918080439.235190-1-egorenar@linux.ibm.com>
In-Reply-To: <20200918080439.235190-1-egorenar@linux.ibm.com>
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
To: "dyoung@redhat.com" <dyoung@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Alexander Egorenkov <egorenar@linux.ibm.com>

Hi Dave,

sorry to bother you.  We need this kernel patch to fix a makedumpfile issue
with the current linux-next.  Should we send this to the addresses below, right?
I'm not sure whether they are enough.

Alex,

Thanks for the patch.  Since this patch is for kernel, it needs to be sent
to kernel maintainers and mailing lists, and I think you can get their
addresses with scripts/get_maintainer.pl in the kernel tree.

$ scripts/get_maintainer.pl /tmp/a.patch 
Dave Young <dyoung@redhat.com> (maintainer:KDUMP)
Baoquan He <bhe@redhat.com> (maintainer:KDUMP)
Vivek Goyal <vgoyal@redhat.com> (reviewer:KDUMP)
kexec@lists.infradead.org (open list:KDUMP)
linux-kernel@vger.kernel.org (open list)

Thanks,
Kazu

-----Original Message-----
> The offset of the field 'init_uts_ns.name' has changed
> since commit 9a56493f6942c0e2df1579986128721da96e00d8.
> Make the offset of the field 'uts_namespace.name' available
> in VMCOREINFO because tools like 'crash-utility' and
> 'makedumpfile' must be able to read it from crash dumps.
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 106e4500fd53..173fdc261882 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> 
>  	VMCOREINFO_SYMBOL(init_uts_ns);
> +	VMCOREINFO_OFFSET(uts_namespace, name);
>  	VMCOREINFO_SYMBOL(node_online_map);
>  #ifdef CONFIG_MMU
>  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> --
> 2.26.2
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
