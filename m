Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400088.outbound.protection.outlook.com
 ([40.107.140.88] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfXmT-0005su-KN
 for kexec@lists.infradead.org; Thu, 19 Nov 2020 00:26:35 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: Facing issue with va to pa conversion in arm64/makedumpfile
Date: Thu, 19 Nov 2020 00:26:23 +0000
Message-ID: <OSBPR01MB19915A5A9BD7F1260E0CAF50DDE00@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <698954d8fcee05aee74833235800829f@qti.qualcomm.com>
In-Reply-To: <698954d8fcee05aee74833235800829f@qti.qualcomm.com>
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
To: "aadiga@qti.qualcomm.com" <aadiga@qti.qualcomm.com>, "panand@redhat.com" <panand@redhat.com>
Cc: "vatsa@codeaurora.org" <vatsa@codeaurora.org>, Bhupesh Sharma <bhsharma@redhat.com>, "arunks@codeaurora.org" <arunks@codeaurora.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Akshay,
(Cc Bhupesh)

-----Original Message-----
> Hi Pratyush/ Kazuhito ,
> 
> While attempting to create dumpfile on arm64, I was face issues with
> virtual address to physical address conversion when kalsr is enable.
> Linux kernel version is 5.4.42 stable kernel.

It seems that it would be due to the flipped VA space at 5.4 arm64 kernel.
Bhupesh has been addressing this for us, but not merged yet.
How does it work with this patch?
http://lists.infradead.org/pipermail/kexec/2020-September/021336.html

(Its 1/3 and 2/3 patches were already merged, so I think the 3/3 patch
can be applied on top of the latest makedumpfile.)

Thanks,
Kazu

> 
> The following patch seems to add patch to enable kalsr support :
> 
> [PATCH 10/10] arm64: fix memory layout as per changes in v4.6 kernel
> 
> https://sourceforge.net/p/makedumpfile/code/ci/b6fe70c7ffef9affb540412407702b15d4a196e9
> 
> 
> static unsigned long long
> +__pa(unsigned long vaddr)
> +{
> +       if (kimage_voffset == NOT_FOUND_NUMBER ||
> +                       (vaddr >= PAGE_OFFSET))
> +               return (vaddr - PAGE_OFFSET + info->phys_base);
> +       else
> +               return (vaddr - kimage_voffset);
> +}
> 
> 
> I see that even when kimage_voffset is available , it calculates pa
> using PAGE_OFFSET.
> But as KALSR is enabled it should ideally use kimage_voffset.
> 
> Not sure what is the significance of the check (vaddr >= PAGE_OFFSET) if
> kimage_voffset is available.
> 
> i think this should be something like
> 
> +       if (kimage_voffset == NOT_FOUND_NUMBER) && (vaddr >=
> PAGE_OFFSET))
> +               return (vaddr - PAGE_OFFSET + info->phys_base);
> +       else
> +               return (vaddr - kimage_voffset);
> 
> 
> 
> Because we want to check vaddr is greater than PAGE_OFFSET when we are
> considering linear mapping without kaslr seed.
> 
> Or may be we should have a separate check which will error out all vaddr
> less than PAGE_OFFSET and kimage_voffset.
> 
> +       if  (vaddr < PAGE_OFFSET)
> +              return -EINVAL;
> +       if (kimage_voffset == NOT_FOUND_NUMBER)
> +               return (vaddr - PAGE_OFFSET + info->phys_base);
> +       else
> +               return (vaddr - kimage_voffset);
> 
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
