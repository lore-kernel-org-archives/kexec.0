Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B88D0E6E1
	for <kexec@archiver.kernel.org>; Mon, 21 Oct 2024 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CvmYDO1xhPy+zhgeDXNpkGK8iU8BHpPj89vtw+inlmM=; b=r8OP8b3QEQ2APC
	X1IzBKFzAebSSPd5ED9JfC77F1xajcSDJK/WEhgvemEWXQBARUWa3dhoXpnvvJ7HBOwb7indhtRbd
	agZktF8UJazafXfjd2th0Vr7OhtWy3tx7lCmMxov3i83+JOBho6QuWyTEui1rpjPJQFFa66xb7bxX
	zCeCGgrVXoJTHl0cADdZ0wsEEApneUso1It8ewWfmcIYCoto7oAZDAd617r33Xgq6DrnoEJOHUKN4
	NM8x56Ms1NfCo/GyF4nY/CyZ22uyzvDQjirmuFjNCH98AYLaUbnH15PWaYDsO1W/jW+uYIOf/dL4W
	zklJBS3VLz6tJsiX8vJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pYP-00000006s0m-1XUn;
	Mon, 21 Oct 2024 10:22:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pWF-00000006rlK-1QcF
	for kexec@lists.infradead.org;
	Mon, 21 Oct 2024 10:20:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3DD605C588A;
	Mon, 21 Oct 2024 10:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D158C4CEE5;
	Mon, 21 Oct 2024 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729506010;
	bh=ngk37yQeUvZXNyvnHFj3uG5cbWkiYI7NIYTJoMkA0lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGYY58XmmzHPNIh95j70+98noRn+lgMrgq7EL3sGOnjfJtcrQkegAHw60F8MbPHo+
	 3nzzQkYt6EisOyFQCx3eBZVpbqGKy0cjrLRtgfMKPChgtHGy7NhBZQ9sQcth0fc3o9
	 BIYeUbtTBvrV1E2f/sDG0eqywfTznjocprkMRI9uihdQGlvgn/SFubwIPJsPt7w+bf
	 rsnF/2tofEyd2PrMSfB3eQxU7PawUDJH2cixV4tUdfMA9MSHHeNoHu3bHnENd9RoJy
	 Bk0jQ/7u+nDEUgn8fE9SDvw4h+edSSEwZlBwFEDbSRQJu5x4QRQOtuTJcd7rY8S394
	 CKbiOPzg8qHNg==
Date: Mon, 21 Oct 2024 11:20:05 +0100
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	kexec@lists.infradead.org
Subject: Re: [PATCHv2 0/3] kexec: Add support for UKI format kernel
Message-ID: <20241021102005.GB402847@kernel.org>
References: <20241016113418.22568-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241016113418.22568-1-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_032011_444348_0FFDA3C7 
X-CRM114-Status: GOOD (  12.98  )
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

On Wed, Oct 16, 2024 at 07:34:12PM +0800, Pingfan Liu wrote:
> As a UEFI PE format kernel image becomes more popular, there is a need
> for kexec to reboot those kinds of images.
> 
> After the introduction of the UKI (another PE), at present, there are
> three competitive methods to support that goal, but all of them have
> pros and cons.[1] It seems that none of them can be accepted in the near
> future.  Therefore, we are resorting to the user space kexec-tools to
> parse the UKI format for the time being.
> 
> By parsing the UKI, systemd-stub is stepped around and PCM will not affect
> the boot up of the second system.
> 
> [1]: https://github.com/rhkdump/kexec_uefi/blob/main/overview.md#the-competitive-solutions

Thanks,

Series applied.

Please see my request for a follow-up for patch 2/3 [1].

[1] https://lore.kernel.org/kexec/20241021101646.GA402847@kernel.org/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
