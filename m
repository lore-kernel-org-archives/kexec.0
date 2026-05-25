Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC70CD5BC9
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RU4mhDc8qVs92H5+4lAVgCVBlE9tWSHjhCyliyrIDc=; b=HnwLdd5zc2THbX1LvqNFSUOJ9X
	uS7I3DZabDDTKG6xySS9TsaDmd3uuFqR0pfrCqFCfMP6h+TAK9ayKiN+U2i0pWMSQqj2a7W26HRyR
	5JeuH5NKehOcOCRBeCFaeSr5HeBTMGzEbIkIhthd7DH0w9jhF0OHa2wjbQx8N4YlERDwv53homesY
	Rnc94Q4LLMRKYvrYzOe7MhMeCSjhe8227wczVu1RlgNngSi3g1alLnxwRtGSP4tTYmW3pMibUREtj
	q+JMJxEK436CBN7yjVkRG+tCBfohTyHn7qNlIFQdCUITMv6ZOAmYjAPRA71raVA85A8aKy2hGcu4V
	/yiteaJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXKw-0000000HXLq-1DbA;
	Mon, 25 May 2026 15:35:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXKu-0000000HXLk-0Qcv
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 15:35:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 49F64600AB;
	Mon, 25 May 2026 15:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D641F000E9;
	Mon, 25 May 2026 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723323;
	bh=4RU4mhDc8qVs92H5+4lAVgCVBlE9tWSHjhCyliyrIDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m9G55K0gx7YOL4cj4gOb2FGACR+7Bfe15lfJS/RfnYvFNkyHit4NSk1tP58/sP/tB
	 I6BOAYqUijW0t3roijovmeXpwe+RYWH4i0wH4oy+ac1ZmzLdvi66K+wjlpUQYpNELv
	 1lKvOPvFAcdMFR7xUTT8lv/k3BEsHVZjwLIy4VZsl7ih4LD+H4fnh6ZTddSBJ7KQJw
	 tzMDh6byuS6tJ5F0VQVYeWFeuc/ElBGk2PStD2NUvnfeS5t3Zrq8qkwLCKvMmrrO5Z
	 fErvA3e6nOrwsEakVqIgbbUUd47FrMMe1YW6ktTI03sm1dOOu/0NjeGsKqitzfLIP0
	 aKLB5Pny4Xk8Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-pci@vger.kernel.org,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex
 Williamson <alex@shazbot.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Jonathan Corbet <corbet@lwn.net>,  Josh Hilke
 <jrhilke@google.com>,  Leon Romanovsky <leonro@nvidia.com>,  Lukas Wunner
 <lukas@wunner.de>,  Mike Rapoport <rppt@kernel.org>,  Parav Pandit
 <parav@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pranjal
 Shrivastava <praan@google.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Saeed Mahameed <saeedm@nvidia.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,  Vipin
 Sharma <vipinsh@google.com>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 04/12] PCI: liveupdate: Document driver binding
 responsibilities
In-Reply-To: <20260522202410.3104264-5-dmatlack@google.com> (David Matlack's
	message of "Fri, 22 May 2026 20:24:02 +0000")
References: <20260522202410.3104264-1-dmatlack@google.com>
	<20260522202410.3104264-5-dmatlack@google.com>
Date: Mon, 25 May 2026 17:35:16 +0200
Message-ID: <2vxzbje37b9n.fsf@kernel.org>
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

On Fri, May 22 2026, David Matlack wrote:

> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.

Nit: Should you also note this in the documentation that this can change
in the future?

>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 96c43b84532c..4f2ec6ffdd16 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -70,6 +70,22 @@
>   * preserved. These may be relaxed in the future:
>   *
>   *  * The device cannot be a Virtual Function (VF).
> + *
> + * Driver Binding
> + * ==============
> + *
> + * In the outgoing kernel, it is the driver's responsibility to ensure that it
> + * does not release a device between pci_liveupdate_preserve() and
> + * pci_liveupdate_unpreserve().
> + *
> + * In the incoming kernel, it is the driver's responsibility to ensure that it
> + * does not release a preserved device between probe() and
> + * pci_liveupdate_finish().
> + *
> + * It is the user's responsibility to ensure that incoming preserved devices are
> + * bound to the correct driver. i.e. The PCI core does not protect against a
> + * device getting preserved by driver A in the outgoing kernel and then getting
> + * bound to driver B in the incoming kernel.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt

-- 
Regards,
Pratyush Yadav

