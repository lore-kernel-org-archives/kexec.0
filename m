Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3774CC982FA
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i6sXuJju1VSKZUvWu8ItDIKa9ytfMiVRqIfIDXcBB7A=; b=OBYYsW32YTazDp2s7DgOutul5T
	iaC69+3wFEn6Xi5mrDDA/DZKIWF7wiDp+H/vEdjy3lVxFYEjUvp+itkbxY2BIOq6iq/nV+7BCh1KT
	54VUX675G3NvuHcnRNNYhqmh8r7Zi8K4TfC6N0tGo1NcHuekKlpRmP2r9kaWK+zApBljdznMTWL9Z
	RofmgTgeRoc0KiMnvcWHiXvdW8x8VjXieXHJQtbmd3OOkKPu4fzBxLiZMhW4GEuGl5PlMYbgmsYss
	2tD8AtTX53NkXX7veHkpskBQBFbUJtWqhGpDcL4HNAqibCAyoRH97OFbNMPdDJoTr4KuY01Ergao2
	JSlCklpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8adF-00000001Zjh-2pK4;
	Mon, 21 Sep 2026 09:48:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8aAe-00000001U31-2ctm;
	Mon, 21 Sep 2026 09:18:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ECE2A601F0;
	Mon, 21 Sep 2026 09:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62E51F000FF;
	Mon, 21 Sep 2026 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982323;
	bh=i6sXuJju1VSKZUvWu8ItDIKa9ytfMiVRqIfIDXcBB7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpMRtO3XO2GapTLkFUCcMIQO2en5kmpXBA4JYaMPBwGnEJuTstZIo7j0l4PWritAn
	 9u4JDzqtwga5Ei3ZSZYEoAQSDyXHKw14UdRV5C4ajSkSzWY0Bf0LsUubpasTPxq29n
	 3DYgHM2BevLJFJt6UQT1E4bAlfEXvnYZDJYE1sb7WJAcQ0Zsy8OZ2EHBS9ZramShzy
	 ClIIKnDpNdguDyQrBNjMx7ocj55eUIakg+mQrcszOm8acgYOlzjGh++FFvu11XbImq
	 pm8VkovoNL1fLidqLycOZCPmnllepGBjda3TcVif4j1rNnCz+DvXxWXkOXw6+r3kcQ
	 xX+B0P6TasoHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/14] arm64: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: guodongtai@kylinos.cn, linux-arm-kernel@lists.infradead.org, yeoreum.yun@arm.com, mclapinski@google.com, ruirui.yang@linux.dev, eric.devolder@oracle.com, hbathini@linux.ibm.com, kernel@xen0n.name, piliu@redhat.com, thuth@redhat.com, ritesh.list@gmail.com, tglx@kernel.org, mpe@ellerman.id.au, x86@kernel.org, takahiro.akashi@linaro.org, akpm@linux-foundation.org, chenhuacai@kernel.org, rppt@kernel.org, catalin.marinas@arm.com, bp@alien8.de, pasha.tatashin@soleen.com, maddy@linux.ibm.com, driver-core@lists.linux.dev, dave.hansen@linux.intel.com, vishal.l.verma@intel.com, bgwin@google.com, npiggin@gmail.com, chleroy@kernel.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, mark.rutland@arm.com, leitao@debian.org, james.morse@arm.com, maqianga@uniontech.com, rafael@kernel.org, sshegde@linux.ibm.com, jbouron@amazon.com, me@linux.beauty, pratyush@kernel.org, palmer@rivosinc.com, linux-kernel@vger.kernel.org, baoquan.he@linux.dev, gregkh@linuxfoundation.org, mingo@redhat.com, zhangtianyang@loongson.cn, hpa@zytor.com, chao.gao@intel.com, kai.huang@intel.com, tangyouling@kylinos.cn, coxu@redhat.com, dakr@kernel.org, kees@kernel.org, graf@amazon.com, linuxppc-dev@lists.ozlabs.org, robh@kernel.org, will@kernel.org, sourabhjain@linux.ibm.com, liukexin@kylinos.cn, seanjc@google.com, loongarch@lists.linux.dev
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-5-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:18:40 +0000
Message-Id: <20260921091840.C62E51F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Mon, 21 Sep 2026 02:47:56 -0700
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: kexec_file_load infinite loop due to unconstrained CMA retry
--

commit 897e1cdce0bd14dc7b700f2043c1f14c66a40791
Author: Jinjie Ruan <ruanjinjie@huawei.com>

arm64: kexec_file: Fix CMA page leaks in segment placement retry loops

This commit fixes a memory leak in the kexec image placement retry loop.
It explicitly releases the associated CMA buffers in the failure paths
before the segment count is reduced.

> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_im=
age.c
> index b70f4df15a1ae..ffcb7f9075e62 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -107,6 +107,7 @@ static void *image_load(struct kimage *image,
>  		 * We couldn't find space for the other segments; erase the
>  		 * kernel segment and try the next available hole.
>  		 */
> +		kexec_free_segment_cma(image, kernel_segment_number);
>  		image->nr_segments -=3D 1;
>  		kbuf.buf_min =3D kernel_segment->mem + kernel_segment->memsz;
>  		kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;

[Severity: High]
Does freeing the CMA segment here create an infinite loop?

The loop updates kbuf.buf_min to search past the current kernel segment
expecting the next kexec_add_buffer() call to allocate from a new hole.

However, kexec_alloc_contig() allocates via CMA:

kernel/kexec_file.c:kexec_alloc_contig() {
    ...
    p =3D dma_alloc_from_contiguous(NULL, nr_pages,
                                  get_order(kbuf->buf_align), true);
    ...
}

The underlying CMA allocator completely ignores kbuf->buf_min and
kbuf->buf_max. Since the CMA block was just freed, the allocator will
repeatedly return the exact same physically contiguous block.=20

If load_other_segments() fails due to layout constraints (like dtb or
initrd placement), it will run again with the identical memory layout, fail
for the exact same reason, and loop infinitely causing a system hang.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D4

