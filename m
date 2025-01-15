Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9A3C02187
	for <kexec@archiver.kernel.org>; Sat, 18 Jan 2025 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MstsdCK7fs6TiHB2aoEPFnlipyR3FTW1b6bpj6iFCyM=; b=QPIL++UkUWSNVQKBc2hvRxl2Zn
	xVKEK4ko46Bd1hG1DAMXCmpXKbHe9hSBAOHpIbAQi3I6zRDq7gPHohfS9fGVed2i40EQFQTvMSMYT
	j2Oz6F/s3kA0gshHVeGPPCLa2D70OVFiNgJsMKLdusrkerwAtvqYeZcWryyYnG388GcFlrAlk5GIv
	/ei7oQYsrEQkbDpkA7JACn8PKnulvqAxyIWUZaMNzJSSHswd3kpoQVbmqwsJ6SpHdAdx7UBzRpfwi
	hmv3IS53IcDHoiHTkNPHeFhfkUKpwl19id5pMNuGh8seKHAhfq8DPEesIqTDobGTGHwpPooFhfYkt
	pJuwPNtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZ49j-000000021Ln-0JgQ;
	Sat, 18 Jan 2025 08:26:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY9hd-0000000CxxV-2yvs;
	Wed, 15 Jan 2025 20:09:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 41F7BA42164;
	Wed, 15 Jan 2025 20:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A6BC4CED1;
	Wed, 15 Jan 2025 20:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736971763;
	bh=HKd2BYN0EJzvcqr3Xx3Vueop4tDJh+K1d/v1F43ixq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMh7oPcJEGeeR1CbLFNvT6sYm/PkFQwDWfBsQ90yztglpZ3/YZEBVnarQ1AC7szWo
	 7TIaoC/5Ds9yuqwsCSv511HrZQrz9DYKTCs5teywBQChtbtwCLdUU15B57wDXyESFf
	 A/x13wKP5lj3nSG+MtRjOv+yVwR6g+BlMg1RaQLmyhmo5lqJ4XKmsH9giN7zUcgT0G
	 JjdlmRxxbsFDdoqRPMfd7BNNsEMs0mR8Cyqj/oCkFnsbRsTmQflWeOU3bRrVWJH9mq
	 wFz46x9sk38sYnuYTKWOXCW+bAgDPbIH7khSU1whNzE/e3Hn5P+2qU6Lun6bUVc/Ly
	 lJaxe0RpKwpyA==
Date: Wed, 15 Jan 2025 20:09:21 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
	Song Liu <song@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Corey Minyard <cminyard@mvista.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2] treewide: const qualify ctl_tables where applicable
Message-ID: <Z4gV8QNnafm-iCC4@liuwe-devbox-debian-v2>
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_120925_815868_468455B6 
X-CRM114-Status: GOOD (  11.44  )
X-Mailman-Approved-At: Sat, 18 Jan 2025 00:25:42 -0800
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

On Fri, Jan 10, 2025 at 03:16:08PM +0100, Joel Granados wrote:
[...]
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 7a35c82976e0..9453f0c26f2a 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -141,7 +141,7 @@ static int sysctl_record_panic_msg = 1;
>   * sysctl option to allow the user to control whether kmsg data should be
>   * reported to Hyper-V on panic.
>   */
> -static struct ctl_table hv_ctl_table[] = {
> +static const struct ctl_table hv_ctl_table[] = {
>  	{
>  		.procname	= "hyperv_record_panic_msg",
>  		.data		= &sysctl_record_panic_msg,

Acked-by: Wei Liu <wei.liu@kernel.org>

