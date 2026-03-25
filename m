Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F9C109C05B
	for <kexec@archiver.kernel.org>; Wed, 25 Mar 2026 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+fZRp4AJi5cb/F6jA80ZrndPdXYxEQL1IK9u8/P+m9k=; b=PADM3ei5pA5/3bXIwzaJ2pvCRg
	lvFVt40Qw4nvFQBMSOHLFkNY3dAaHdedcZVZsI7KhdOIfZnusIqa395evQ6LSWmaJbRUiD25ie8Kg
	yuGKZ2P9hk1RoBXo92iwr81vdKiN6FNBbr2fsk2oaIDPGnmV/9f50yMkbNNN+LLB1vdgqH6YzWN0B
	X2DMoVJ9lHgScNm0ZX3uWvaZdg6i0dGUcfXq33SUnKDuJt3K0UPBoFwuSFGDSYJL9UWhdBnyHJTzX
	D5a50usP0X4zR9hXzSWjiLru4/9xJ6NuLfKi2IWUg3E9TFQgPxu3fNiD54EQDWVXgUsK5dKDBugMS
	EA5Ypohg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5UVD-00000004BxH-2V1O;
	Wed, 25 Mar 2026 20:06:55 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5UVB-00000004Bwp-3s07
	for kexec@lists.infradead.org;
	Wed, 25 Mar 2026 20:06:55 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c648bc907ebso200797a12.3
        for <kexec@lists.infradead.org>; Wed, 25 Mar 2026 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774469213; x=1775074013; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fZRp4AJi5cb/F6jA80ZrndPdXYxEQL1IK9u8/P+m9k=;
        b=JYdkNmXdYrUXbrmo+iT1hSsJOVELysQY3kraFYDDs7JjPjfrlzilVHc7BMu8ADMgCh
         8stISoG5oFXnI8AXjtnQ8XQpqFypG2X65FAopauATZKCFUILqE+lGHWq5V/C+CnPXp1J
         g+cuYGsqeounC9UEnmRahz1FD9YZacMCd0ljPpGkHF9TRqhw8N8fDwnoUaRNtkRSA17g
         CSTkt5XIeS/sO7f8iJ/2aXKCloXuuXCEzN17uu5hmndqfX4xaFuMA2HTIbTCUi9kcV2V
         1HPsXEI73kN5jAg4n/AtXYn3UtpksnBEQTXJeddUS+dml5KURhGlyl/NG80kOwMvYzhB
         ZzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469213; x=1775074013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fZRp4AJi5cb/F6jA80ZrndPdXYxEQL1IK9u8/P+m9k=;
        b=T5ib9o8wkm71oa4+pw78HX0Hcl/0sgrwRXJbaJ9BFNYgEy1WN2CqJC6r9PJxa4LPV6
         qrsUbvHiseOX+8QOpGxYhwI+UbOGMwafqBaP/9nOpf6Tio5QLntUx7Zhd2051nlzzv5y
         fYKmiw+Kb3l1olu6aXGkkFoIpNTFEnEp8Vozyz8UUQAmXzz5qUjFr0j6UW834zstzQIQ
         D4z46wK+Opx1XTVEhngO2C0EPviKMc4Pq2bwbjfWjgBTxneYHfmG/nMv+Tygl2Sc41Jq
         Lj92rud5R0cXL8UB9JeOQsgASnGk/HtSozIZVp/J1Uuf1MAxIfn9+ehocg9OtlaZuuLt
         +qEw==
X-Forwarded-Encrypted: i=1; AJvYcCWvyU7IY+KpTtYbLIE13AqS0UlaiHS3wcuIifLFONAFJtT9h8vWH1nzvVGHu/QSH0WtAi/bHA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyLHwRo+VyYHZLFHDixJ+mT5VAA0GGyIVAgniYf9bTMhvwliAeC
	UyzRJ9LPGbEMf5a/2XDRDCjC0AJhj26h6XYwWZPA9jvztITFaU9phMqxVji/cBv1vA==
X-Gm-Gg: ATEYQzyy1O+LfXcnbdgWL6vg3ZiVPutBpltpCb7F4yaZGLLWEsLJN0wXO/ZAQPK2j8N
	Pi54zi24RVkRm9uuslr53FC5Gxxvo8QAXwQ9gFJ1zFDVNnNplNWpzXaex6Qu0kvcvstQnZROCxq
	7pC+iAvtmPCovtDeshnie2jum84Af4QOJYMkBHtkah+CYwM+RSfBCqhLjoQKyOYHZArvoGkn5oY
	XO5OYYYYRElxb2DUzeR8cBBUPOrcnvniHHkuDlsBZAIUdy1XdR3vMG/1Xb1mI/Zd+P0mEM2+LU+
	l4DUKlF4evnZpd9SOuvUqZ7Pt00Hrd9s24Y6JiiyYIRfWWINKO4FCQwW/LUescQBR8uNrSlPTdW
	n2yo/DVVMGuVPser6DIawEu+3w6tXlX+4lkWa16aDVCcb44/zHihdYsJIhqAQZscbKBeTH4qMOH
	mcE48y6e96qHJWLOGuc8MHy8lOC1TRhIAvFFkRlY6yqkzV/jPuUr9wBelaIck8Mg==
X-Received: by 2002:a05:6a20:8ca6:b0:398:b3bd:de58 with SMTP id adf61e73a8af0-39c4aed5082mr3746836637.65.1774469212632;
        Wed, 25 Mar 2026 13:06:52 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673819da1sm305751a12.11.2026.03.25.13.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:06:51 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:06:47 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <acRAV7IK6RW8h_QM@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-3-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323235817.1960573-3-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_130653_965658_2A9BB0F8 
X-CRM114-Status: GOOD (  25.27  )
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

On 2026-03-23 11:57 PM, David Matlack wrote:

> +static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> +{
> +	kho_restore_free(args->obj);
> +}
> +
> +static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
> +	.preserve = pci_flb_preserve,
> +	.unpreserve = pci_flb_unpreserve,
> +	.retrieve = pci_flb_retrieve,
> +	.finish = pci_flb_finish,
> +	.owner = THIS_MODULE,
> +};
...
> +static int pci_liveupdate_flb_get_incoming(struct pci_ser **serp)
> +{
> +	int ret;
> +
> +	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)serp);
> +
> +	/* Live Update is not enabled. */
> +	if (ret == -EOPNOTSUPP)
> +		return ret;
> +
> +	/* Live Update is enabled, but there is no incoming FLB data. */
> +	if (ret == -ENODATA)
> +		return ret;
> +
> +	/*
> +	 * Live Update is enabled and there is incoming FLB data, but none of it
> +	 * matches pci_liveupdate_flb.compatible.
> +	 *
> +	 * This could mean that no PCI FLB data was passed by the previous
> +	 * kernel, but it could also mean the previous kernel used a different
> +	 * compatibility string (i.e.a different ABI). The latter deserves at
> +	 * least a WARN_ON_ONCE() but it cannot be distinguished from the
> +	 * former.
> +	 */
> +	if (ret == -ENOENT) {
> +		pr_info_once("PCI: No incoming FLB data detected during Live Update");
> +		return ret;
> +	}
> +
> +	/*
> +	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
> +	 * but it cannot be retrieved. Proceed with standard initialization as
> +	 * if there was not incoming PCI FLB data.
> +	 */
> +	WARN_ONCE(ret, "PCI: Failed to retrieve incoming FLB data during Live Update");
> +	return ret;
> +}
> +
> +u32 pci_liveupdate_incoming_nr_devices(void)
> +{
> +	struct pci_ser *ser;
> +
> +	if (pci_liveupdate_flb_get_incoming(&ser))
> +		return 0;
> +
> +	return ser->nr_devices;
> +}
> +
> +void pci_liveupdate_setup_device(struct pci_dev *dev)
> +{
> +	struct pci_ser *ser;
> +
> +	if (pci_liveupdate_flb_get_incoming(&ser))
> +		return;
> +
> +	if (!pci_ser_find(ser, dev))
> +		return;
> +
> +	dev->liveupdate_incoming = true;
> +}

There is an inerent race between callers of
liveupdate_flb_get_incoming() and liveupdate_flb_ops.finish(). There is
no way for callers to protect themselves against the finish() callback
running and freeing the incoming FLB after liveupdate_flb_get_incoming()
returns. Sashiko flagged this as well [1].

After some off list discussion with Pasha and Sami, the proposal to fix
this is to have liveupdate_flb_get_incoming() increment the reference
count on the incoming FLB. We will add a liveupdate_flb_put_incoming()
to drop the reference when the caller is done using the incoming FLB.

I plan to include a patch for this in v4.

[1] https://sashiko.dev/#/patchset/20260323235817.1960573-1-dmatlack%40google.com?patch=7974

