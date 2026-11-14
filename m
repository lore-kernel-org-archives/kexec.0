Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0E606A327
	for <kexec@archiver.kernel.org>; Sat, 14 Nov 2026 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r2/8/gmc;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nFscZflr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c0GDsRXX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qh8D85+/rqFc7JFnsbFf89BdzJYpnPx85C+buDkj5XY=; b=r2/8/gmcUoRMVR
	4QNidsd4UniOSJ7tHwtutbx1ydP/na5l+fIb+8exS1jtB7l52Mri2IQjNJLhEwd7mG3sLSHg3eV6F
	vlCJgG6loMDoMRur7J+Vzt+Uf6asNsXrEi1gj3mzJMi/ZbmRlSMVgvTC6tRqQr2oVxLhpFOcVoAXz
	ltq7F41sFG/RApyXbA4M/W//BT0wKA+xLXZP0AbRPfs4DjWhMX6kHcfmtTSt2J520IPxE3ZhsM6Tz
	eD/82mTRHSdq6zZCD6EqnzkxL/+fk5S/3W8gHyL33sdGoGXF3UPhmOQH2FVnwaEB+ZtjBKb6h+hEh
	DSL9gl2d3LRlRhePqKww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSIAA-0000000GZvq-1l2C;
	Sat, 14 Nov 2026 18:07:42 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSIA7-0000000GZul-2Pce
	for kexec@lists.infradead.org;
	Sat, 14 Nov 2026 18:07:41 +0000
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AEHpO732060188
	for <kexec@lists.infradead.org>; Sat, 14 Nov 2026 18:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qh8D85+/rqFc7JFnsbFf89BdzJYpnPx85C+buDkj5XY=; b=nFscZflrGPMCkiYW
	Lh+FAKQWMtpwvD4f0ymyjp5MatH6wZhJzl9zC0VfBlb4CLznKNOXqhGTp0cMkBxN
	Yqs2/ulE399Oy3nXDjqwMT5axIBzjHs1bR9RAL+R3TQxkxmzK0dXVlhP5d5t9lUe
	/5HVl+RYXsgMtNjSWPnDnk1yXl/L4TTyA89eKTO7oaMtBO1MEWsiyM5tmFtflv0E
	/yauIV2jWtd/8/QUtFfolRf3+rsRbvl0V8t5j+blh3K6DujjXv9jH4JbFZa3pk7V
	tiK328guRyflMlP4eUaNCaivD8RpE2DnUAtSIN8wyG4zOA1ZJ4EmNBaob9gjGvHZ
	Wv+A2A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhm8sbbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kexec@lists.infradead.org>; Sat, 14 Nov 2026 18:07:38 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1aa0fb7f157so2500079c88.0
        for <kexec@lists.infradead.org>; Sat, 14 Nov 2026 10:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794679657; x=1795284457; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qh8D85+/rqFc7JFnsbFf89BdzJYpnPx85C+buDkj5XY=;
        b=c0GDsRXXTNH07qXNDdzBf8+3GISU8Iwtiz16iWEfihd/0EoGhvkNY83AGun/ywl0sN
         2yKSs2kUCKVWSPxzHu7mIny8PFi3or0x//7az6NPlg+HyBlHhdnqLY8/74Y1z87LHKYL
         1iZJSrmfMf1Vcr21rmQ117FzQz+ie6TMX/E4nXzUHDVGJYXxenDyF4SFS2ohKtO7k/UH
         n8a4UTIPmjZBK16z0rHLyGHQXr+3AM+PptxRsxn7uWqyk0dRlqoHp0+70UFduRyTnxWM
         xcs2yU8qXWQOk4gPsYcNXavEI+Kcn/L5VeCbmlb5MyoSM0Xrr7jTaMY+Yc0EMVyMP1Ax
         ZJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794679657; x=1795284457;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qh8D85+/rqFc7JFnsbFf89BdzJYpnPx85C+buDkj5XY=;
        b=tj30Ohs5a72PCs0ermxnMdeWFDR2Kji7GO0nQIwxe69ipTb67y0UHMGEmy+TZ/Xhir
         fIWpyjUMc8y11OZ4A+BH16utGBg9KVm4MRv4PWgNz5Zxgsl/feZfHDKRqt+2bj9EMjhq
         HHNuCHtJaVrLFHK2JWwh+2K7oWMfFDwCzvALp7dabJtQTYYmc9NNDvoMwUjEPSY/pRpq
         cewbAy6okzrgINxSGw6wnbWohImQtEanhbgt5O+ZOhCe1pi3AfwY9ih1A2gALZ+I2Q9b
         FDasQhPQM2ZBFwjlTFYGK+irR2PQ42e2XXIKb9HlgAwecIXUzu9oLb9ltY+BqAS4VGnr
         V2IA==
X-Forwarded-Encrypted: i=1; AL+hErH4NIImA9WWe1VmM8S+VX+Lgkls5TaLL3n3nLhrQICNY1MGTup4YgbO2Tq9F7K3BFXY3pPF9A==@lists.infradead.org
X-Gm-Message-State: APuU4Z+diClHgV81a1CWtwaxSAldqGmbdrRkF9AUAD/D3k6i11MLJD/d
	dKawEc3LQt9YFveEe4DXXj8vIHBj7s/3HKEPDuawwQZpoaB+aSguEMDbkoIN8KFu/f5g3i8HQDX
	FE1EEmImOzU6EbbdJP4NuAM++t2KvEZjiGvwOo2A2JzIQytA4zsRCSJKEXlhdxlU=
X-Gm-Gg: AYBFou1PEcrIv0EtiuE0O8seUwpfDd3V4vDfQVvsQ5tXGXAdRu856tAW3r5aIy3Whqk
	3PSntkysajxV3t4eExVwLWb9Gmuvb00xf8c2YZNPaRONsdSPVqxmAmNK6iDEpa7GRxF3P2GUNXE
	+ItXSryT+qRwDQgPCRgIh8g0mp/MLO3twUwdS7tOPL94ifS6VsRhAcpvbzPns3262lhh5HN3UZr
	KN5YZJZW9vDabXyzhH8pa0KOkJWzsIxH3AYbFy62oouPKcZ6qybwRagPpEBhSGr+xvg3sakBllU
	iQwtPQgrKB1S+nXPhmlN/6bQqXzOSGmLZ9YoKYVP4AgiEykrxvcJ/Zvs4E6siMKcBmH5OqoaoOm
	lPYocfUwtugDi6lqWGX6Mdh0yP8k/rdy9pExeE/FgpDUPGaG5e+GdfA==
X-Received: by 2002:a05:701b:4354:b0:195:76af:b810 with SMTP id a92af1059eb24-1b5030bb5a3mr5117161c88.25.1794679656865;
        Sat, 14 Nov 2026 10:07:36 -0800 (PST)
X-Received: by 2002:a05:701b:4354:b0:195:76af:b810 with SMTP id a92af1059eb24-1b5030bb5a3mr5117132c88.25.1794679656105;
        Sat, 14 Nov 2026 10:07:36 -0800 (PST)
Received: from localhost ([188.253.117.185])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm24690685c88.9.2026.11.14.10.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 10:07:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 02:07:27 +0800
Message-Id: <DMV4U82NLDBL.2LTGJAM719DGM@oss.qualcomm.com>
Cc: "Song Shuai" <songshuaishuai@tinylab.org>,
        =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        "Han Gao"
 <gaohan@iscas.ac.cn>, "Jinjie Ruan" <ruanjinjie@huawei.com>,
        "Mike
 Rapoport" <rppt@kernel.org>,
        "Baoquan He" <baoquan.he@linux.dev>, "Guo Ren"
 <guoren@kernel.org>,
        <kexec@lists.infradead.org>, "Cong Wang"
 <cwang@multikernel.io>,
        "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH] riscv: kexec_file: Keep segments out of the new
 kernel's PMD padding
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Cong Wang" <xiyou.wangcong@gmail.com>, <linux-kernel@vger.kernel.org>,
        "Paul Walmsley" <pjw@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
        <linux-riscv@lists.infradead.org>
X-Mailer: aerc 0.22.0.r39.g5d778487
References: <20261114034901.107028-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20261114034901.107028-1-xiyou.wangcong@gmail.com>
X-Authority-Analysis: v=2.4 cv=ItKL47/g c=1 sm=1 tr=0 ts=6af8a36a cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=IMt4O7P0LTl0bQ2OADMA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA3MiBTYWx0ZWRfXzTmIh3cziEdI
 kKzX1O8sGGSh675WyFDTgY8Jd9YdvJlzCI758iKBF66JhZ/Cn+w/Nvu4SbIyw3LFTmSQC08W+Um
 TZfG8zb0BXlzYIQ5MmO/DEza3rJLL2c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA3MiBTYWx0ZWRfXzdcXpfvxE95i
 FM0hNXHoqLvU3eofDygxxQCEIdCEcs1cKcKsUN7lrPKEOVbt0pfypehMzMovz3WcSNdf8wBfwgz
 nXTIuXR/iaMnsrsZvEWmhFUVyDwtnVex9fjMr2ownxcPwlmHJ/dKEWnc42sm9RElluQpLvUVLAa
 CxbGLa4kcLJvhag/YN/1ksrW42H8R+oV4h8JFVHsPW/vQAmWl0t9U+0gIjkboNSFRVKYF8p521l
 aKc4FCeNmdCLDQz3NOyA/DMzGYOwbl4ntM/GHCOsFosVStpolc2lhB1e6ZkMSv/BveuqTPuwCjb
 7pCcX7Ss544nNhaRyGzD9XajD4M5u1P0kxW54u0FKH1YnSX4+o+KgQpKwaXiVm5uCiyxpLDdA7U
 yjDXAwdbkR2PHsKeM6aYnubLFpOlxRFiTSzx9VyslNBQn5ElxzAqjWVMYY9yV7NUajM5RticILf
 fRSaCx/4DuYRmqxxBrA==
X-Proofpoint-ORIG-GUID: Dho2Twy7t1kLRXwWkuv66o1PC_kUuRUh
X-Proofpoint-GUID: Dho2Twy7t1kLRXwWkuv66o1PC_kUuRUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611140072
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_100739_724500_BF1E0893 
X-CRM114-Status: GOOD (  26.76  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Nov 14, 2026 at 11:49 AM CST, Cong Wang wrote:
> From: Cong Wang <cwang@multikernel.io>
>
> A 64-bit kernel with STRICT_KERNEL_RWX reserves itself up to the next
> PMD boundary past _end in setup_bootmem(). load_extra_segments() only
> keeps the other segments above kernel_start + kernel_len, which is the
> unaligned _end of the new kernel, so they may be placed in that padding.
>
> The segments are placed top-down, which normally keeps them far from
> the kernel. A kdump kernel's segments are confined to the crashkernel
> region though, and when it has little room to spare, the lowest of
> them, the initrd and the device tree, end up in the padding. The kdump
> kernel then finds its initrd in memory it reserved for itself, drops
> it, and panics without a root file system:
>
>   crashkernel reserved: 0x000000017be00000 - 0x000000017fe00000 (64 MB)
>   Loaded kernel at 0x17be00000 bufsz=3D0x1c40600 memsz=3D0x1cb1000
>   Loaded initrd at 0x17db58000
>   ...
>   Starting crashdump kernel...
>   INITRD: 0x17db58000+0x022a4000 overlaps in-use memory region
>   ...
>   Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-blo=
ck(0,0)
>
> The load itself succeeds, so this only shows once the system crashes.
>
> The kernel being loaded may be any version or configuration that
> reserves the padding, so the loader has to keep clear of it. Start the
> other segments at the next PMD boundary. A crashkernel region too small
> for them now fails the load with -EADDRNOTAVAIL, and one with enough
> room boots the kdump kernel with its initrd.
>
> This was found while testing multikernel, which loads a kernel with
> kexec_file and hits the same overlap.

This catches insufficient space at load time rather than accepting a
layout that overlaps the target kernel's PMD padding and fails at boot.

Tested on an OrangePi RV2 (SpacemiT K1), using zero-padded initrds to
exercise the following cases:

1. With sufficient space, the patched loader boots the capture kernel
   and runs its initramfs /init.
2. Without the patch, a tight crash reservation accepts an unsafe
   layout; the capture kernel reports the initrd overlap and panics.
3. With the patch, the same tight configuration fails at load time
   with EADDRNOTAVAIL.

Tested-by: Ze Huang <ze.huang@oss.qualcomm.com>
Reviewed-by: Ze Huang <ze.huang@oss.qualcomm.com>

>
> Fixes: 809a11eea8e8 ("riscv: kexec_file: Support loading Image binary fil=
e")
> Signed-off-by: Cong Wang <cwang@multikernel.io>
> ---
>  arch/riscv/kernel/machine_kexec_file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/m=
achine_kexec_file.c
> index 26cd2a8bd0cd..0d2d43a7dbfa 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -251,7 +251,8 @@ int load_extra_segments(struct kimage *image, unsigne=
d long kernel_start,
>  	char *modified_cmdline =3D NULL;
> =20
>  	kbuf.image =3D image;
> -	kbuf.buf_min =3D kernel_start + kernel_len;
> +	/* The new kernel reserves itself up to the next PMD boundary */
> +	kbuf.buf_min =3D ALIGN(kernel_start + kernel_len, PMD_SIZE);
>  	kbuf.buf_max =3D PFN_PHYS(max_low_pfn);
> =20
>  #ifdef CONFIG_CRASH_DUMP



