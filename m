Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A76C77B7C
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UJgJXEmpNPiQnD6c79MLccGU2OkAM1MEi4sz6o10IuM=; b=Lt8Fh3SJfdn8L5
	akLt8LT4i90v9ic9GKJWt1iDBrfTtPZUTbRa5rUyBTjVetFbn/jVHTdBmaqtWNhv3oA+fHTyNzIJW
	3wSh4SDQN40W3MR5F833TJ8jZjzufvzodkm8VPqqmlyq6TcypfLDzL7XOaRADSySoflk2lviBXbp9
	6Oax/agQRU1JBZW3HjlZNmdgm5LhQ0J+x46WKT21+ckv/oBUxquI2BcMCotlhggpvuHdm5K8b6PG1
	CkcQxybZQ3/9YEckZ/anWTTO07T5NFuvIawPuyPLzogxmt74edRhwo/tF6J/RSimjMxom/RLF2aOv
	ljH6nRnYUgxLAmvPtqZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puxQ1-00BCHf-26;
	Fri, 05 May 2023 15:32:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puxPz-00BCGp-0O
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 15:32:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2A62C63EE3;
	Fri,  5 May 2023 15:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97354C433EF;
	Fri,  5 May 2023 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683300741;
	bh=Q0udQNczgiTXef0I6TQl4XjEa28GMITzLeVbirTigto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJ+UwqvB5nF4VUyKHi6/WyE7Lveo46g0Hg4iFzYEzv2jJXzQ6oKkmO7gV19rpTVvy
	 b1dKFeoOc9k+kdtBZkRt7qzIWVpKqjN/nLEy60G6YYDIEeSM3qdEaDJPYSO/bTekw3
	 hLbZrciBZhaxi2nE3A7eoIi+oIqcvI5Ds7yq6FpQWOi85M6lY322Fo5NcjfmV/sNBd
	 lFuyCYL7fSleesH34X8O5MEmiWw7CEUHorVaUm2JtplnJUkIqvMGPJvwIbcqMIJruL
	 eMsPaEUqnd+bYXlq3p/mU7RfufJkj/vumt80tcLH/5i68ZOpfk5FAdMNmfE03oYHeO
	 sh2pDYYNZJjUQ==
Date: Fri, 5 May 2023 17:32:18 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, ardb@kernel.org, jeremy.linton@arm.com
Subject: Re: [PATCH 1/5] kexec: Adding missing free for kernel_buf
Message-ID: <ZFUhgnfTwJEKIBpp@kernel.org>
References: <20230505025438.11943-1-piliu@redhat.com>
 <20230505025438.11943-2-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230505025438.11943-2-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_083223_200470_5B165EF8 
X-CRM114-Status: GOOD (  15.93  )
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

On Fri, May 05, 2023 at 10:54:33AM +0800, Pingfan Liu wrote:
> slurp_decompress_file() allocates memory but nowhere to free it.
> Adding that missing free.

Hi Pingfan,

There seem to be:

a) other places where slurp_decompress_file() is called and;
b) other places where do_kexec_file_load() returns.

I wonder if a more comprehensive fix appropriate.

> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> To: kexec@lists.infradead.org
> Cc: horms@verge.net.au
> Cc: ardb@kernel.org
> Cc: jeremy.linton@arm.com
> ---
>  kexec/kexec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 36bb2ad..614cd1d 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1379,6 +1379,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>  		}
>  	}
>  
> +	free(kernel_buf);
>  	close(kernel_fd);
>  	return ret;
>  }
> -- 
> 2.31.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
