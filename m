Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8FBD1266D
	for <kexec@archiver.kernel.org>; Wed,  3 Dec 2025 04:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1yfFnHd2O+ey2emx3WNvhy/8c1cT+0ZPEU9nVgrRa10=; b=A962gTQftkeXiqj0+FVY3PnCR5
	LDAutosL0nwqKKBQmYl6lncn9EGs90IVa6HNCbv43VDwq+goi/Ki426BRId7j1AGyOP65CG2ciU8Y
	Hakn9rF+EZtbpA6J5s6hNrEufW5+F21N9fAN7MIUmguPk/669xUkn7mUByWcy2A9vvsHK/UbU8TTs
	Egf/6yBZTzZE0UQJcjEOb9qfca8UtlfOVpNLGhu32KRSWrn9k4FRHeHuTgYia5Xey7dDS+1ZxlCAE
	B/wHwoI4ZZHY86/06vx7xdMcWeP6uRiE7X/CMSI43RsIgavQJ1UVH2Wb6lI5DQlElWgAIDpbPpD78
	uIWzdWWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQeOU-000000066kk-2UDs;
	Wed, 03 Dec 2025 04:23:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQeOR-000000066kD-2y6z
	for kexec@lists.infradead.org;
	Wed, 03 Dec 2025 04:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764735783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yfFnHd2O+ey2emx3WNvhy/8c1cT+0ZPEU9nVgrRa10=;
	b=AJCMM/Vmf5SIMUFR0Bj/HlTB0vvdn2Vb5v9BLuXtJTy53M1jGPvvM9pl/If+xk5Sf4egjt
	R9yK1mSQ9PWgsroyJCnLNdRY1JajHhpo3Jb1Gs5H2yf3LjYJ+4rm5Gx2c+DikfPePAlVgT
	twGglE5n+/06UXw5Ud51KzFER/mahkk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-jA2hFMAfNweXjluk8IpZmQ-1; Tue, 02 Dec 2025 23:22:59 -0500
X-MC-Unique: jA2hFMAfNweXjluk8IpZmQ-1
X-Mimecast-MFC-AGG-ID: jA2hFMAfNweXjluk8IpZmQ_1764735778
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so9067690a12.0
        for <kexec@lists.infradead.org>; Tue, 02 Dec 2025 20:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764735778; x=1765340578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1yfFnHd2O+ey2emx3WNvhy/8c1cT+0ZPEU9nVgrRa10=;
        b=a+jzap0In+gsW1KvIdsVii91zCOXLi6NPRiKb847P4N5WjOkFrBUaU9sPC6BoLF4n8
         +xiv1M96gVNbbcForJLCbmV9omj945L7lvG2LMQxud7VksVxjriXORP8KVlyogFvYjVj
         yOdjF1D0QBQVJ3m9y4Qv+P2kg3xfzeLQXU7DWCPyJa7M5X5eZIm65u4OwaFSfxekfZmY
         ygVMLUXm970ZE01g0LHxoEBdERWBP18aErT3Ez00w3w48CUxVn/P+46bY45EBlU9Q/GM
         2s0MucAkDdk1MmZDQCB54EHkMIrN4VbeeSd64tkLZcDbkKIYC9EMgU3hEWzNINJ8SIog
         SogQ==
X-Gm-Message-State: AOJu0YzlfK4+Q6Hq1XjX+/2cpFOLiD65kOJtPDAVMdBuYQBHNkmkEsB3
	yxenoQgEZAoH+vR2Jw35USup8/BBWjlG4cQPh0PkjVJ+kA4FCk1KC7Q2K9UGVmHKWc6yVlwUvwX
	2ALPxjhPQhcI+v+aNQ4NdOCR/GHVtOebYt86mARbR5KBtDkUN+cSTZamLa45xSCuFrz7rVaEzrp
	vDaVF8tQKUeOOBB6oQKSrsDnI2i1GOSSICungH
X-Gm-Gg: ASbGnctEVcbQUv0qyJNFZ1Ud9o6tFGEsxeO0Rddm+OF24RKiFuzhAm8g3yhRz+b1lZv
	N6Jnc9otE3ddskLzmsxYDzoi4GIw9YvJgkStLmSZmgOuFcZHffLag4dPv1TzwAi1x+29U3XdVtT
	zUkFEqFQ9SjE9vxpBniV3MiYP+caAdrRW9FKgz6CV7wR5UTxB02h8yK6gwGu1ydmsMaMM=
X-Received: by 2002:a05:7300:f281:b0:2ab:91dc:d701 with SMTP id 5a478bee46e88-2ab92f195e4mr450766eec.39.1764735778066;
        Tue, 02 Dec 2025 20:22:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7VqST5QJw9x0kBhY53kwUi1JXZ5wZx+5tD4beg/EIoQFy8J3rlOz7jGyncv6OcXzTT/3QMsUeGu1pLXctdzk=
X-Received: by 2002:a05:7300:f281:b0:2ab:91dc:d701 with SMTP id
 5a478bee46e88-2ab92f195e4mr450759eec.39.1764735777553; Tue, 02 Dec 2025
 20:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20251106065904.10772-1-piliu@redhat.com> <aSZTb1X26MjSZIzF@MiWiFi-R3L-srv>
In-Reply-To: <aSZTb1X26MjSZIzF@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 3 Dec 2025 12:22:46 +0800
X-Gm-Features: AWmQ_bm207_WeFuiCeBVVgYCRxYqLrcwMMzkOfXhkuky7XbX8n5SIigipYu_CIU
Message-ID: <CAF+s44S2_DG92dJAGX8GZdc-OgOz1a7E+ScbyOGcG85QayBS1w@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of kimage_map_segment()
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cJ52VKozwoGRZRKPst5mCTTvRmde08m2DERBLal-xT4_1764735778
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_202307_913869_D1B3086E 
X-CRM114-Status: GOOD (  29.75  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Baoquan,

On Wed, Nov 26, 2025 at 9:10=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Pingfan,
>
> On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > The kexec segment index will be required to extract the corresponding
> > information for that segment in kimage_map_segment(). Additionally,
> > kexec_segment already holds the kexec relocation destination address an=
d
> > size. Therefore, the prototype of kimage_map_segment() can be changed.
>
> Because no cover letter, I just reply here.
>
> I am testing code of (tag: next-20251125, next/master) on arm64 system.
> I saw your two patches are already in there. When I used kexec reboot
> as below, I still got the warning message during ima_kexec_post_load()
> invocation.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> kexec -d -l /boot/vmlinuz-6.18.0-rc7-next-20251125 --initrd /boot/initram=
fs-6.18.0-rc7-next-20251125.img --reuse-cmdline
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

"I have used the Fedora 42 server and its config file to reproduce the
issue you reported here. However, I cannot reproduce it with my patch.
Instead, if I revert my patch, I can see the warning again.

I suspect that you observed the warning thrown by the original Fedora
42 kernel instead of mine.

You need to kexec-reboot into vmlinuz-6.18.0-rc7-next-20251125, and at
that point, try 'kexec -d -l /boot/vmlinuz-6.18.0-rc7-next-20251125
--initrd /boot/initramfs-6.18.0-rc7-next-20251125.img
--reuse-cmdline'.

If this is a false alarm, I will rewrite the commit log and send out v3.


Thanks,

Pingfan

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [34283.657670] kexec_file: kernel: 000000006cf71829 kernel_size: 0x48b000=
0
> [34283.657700] PEFILE: Unsigned PE binary
> [34283.676597] ima: kexec measurement buffer for the loaded kernel at 0xf=
f206000.
> [34283.676621] kexec_file: Loaded initrd at 0x84cb0000 bufsz=3D0x25ec426 =
memsz=3D0x25ed000
> [34283.684646] kexec_file: Loaded dtb at 0xff400000 bufsz=3D0x39e memsz=
=3D0x1000
> [34283.684653] kexec_file(Image): Loaded kernel at 0x80400000 bufsz=3D0x4=
8b0000 memsz=3D0x48b0000
> [34283.684663] kexec_file: nr_segments =3D 4
> [34283.684666] kexec_file: segment[0]: buf=3D0x0000000000000000 bufsz=3D0=
x0 mem=3D0xff206000 memsz=3D0x1000
> [34283.684674] kexec_file: segment[1]: buf=3D0x000000006cf71829 bufsz=3D0=
x48b0000 mem=3D0x80400000 memsz=3D0x48b0000
> [34283.725987] kexec_file: segment[2]: buf=3D0x00000000c7369de6 bufsz=3D0=
x25ec426 mem=3D0x84cb0000 memsz=3D0x25ed000
> [34283.747670] kexec_file: segmen
> ** replaying previous printk message **
> [34283.747670] kexec_file: segment[3]: buf=3D0x00000000d83b530b bufsz=3D0=
x39e mem=3D0xff400000 memsz=3D0x1000
> [34283.747973] ------------[ cut here ]------------
> [34283.747976] WARNING: CPU: 33 PID: 16112 at kernel/kexec_core.c:1002 ki=
mage_map_segment+0x138/0x190
> [34283.778574] Modules linked in: rfkill vfat fat ipmi_ssif igb acpi_ipmi=
 ipmi_si ipmi_devintf mlx5_fwctl i2c_algo_bit ipmi_msghandler fwctl fuse lo=
op nfnetlink zram lz4hc_compress lz4_compress xfs mlx5_ib macsec mlx5_core =
nvme nvme_core mlxfw psample tls nvme_keyring nvme_auth pci_hyperv_intf sbs=
a_gwdt rpcrdma sunrpc rdma_ucm ib_uverbs ib_srpt ib_isert iscsi_target_mod =
target_core_mod ib_iser i2c_dev ib_umad rdma_cm ib_ipoib iw_cm ib_cm libisc=
si ib_core scsi_transport_iscsi aes_neon_bs
> [34283.824233] CPU: 33 UID: 0 PID: 16112 Comm: kexec Tainted: G        W =
          6.17.8-200.fc42.aarch64 #1 PREEMPT(voluntary)
> [34283.836355] Tainted: [W]=3DWARN
> [34283.839684] Hardware name: CRAY CS500/CMUD        , BIOS 1.4.0 Jun 17 =
2020
> [34283.846903] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [34283.854243] pc : kimage_map_segment+0x138/0x190
> [34283.859120] lr : kimage_map_segment+0x4c/0x190
> [34283.863920] sp : ffff8000a0643a90
> [34283.867394] x29: ffff8000a0643a90 x28: ffff800083d0a000 x27: 000000000=
0000000
> [34283.874901] x26: 0000aaaad722d4b0 x25: 000000000000008f x24: ffff80008=
3d0a000
> [34283.882608] x23: 0000000000000001 x22: 00000000ff206000 x21: 00000000f=
f207000
> [34283.890305] x20: ffff008fbd306980 x19: ffff008f895d6400 x18: 00000000f=
ffffff9
> [34283.897815] x17: 303d6d656d206539 x16: 3378303d7a736675 x15: 646565732=
d676e72
> [34283.905516] x14: 00646565732d726c x13: 616d692c78756e69 x12: 6c0063657=
8656b2d
> [34283.912999] x11: 007265666675622d x10: 636578656b2d616d x9 : ffff80008=
050b73c
> [34283.920691] x8 : 0001000000000000 x7 : 0000000000000000 x6 : 000000008=
0000000
> [34283.928197] x5 : 0000000084cb0000 x4 : ffff008fbd2306b0 x3 : ffff008fb=
d305000
> [34283.935898] x2 : fffffff7ff000000 x1 : 0000000000000004 x0 : ffff80008=
2046000
> [34283.943603] Call trace:
> [34283.946039]  kimage_map_segment+0x138/0x190 (P)
> [34283.950935]  ima_kexec_post_load+0x58/0xc0
> [34283.955225]  __do_sys_kexec_file_load+0x2b8/0x398
> [34283.960279]  __arm64_sys_kexec_file_load+0x28/0x40
> [34283.965965]  invoke_syscall.constprop.0+0x64/0xe8
> [34283.971025]  el0_svc_common.constprop.0+0x40/0xe8
> [34283.975883]  do_el0_svc+0x24/0x38
> [34283.979361]  el0_svc+0x3c/0x168
> [34283.982833]  el0t_64_sync_handler+0xa0/0xf0
> [34283.987176]  el0t_64_sync+0x1b0/0x1b8
> [34283.991000] ---[ end trace 0000000000000000 ]---
> [34283.996060] ------------[ cut here ]------------
> [34283.996064] WARNING: CPU: 33 PID: 16112 at mm/vmalloc.c:538 vmap_pages=
_pte_range+0x2bc/0x3c0
> [34284.010006] Modules linked in: rfkill vfat fat ipmi_ssif igb acpi_ipmi=
 ipmi_si ipmi_devintf mlx5_fwctl i2c_algo_bit ipmi_msghandler fwctl fuse lo=
op nfnetlink zram lz4hc_compress lz4_compress xfs mlx5_ib macsec mlx5_core =
nvme nvme_core mlxfw psample tls nvme_keyring nvme_auth pci_hyperv_intf sbs=
a_gwdt rpcrdma sunrpc rdma_ucm ib_uverbs ib_srpt ib_isert iscsi_target_mod =
target_core_mod ib_iser i2c_dev ib_umad rdma_cm ib_ipoib iw_cm ib_cm libisc=
si ib_core scsi_transport_iscsi aes_neon_bs
> [34284.055630] CPU: 33 UID: 0 PID: 16112 Comm: kexec Tainted: G        W =
          6.17.8-200.fc42.aarch64 #1 PREEMPT(voluntary)
> [34284.067701] Tainted: [W]=3DWARN
> [34284.070833] Hardware name: CRAY CS500/CMUD        , BIOS 1.4.0 Jun 17 =
2020
> [34284.078238] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [34284.085546] pc : vmap_pages_pte_range+0x2bc/0x3c0
> [34284.090607] lr : vmap_small_pages_range_noflush+0x16c/0x298
> [34284.096528] sp : ffff8000a0643940
> [34284.100001] x29: ffff8000a0643940 x28: 0000000000000000 x27: ffff80008=
4f76000
> [34284.107699] x26: fffffdffc0000000 x25: ffff8000a06439d0 x24: ffff80008=
2046000
> [34284.115174] x23: ffff800084f75000 x22: ffff007f80337ba8 x21: 03fffffff=
fffffc0
> [34284.122821] x20: ffff008fbd306980 x19: ffff8000a06439d4 x18: 00000000f=
ffffff9
> [34284.130331] x17: 303d6d656d206539 x16: 3378303d7a736675 x15: 646565732=
d676e72
> [34284.138032] x14: 0000000000004000 x13: ffff009781307130 x12: 000000000=
0002000
> [34284.145733] x11: 0000000000000000 x10: 0000000000000001 x9 : ffff80008=
04e197c
> [34284.153248] x8 : 0000000000000027 x7 : ffff800085175000 x6 : ffff8000a=
06439d4
> [34284.160944] x5 : ffff8000a06439d0 x4 : ffff008fbd306980 x3 : 006800000=
0000f03
> [34284.168449] x2 : ffff007f80337ba8 x1 : 0000000000000000 x0 : 000000000=
0000000
> [34284.176150] Call trace:
> [34284.178768]  vmap_pages_pte_range+0x2bc/0x3c0 (P)
> [34284.183665]  vmap_small_pages_range_noflush+0x16c/0x298
> [34284.189264]  vmap+0xb4/0x138
> [34284.192312]  kimage_map_segment+0xdc/0x190
> [34284.196794]  ima_kexec_post_load+0x58/0xc0
> [34284.201044]  __do_sys_kexec_file_load+0x2b8/0x398
> [34284.206107]  __arm64_sys_kexec_file_load+0x28/0x40
> [34284.211254]  invoke_syscall.constprop.0+0x64/0xe8
> [34284.216139]  el0_svc_common.constprop.0+0x40/0xe8
> [34284.221196]  do_el0_svc+0x24/0x38
> [34284.224678]  el0_svc+0x3c/0x168
> [34284.227983]  el0t_64_sync_handler+0xa0/0xf0
> [34284.232526]  el0t_64_sync+0x1b0/0x1b8
> [34284.236376] ---[ end trace 0000000000000000 ]---
> [34284.241412] kexec_core: Could not map ima buffer.
> [34284.241421] ima: Could not map measurements buffer.
> [34284.551336] machine_kexec_post_load:155:
> [34284.551354]   kexec kimage info:
> [34284.551366]     type:        0
> [34284.551373]     head:        90363f9002
> [34284.551377]     kern_reloc: 0x00000090363f7000
> [34284.551381]     el2_vectors: 0x0000000000000000
> [34284.551384] kexec_file: kexec_file_load: type:0, start:0x80400000 head=
:0x90363f9002 flags:0x8
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> >
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: <stable@vger.kernel.org>
> > To: kexec@lists.infradead.org
> > To: linux-integrity@vger.kernel.org
> > ---
> >  include/linux/kexec.h              | 4 ++--
> >  kernel/kexec_core.c                | 9 ++++++---
> >  security/integrity/ima/ima_kexec.c | 4 +---
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index ff7e231b0485..8a22bc9b8c6c 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
> >  #define kexec_dprintk(fmt, arg...) \
> >          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0=
)
> >
> > -extern void *kimage_map_segment(struct kimage *image, unsigned long ad=
dr, unsigned long size);
> > +extern void *kimage_map_segment(struct kimage *image, int idx);
> >  extern void kimage_unmap_segment(void *buffer);
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> > @@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *re=
gs) { }
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0=
; }
> >  static inline int kexec_crash_loaded(void) { return 0; }
> > -static inline void *kimage_map_segment(struct kimage *image, unsigned =
long addr, unsigned long size)
> > +static inline void *kimage_map_segment(struct kimage *image, int idx)
> >  { return NULL; }
> >  static inline void kimage_unmap_segment(void *buffer) { }
> >  #define kexec_in_progress false
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index fa00b239c5d9..9a1966207041 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int=
 idx)
> >       return result;
> >  }
> >
> > -void *kimage_map_segment(struct kimage *image,
> > -                      unsigned long addr, unsigned long size)
> > +void *kimage_map_segment(struct kimage *image, int idx)
> >  {
> > +     unsigned long addr, size, eaddr;
> >       unsigned long src_page_addr, dest_page_addr =3D 0;
> > -     unsigned long eaddr =3D addr + size;
> >       kimage_entry_t *ptr, entry;
> >       struct page **src_pages;
> >       unsigned int npages;
> >       void *vaddr =3D NULL;
> >       int i;
> >
> > +     addr =3D image->segment[idx].mem;
> > +     size =3D image->segment[idx].memsz;
> > +     eaddr =3D addr + size;
> > +
> >       /*
> >        * Collect the source pages and map them in a contiguous VA range=
.
> >        */
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/im=
a/ima_kexec.c
> > index 7362f68f2d8b..5beb69edd12f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
> >       if (!image->ima_buffer_addr)
> >               return;
> >
> > -     ima_kexec_buffer =3D kimage_map_segment(image,
> > -                                           image->ima_buffer_addr,
> > -                                           image->ima_buffer_size);
> > +     ima_kexec_buffer =3D kimage_map_segment(image, image->ima_segment=
_index);
> >       if (!ima_kexec_buffer) {
> >               pr_err("Could not map measurements buffer.\n");
> >               return;
> > --
> > 2.49.0
> >
>


