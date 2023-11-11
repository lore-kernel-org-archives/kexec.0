Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21015C4332F
	for <kexec@archiver.kernel.org>; Sat, 11 Nov 2023 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GwS2GWsWXbkFgGlT129G2uExs1kl9OKUd59x+rzuxAc=; b=UVdGJnRG19MFPy
	oH+Gn8hKycuMutND03TsclQu+AaXBXlUCL9hIWuWxiS5F/ttKNFcFVvZpQuXQTmMZ/hUhLO8V6u1m
	BU23VuitIkjP+08jW1vkDij32RKrOcasQRurcVTnfSJe07ca+r9zSj31NyEmjAdIq2jfczK/tpIgH
	PnjMzIOZ5OwvIeJtRncEP4Lky/XKd2NR1wKhNakZ/fVDcH0I/JO3bJDJbnrD5rPJN87N584HVAXbk
	q7XjocImdpY2mtHyyOfTmJ0/VSyHYzjsi2PDcKGGFjAGUXki/jFkk68KbAVUm+50dFkwU8MicQgEQ
	mmaWW6qd5s+yx7IyKOkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1s2G-00BDbF-2Y;
	Sat, 11 Nov 2023 17:44:44 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1s2D-00BDaX-2r
	for kexec@lists.infradead.org;
	Sat, 11 Nov 2023 17:44:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 48C54B81236;
	Sat, 11 Nov 2023 17:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23891C433C7;
	Sat, 11 Nov 2023 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699724677;
	bh=6Edi0vC9LiOgbsxo7Eus18euFKTCuNPbb5omqvA3nIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0LfvHwwqV91pqUaZR5D96C/DUoNEis+eOARQ0Xgo0xy5aZNDZZuJdWIZDcwbiP6B
	 qeqhm3w+sQPudByElpCEYTv86EmHFa3eq+DBgp3Vq6bqCdpu7fnUs08NRmmzlAjJtT
	 DwJybcieV1EKhXwAJzKJFXa7LxNNHot5wL/Qy7hJW/ng8MzDfhFgCh5/z6OH24aSo1
	 UYqU4tgm2Iemih3nAIIU+YfX7fH/42plr0qBg7+v9BzDY1nayemfduvJ9W8YU2T03n
	 dBagxMEFrwONmbcLz9LreJwMDub/X5lYyZ3tG2ecHa/8tHxRI9K+d9DgX2QS4yEK0j
	 tV4v1mfzeeHqg==
Date: Sat, 11 Nov 2023 09:44:35 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v7 06/13] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20231111174435.GA998@sol.localdomain>
References: <20231110222751.219836-1-ross.philipson@oracle.com>
 <20231110222751.219836-7-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231110222751.219836-7-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231111_094442_096897_9AD558B8 
X-CRM114-Status: UNSURE (   7.11  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Nov 10, 2023 at 05:27:44PM -0500, Ross Philipson wrote:
>  arch/x86/boot/compressed/early_sha1.c   | 12 ++++
>  lib/crypto/sha1.c                       | 81 +++++++++++++++++++++++++

It's surprising to still see this new use of SHA-1 after so many people objected
to it in the v6 patchset.  It's also frustrating that the SHA-1 support is still
being obfuscated by being combined in one patch with SHA-2 support, perhaps in
an attempt to conflate the two algorithms and avoid having to give a rationale
for the inclusion of SHA-1.  Finally, new functions should not be added to
lib/crypto/sha1.c unless those functions have multiple users.

- Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
