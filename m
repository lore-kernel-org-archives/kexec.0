Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9F6C48298
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Js7OYRuNOUANC1bvluukHh9LEtIzHwqfcBduQCB51+0=; b=ABCFHW6wc8v3Dg
	W2l/QyZV6kMuEeAQ9EcaV7vbWDzWpwurQlH1YPfQq8q35CQ19dxaGRUx17Z/2rbTFopRx1lVdTlR0
	B++IrIzIKk5sNB8rTzZeWWuEBaM9pV6MA/JtGjALskX+qZxfub/oJR6iM08J5Ix1PRLzjRvNkBvZA
	mdfTKOOvOot71+EZP7SbVnkyoFZHeUn2xSA1v4Rdzbl96pUVxnAPo7hLt0wuLBfvMaD+LSTZ5Yjor
	pZlVMr9T73zFSWmkfJAO0i/4rJwvPwwJhxWYouKRTqGV1QhhiOXqt+ACanMSNwDTqjbH2azJa6yW9
	NjWFNbQzeZBvzfGUi+0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2WI-000000045ym-2ufi;
	Mon, 05 Feb 2024 17:12:34 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2WG-000000045xm-33cf
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 17:12:34 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-21433afcc53so2878419fac.3
        for <kexec@lists.infradead.org>; Mon, 05 Feb 2024 09:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707153151; x=1707757951; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qDbIp2yNtXU1RzQ539qXvN5xu3jf0vrl0xdf7V68t0=;
        b=HFXAfszkGVVb0VNpLeE+mFqz2Jfx8EqqtQ44io9T4NoL3lSyfMWwayQHiFXekfn1or
         Z4pw5H2FLAnOAoKWhYg3dYZKKHKAWwXYRxTmiB27H2HdUrZXnKhR6GsP9AmSJJ5JQViO
         cvL+Yb+91V5C5dLovbbkO48r7h7k3tzPJbTxTfhITeVbUX99TSSAZwseHzxRHjOiSzeN
         MBmtP20dDqcuPyv1LdCZhF8OeDhcTG8u0hqwAcx6FBSzakiowYHoWZ0h4choV5N30Cgo
         0HO1lGyFU7LjiSHe2P+KU9vylWx5iBFUVnDWbb9ELoc0QZHPxo1Nslh/6kq32sa1MjT/
         XsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153151; x=1707757951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qDbIp2yNtXU1RzQ539qXvN5xu3jf0vrl0xdf7V68t0=;
        b=K2qGLOfJBsD6MXhA0TNy37/MDZhONrVvyTN4MJM+baQclMhfkljfTd+aw9vfM74/vY
         OYQihf3eIwRk87hhbO++2driLFmARwST/5JE1cNtCPSDyoWARUULKj0KhOvpm3rnBGXe
         2yO6zsMT92brMXjMvo8B6RzeQ8KsN8FTY/IVg+01/bxPf6XcaVD8tdqzHa0irtKb/2iL
         2vZnKHhSOdTeUNYgHncP7zorn9SYHW9Y5qGXccvkytfddaHDfm/SsZ1GhlewJ4QfoRtu
         2wUFV6HA18evwtiyZhAw27R/f/yU3mFTkl3F64VQEXd++FwmijSAkWJuThK4ZyPTZ/W7
         aWTA==
X-Gm-Message-State: AOJu0YwWzl8Cm3tWMJ4nd407XD7Dc6ZQLAh8MR6GsDo0AKT46z+I6tQP
	kHyaLoNV/hTggDDgJrsszIaQZ95HeQ9YBE4aEUxwoRxolYvO3Y+9f4IJrjSoNpc=
X-Google-Smtp-Source: AGHT+IFln/5f5G6GIeUtem4PLnGVB16+0C+2crVsZ05VhszKdHkv3XoMdgobGPR5lticlBVyoAC2eg==
X-Received: by 2002:a05:6871:5813:b0:215:68d7:461b with SMTP id oj19-20020a056871581300b0021568d7461bmr322778oac.23.1707153151179;
        Mon, 05 Feb 2024 09:12:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/rPy91arwpYIwAojARklp6ZMF9K+LQVXtUZZ6YGhWdbSR41RR9S8S8caNOyg5Xw541tmu/KUnL1bRkwrLAWUFUQvIxBuAH86HrvajT0/XV7ievA8flm9zmbktlvTgPRA0yJDD3YeqEMbTqxaPHx78ygvrA/LdsiY6hjFAYx3hveMP1d6W/6K3k1EeoEzo90VzeDX4LNG2UcoIuzn8m6WZRZawwUNd+8QLX9XNbvyX+fxR3fyR2KkUPftZmPdowvRIAvlRhyHwjG1bgBeEvc7d3Im4bHyZ5LgWimpfq0AnUsJa49hcgqa18SGKfIDO357HXXSckB3H4VdxbBTR9I45dNsvSz2iUqZTjHAbpAgsGcljcsJXIYKsrhGG9FxLtW5p590R06d0vW4BCLwzh5MlbNqk4LSt2GTNcJcpmFo55Yyj1G/hlxQypUbHBJCZVzbbo7/FoWYMlsuz7iMv5EBzmfwGjNEvyEkU4+HAjiu9R7nOQl62M73DoGf/9IBMJILTI4CKJkoWgyKcr9LlTDO16Riw0X0a2+S/yupU46js8efVoG04val7Yb6gYBHIStR6H11fRi9OhWk0YB5VN6N5KYXugRjyOAxpVLg0Rtt8AvhK8Dykw3m3tmG3Yi6bseB6dR4OYaw0dXa8GiZ/u1/G7p4k8O6NLeS+iE8ypk+u0M5hspJ7wNhWTvsjpjHNt1xovNvCg/o0wX4tLIgyKy9BQQf8jiFAkcp8+tFunLmk7sxu
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ej8-20020ad45a48000000b0068c6789ce9csm162580qvb.6.2024.02.05.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:12:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rX2WE-000dJX-5F;
	Mon, 05 Feb 2024 13:12:30 -0400
Date: Mon, 5 Feb 2024 13:12:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>,
	Usama Arif <usama.arif@bytedance.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	madvenka@linux.microsoft.com, steven.sistare@oracle.com,
	yuleixzhang@tencent.com
Subject: Re: [RFC 14/18] intel-iommu: Allocate domain pgtable pages from
 pkernfs
Message-ID: <20240205171230.GB31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205120203.60312-15-jgowans@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-15-jgowans@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_091232_834902_2C2D69B9 
X-CRM114-Status: GOOD (  11.29  )
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

On Mon, Feb 05, 2024 at 12:01:59PM +0000, James Gowans wrote:
> @@ -946,7 +946,13 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>  		if (!dma_pte_present(pte)) {
>  			uint64_t pteval;
>  
> -			tmp_page = alloc_pgtable_page(domain->nid, gfp);
> +			if (domain->pgtables_allocator.vaddr)
> +				iommu_alloc_page_from_region(
> +						&domain->pgtables_allocator,
> +						&tmp_page,
> +						NULL);

I'm really worried about this change - I plan to redo all of this page
table handling code so it makes use of struct page members for things
like RCU free and more.

Does this end up making the entire struct page owned by the
filesystem?

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
