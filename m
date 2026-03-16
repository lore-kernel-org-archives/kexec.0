Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC71FF53D6E
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x9RU4Mq6bXwi7763tJq20duY+x4lhVoegGX5yfdZIpA=; b=Q368RATFqjm0PYFMqKLylkXz/Q
	l4KmoAsxa5mAkq/WS8AcPI9ZHqMQRe6mSda2oRWa594RuYIh4U5y89Jz1fTa1ZcpVbhqM/Fo84+t4
	KtOcxd2PPj4Fa5V+dOYAxyRlgVnF6dcLwTZQ4ng+2+v5JtqqXB/zA3ZztVwW/9AVGBWR2k/AkLuIq
	MGm/WwsZmFWNxeLo2LoxHSxOPYpvMfOtxZbwWcSVP9zPcKgASLsCiZiLkLTsctAYv7ErZ49/hatTh
	AkYqOTM9FPyC3haNN5kh0bLttOrqp97DMY/+ekTtqrudhrnt6S+97Y18U0XZP7fHonwAPONa0U4ax
	UM/7i2/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2ARE-00000004Pd4-00r1;
	Mon, 16 Mar 2026 16:05:04 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2ARB-00000004PcI-0L68
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 16:05:02 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b052ec7176so94135ad.1
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773677100; x=1774281900; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9RU4Mq6bXwi7763tJq20duY+x4lhVoegGX5yfdZIpA=;
        b=Unbe8VjHrqg9QGds+65GRLeC2Er3SDXauvw//IK+oSco8tWwwl0KtAuRWXLAL41Ai2
         9F6x2CgNKg/tOWlihsuVGX7C/BamPYMlYAl+Bm8TDXMS3MeSLxVxFdApbnfLulvJbw8a
         B32CnFP/PWwQnij8shV59MqfPr8n0Lv/ieP8Vd0GFyWZM6zC2i90SpejbRxdZuVN1iCu
         UWhJ4fs9Adc76XTw9hQnLAhi4Zi2TkWmwmNBYnNXYq3u0enMvsWzySOxW/nqnGUx4KUD
         teL9ymcdo6if9nkkTi/FCORG1nf9/18vxSX8+Y2l4mHRBhdLDfII0TBRcIE5ZH2nR4bW
         jnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677100; x=1774281900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9RU4Mq6bXwi7763tJq20duY+x4lhVoegGX5yfdZIpA=;
        b=qZ0rBpKCjyTgR6GWiPN/vU8lwcb3v49CIP0cOVX2wdt8lgrk+q4eVmVfqGf1m4J/Jt
         8ynoWblGXSJX3abVvIWNi+efr576EHVaupunfwuPjsrcHHOeUa00S/Ngc3qdOzIzzIvf
         0U1knIihYGxoqI/xVxZa5UYgzJm6TiRjKiK75VeXKB0D3wJlfHzXclf4RGA+i8maGJsa
         zOV9LRqiFZgUMBoG/I9cRHE0lxqhazObY7soe+PfNclVUA9UlnUAp4VGomoI41GL3l7o
         jB05tW8d50wQ8vEuIMwLI1VjqgX87JJBfqKX2MNPsyYmFpr/1VN9X3c+hbJwEUMdolwE
         3JHw==
X-Forwarded-Encrypted: i=1; AJvYcCVqHmV4sNl+hVv07f1x/WTPPZ3v8iM/GC18ceHEJH864VJkuOnwY31JmCzMq+dmNwarYJyCiA==@lists.infradead.org
X-Gm-Message-State: AOJu0YztmCb1YvJQMkkFuBuHtBSsO1PyQwDJOSfivUSc6gx24Mg48PAM
	PHX29cAh1kjOeytdnrzImqXObWgYROKMnC+lB3vS53NcN/Hol83Fv2C2KGrh/Vg35g==
X-Gm-Gg: ATEYQzwStgTzqESxx41O8kBRk1erkQQ+4jpz9L0dPkE14JQVW2DaFKAIoCG14tNUC44
	Hidg1gstPdQyTpCBeUKYS+orcYj6Zqw7f/lza7hW2+aK49gj/Bz0y6V4sZQj6G4xb+6Ir5zKkWo
	Tzmy4+e1u9p0hZoCU/wAHjZiw4DbhULiktw6GyAQRPNT6LOGbErIAcKtrCFMXjS8jUMeV4CFVGQ
	XF6zbQ5m3bvTRAdoeJ+o6TIDw6E4kGm5nf9X/sFG0uPTaHwxcIij9+gq/lGGIYywCG8VQn55UKk
	/6qwBod98MwnfKe2nrsyrCOPj17H4GipJMA5d6d7PGecRj4n3TUpYVOs8PgqzTIxO3E5ojapbWN
	xHFJn0VhPXm07YwAnm4jFkoeNdgXkAMLD71PjOodT4iwgPp1fM6M5zYJ/7Aq6raPgF/RSIiM1AP
	Hz7hl3F7O6jeWx7cROG/Zc/fIzrtMZz/IFk5epcwKz0waJbS6rqhpkXRC/FrLD
X-Received: by 2002:a17:902:ce0f:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2b04215e0c7mr4424785ad.20.1773677099288;
        Mon, 16 Mar 2026 09:04:59 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b048527a19sm71890555ad.7.2026.03.16.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:04:58 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:04:54 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 16/22] vfio: selftests: Add
 vfio_pci_liveupdate_uapi_test
Message-ID: <20260314073250.GE4177610.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-17-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-17-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_090501_127442_B0E78D91 
X-CRM114-Status: GOOD (  12.95  )
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

On Thu, Jan 29, 2026 at 09:25:03PM +0000, David Matlack wrote:
> +
> +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
> +{
> +	int ret;
> +
> +	ret = luo_session_preserve_fd(self->session_fd, self->device->fd, 0);
> +
> +	/* Preservation should only be supported for VFIO cdev files. */
> +	ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
> +}
> +
> +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
> +{
> +	int ret;
> +
> +	if (self->iommu->iommufd)
> +		return;

for iommufd variant, should we mark test as skipped instead of showing
it as passed?

> +int main(int argc, char *argv[])
> +{
> +	int fd;
> +
> +	fd = luo_open_device();
> +	if (fd < 0) {
> +		printf("open(%s) failed: %s, skipping\n", LUO_DEVICE, strerror(errno));
> +		return KSFT_SKIP;

Both can be combined using ksft_exit_skip()


