Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B7BC5DF81
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q1ljl4cz56ii5aPmEh0p+/B4T88PoXWLCILEreXEYY0=; b=cMVkQLbVytUcm7WvJ+7Wr3pEQz
	gnOpU1lM36phVKnmNPv6ulwkviUCJo83Y7cFp5c2DI3i9woBjFhvOr7e593j1xqfRAzBCw6lrNq4r
	xINBs5WX5JcepSCh/WqTmyl6Il+QL1pnf4gA5RBRXgLMH6jYTdKX1rpY5NcWvJvMiyWyVNCLjr7mf
	gUnYIAJE+9CQt0jd0BzLLG3p21Ptg8uW4b8H8V4p3iWVWEstqBYHSfHQv+WogFeAhl2u0yvVoOVNb
	9amwN4T0EkrBiyoNYAm8jQti4eHlYVsXlQ1ntvFqVD35rgrZ6tLGsfd+jkOkZMdeVk/QfiIVGrEUp
	TO8iFNDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx7C5-0000000C0zb-3CEI;
	Thu, 20 Aug 2026 18:08:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx7C4-0000000C0zN-2B93;
	Thu, 20 Aug 2026 18:08:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DAEBE40526;
	Thu, 20 Aug 2026 18:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BD01F000E9;
	Thu, 20 Aug 2026 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787249327;
	bh=Q1ljl4cz56ii5aPmEh0p+/B4T88PoXWLCILEreXEYY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DpeQzaY1MvfM6dZTH/+yddWLJh5BvqpeaOdNnVIoPbjkcLgbNv4xUX5XKLpwz198R
	 Mpkaq94EpVdGZ9ebfp6nIELSeGFnkvGMKsCbVb872lHcJSOHsfYPc9fW/xC9ie0tm0
	 lGo8oVkNkeONksK79F2+xNkEhlwqF9xrfKRpDlIM47S5YbOECIuTbvucsW/Uwengxm
	 pmnKRVjNpMxjhNkh2mJS16ZEYtMTXVV3dAV/H6Qe8D7WhK9thXOYqUTGk/bVS5AbkR
	 lCGbe6ESXOR423vvLyFXRQ8QU/JS4WymEY2f4DpLIl3nSBX0Es+D/jyyzBU6pPNMOh
	 ces9hPevHWuUg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  Huacai Chen
 <chenhuacai@kernel.org>,  WANG Xuerui <kernel@xen0n.name>,  Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <baoquan.he@linux.dev>,  Mike
 Rapoport <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Tao Liu <ltao@redhat.com>,
  Philipp Rudo <prudo@redhat.com>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  loongarch@lists.linux.dev,
  linux-riscv@lists.infradead.org,  kexec@lists.infradead.org
Subject: Re: [PATCH v2 2/2] kexec: fix error propagation in
 kexec_image_probe_default()
In-Reply-To: <20260819-mpilaniy-v2-2-95e929ede0e5@redhat.com> (Mukesh
	Pilaniya's message of "Wed, 19 Aug 2026 23:17:23 +0530")
References: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
	<20260819-mpilaniy-v2-2-95e929ede0e5@redhat.com>
Date: Thu, 20 Aug 2026 20:08:42 +0200
Message-ID: <2vxzmrugzmtx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Aug 19 2026, Mukesh Pilaniya wrote:

> kexec_image_probe_default() overwrites ret with each loader's probe
> return value and returns whatever the last loader returned when no
> probe matches.  The error code reaching userspace depends on whichever
> loader happens to be last in kexec_file_loaders[].
>
> Only continue to the next loader when a probe returns -ENOEXEC.
> Propagate any other error such as -ENOMEM immediately. Return -ENOEXEC
> only when all loaders have been tried and none matched.
>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

